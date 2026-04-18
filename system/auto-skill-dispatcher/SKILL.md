---
name: auto-skill-dispatcher
description: 自动技能调度器 - 根据用户输入自动识别任务类型并选择合适的技能，支持链路式调用和条件分支
version: "4.0"
---

# Skill: auto-skill-dispatcher

**角色**: 系统 (System)
**功能**: 自动技能调度器
**触发关键词**: [所有关键词]
**版本**: 4.0 (覆盖 59 个技能，支持链路调用)

## 核心能力

1. **意图识别** — 分析用户输入，识别任务类型，匹配置信度评分，支持多意图识别
2. **技能匹配** — 关键词匹配、语义理解、上下文推断、链路推荐
3. **链路调度** — 单技能执行、多技能顺序执行、条件分支执行、自动推进/暂停
4. **状态追踪** — 执行状态记录、文档流转追踪、技能依赖检查

---

## 调度规则

### 产品技能 (10)

| 用户输入 | 触发技能 | 推荐下一步 |
|----------|----------|------------|
| 需求分析、用户故事 | product/requirement/product-requirement-analysis | → collab-product-to-dev 或 product-collaborative-requirement-optimization |
| 需求整理、结构化 | product/requirement/product-requirement-structuring | → product-requirement-analysis |
| 需求评审、三方评审 | product/requirement/product-collaborative-requirement-optimization | → collab-product-to-dev |
| 项目分析、模块划分 | product/analysis/global-project-analysis | → product-technical-assessment |
| 数据分析、埋点 | product/analysis/data-analysis | → dev-implementation |
| 技术评估、可行性 | product/analysis/product-technical-assessment | → module-product-requirement |
| 模块需求、详细需求 | product/module/module-product-requirement | → dev-context-first |
| 模块文档、文档整理 | product/module/module-document-keeper | → document-integrity-check |
| 页面最佳实践、交互规范 | product/module/product-page-feature-best-practices | → dev/implementation/frontend |
| 用户反馈、NPS | product/feedback/analysis | → product-requirement-analysis |

### 开发技能 (12)

| 用户输入 | 触发技能 | 推荐下一步 |
|----------|----------|------------|
| 给我上下文、先看看代码 | dev/context/dev-context-first | → dev-implementation |
| 模块上下文、了解模块 | dev/context/module-dev-context | → dev-implementation |
| 实现功能、编写代码 | dev/implementation/dev-implementation | → dev-code-review |
| 前端开发、页面开发 | dev/implementation/frontend | → dev-frontend-standards |
| 后端开发、API开发 | dev/implementation/backend | → dev-code-review |
| 代码审查、CR | dev/code-review | → collab-dev-to-qa (通过) 或 dev-implementation (失败) |
| 代码质量、lint | dev/standards/dev-code-quality | → dev-code-review |
| 前端规范、响应式 | dev/standards/dev-frontend-standards | → dev/implementation/frontend |
| 多模块协同开发 | dev/modules/module-collaborative-dev | → parallel-module-orchestrator |
| 模块拆解、划分模块 | dev/modules/module-splitting | → parallel-module-orchestrator |
| 并行开发、多模块编排 | dev/modules/parallel-module-orchestrator | → dev-implementation |
| 需求匹配、代码验证 | dev/verify-implementation | → dev-implementation (如不匹配) |

### 测试技能 (8)

| 用户输入 | 触发技能 | 推荐下一步 |
|----------|----------|------------|
| 测试上下文、了解被测功能 | qa/context/qa-context-first | → test-case-design |
| 半路测试、没有需求文档、从代码分析 | qa/context/qa-context-from-code | → test-case-design |
| 模块测试、测试前 | qa/context/module-test-context | → test-case-design |
| 测试用例、设计用例 | qa/test-case/test-case-design | → test-case-prioritization |
| 用例优先级、测试排序 | qa/test-case/test-case-prioritization | → test-executor |
| 执行测试、运行测试 | qa/execution/test-executor | → collab-acceptance-review (通过) 或 bug-coordinator (失败) |
| E2E测试、Playwright | qa/advanced/e2e-testing | → test-executor |
| 性能测试、负载测试 | qa/advanced/performance-testing | → dev-implementation (如不达标) |

