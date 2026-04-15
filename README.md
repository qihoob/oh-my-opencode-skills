# oh-my-opencode-skills

统一管理的 Skills 项目，按**角色**和**协同**两个维度组织，覆盖完整 SDLC 流程。

> 从 25 个技能扩展到 **53 个技能**，新增 Dev/QA/Collaboration/Visual 等多维度技能，实现全链路覆盖。

---

## 目录结构

```
skills/
├── collaboration/                              # 协同技能 (9 项)
│   ├── handoff/
│   │   ├── collab-product-to-dev/SKILL.md      # 产品->开发需求交接
│   │   └── collab-dev-to-qa/SKILL.md           # 开发->测试提测交接
│   ├── review/
│   │   └── collab-acceptance-review/SKILL.md   # 验收评审
│   ├── process/
│   │   ├── collab-retrospective/SKILL.md       # 迭代复盘
│   │   ├── bug-coordinator/SKILL.md            # Bug 协调器
│   │   └── iteration-closure/SKILL.md          # 迭代闭环
│   └── sync/
│       ├── document-alignment/SKILL.md         # 文档对齐
│       ├── context-alignment/SKILL.md          # 上下文对齐
│       └── incident/SKILL.md                   # 应急响应
├── dev/                                        # 开发技能 (12 项)
│   ├── context/
│   │   ├── dev-context-first/SKILL.md          # 开发前获取最小上下文
│   │   └── module-dev-context/SKILL.md         # 模块上下文获取
│   ├── implementation/
│   │   ├── dev-implementation/SKILL.md         # 通用功能实现
│   │   ├── frontend/SKILL.md                   # 前端开发实现
│   │   └── backend/SKILL.md                    # 后端开发实现
│   ├── code-review/SKILL.md                    # 代码审查 (增强版)
│   ├── standards/
│   │   ├── dev-code-quality/SKILL.md           # 代码质量规范
│   │   └── dev-frontend-standards/SKILL.md     # 前端开发规范
│   ├── modules/
│   │   ├── module-collaborative-dev/SKILL.md   # 多模块协同开发
│   │   ├── module-splitting/SKILL.md           # 模块拆解器
│   │   └── parallel-module-orchestrator/SKILL.md # 并行模块编排器
│   └── verify-implementation/SKILL.md          # 实现与需求匹配监督
├── devops/                                     # DevOps 技能 (7 项)
│   ├── ci/
│   │   └── pipeline/SKILL.md                   # CI/CD 流水线
│   ├── deploy/
│   │   ├── dockerfile/SKILL.md                 # Docker 部署
│   │   ├── k8s/SKILL.md                        # Kubernetes 部署
│   │   └── multi-env/SKILL.md                  # 多环境管理
│   ├── monitoring/
│   │   └── observability/SKILL.md              # 监控与可观测性
│   ├── data/
│   │   └── migration/SKILL.md                  # 数据库迁移
│   └── cost-optimization/SKILL.md              # 成本优化
├── product/                                    # 产品技能 (10 项)
│   ├── requirement/
│   │   ├── product-requirement-analysis/SKILL.md         # 需求分析
│   │   ├── product-requirement-structuring/SKILL.md      # 需求整理
│   │   └── product-collaborative-requirement-optimization/SKILL.md # 协同需求优化
│   ├── analysis/
│   │   ├── global-project-analysis/SKILL.md    # 项目全局分析
│   │   ├── data-analysis/SKILL.md              # 数据分析与埋点
│   │   └── product-technical-assessment/SKILL.md # 技术评估
│   ├── module/
│   │   ├── module-product-requirement/SKILL.md  # 模块需求细化
│   │   ├── module-document-keeper/SKILL.md     # 模块文档管理
│   │   └── product-page-feature-best-practices/SKILL.md # 页面功能最佳实践
│   └── feedback/
│       └── analysis/SKILL.md                   # 用户反馈分析
├── project/                                    # 项目技能 (1 项)
│   └── kickoff/SKILL.md                        # 项目启动
├── qa/                                         # 测试技能 (7 项)
│   ├── context/
│   │   ├── qa-context-first/SKILL.md           # 测试前获取最小上下文
│   │   └── module-test-context/SKILL.md        # 模块测试上下文
│   ├── test-case/
│   │   ├── test-case-design/SKILL.md           # 测试用例设计
│   │   └── test-case-prioritization/SKILL.md   # 测试用例优先级
│   ├── execution/
│   │   └── test-executor/SKILL.md              # 测试执行
│   └── advanced/
│       ├── e2e-testing/SKILL.md                # E2E 测试
│       └── performance-testing/SKILL.md        # 性能测试
├── system/                                     # 系统技能 (5 项)
│   ├── auto-skill-dispatcher/SKILL.md          # 自动技能调度器
│   ├── chain-executor/SKILL.md                 # 技能链路执行器
│   ├── state-tracker/SKILL.md                  # 执行状态追踪器
│   ├── document-integrity-check/SKILL.md       # 文档完整性检查
│   └── security/
│       └── compliance/SKILL.md                 # 安全合规
└── visual/                                     # 视觉技能 (2 项)
    ├── design-handoff/SKILL.md                 # 设计稿交接
    └── design-review/SKILL.md                  # 视觉设计评审
```

