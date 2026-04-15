---
name: state-tracker
description: 流程监控引擎 - 监控文档产出驱动自动推进，追踪角色交接，管理阻塞与恢复
version: "2.0"
---

# Skill: state-tracker

**角色**: 系统 (System)
**功能**: 流程监控、文档监听、角色通知、阻塞管理
**版本**: 2.0 (重写为流程监控引擎)

## 核心机制

**文档驱动推进**：监控 `.opencode/docs/` 目录，每当新文档出现，匹配自驱动规则，触发下一步。

```
文档产出 → 监听检测 → 规则匹配 → 角色通知 → 技能触发 → 新文档产出 → 循环
```

---

## 状态定义

### 步骤状态

| 状态 | 说明 | 推进条件 |
|------|------|----------|
| `pending` | 等待前置步骤完成 | 前置步骤变为 done |
| `ready` | 可执行，等待触发 | 触发条件满足 |
| `running` | 正在执行 | 技能正在运行 |
| `waiting` | 等待人工确认 | 用户说"继续" |
| `done` | 已完成，文档已产出 | — |
| `failed` | 执行失败 | 需要人工介入 |
| `blocked` | 被阻塞 | 阻塞条件解除 |
| `skipped` | 被跳过 | — |

### 链路状态

| 状态 | 说明 |
|------|------|
| `initialized` | 链路已初始化，未开始 |
| `running` | 正在执行中 |
| `paused` | 在暂停点等待确认 |
| `completed` | 全部步骤完成 |
| `failed` | 有步骤失败且未恢复 |

---

## 状态存储

**路径**: `.opencode/state.json`

```json
{
  "version": "2.0",
  "chain": {
    "name": "sdlc-full",
    "status": "running",
    "mode": "semi-auto",
    "startedAt": "2026-04-15T10:00:00Z",
    "updatedAt": "2026-04-15T14:30:00Z"
  },
  "currentStep": 4,
  "totalSteps": 11,
  "steps": [
    {
      "id": 1,
      "skill": "product-requirement-analysis",
      "role": "产品",
      "status": "done",
      "output": "requirement-login.md",
      "startedAt": "2026-04-15T10:00:00Z",
      "completedAt": "2026-04-15T10:30:00Z",
      "autoTrigger": "collab-product-to-dev"
    },
    {
      "id": 2,
      "skill": "collab-product-to-dev",
      "role": "产品→开发",
      "status": "done",
      "output": "handoff-product-to-dev.md",
      "startedAt": "2026-04-15T10:30:00Z",
      "completedAt": "2026-04-15T10:45:00Z",
      "pausePoint": true,
      "autoTrigger": "dev-context-first"
    },
    {
      "id": 3,
      "skill": "dev-context-first",
      "role": "开发",
      "status": "done",
      "output": "context-report-login.md",
      "startedAt": "2026-04-15T10:45:00Z",
      "completedAt": "2026-04-15T11:00:00Z",
      "autoTrigger": "dev-implementation"
    },
    {
      "id": 4,
      "skill": "dev-implementation",
      "role": "开发",
      "status": "running",
      "output": null,
      "startedAt": "2026-04-15T11:00:00Z",
      "expectedOutput": "implementation-login.md",
      "autoTrigger": "verify-implementation"
    },
    {
      "id": 5,
      "skill": "verify-implementation",
      "role": "开发",
      "status": "pending",
      "expectedOutput": "verify-report-login.md",
      "autoTrigger": {
        "allMatch": "dev-code-review",
        "hasMismatch": "dev-implementation",
        "crossLayerMismatch": "module-collaborative-dev"
      }
    }
  ],
  "documents": {
    "produced": [
      { "path": "requirement-login.md", "step": 1, "producedAt": "2026-04-15T10:30:00Z" },
      { "path": "handoff-product-to-dev.md", "step": 2, "producedAt": "2026-04-15T10:45:00Z" },
      { "path": "context-report-login.md", "step": 3, "producedAt": "2026-04-15T11:00:00Z" }
    ],
    "expected": [
      { "path": "implementation-login.md", "step": 4, "triggerOn": "create" },
      { "path": "verify-report-login.md", "step": 5, "triggerOn": "create" }
    ]
  },
  "notifications": [
    {
      "step": 2,
      "role": "开发",
      "message": "需求已交接，请执行 dev-context-first 开始实现",
      "sentAt": "2026-04-15T10:45:00Z",
      "read": true
    }
  ],
  "branches": [],
  "blocks": []
}
```

---

## 文档监听

### 监听规则

```
监控路径: .opencode/docs/

当检测到新文件创建时:
1. 提取文件名模式（requirement-* / implementation-* / bug-* / ...）
2. 匹配自驱动规则表（见 chain-executor）
3. 评估条件分支（通过/失败/偏差）
4. 更新 state.json：
   - 标记当前步骤为 done
   - 记录产出文档
   - 设置下一步为 ready
5. 触发角色通知
6. 自动执行下一步（全自动模式）或提示用户（半自动模式）
```

### 文件名模式匹配

| 模式 | 对应步骤 | 触发动作 |
|------|----------|----------|
| `requirement-*.md` | 需求分析完成 | 推进到需求交接 |
| `handoff-product-to-dev.md` | 需求交接完成 | 推进到开发上下文 |
| `contract-*.md` | 契约定义完成 | 推进到实现（按契约） |
| `implementation-*.md` | 功能实现完成 | 推进到实现验证 |
| `verify-report-*.md` | 验证完成 | 根据结果分支 |
| `code-review-*.md` | 代码审查完成 | 根据结果分支 |
| `handoff-dev-to-qa.md` | 提测完成 | 推进到测试设计 |
| `test-cases-*.md` | 用例设计完成 | 推进到测试执行 |
| `test-report-*.md` | 测试执行完成 | 根据结果分支 |
| `bug-*.md` | Bug 生成 | 推进到 Bug 协调 |
| `implementation-bugfix-*.md` | Bug 修复完成 | 推进到回归测试 |
| `acceptance-report.md` | 验收完成 | 根据结果分支 |
| `retrospective-report.md` | 复盘完成 | 推进到迭代闭环 |
| `health-check-*.md` | 健康检查完成 | 推进到迭代规划 |
| `DOC_AUDIT.md` | 文档审计完成 | 推进到文档对齐 |

