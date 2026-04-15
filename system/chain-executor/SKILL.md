---
name: chain-executor
description: 技能链路自驱动引擎 - 文档驱动的自动流程推进，无需人工触发下一步
version: "2.0"
---

# Skill: chain-executor

**角色**: 系统 (System)
**功能**: 文档驱动的自推进引擎
**触发词**: 执行链路、运行流程、开始流程、auto-run、自驱动、自动推进
**版本**: 2.0 (重写为文档驱动引擎)

## 核心理念

**文档是燃料，流程是引擎。** 每个技能产出的文档是驱动下一步自动执行的触发器。

```
旧模式（人工推动）：
  技能A完成 → 人说"下一步" → 技能B → 人说"下一步" → 技能C

新模式（自驱动）：
  技能A完成 → 文档X产出 → 自动检测到X → 触发技能B → 文档Y产出 → 自动检测到Y → 触发技能C
```

## 自驱动规则

### 规则一：文档产出 = 自动触发

每当 `.opencode/docs/` 下出现新文档，评估是否触发下一步：

| 文档产出 | 自动触发 | 条件 |
|----------|----------|------|
| `requirement-*.md` | `collab-product-to-dev` | 无条件触发 |
| `handoff-product-to-dev.md` | `dev-context-first` | 无条件触发 |
| `context-report-*.md` | `dev-implementation` | 无条件触发 |
| `contract-*.md` | `dev-implementation`(按契约) | 契约文档完成后触发实现 |
| `implementation-*.md` | `verify-implementation` | 无条件触发 |
| `verify-report-*.md` (全部匹配) | `dev-code-review` | 验证通过 |
| `verify-report-*.md` (有偏差) | `dev-implementation`(修正) | 验证不通过 |
| `code-review-*.md` (通过) | `collab-dev-to-qa` | 审查通过 |
| `code-review-*.md` (失败) | `dev-implementation`(修复) | 审查不通过 |
| `handoff-dev-to-qa.md` | `test-case-design` | 无条件触发 |
| `test-cases-*.md` | `test-executor` | 无条件触发 |
| `test-report-*.md` (全部通过) | `collab-acceptance-review` | 测试通过 |
| `test-report-*.md` (有失败) | `bug-coordinator` | 测试失败 |
| `bug-*.md` | `bug-coordinator` (分配) | 自动分配 |
| `bug-分配单` | `dev-implementation`(Bug修复模式) | 分配完成 |
| `implementation-bugfix-*.md` | `test-executor`(回归) | 修复完成 |
| `acceptance-report.md` (通过) | `collab-retrospective` | 验收通过 |
| `acceptance-report.md` (不通过) | `dev-implementation`(修复) | 验收不通过 |
| `retrospective-report.md` | `iteration-closure` | 无条件触发 |
| `iteration-closure.md` | `global-project-analysis`(健康检查) | 无条件触发 |
| `health-check-*.md` | 下一迭代规划 | 健康报告产出 |

### 规则二：条件分支 = 自动分流

```
文档产出后，检查结果字段，自动选择分支：

dev-code-review 产出 code-review-*.md
  ├── result: "pass"    → 自动推到 collab-dev-to-qa
  ├── result: "fail"    → 自动退回 dev-implementation（标注问题）
  └── result: "security" → 自动转到 security-compliance

test-executor 产出 test-report-*.md
  ├── passRate ≥ 100%   → 自动推到 collab-acceptance-review
  ├── passRate < 100%   → 自动生成 bug-*.md → 推到 bug-coordinator
  └── 有阻塞用例         → 标记依赖，等待阻塞解除

verify-implementation 产出 verify-report-*.md
  ├── 全部匹配          → 自动推到 dev-code-review
  ├── 有偏差            → 自动退回 dev-implementation（标注偏差项）
  └── 跨层不一致        → 自动推到 module-collaborative-dev（补充契约）
```

### 规则三：角色交接 = 自动通知