**总计**: 53 个技能，8 个分类，统一采用 `SKILL.md` 格式

---

## 完整 Skills 清单

### 1. Project - 项目管理 (1 项)

| Skill | 说明 | 触发词 |
|-------|------|--------|
| `project/kickoff` | 项目启动器 | 启动项目、新项目、项目初始化 |

### 2. Product - 产品 (10 项)

| Skill | 说明 | 触发词 |
|-------|------|--------|
| `product/requirement/product-requirement-analysis` | 需求分析与用户故事编写 | 需求分析、用户故事、需求澄清 |
| `product/requirement/product-requirement-structuring` | 需求整理与结构化 | 需求整理、结构化需求 |
| `product/requirement/product-collaborative-requirement-optimization` | 协同需求优化 | 协同需求、需求评审优化、多方需求 |
| `product/analysis/global-project-analysis` | 项目全局分析 | 项目分析、模块划分、全局梳理 |
| `product/analysis/data-analysis` | 数据分析与埋点 | 数据分析、埋点、指标 |
| `product/analysis/product-technical-assessment` | 技术评估 | 技术评估、技术可行性 |
| `product/module/module-product-requirement` | 模块需求细化 | 模块需求、详细需求 |
| `product/module/module-document-keeper` | 模块文档管理 | 模块文档、文档整理、把控全局 |
| `product/module/product-page-feature-best-practices` | 页面功能最佳实践 | 页面设计、功能最佳实践、页面规范 |
| `product/feedback/analysis` | 用户反馈分析 | 用户反馈、反馈分析、NPS、A/B 测试 |

### 3. Dev - 开发 (12 项)

| Skill | 说明 | 触发词 |
|-------|------|--------|
| `dev/context/dev-context-first` | 开发前获取最小上下文 | 给我上下文、先看看代码、先了解下 |
| `dev/context/module-dev-context` | 模块上下文获取 | 模块上下文、了解模块 |
| `dev/implementation/dev-implementation` | 通用功能实现 | 实现功能、编写代码、开发功能 |
| `dev/implementation/frontend` | 前端开发实现 | 前端开发、页面开发、组件实现 |
| `dev/implementation/backend` | 后端开发实现 | 后端开发、API 开发、接口实现 |
| `dev/code-review` | 代码审查 (增强版) | 代码审查、Code Review、CR、代码检查 |
| `dev/standards/dev-code-quality` | 代码质量规范 | 代码质量、ESLint、代码规范 |
| `dev/standards/dev-frontend-standards` | 前端开发规范 | 前端规范、响应式、前端标准 |
| `dev/modules/module-collaborative-dev` | 多模块协同开发 | 协同开发、多模块、前后端协同 |
| `dev/modules/module-splitting` | 模块拆解器 | 模块拆分、拆解模块、模块划分 |
| `dev/modules/parallel-module-orchestrator` | 并行模块编排器 | 并行开发、模块编排、多模块任务 |
| `dev/verify-implementation` | 实现与需求匹配监督 | 验证实现、需求匹配、实现检查 |

### 4. QA - 测试 (7 项)

| Skill | 说明 | 触发词 |
|-------|------|--------|
| `qa/context/qa-context-first` | 测试前获取最小上下文 | 测试上下文、了解被测功能、测试范围 |
| `qa/context/module-test-context` | 模块测试上下文 | 模块测试、测试模块上下文 |
| `qa/test-case/test-case-design` | 测试用例设计 | 测试用例、设计用例、测试场景 |
| `qa/test-case/test-case-prioritization` | 测试用例优先级排序 | 用例优先级、测试排序、测试资源分配 |
| `qa/execution/test-executor` | 测试执行 | 执行测试、运行测试、测试报告 |
| `qa/advanced/e2e-testing` | E2E 端到端测试 | E2E 测试、端到端测试、自动化测试 |
| `qa/advanced/performance-testing` | 性能测试 | 性能测试、压力测试、负载测试 |

