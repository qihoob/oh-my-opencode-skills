---
name: chain-executor
description: 技能链路自驱动引擎 - 文档驱动的自动流程推进，含迭代回退、CI快速修复循环、非线性流程支持
version: "3.0"
---

# Skill: chain-executor

**角色**: 系统 (System)
**功能**: 文档驱动的自推进引擎
**触发词**: 执行链路、运行流程、开始流程、auto-run、自驱动、自动推进
**版本**: 3.0 (增加迭代回退、CI快速修复循环、非线性流程)

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

**匹配原则**：如一个文件名同时命中多个规则，优先使用**更具体**的模式（如 `requirement-structure-*` 优先于 `requirement-*`）。

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
| `handoff-dev-to-qa.md` | `qa-context-first` 或 `test-case-design` | 无条件触发 |
| `qa-context-report-*.md` | `test-case-design` | 无条件触发 |
| `test-cases-*.md` | `test-executor` | 无条件触发 |
| `test-report-*.md` (全部通过) | `collab-acceptance-review` | 测试通过 |
| `test-report-*.md` (有失败) | `bug-coordinator` | 测试失败 |
| `bug-{module}-{seq}.md` | `bug-coordinator` (分配) | 自动分配 |
| `bug-分配单` | `dev-implementation`(Bug修复模式) | 分配完成 |
| `bug-{module}-{seq}.md` (修复后更新) | `test-executor`(回归) | 修复完成 |
| `acceptance-report.md` (通过) | `collab-retrospective` | 验收通过 |
| `acceptance-report.md` (不通过) | `dev-implementation`(修复) | 验收不通过 |
| `retrospective-report.md` | `iteration-closure` | 无条件触发 |
| `iteration-closure.md` | `global-project-analysis`(健康检查) | 无条件触发 |
| `health-check-*.md` | 下一迭代规划 | 健康报告产出 |
| `incident-report-*.md` | `bug-coordinator` 或 `dev-implementation`(修复) | 止血完成 |
| `bugfix-*.md` | `test-executor`(回归) | 调试修复完成 |
| `quickfix-*.md` | `test-executor`(回归) | 快速修复完成 |
| `requirement-structure-*.md` | `product-collaborative-requirement-optimization`(需评审) 或 `product-requirement-analysis`(补充AC) | 需求结构化完成 |
| `requirement-review-*.md` | `collab-product-to-dev` | 需求评审完成 |
| `reverse-requirement-*.md` | `collab-product-to-dev` 或 `product-requirement-analysis` | 逆向伪需求完成 |
| `data-tracking-*.md` | `dev-implementation` | 埋点设计完成 |
| `design-review-*.md` | `visual/design-handoff` | 设计评审完成 |
| `design-handoff-*.md` | `dev/implementation/frontend` | 设计交接完成 |
| `feedback-analysis-*.md` | `product-requirement-analysis` | 反馈分析完成 |
| `page-best-practices-*.md` | `dev/implementation/frontend` | 页面最佳实践完成 |
| `context-alignment-*.md` | `dev-implementation`(按对齐结果修正) | 上下文对齐完成 |
| `alignment-*.md` | `dev-implementation`(按对齐结果修正) | 文档对齐完成 |
| `dep-eval-*.md` | `dev-implementation`(如决定引入) | 依赖评估完成 |
| `refactoring-*.md` | `dev-code-review` | 重构完成 |
| `e2e-test-plan-*.md` | `qa/execution/test-executor` | E2E测试计划完成 |
| `context-snapshot-*.md` | `dev-implementation`(恢复后继续) | 上下文快照保存 |
| `security-audit-*.md` | `dev-implementation`(如有问题) → `dev-code-review`(修复后复审) | 安全审计完成 |
| `cost-optimization-*.md` | - | 成本优化建议完成 |
| `module-splitting-*.md` | `parallel-module-orchestrator` | 模块拆解完成 |
| `module-orchestration-*.md` | `dev-implementation`(各模块并行) | 模块编排完成 |
| `module-context-*.md` | `parallel-module-orchestrator` | 模块上下文产出 |
| `adr-*.md` | - | 架构决策记录完成 |
| `project-overview.md` | `product-technical-assessment`、`product-requirement-analysis` 或 `module-splitting` | 项目概览完成 |
| `performance-test-report-*.md` | `dev-implementation`(如不达标) 或 `collab-acceptance-review`(达标) | 性能测试完成 |
| `module-test-context-*.md` | `qa/test-case/test-case-design` | 模块测试上下文获取 |
| `db-schema-*.md` | `devops/data/schema-review` | 数据库设计完成 |
| `db-review-*.md` (通过) | `devops/data/migration` | 数据库设计评审通过 |
| `db-review-*.md` (不通过) | `devops/data/schema-design`（修改设计） | 数据库设计评审不通过 |
| `db-change-impact-*.md` | `devops/data/schema-design`（更新设计）或 `dev-implementation`（修复） | 数据库变更影响分析完成 |

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

### 规则四：迭代回退（非线性流程）