### 协同技能 (9)

| 用户输入 | 触发技能 | 前置条件 | 推荐下一步 |
|----------|----------|----------|------------|
| 需求交接、转开发 | collab-product-to-dev | requirement-*.md | → dev-context-first |
| 提测、测试交接 | collab-dev-to-qa | code-review-*.md + 提测前检查点 | → test-case-design |
| 验收、UAT | collab-acceptance-review | test-report-*.md + 验收前健康快照 | → collab-retrospective 或 iteration-closure |
| 复盘、回顾 | collab-retrospective | - | → iteration-closure |
| Bug协调、Bug追踪 | bug-coordinator | - | → dev-implementation (修复) |
| 迭代闭环、下一迭代 | iteration-closure | collab-retrospective 完成 + 迭代健康检查 | → global-project-analysis |
| 文档对齐、三方对齐 | document-alignment | DOC_AUDIT.md | - |
| 同步、对齐 | context-alignment | - | - |
| 线上故障、应急 | incident | - | → bug-coordinator → dev-implementation |
| 项目体检、健康检查 | global-project-analysis(健康检查模式) | - | → 产出 health-check-*.md |

### DevOps 技能 (7)

| 用户输入 | 触发技能 | 推荐下一步 |
|----------|----------|------------|
| CI/CD、流水线 | devops/ci/pipeline | → dockerfile |
| Docker、容器化 | devops/deploy/dockerfile | → k8s |
| K8s、Kubernetes | devops/deploy/k8s | → multi-env |
| 多环境、环境配置 | devops/deploy/multi-env | → observability |
| 监控、告警、日志 | devops/monitoring/observability | - |
| 数据库迁移、DDL | devops/data/migration | → security-compliance |
| 成本优化、云成本 | devops/cost-optimization | - |

### 系统技能 (5)

| 用户输入 | 触发技能 | 推荐下一步 |
|----------|----------|------------|
| 执行链路、运行流程 | system/chain-executor | (链路管理) |
| 安全审计、合规检查 | system/security/compliance | → dev-code-review (如有问题) |
| 文档检查、完整性检查 | system/document-integrity-check | → document-alignment |

### 项目技能 (1)

| 用户输入 | 触发技能 | 推荐下一步 |
|----------|----------|------------|
| 启动项目、新项目 | project/kickoff | → global-project-analysis → module-splitting |

### 视觉技能 (2)

| 用户输入 | 触发技能 | 推荐下一步 |
|----------|----------|------------|
| 设计稿交接、UI交接 | visual/design-handoff | → dev/implementation/frontend |
| 设计评审、视觉确认 | visual/design-review | → design-handoff 或 product-page-feature-best-practices |

---

## 链路识别

### 链路 1: 完整 SDLC (12 步)
```
触发词: "完整流程", "端到端", "从零到上线"

product-requirement-analysis → collab-product-to-dev → dev-context-first
→ dev-implementation → verify-implementation → dev-code-review → collab-dev-to-qa
→ test-case-design → test-executor → collab-acceptance-review
→ collab-retrospective → iteration-closure
```

### 链路 2: Bug 修复闭环 (6+ 步)
```
触发词: "bug", "修复", "报错", "错误"

test-executor (发现失败)
  → 自动生成 bug-{id}.md
  → bug-coordinator (分析+分配，生成分配单)
  → dev-implementation (Bug修复模式: 读分配单 → 根因分析 → 最小修复)
  → test-executor (回归测试)
       ↓
  通过 → Bug 关闭
  失败 → 退回 dev-implementation (标注新问题，循环)
```

### 链路 3: 线上故障 (4 步)
```
触发词: "线上故障", "服务挂了", "P0", "应急"

incident → dev-context-first → dev-implementation → test-executor
                                                         ↓
                                                  通过 → collab-retrospective
```

### 链路 4: 新项目启动 (7 步)
```
触发词: "新项目", "项目初始化", "从零开始"

project-kickoff → global-project-analysis → product-technical-assessment
→ module-splitting → parallel-module-orchestrator → dev-implementation → verify-implementation
```