### 5. Collaboration - 协同 (9 项)

| Skill | 说明 | 触发词 |
|-------|------|--------|
| `collaboration/handoff/collab-product-to-dev` | 产品->开发需求交接 | 需求交接、需求评审、开发确认 |
| `collaboration/handoff/collab-dev-to-qa` | 开发->测试提测交接 | 提测、测试交接、开发完成、申请测试 |
| `collaboration/review/collab-acceptance-review` | 验收评审 | 验收、UAT、验收评审、产品验收 |
| `collaboration/process/collab-retrospective` | 迭代复盘 | 复盘、回顾、总结、retro |
| `collaboration/process/bug-coordinator` | Bug 协调器 | Bug 协调、跨模块 Bug、Bug 追踪 |
| `collaboration/process/iteration-closure` | 迭代闭环 | 迭代闭环、下轮规划、迭代收尾 |
| `collaboration/sync/document-alignment` | 文档对齐 | 文档对齐、文档同步、三方对齐 |
| `collaboration/sync/context-alignment` | 上下文对齐 | 上下文对齐、需求对齐、模块协调 |
| `collaboration/sync/incident` | 应急响应 | 线上故障、紧急修复、应急响应 |

### 6. DevOps (7 项)

| Skill | 说明 | 触发词 |
|-------|------|--------|
| `devops/ci/pipeline` | CI/CD 流水线 | CI/CD、流水线、GitHub Actions、Jenkins |
| `devops/deploy/dockerfile` | Docker 部署 | Docker、容器化、dockerfile |
| `devops/deploy/k8s` | Kubernetes 部署 | K8s、Kubernetes、kubectl |
| `devops/deploy/multi-env` | 多环境管理 | 多环境、环境配置、dev/staging/prod |
| `devops/monitoring/observability` | 监控与可观测性 | 监控、告警、日志、链路追踪、Grafana |
| `devops/data/migration` | 数据库迁移 | 数据库迁移、数据变更、DDL、迁移脚本 |
| `devops/cost-optimization` | 成本优化 | 成本优化、云成本、FinOps、预算管理 |

### 7. System - 系统 (5 项)

| Skill | 说明 | 触发词 |
|-------|------|--------|
| `system/auto-skill-dispatcher` | 自动技能调度器 | [所有] - 自动识别任务类型 |
| `system/chain-executor` | 技能链路执行器 | 执行链路、运行流程、开始流程 |
| `system/state-tracker` | 执行状态追踪器 | 状态追踪、执行状态、链路进度 |
| `system/document-integrity-check` | 文档完整性检查 | 文档检查、完整性检查、文档审计 |
| `system/security/compliance` | 安全合规 | 安全审计、合规检查、GDPR、SOC2 |

### 8. Visual - 视觉 (2 项)

| Skill | 说明 | 触发词 |
|-------|------|--------|
| `visual/design-handoff` | 设计稿交接 | 设计交接、设计稿、切图交接 |
| `visual/design-review` | 视觉设计评审 | 设计评审、视觉评审、UI 评审 |

---

## 完整 SDLC 流程

```
项目启动 → 产品规划 → 设计交接 → 需求交接 → 开发实现 → 提测交接 → 测试验证 → 验收评审 → 上线部署 → 迭代复盘 → 迭代闭环
    ↓          ↓          ↓          ↓          ↓          ↓          ↓          ↓          ↓          ↓          ↓
 kickoff   requirement  design    交接单    implementation 提测单    test-cases  验收报告   部署配置    复盘报告   下轮规划
           产品分析     handoff
```

### 核心调用链路

#### 链路 1: 完整 SDLC (11 步)

```
product-requirement-analysis       # 1. 需求分析
  → collab-product-to-dev          # 2. 需求交接
    → dev-context-first            # 3. 获取开发上下文
      → dev-implementation         # 4. 功能实现
        → dev-code-review          # 5. 代码审查
          → collab-dev-to-qa       # 6. 提测交接
            → test-case-design     # 7. 测试用例设计
              → test-executor      # 8. 测试执行
                → collab-acceptance-review  # 9. 验收评审
                  → collab-retrospective    # 10. 迭代复盘
                    → iteration-closure     # 11. 迭代闭环
```

