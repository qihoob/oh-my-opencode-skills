# oh-my-opencode-skills

Claude Code 技能库 — 59 个结构化 SKILL.md 技能，覆盖完整 SDLC 流程。

通过 `CLAUDE.md` 配置加载，Claude Code 自动读取 SKILL.md 文件执行，无需注册。

---

## 快速开始

### 一键安装（推荐）

```bash
curl -fsSL https://raw.githubusercontent.com/qihoob/oh-my-opencode-skills/main/install.sh | bash
```

支持 `wget`：

```bash
wget -qO- https://raw.githubusercontent.com/qihoob/oh-my-opencode-skills/main/install.sh | bash
```

自定义安装路径：

```bash
SKILL_DIR=~/my-skills curl -fsSL https://raw.githubusercontent.com/qihoob/oh-my-opencode-skills/main/install.sh | bash
```

`install.sh` 会自动完成：
- 检测 `curl` / `wget`，适配你的环境
- 克隆仓库到 `~/skill`（已安装则更新到最新版）
- 替换项目内 `{{SKILL_DIR}}` 占位符为实际绝对路径
- 生成 `~/.claude/CLAUDE.md` 全局配置（绝对路径，开箱即用）
- 幂等：重复执行只会更新，不会覆盖已有配置

### 本地安装

如果已经 clone 了仓库：

```bash
~/skill/install.sh                # 默认路径 ~/skill
~/skill/install.sh /opt/skills    # 自定义路径
```

### 使用

直接和 Claude Code 对话，说你想做什么：

```
> 需求分析用户登录功能
> 给我上下文，先看看代码
> 实现用户登录功能
> 帮我审查代码
> 设计测试用例
> 执行测试
```

Claude Code 会自动读取对应的 SKILL.md，按其中的步骤执行。

### 3. 自动链路

当用户说"完整流程"、"从零到上线"时，会自动按链路依次执行：

```
需求分析 → 需求交接 → 获取上下文 → 功能实现 → 实现验证 → 代码审查
→ 提测 → 用例设计 → 测试执行 → 验收 → 复盘 → 迭代闭环
```

每步产出的文档会自动触发下一步。

---

## 目录结构

```
skill/
├── system/                  # 系统引擎 (5)
│   ├── auto-skill-dispatcher/   # 自动调度器 — 识别意图、匹配技能
│   ├── chain-executor/          # 链路执行器 — 文档驱动的自推进引擎
│   ├── state-tracker/           # 状态追踪器 — 流程监控与角色通知
│   ├── document-integrity-check/ # 文档完整性检查
│   └── security/compliance/     # 安全合规检查
├── project/                 # 项目启动 (1)
│   └── kickoff/                 # 新项目初始化
├── product/                 # 产品规划 (10)
│   ├── requirement/             # 需求分析、整理、协同优化
│   ├── analysis/                # 项目分析、数据分析、技术评估
│   ├── module/                  # 模块需求、文档管理、页面最佳实践
│   └── feedback/                # 用户反馈分析
├── dev/                     # 开发实现 (17)
│   ├── context/                 # 开发上下文获取（全局/模块）
│   ├── implementation/          # 功能实现（通用/前端/后端）
│   ├── modules/                 # 模块协同、拆解、并行编排
│   ├── standards/               # 代码质量规范、前端规范
│   ├── code-review/             # 代码审查
│   ├── verify-implementation/   # 实现与需求匹配验证
│   ├── debugging/               # 系统化调试
│   ├── refactoring/             # 安全重构
│   ├── adr/                     # 架构决策记录
│   ├── dependency-eval/         # 依赖评估
│   └── context-restore/         # 上下文保存/恢复
├── qa/                      # 测试验证 (8)
│   ├── context/                 # 测试上下文（有文档/无文档/模块）
│   ├── test-case/               # 用例设计、优先级排序
│   ├── execution/               # 测试执行（接口/浏览器/手动）
│   └── advanced/                # E2E 测试、性能测试
├── collaboration/           # 协同交接 (9)
│   ├── handoff/                 # 需求交接、提测交接
│   ├── review/                  # 验收评审
│   ├── process/                 # 复盘、Bug 协调、迭代闭环
│   └── sync/                    # 文档对齐、上下文对齐、应急响应
├── devops/                  # DevOps (7)
│   ├── ci/                      # CI/CD 流水线
│   ├── deploy/                  # Docker、K8s、多环境
│   ├── monitoring/              # 监控可观测性
│   ├── data/                    # 数据库迁移
│   └── cost-optimization/       # 成本优化
└── visual/                  # 视觉设计 (2)
    ├── design-handoff/          # 设计稿交接
    └── design-review/           # 设计评审
```