```
当流程跨越角色边界时，自动生成角色通知：

产品 → 开发（collab-product-to-dev 完成）:
  "需求已交接，开发请执行 dev-context-first 开始实现"
  → 自动触发 dev-context-first

开发 → 测试（collab-dev-to-qa 完成）:
  "提测单已生成，测试请执行 test-case-design 开始测试"
  → 自动触发 test-case-design

测试 → 开发（test-executor 发现 Bug）:
  "发现 {N} 个Bug，已生成Bug单，开发请查看分配单开始修复"
  → 自动触发 bug-coordinator → 自动触发 dev-implementation(Bug修复模式)

开发 → 产品（collab-acceptance-review 完成）:
  "验收通过，产品请执行 collab-retrospective 开始复盘"
  → 自动触发 collab-retrospective
```

---

## 预定义链路（10 条）

### 链路 1: 完整 SDLC（自驱动）

```
用户说："实现用户登录功能"

product-requirement-analysis
  → 产出 requirement-login.md
  → [自动] collab-product-to-dev
    → 产出 handoff-product-to-dev.md
    → [自动] dev-context-first
      → 产出 context-report-login.md
      → [自动] dev-implementation
        → 产出 implementation-login.md
        → [自动] verify-implementation
          → 产出 verify-report-login.md (全部匹配)
          → [自动] dev-code-review
            → 产出 code-review-login.md (通过)
            → [自动] collab-dev-to-qa
              → 产出 handoff-dev-to-qa.md
              → [自动] test-case-design
                → 产出 test-cases-login.md
                → [自动] test-executor
                  → 产出 test-report-login.md (全部通过)
                  → [自动] collab-acceptance-review
                    → 产出 acceptance-report.md (通过)
                    → [自动] collab-retrospective
                      → 产出 retrospective-report.md
                      → [自动] iteration-closure
                        → [自动] global-project-analysis(健康检查)
```

### 链路 2: Bug 修复闭环（自驱动）

```
test-executor 发现失败用例
  → [自动] 生成 bug-{id}.md
  → [自动] bug-coordinator 分析分配
    → 产出 bug-分配单
    → [自动] dev-implementation (Bug修复模式)
      → 产出 implementation-bugfix-{id}.md
      → [自动] test-executor (回归测试)
        → 通过 → [自动] Bug 关闭
        → 失败 → [自动] 退回 dev-implementation (循环)
```

### 链路 3: 线上故障（自驱动）

```
用户说："支付服务挂了"

incident
  → 产出 incident-report.md (止血完成)
  → [自动] dev-context-first (定位根因)
    → [自动] dev-implementation (根因修复)
      → [自动] test-executor (验证)
        → 通过 → [自动] collab-retrospective (复盘)
```

### 链路 4: 新项目启动（自驱动）

```
用户说："启动新项目"

project-kickoff
  → [自动] global-project-analysis
    → [自动] product-technical-assessment
      → [自动] module-splitting
        → [自动] parallel-module-orchestrator
          → [自动] dev-implementation (各模块)
```

### 链路 5: 文档治理（自驱动）

```
module-document-keeper
  → [自动] document-integrity-check
    → 产出 DOC_AUDIT.md
    → [自动] document-alignment
```

### 链路 6: DevOps 部署（自驱动）

```
ci-pipeline → dockerfile → k8s → multi-env → observability → cost-optimization
每步产出配置文件，自动推下一步。
```

### 链路 7: 数据迁移（自驱动）

```
dev-context-first → migration → security-compliance
```

### 链路 8: 用户反馈驱动（自驱动）

```
feedback-analysis
  → [自动] product-requirement-analysis
    → [自动] dev-implementation
      → [自动] collab-acceptance-review
```

### 链路 9: 前后端分离（自驱动）

```
product-collaborative-requirement-optimization
  → [自动] module-collaborative-dev
    → 产出 contract-*.md
    → [自动并行] frontend + backend
      → [自动] verify-implementation (跨层检查)
        → [自动] collab-dev-to-qa
```