#### 链路 2: Bug 修复 (4 步)

```
bug-coordinator                    # 1. Bug 协调定位
  → dev-context-first              # 2. 获取上下文
    → dev-implementation           # 3. 修复实现
      → test-executor              # 4. 回归测试
```

#### 链路 3: 文档治理 (3 步)

```
module-document-keeper             # 1. 模块文档整理
  → document-integrity-check      # 2. 完整性检查
    → document-alignment          # 3. 三方文档对齐
```

#### 链路 4: DevOps 部署 (6 步)

```
pipeline                           # 1. CI/CD 流水线配置
  → dockerfile                     # 2. Docker 容器化
    → k8s                          # 3. K8s 部署配置
      → multi-env                  # 4. 多环境配置
        → observability            # 5. 监控可观测性
          → cost-optimization      # 6. 成本优化
```

#### 链路 5: 新项目启动 (5 步)

```
project-kickoff                    # 1. 项目启动
  → global-project-analysis       # 2. 项目全局分析
    → product-technical-assessment # 3. 技术评估
      → module-splitting           # 4. 模块拆解
        → parallel-module-orchestrator  # 5. 并行模块编排
```

#### 链路 6: 数据迁移 (3 步)

```
dev-context-first                  # 1. 了解现有结构
  → migration                      # 2. 数据库迁移
    → security/compliance          # 3. 安全合规检查
```

#### 链路 7: 用户反馈优化 (4 步)

```
feedback-analysis                  # 1. 用户反馈分析
  → product-requirement-analysis   # 2. 需求分析(基于反馈)
    → dev-implementation           # 3. 功能实现
      → collab-acceptance-review   # 4. 验收评审
```

---

## 使用方式

### 方式 1: 自动调度 (推荐)

```typescript
skill(name="system/auto-skill-dispatcher", user_message="帮我实现用户登录功能")
```

### 方式 2: 手动调用 Skill

```typescript
skill(name="product/requirement/product-requirement-analysis", user_message="分析用户注册需求")
```

### 方式 3: 通过 Task 加载 Skill

```typescript
task(
  category="unspecified-high",
  load_skills=["product/requirement/product-requirement-analysis"],
  prompt="分析用户登录功能需求"
)
```

### 方式 4: 完整流程调用

```typescript
// 阶段 1: 需求分析
task(category="unspecified-high", load_skills=["product/requirement/product-requirement-analysis"])

// 阶段 2: 开发实现
task(category="deep", load_skills=["dev/context/dev-context-first", "dev/implementation/dev-implementation"])

// 阶段 3: 测试验证
task(category="unspecified-high", load_skills=["qa/test-case/test-case-design", "qa/execution/test-executor"])
```

---

## 角色技能映射

| 角色 | 主要技能 |
|------|---------|
| **产品经理** | product-requirement-analysis, product-requirement-structuring, product-collaborative-requirement-optimization, global-project-analysis, data-analysis, product-technical-assessment, product-page-feature-best-practices, feedback-analysis, collab-product-to-dev, collab-acceptance-review, design-review |
| **开发工程师** | dev-context-first, module-dev-context, dev-implementation, frontend, backend, dev-code-quality, dev-frontend-standards, module-collaborative-dev, verify-implementation, collab-product-to-dev, collab-dev-to-qa |
| **测试工程师** | qa-context-first, module-test-context, test-case-design, test-case-prioritization, test-executor, e2e-testing, performance-testing, collab-dev-to-qa, collab-acceptance-review |
| **DevOps 工程师** | pipeline, dockerfile, k8s, multi-env, observability, migration, cost-optimization |
| **技术负责人** | code-review, module-splitting, parallel-module-orchestrator, module-document-keeper, document-integrity-check, document-alignment, security/compliance, collab-retrospective |
| **视觉设计师** | design-handoff, design-review, product-page-feature-best-practices |

---

## 配置

### oh-my-opencode.json