---

## 技能清单

### System - 系统引擎 (5)

| 技能 | 说明 | 触发词 |
|------|------|--------|
| `system/auto-skill-dispatcher` | 自动识别意图匹配技能 | 所有输入 — 自动识别 |
| `system/chain-executor` | 文档驱动的自推进流程引擎 | 执行链路、运行流程、自驱动 |
| `system/state-tracker` | 流程监控、状态追踪、角色通知 | 项目进度、当前状态 |
| `system/document-integrity-check` | 文档链完整性 + 内容一致性检查 | 文档检查、文档审计 |
| `system/security/compliance` | 安全审计与合规检查 | 安全审计、合规、GDPR、SOC2 |

### Project - 项目启动 (1)

| 技能 | 说明 | 触发词 |
|------|------|--------|
| `project/kickoff` | 新项目初始化 | 启动项目、新项目、项目初始化 |

### Product - 产品规划 (10)

| 技能 | 说明 | 触发词 |
|------|------|--------|
| `product/requirement/product-requirement-analysis` | 需求分析 + 用户故事 + 验收标准 | 需求分析、用户故事 |
| `product/requirement/product-requirement-structuring` | 需求整理与结构化 | 需求整理、结构化需求 |
| `product/requirement/product-collaborative-requirement-optimization` | 协同需求评审与优化 | 需求评审、三方评审、需求优化 |
| `product/analysis/global-project-analysis` | 项目全局分析 + 健康检查 | 项目分析、模块划分、项目体检 |
| `product/analysis/data-analysis` | 数据分析与埋点设计 | 数据分析、埋点、指标设计 |
| `product/analysis/product-technical-assessment` | 技术可行性评估 | 技术评估、开发成本 |
| `product/module/module-product-requirement` | 模块级需求细化 | 模块需求、需求拆解 |
| `product/module/module-document-keeper` | 模块文档管理与汇总 | 模块文档、把控全局 |
| `product/module/product-page-feature-best-practices` | 页面功能设计规范 | 页面设计、交互规范 |
| `product/feedback/analysis` | 用户反馈分析 | 用户反馈、NPS、A/B 测试 |

### Dev - 开发实现 (17)

| 技能 | 说明 | 触发词 |
|------|------|--------|
| `dev/context/dev-context-first` | 开发前获取最小上下文 | 给我上下文、先看看代码 |
| `dev/context/module-dev-context` | 模块级上下文获取 | 模块上下文、了解模块 |
| `dev/implementation/dev-implementation` | 通用功能实现（含 Bug 修复、TDD 模式） | 实现功能、编写代码 |
| `dev/implementation/frontend` | 前端专项开发 | 前端开发、页面开发 |
| `dev/implementation/backend` | 后端专项开发 | 后端开发、API 开发 |
| `dev/code-review` | 代码审查（质量 + 安全 + 跨文件一致性） | 代码审查、CR、Review |
| `dev/verify-implementation` | 实现与需求匹配验证 + 跨层一致性检查 | 需求匹配、实现检查 |
| `dev/standards/dev-code-quality` | 代码质量规范 | lint、eslint、代码规范 |
| `dev/standards/dev-frontend-standards` | 前端开发规范 | 前端规范、响应式、a11y |
| `dev/modules/module-collaborative-dev` | 多模块协同开发 + 契约定义 | 多模块协同、前后端协同 |
| `dev/modules/module-splitting` | 模块拆解 | 模块拆解、划分模块 |
| `dev/modules/parallel-module-orchestrator` | 并行模块开发编排 | 并行开发、多模块编排 |
| `dev/debugging` | 系统化调试（复现 → 定位 → 修复） | 调试、debug、排查问题 |
| `dev/refactoring` | 安全重构（小步 + 每步验证） | 重构、refactor |
| `dev/adr` | 架构决策记录 | ADR、架构决策、技术选型 |
| `dev/dependency-eval` | 依赖引入评估 | 评估依赖、引入依赖 |
| `dev/context-restore` | 上下文保存与恢复 | 保存上下文、恢复上下文 |

### QA - 测试验证 (8)