```
流程不是单向的。以下场景允许回退到上游步骤：

4.1 需求回退
  触发条件:
    - dev-context-first 发现需求不明确 / 有矛盾
    - dev-implementation 发现需求无法实现 / 需要拆分
    - test-case-design 发现 AC 不可验证
  回退到: product-requirement-analysis
  操作:
    - 标注回退原因（哪个点不明确/不可行/不可验证）
    - 产出 question-for-product.md（问题清单）
    - 不删除已有文档，等需求更新后继续

4.2 设计回退
  触发条件:
    - dev-implementation 发现方案设计有严重缺陷
    - verify-implementation 发现跨层不一致（接口/数据模型/状态机）
  回退到: module-collaborative-dev（重新产出契约）
  操作:
    - 标注不一致的具体位置
    - 更新 contract-*.md
    - 相关模块同步更新

4.3 实现回退
  触发条件:
    - dev-code-review 发现实现方案问题（非代码风格问题）
    - collab-acceptance-review 发现功能与需求不符
  回退到: dev-implementation
  操作:
    - 带着审查意见回到实现
    - 重新评估方案设计
    - 修复后重新走验证流程

4.4 回退保护
  - 同一个节点最多回退 3 次，超过 3 次暂停并提示人工介入
  - 回退时保留所有已有文档，不删除
  - 每次回退记录原因，避免反复回退
```

### 规则五：CI 快速修复循环

```
当测试执行器（test-executor）或代码审查（code-review）发现问题时，
不走完整的 bug-coordinator 流程，而是直接快速修复：

5.1 测试失败快速修复
  触发条件: test-executor 产出 test-report，有失败用例

  快速路径（失败用例 ≤ 3 个且为 P2/P3 级别）:
    test-report-*.md (有失败)
      → [直接] dev-implementation (快速修复模式)
        → 只修复失败用例对应的问题
        → 产出 quickfix-{id}.md
      → [自动] test-executor (回归测试)
        → 通过 → 回到正常流程
        → 失败 → 再次快速修复（最多 2 轮）
        → 2 轮后仍失败 → 升级为正式 Bug → bug-coordinator

  正式路径（失败用例 > 3 个或有 P0/P1 级别）:
    test-report-*.md (有失败)
      → [自动] bug-coordinator
      → [自动] dev-implementation (Bug修复模式)
      → [自动] test-executor (回归测试)

5.2 代码审查问题快速修复
  触发条件: dev-code-review 产出 code-review，有修改建议

  快速路径（修改建议 ≤ 5 个且非安全问题）:
    code-review-*.md (有问题)
      → [直接] dev-implementation (快速修复模式)
        → 逐条修复审查意见
        → 更新 code-review 文档标注已修复
      → [自动] dev-code-review (复审)
        → 通过 → 回到正常流程
        → 不通过 → 再次修复（最多 2 轮）

  正式路径（修改建议 > 5 个或有安全问题）:
    code-review-*.md (有严重问题)
      → 回退到 dev-implementation（重新评估方案）

5.3 快速修复 vs 正式 Bug 流程判断
  ┌──────────────────┬────────────────────┐
  │ 快速修复          │ 正式 Bug 流程      │
  ├──────────────────┼────────────────────┤
  │ 失败用例 ≤ 3      │ 失败用例 > 3       │
  │ P2/P3 级别       │ P0/P1 级别        │
  │ 单模块影响        │ 跨模块影响         │
  │ 修复预计 < 10 分钟│ 修复预计 > 10 分钟 │
  │ 不涉及数据迁移    │ 涉及数据迁移       │
  │ 不涉及接口变更    │ 涉及接口变更       │
  └──────────────────┴────────────────────┘
```

---

## 预定义链路（10 条）

### 链路 1: 完整 SDLC（自驱动）

```
用户说："实现用户登录功能"

product-requirement-analysis
  → 产出 requirement-login.md
  → [可选] product-collaborative-requirement-optimization（复杂需求建议评审）
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
  → 判断: 快速修复 or 正式 Bug?

  快速修复路径:
    → [直接] dev-implementation (快速修复)
      → [自动] test-executor (回归)
        → 通过 → Bug 关闭
        → 失败 → 再修一轮（最多2轮）
        → 2轮后仍失败 → 升级为正式 Bug

  正式 Bug 路径:
    → [自动] 生成 bug-{module}-{seq}.md
    → [自动] bug-coordinator 分析分配
      → 产出 bug-分配单
      → [自动] dev-implementation (Bug修复模式)
        → 更新 bug-{module}-{seq}.md（添加修复记录）
        → [自动] test-executor (回归测试)
          → 通过 → [自动] Bug 关闭
          → 失败 → [自动] 退回 dev-implementation (循环)
```

### 链路 3: 线上故障（自驱动）

```
用户说："支付服务挂了"

incident
  → 产出 incident-report-{id}.md (止血完成)
  → [自动] bug-coordinator (分析影响、分配修复)
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
devops/data/schema-design
  → 产出 db-schema-*.md
  → [自动] devops/data/schema-review
    → 产出 db-review-*.md (通过)
    → [自动] devops/data/migration
      → [自动] devops/data/change-impact
        → [自动] system/security/compliance
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

### 流程控制命令

```
用户可以在任意节点发出以下命令：

"回退到需求" / "回到需求分析"
  → 回退到 product-requirement-analysis
  → 保留已有文档，标注回退原因

"回退到设计" / "回到方案设计"
  → 回退到 dev-implementation (方案设计阶段)
  → 保留已有文档，标注回退原因

"跳过审查" / "跳过 code review"
  → 跳过 dev-code-review，直接进入 collab-dev-to-qa
  → 标注跳过原因（仅限紧急情况）

"跳过验证" / "跳过 verify"
  → 跳过 verify-implementation，直接进入 dev-code-review
  → 标注跳过原因

"暂停" / "暂停流程"
  → 在当前步骤暂停，保存状态
  → 可随时用"继续"恢复

"重试" / "重试当前步骤"
  → 重新执行当前步骤
  → 适用于外部环境问题导致的失败

"状态" / "流程状态"
  → 显示当前流程进度
  → 显示已完成步骤和下一步
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
- read: 读取 SKILL.md 文件加载并执行技能；读取 state.json 和产出文档
- write: 更新 state.json
- glob: 监控 .opencode/docs/ 新文档