---

## 角色通知

### 通知规则

```
当流程跨越角色边界时，自动生成通知：

| 触发点 | 通知角色 | 消息模板 |
|--------|----------|----------|
| 需求文档产出 | 产品 | "需求分析完成，请确认后交接给开发" |
| 需求交接完成 | 开发 | "需求已交接，请获取上下文开始实现" |
| 契约文档产出 | 开发（前后端） | "契约已定义，请按契约实现" |
| 实现完成 | 开发 | "实现完成，请执行验证" |
| 审查通过 | 开发 | "代码审查通过，请准备提测" |
| 提测完成 | 测试 | "提测单已生成，请设计测试用例" |
| 用例设计完成 | 测试 | "用例已设计，请执行测试" |
| 测试失败 | 开发 | "发现 {N} 个Bug，已生成Bug单，请修复" |
| Bug 分配完成 | 开发 | "Bug 已分配给您，请查看分配单开始修复" |
| Bug 修复完成 | 测试 | "Bug 已修复，请执行回归测试" |
| 测试全部通过 | 产品 | "测试通过，请安排验收" |
| 验收通过 | 全员 | "验收通过，请安排复盘" |
| 复盘完成 | 全员 | "复盘完成，进入迭代闭环" |
```

---

## 阻塞管理

### 阻塞来源

| 阻塞类型 | 说明 | 解除条件 |
|----------|------|----------|
| `missing_doc` | 前置文档不存在 | 文档创建 |
| `dependency` | 依赖的上游步骤未完成 | 上游步骤完成 |
| `blocker_bug` | P0 Bug 阻塞后续测试 | Bug 修复并通过回归 |
| `env_issue` | 环境不可用 | 环境恢复 |
| `need_clarify` | 需求不明确 | 产品澄清 |
| `waiting_approval` | 等待审批 | 审批通过 |

### 阻塞解除后自动推进

```
当阻塞条件解除时:
1. 检查被阻塞的步骤是否 now ready
2. 如 ready → 自动通知对应角色
3. 如为全自动模式 → 自动执行
```

---

## 操作

| 操作 | 说明 | 调用方式 |
|------|------|----------|
| `init` | 初始化新链路 | chain-executor 启动链路时 |
| `start-step` | 开始执行某步骤 | 技能开始执行时 |
| `complete-step` | 标记步骤完成 | 技能执行完毕、文档产出后 |
| `fail-step` | 标记步骤失败 | 技能执行出错时 |
| `pause` | 暂停链路 | 遇到暂停点时 |
| `resume` | 恢复链路 | 用户说"继续"时 |
| `branch` | 选择分支路径 | 条件判断后 |
| `block` | 标记阻塞 | 发现阻塞条件时 |
| `unblock` | 解除阻塞 | 阻塞条件消除时 |
| `notify` | 发送角色通知 | 跨角色交接时 |
| `status` | 获取当前状态 | 任何时刻查询 |

---

## 进度看板

### 当前状态查询

用户随时可以说"项目进度"、"当前状态"、"到哪了"，输出以下看板：

```markdown
## 项目进度看板

**链路**: SDLC 完整流程
**模式**: 半自动
**进度**: 4/11 (36%)
**当前**: 开发 → 功能实现中

### 执行进度
| # | 技能 | 角色 | 状态 | 产出文档 | 耗时 |
|---|------|------|------|----------|------|
| 1 | 需求分析 | 产品 | ✅ 完成 | requirement-login.md | 30min |
| 2 | 需求交接 | 产品→开发 | ✅ 完成 | handoff-*.md | 15min |
| 3 | 开发上下文 | 开发 | ✅ 完成 | context-report.md | 15min |
| 4 | 功能实现 | 开发 | 🔵 进行中 | — | 3h+ |
| 5 | 实现验证 | 开发 | ⚪ 待执行 | — | — |
| 6 | 代码审查 | 开发 | ⚪ 待执行 | — | — |
| 7 | 提测交接 | 开发→测试 | ⚪ 待执行 | — | — |
| 8 | 用例设计 | 测试 | ⚪ 待执行 | — | — |
| 9 | 测试执行 | 测试 | ⚪ 待执行 | — | — |
| 10 | 验收评审 | 产品 | ⚪ 待执行 | — | — |
| 11 | 复盘闭环 | 全员 | ⚪ 待执行 | — | — |

### 待处理通知
- 🔔 测试: "提测单生成后，请设计测试用例"（预计今天下午）

### 活跃 Bug
| Bug | 严重程度 | 状态 | 负责人 |
|-----|----------|------|--------|
| — | — | — | — |

### 阻塞项
- 无
```

---

## 配合 Skills

| 配合技能 | 关系 | 说明 |
|----------|------|------|
| `system/chain-executor` | 核心 | 执行器调用本技能管理状态和推进 |
| `system/auto-skill-dispatcher` | 入口 | 调度器读取状态决定触发 |
| `system/document-integrity-check` | 协同 | 文档产出后触发完整性检查 |
| `system/security/compliance` | 协同 | 安全过程更新状态 |

## 工具
- read: 读取 state.json
- write: 更新 state.json
- glob: 监控 .opencode/docs/ 目录变化