| 技能 | 说明 | 触发词 |
|------|------|--------|
| `qa/context/qa-context-first` | 测试前获取上下文（有需求文档） | 测试上下文、了解被测功能 |
| `qa/context/qa-context-from-code` | 从代码逆向推导测试上下文（无文档） | 半路测试、没有需求文档、从代码分析 |
| `qa/context/module-test-context` | 模块级测试上下文 | 模块测试、测试前 |
| `qa/test-case/test-case-design` | 测试用例设计（九维度覆盖） | 测试用例、设计用例 |
| `qa/test-case/test-case-prioritization` | 用例优先级排序 | 用例优先级、测试排序 |
| `qa/execution/test-executor` | 多模式测试执行（接口/浏览器/手动） | 执行测试、运行测试 |
| `qa/advanced/e2e-testing` | E2E 端到端测试 | E2E 测试、Playwright |
| `qa/advanced/performance-testing` | 性能测试 | 性能测试、压力测试 |

### Collaboration - 协同交接 (9)

| 技能 | 说明 | 触发词 |
|------|------|--------|
| `collaboration/handoff/collab-product-to-dev` | 产品 → 开发需求交接 | 需求交接、转开发 |
| `collaboration/handoff/collab-dev-to-qa` | 开发 → 测试提测交接 | 提测、测试交接 |
| `collaboration/review/collab-acceptance-review` | 验收评审 | 验收、UAT |
| `collaboration/process/collab-retrospective` | 迭代复盘 | 复盘、回顾、retro |
| `collaboration/process/bug-coordinator` | Bug 协调与分配 | Bug 协调、Bug 追踪 |
| `collaboration/process/iteration-closure` | 迭代闭环 → 下一迭代 | 迭代闭环、下一迭代 |
| `collaboration/sync/document-alignment` | 文档三方对齐 | 文档对齐、三方对齐 |
| `collaboration/sync/context-alignment` | 上下文对齐 | 同步、对齐、模块协调 |
| `collaboration/sync/incident` | 线上故障应急响应 | 线上故障、P0、应急 |

### DevOps (7)

| 技能 | 说明 | 触发词 |
|------|------|--------|
| `devops/ci/pipeline` | CI/CD 流水线配置 | CI/CD、流水线、GitHub Actions |
| `devops/deploy/dockerfile` | Docker 容器化 | Docker、容器化 |
| `devops/deploy/k8s` | Kubernetes 部署 | K8s、Kubernetes |
| `devops/deploy/multi-env` | 多环境管理 | 多环境、dev/staging/prod |
| `devops/monitoring/observability` | 监控可观测性 | 监控、告警、Grafana |
| `devops/data/migration` | 数据库迁移 | 数据库迁移、DDL |
| `devops/cost-optimization` | 成本优化 | 成本优化、FinOps |

### Visual - 视觉设计 (2)

| 技能 | 说明 | 触发词 |
|------|------|--------|
| `visual/design-handoff` | 设计稿交接 | 设计交接、UI 交接 |
| `visual/design-review` | 设计评审 | 设计评审、视觉确认 |

---

## 核心链路

### 链路 1: 完整 SDLC (12 步)

```
用户说："实现用户登录功能" 或 "完整流程"

product-requirement-analysis       # 1. 需求分析 → 产出 requirement-*.md
  → collab-product-to-dev          # 2. 需求交接 → 产出 handoff-*.md
    → dev-context-first            # 3. 获取开发上下文
      → dev-implementation         # 4. 功能实现 → 产出 implementation-*.md
        → verify-implementation    # 5. 实现验证（需求匹配 + 跨层一致性）
          → dev-code-review        # 6. 代码审查 → 产出 code-review-*.md
            → collab-dev-to-qa     # 7. 提测交接 → 产出 handoff-dev-to-qa.md
              → test-case-design   # 8. 用例设计 → 产出 test-cases-*.md
                → test-executor    # 9. 测试执行 → 产出 test-report-*.md
                  → collab-acceptance-review  # 10. 验收评审
                    → collab-retrospective    # 11. 迭代复盘
                      → iteration-closure     # 12. 迭代闭环
```

### 链路 2: Bug 修复闭环

```
测试失败 → 判断严重程度

快速修复路径（失败 ≤ 3 个且 P2/P3）：
  dev-implementation(快速修复) → test-executor(回归) → 通过 → 关闭

正式 Bug 路径（失败 > 3 个或有 P0/P1）：
  bug-coordinator(分配) → dev-implementation(Bug修复) → test-executor(回归) → 关闭
```

### 链路 3: 线上故障