```json
{
  "$schema": "https://raw.githubusercontent.com/oh-my-opencode/schemas/main/oh-my-opencode.json",
  "skills": {
    "sources": ["/path/to/skills"],
    "autoLoad": true
  },
  "agents": {
    "sisyphus": {
      "defaultSkills": [
        "system/auto-skill-dispatcher",
        "system/chain-executor",
        "system/state-tracker",
        "system/document-integrity-check",
        "system/security/compliance",

        "project/kickoff",

        "product/requirement/product-requirement-analysis",
        "product/requirement/product-requirement-structuring",
        "product/requirement/product-collaborative-requirement-optimization",
        "product/analysis/global-project-analysis",
        "product/analysis/data-analysis",
        "product/analysis/product-technical-assessment",
        "product/module/module-product-requirement",
        "product/module/module-document-keeper",
        "product/module/product-page-feature-best-practices",
        "product/feedback/analysis",

        "dev/context/dev-context-first",
        "dev/context/module-dev-context",
        "dev/implementation/dev-implementation",
        "dev/implementation/frontend",
        "dev/implementation/backend",
        "dev/code-review",
        "dev/standards/dev-code-quality",
        "dev/standards/dev-frontend-standards",
        "dev/modules/module-collaborative-dev",
        "dev/modules/module-splitting",
        "dev/modules/parallel-module-orchestrator",
        "dev/verify-implementation",

        "qa/context/qa-context-first",
        "qa/context/module-test-context",
        "qa/test-case/test-case-design",
        "qa/test-case/test-case-prioritization",
        "qa/execution/test-executor",
        "qa/advanced/e2e-testing",
        "qa/advanced/performance-testing",

        "collaboration/handoff/collab-product-to-dev",
        "collaboration/handoff/collab-dev-to-qa",
        "collaboration/review/collab-acceptance-review",
        "collaboration/process/collab-retrospective",
        "collaboration/process/bug-coordinator",
        "collaboration/process/iteration-closure",
        "collaboration/sync/document-alignment",
        "collaboration/sync/context-alignment",
        "collaboration/sync/incident",

        "devops/ci/pipeline",
        "devops/deploy/dockerfile",
        "devops/deploy/k8s",
        "devops/deploy/multi-env",
        "devops/monitoring/observability",
        "devops/data/migration",
        "devops/cost-optimization",

        "visual/design-handoff",
        "visual/design-review"
      ],
      "skillSettings": {
        "dev/code-review": {
          "enableAutoReview": true,
          "requireTests": true,
          "minCoverage": 80,
          "blockOnSecurityIssues": true
        },
        "devops/monitoring/observability": {
          "defaultStack": "prometheus-grafana-jaeger",
          "enableGoldenSignals": true
        },
        "system/security/compliance": {
          "enableAutoScan": true,
          "complianceFrameworks": ["GDPR", "SOC2"],
          "blockOnCriticalVulnerabilities": true
        }
      }
    }
  },
  "hooks": {
    "preCommit": ["dev/code-review"],
    "prePush": ["qa/execution/test-executor", "system/security/compliance"],
    "preDeploy": ["devops/monitoring/observability", "devops/data/migration"]
  },
  "integrations": {
    "github": {
      "enablePRReview": true,
      "enableSecurityScan": true,
      "enableCoverageCheck": true
    },
    "sonarqube": {
      "enabled": true,
      "qualityGate": "default"
    },
    "codecov": {
      "enabled": true,
      "targetCoverage": 80
    }
  }
}
```

---

## 统计

| 指标 | 数值 |
|------|------|
| **技能总数** | 53 |
| **分类数** | 8 (Project, Product, Dev, QA, Collaboration, DevOps, System, Visual) |
| **覆盖阶段** | 7 (产品规划、协同交接、开发实现、测试验证、系统检查、项目管理、DevOps) |
| **产出文档** | 22+ (requirement-*.md, implementation-*.md, test-cases-*.md, test-report-*.md, etc.) |
| **核心链路** | 7 条 |

### 分类明细

| 分类 | 数量 |
|------|------|
| Product | 10 |
| Dev | 12 |
| QA | 7 |
| Collaboration | 9 |
| DevOps | 7 |
| System | 5 |
| Project | 1 |
| Visual | 2 |

---

## 文档

| 文档 | 说明 |
|------|------|
| [`TASK_CHECKLIST.md`](./docs/TASK_CHECKLIST.md) | 完整任务清单 - 53 个技能的详细 checklists |
| [`SKILL_INVOCATION_CHAIN.md`](./docs/SKILL_INVOCATION_CHAIN.md) | 技能调用链路 - 触发条件、依赖关系、输出流转 |

---

**版本**: v3.0
**最后更新**: 2026-04-15