### 链路 5: 文档治理 (3 步)
```
触发词: "文档", "对齐", "整理", "审计"

module-document-keeper → document-integrity-check → document-alignment
```

### 链路 6: DevOps 部署 (6 步)
```
触发词: "部署", "上线", "发布", "devops"

ci-pipeline → dockerfile → k8s → multi-env → observability → cost-optimization
```

### 链路 7: 数据迁移 (3 步)
```
触发词: "数据库迁移", "表结构变更"

dev-context-first → migration → security-compliance
```

### 链路 8: 用户反馈驱动优化 (4 步)
```
触发词: "用户反馈", "改进", "NPS下降"

feedback-analysis → product-requirement-analysis → dev-implementation → collab-acceptance-review
```

### 链路 9: 前后端分离开发 (6 步)
```
触发词: "前后端分离", "前后端协同"

product-collaborative-requirement-optimization → module-collaborative-dev
→ frontend + backend (并行) → verify-implementation → collab-dev-to-qa
```

### 链路 10: 设计到代码 (3 步)
```
触发词: "设计稿", "视觉交付", "设计转代码"

design-review → design-handoff → dev/implementation/frontend
```

---

## 前置依赖检查

在执行技能前，自动检查前置条件：

| 技能 | 前置依赖 | 检查方式 |
|------|----------|----------|
| dev-implementation | product-requirement-analysis | requirement-*.md 是否存在 |
| dev/implementation/frontend | dev-context-first 或 product-page-feature-best-practices | 上下文已获取 |
| dev/implementation/backend | contract-*.md（跨层时）或 dev-context-first | 契约文档是否存在 |
| dev-code-review | verify-implementation（或 dev-implementation） | verify-report-*.md 或 implementation-*.md 是否存在 |
| qa-test-case-design | product-requirement-analysis 或 qa-context-from-code | requirement-*.md 或逆向分析报告是否存在 |
| qa-test-executor | qa-test-case-design | test-cases-*.md 是否存在 |
| collab-product-to-dev | product-requirement-analysis | requirement-*.md 是否存在 |
| collab-dev-to-qa | dev-code-review | code-review-*.md 是否存在 |
| collab-acceptance-review | qa-test-executor | test-report-*.md 是否存在 |
| iteration-closure | collab-retrospective | 复盘报告是否存在 |
| parallel-module-orchestrator | module-splitting | 模块拆解报告是否存在 |
| module-collaborative-dev | product-requirement-analysis | requirement-*.md 是否存在 |
| verify-implementation | dev-implementation + contract-*.md（如有） | implementation-*.md 是否存在 |
| incident | - | 无前置，立即执行 |

---

## 智能推荐

### 技能完成后推荐

| 完成的技能 | 条件 | 推荐下一个 |
|------------|------|------------|
| product-requirement-analysis | - | collab-product-to-dev |
| product-collaborative-requirement-optimization | 通过 | collab-product-to-dev |
| product-technical-assessment | - | module-product-requirement |
| global-project-analysis | - | module-splitting |
| module-splitting | - | parallel-module-orchestrator |
| module-collaborative-dev | - | 产出 contract-*.md，然后 dev-implementation |
| dev-context-first | - | dev-implementation |
| dev-implementation | - | verify-implementation (含跨层检查) |
| dev-code-review | 通过 | collab-dev-to-qa |
| dev-code-review | 失败 | dev-implementation (修复) |
| verify-implementation | 全部匹配 + 跨层一致 | dev-code-review |
| verify-implementation | 有偏差 | dev-implementation (修正) |
| verify-implementation | 跨层不一致 | module-collaborative-dev (补充契约/对齐) |
| qa-test-case-design | - | test-case-prioritization |
| qa-test-executor | 全部通过 | collab-acceptance-review |
| qa-test-executor | 有失败 | bug-coordinator |
| bug-coordinator | 分配完成 | dev-implementation (修复) |
| collab-acceptance-review | 通过 | collab-retrospective |
| collab-retrospective | - | iteration-closure |
| iteration-closure | - | global-project-analysis (下一迭代) |
| incident | 止血完成 | dev-implementation (根因修复) |
| security-compliance | 有问题 | dev-code-review |