```
用户说："支付服务挂了"

incident(止血) → dev-context-first(定位) → dev-implementation(修复) → test-executor(验证)
```

### 链路 4: 新项目启动

```
用户说："启动新项目"

project-kickoff → global-project-analysis → module-splitting
  → parallel-module-orchestrator → dev-implementation(各模块)
```

### 更多链路

| 链路 | 步骤 | 触发词 |
|------|------|--------|
| 文档治理 | module-document-keeper → document-integrity-check → document-alignment | 文档整理、文档审计 |
| DevOps 部署 | pipeline → dockerfile → k8s → multi-env → observability → cost-optimization | 部署、上线 |
| 前后端分离 | collaborative-optimization → module-collaborative-dev → frontend + backend(并行) → verify | 前后端分离 |
| 设计转代码 | design-review → design-handoff → frontend | 设计稿转代码 |
| 安全重构 | refactoring → test-executor → code-review → adr(如涉及架构变更) | 重构 |
| 依赖引入 | dependency-eval → dev-implementation → adr | 引入依赖 |

---

## 核心机制

### 自驱动（文档触发）

每个技能产出的文档会自动触发下一个技能，无需人工推流程：

```
requirement-*.md 产出 → 自动触发需求交接
implementation-*.md 产出 → 自动触发实现验证
code-review-*.md(通过) → 自动触发提测
test-report-*.md(失败) → 自动生成 Bug 单 → 自动分配修复
acceptance-report.md(通过) → 自动触发复盘
```

### 变更清洁

每次代码变更遵循**先证明安全、再执行删除**：

1. grep 全局搜索待删项的引用数
2. 引用数 = 0 → 安全删除
3. 引用数 > 0 且有范围外引用 → 不删除，标记 `@deprecated`
4. 删除后运行测试确认无回归

覆盖在 `dev-implementation`、`debugging`、`refactoring`、`verify-implementation`、`code-review` 五个技能中。

### 契约先行

跨层功能（前端/后端/数据库）必须先产出 `contract-*.md`，三层按同一契约实现。`verify-implementation` 会自动检查三层一致性。

### 健康检查

在提测前、验收前、迭代结束时自动执行项目健康检查，检测文档链完整性、需求实现度、契约一致性、代码健康度、架构偏移度。

---

## 角色技能映射

| 角色 | 核心技能 |
|------|---------|
| **产品经理** | requirement-analysis, collaborative-optimization, global-project-analysis, product-technical-assessment, data-analysis, feedback-analysis, collab-product-to-dev, collab-acceptance-review |
| **开发工程师** | dev-context-first, dev-implementation, frontend, backend, code-review, debugging, refactoring, module-collaborative-dev, verify-implementation |
| **测试工程师** | qa-context-first, qa-context-from-code, test-case-design, test-executor, e2e-testing, performance-testing, collab-dev-to-qa |
| **DevOps** | pipeline, dockerfile, k8s, multi-env, observability, migration, cost-optimization |
| **技术负责人** | code-review, module-splitting, parallel-module-orchestrator, adr, document-integrity-check, security/compliance, collab-retrospective |
| **视觉设计师** | design-handoff, design-review, product-page-feature-best-practices |

---

## 文档产出

技能执行过程中会在 `.opencode/docs/` 下产出结构化文档：

| 文档模式 | 产出技能 | 消费技能 |
|----------|---------|---------|
| `requirement-{feature}.md` | product-requirement-analysis | 开发、测试、验收 |
| `contract-{feature}.md` | module-collaborative-dev | 前端、后端、验证 |
| `implementation-{feature}.md` | dev-implementation | 审查、测试、验收 |
| `code-review-{feature}.md` | code-review | 提测 |
| `handoff-dev-to-qa.md` | collab-dev-to-qa | 测试 |
| `test-cases-{feature}.md` | test-case-design | 测试执行 |
| `test-report-{feature}.md` | test-executor | 验收、Bug 协调 |
| `bug-{module}-{seq}.md` | test-executor | Bug 协调、修复 |
| `acceptance-report.md` | collab-acceptance-review | 复盘 |
| `health-check-{date}.md` | global-project-analysis | 迭代闭环 |

---

## 统计

| 分类 | 数量 |
|------|------|
| System | 5 |
| Project | 1 |
| Product | 10 |
| Dev | 17 |
| QA | 8 |
| Collaboration | 9 |
| DevOps | 7 |
| Visual | 2 |
| **总计** | **59** |

---

**版本**: v4.0
**最后更新**: 2026-04-18