### 链路 10: 设计到代码（自驱动）

```
design-review
  → [自动] design-handoff
    → [自动] dev/implementation/frontend
```

---

## 执行模式

### 模式 A: 全自动（自驱动）

```
触发词: "自动执行", "auto-run", "全链路执行"

行为: 按链路从第一步开始，每步完成后自动检测产出文档，自动触发下一步。
遇到分支时，根据结果自动选择路径。
遇到需要人工确认的节点（如验收），暂停并通知。

适合: 有明确需求的完整功能开发
```

### 模式 B: 半自动（推荐）

```
触发词: "开始链路", "执行流程"

行为: 每步完成后，展示产出文档摘要和下一步推荐，等待用户确认后执行。
用户可随时介入调整、跳过或回退。

适合: 需要人工审核关键节点的流程
```

### 模式 C: 文档监听（被动）

```
触发词: "监听模式", "自动推进"

行为: 不主动启动流程，但持续监控 .opencode/docs/ 目录。
当检测到新文档时，自动匹配自驱动规则，提示或执行下一步。

适合: 多人协作、跨角色流程推进
```

---

## 暂停与恢复机制

### 自动暂停点

```
以下节点自动暂停，等待人工确认后继续：

1. collab-product-to-dev — 需求交接后，等开发确认接收
2. dev-implementation — 实现方案设计后，等技术负责人确认方案
3. collab-dev-to-qa — 提测前，等开发确认自测通过
4. collab-acceptance-review — 验收前，等产品/客户确认参与
5. iteration-closure — 迭代闭环前，等全员复盘完成
```

### 恢复方式

```
用户说: "继续" / "下一步" / "确认"
  → 读取 state.json 获取当前暂停点
  → 执行下一步
```

---

## 输出格式

### 链路启动

```markdown
## 链路启动：{链路名称}

**模式**: {全自动/半自动/监听}
**总步骤**: {N}
**预计节点**: {关键暂停点列表}

### 执行计划
| # | 技能 | 角色 | 产出文档 | 是否暂停 |
|---|------|------|----------|----------|
| 1 | product-requirement-analysis | 产品 | requirement-*.md | 否 |
| 2 | collab-product-to-dev | 产品→开发 | handoff-*.md | 是 |
| 3 | dev-context-first | 开发 | context-report | 否 |
| ... | ... | ... | ... | ... |

▶ 开始执行 Step 1...
```

### 步骤完成（自动推进）

```markdown
## ✅ Step {N} 完成：{技能名}

**产出文档**: {文档路径}
**关键结果**: {摘要}

### 📄 文档已检测到
检测到 {文档名} → 匹配自驱动规则 → 自动触发下一步

▶ 自动执行 Step {N+1}: {技能名}...
```

### 暂停等待

```markdown
## ⏸️ Step {N} 等待确认：{技能名}

**等待原因**: {需要人工确认的原因}
**等待角色**: {产品/开发/测试/技术负责人}

### 确认后将继续
→ Step {N+1}: {技能名}

💡 说"继续"或"确认"以继续执行
```

### 分支选择

```markdown
## 🔀 分支检测：{技能名}

**结果**: {pass/fail/条件}
**匹配规则**: {规则描述}

### 自动选择路径
→ {路径描述}

▶ 执行: {下一步技能名}
```

---

## 配合 Skills

| 配合技能 | 关系 | 说明 |
|----------|------|------|
| `system/state-tracker` | 核心 | 状态追踪与文档监控 |
| `system/auto-skill-dispatcher` | 入口 | 用户输入识别链路类型 |
| `system/document-integrity-check` | 协同 | 文档产出后完整性验证 |

## 工具
- skill(): 加载并执行技能
- read: 读取 state.json 和产出文档
- write: 更新 state.json
- glob: 监控 .opencode/docs/ 新文档