### 文档创建后推荐

| 创建的文档 | 推荐技能 | 提示信息 |
|------------|----------|----------|
| requirement-*.md | collab-product-to-dev | "需求文档已创建，是否交接给开发？" |
| contract-*.md | dev-implementation | "契约文档已定义，按契约开始实现？" |
| implementation-*.md | verify-implementation | "实现完成，是否验证需求匹配和跨层一致性？" |
| code-review-*.md | collab-dev-to-qa | "代码审查通过，是否需要提测？（提测前执行项目检查点）" |
| test-cases-*.md | qa-test-executor | "测试用例已设计，是否执行测试？" |
| test-report-*.md | collab-acceptance-review | "测试报告已生成，是否进行验收？（验收前执行健康快照）" |
| alignment-*.md | - | "文档已对齐" |
| DOC_AUDIT.md | document-alignment | "文档审计完成，是否对齐？" |
| security-audit-*.md | dev-code-review | "安全审计完成，是否修复问题？" |
| health-check-*.md | iteration-closure | "健康报告已生成，请查看偏移项并纳入迭代计划" |
| bug-*.md | bug-coordinator | "Bug 已记录，是否分配修复？" |
| Bug 分配单生成 | dev-implementation(Bug修复模式) | "Bug 已分配，请查看分配单开始修复" |
| 修复完成 | test-executor | "修复完成，请执行回归测试" |

---

## 条件分支

### 代码审查分支
```
dev-code-review
  ├── 轻微问题 → dev-implementation (修复) → dev-code-review (复验)
  ├── 严重问题 → product-collaborative-requirement-optimization (重新评估)
  └── 安全风险 → security-compliance (深入审计) → dev-implementation
```

### 测试失败分支
```
qa-test-executor (失败)
  ├── Bug → bug-coordinator → dev-implementation → test-executor (复测)
  ├── 需求偏差 → collab-product-to-dev (澄清) → dev-implementation
  └── 用例问题 → test-case-design (修订) → test-executor
```

### 验收分支
```
collab-acceptance-review
  ├── 通过 → collab-retrospective → iteration-closure
  ├── 有条件通过 → dev-implementation (修复) → collab-acceptance-review (复验)
  └── 不通过 → product-collaborative-requirement-optimization (重新评审)
```

### 性能测试分支
```
performance-testing
  ├── 达标 → cost-optimization
  └── 不达标 → dev-context-first → dev-implementation → performance-testing (复测)
```

### 跨层不一致分支
```
verify-implementation (发现跨层不一致)
  ├── 前后端不一致 → module-collaborative-dev (补充/修订契约) → dev-implementation (按契约修正)
  ├── 后端数据库不一致 → devops/data/migration (补字段/索引) → dev-implementation (适配)
  ├── 接口实现不一致 → dev-implementation (按契约修正实现)
  └── 新旧代码共存 → dev-implementation (执行变更清洁，删除旧代码)
```

---

## 输出格式

### 单技能调度
```markdown
## 任务识别
- **任务类型**: [产品/开发/测试/DevOps/协同/系统/视觉]
- **具体意图**: [用户想做什么]
- **触发技能**: {skill-name}

## 执行
[技能执行输出]

## 下一步建议
- [建议 1]
- [建议 2]
```

### 链路调度
```markdown
## 链路识别
- **链路名称**: {chain-name}
- **总步骤**: {total-steps}
- **当前步骤**: {current-step}/{total-steps}

## 执行进度
| 步骤 | 技能 | 状态 |
|------|------|------|
| 1 | {skill-1} | ✅ 完成 |
| 2 | {skill-2} | 🔄 执行中 |
| 3 | {skill-3} | ⏳ 等待 |

## 当前执行
[当前技能执行输出]

## 下一步
[下一步预览]
```

---

## 工具可用
- read: 读取 SKILL.md 文件加载并执行技能
- Agent: 创建子任务（如需并行执行）
- read/grep: 检查文档是否存在
- write: 写入执行状态
- glob: 扫描文件结构
