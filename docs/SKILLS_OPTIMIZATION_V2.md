# Skills 整合优化方案

## 核心理念

**不是精简，而是整合优化**
- 保留全部 87 个技能，不丢失任何信息
- 按「角色」+「协同」视角重新组织
- 消除目录层级混乱，明确边界

---

## 一、当前结构问题

```
问题1: 分类维度不统一
├── product/      (按角色)
├── dev/          (按角色)
├── qa/           (按角色)
├── collaboration/(按协作方式)
├── module-xxx/   (按范围)
├── devops/       (按技术域)
└── system/       (按系统)

问题2: 协同没有独立位置
└── 协同技能散落在各目录中

问题3: 模块技能重复
├── module-product-requirement
├── module_product_requirement
├── module-dev-context
├── module_dev_context
└── ...
```

---

## 二、整合后的结构 (3层)

```
skills/
├── ROLES/                    # 角色技能 (按角色分类)
│   ├── PROJECT/             # 项目管理
│   │   ├── kickoff.md       # 项目启动
│   │   ├── resume.md        # 项目恢复
│   │   ├── team-config.md   # 团队配置
│   │   └── task-dist.md     # 任务分配
│   │
│   ├── PRODUCT/             # 产品角色
│   │   ├── requirement/     # 需求分析
│   │   │   ├── analysis.md
│   │   │   ├── structuring.md
│   │   │   ├── assessment.md
│   │   │   └── backlog.md
│   │   ├── design/          # 功能设计
│   │   │   ├── page.md
│   │   │   ├── ux.md
│   │   │   └── edge-case.md
│   │   └── acceptance/       # 验收
│   │       └── criteria.md
│   │
│   ├── DEV/                 # 开发角色
│   │   ├── context/         # 上下文获取
│   │   │   ├── dev-first.md
│   │   │   └── module-dev-context.md
│   │   ├── implementation/  # 实现
│   │   │   ├── frontend.md
│   │   │   ├── backend.md
│   │   │   └── api.md
│   │   ├── quality/          # 质量保障
│   │   │   ├── code-review.md
│   │   │   ├── quality.md
│   │   │   ├── standards.md
│   │   │   └── security.md
│   │   ├── engineering/      # 工程能力
│   │   │   ├── debugging.md
│   │   │   ├── refactoring.md
│   │   │   ├── modular.md
│   │   │   └── docs.md
│   │   └── ops/              # 运维部署
│   │       ├── log.md
│   │       └── stability.md
│   │
│   └── QA/                   # 测试角色
│       ├── context/          # 上下文获取
│       │   └── qa-first.md
│       ├── planning/         # 测试规划
│       │   ├── strategy.md
│       │   ├── prioritization.md
│       │   └── case-design.md
│       ├── execution/        # 测试执行
│       │   ├── executor.md
│       │   └── e2e.md
│       └── analysis/         # 测试分析
│           ├── performance.md
│           └── defect.md
│
├── COLLABORATION/            # 协同技能 (核心!)
│   ├── HANDOFF/             # 角色交接
│   │   ├── product-to-dev.md
│   │   ├── dev-to-qa.md
│   │   └── qa-to-product.md
│   │
│   ├── SYNC/                # 同步对齐
│   │   ├── context-align.md
│   │   ├── dev-qa-sync.md
│   │   ├── module-coord.md
│   │   └── requirement-align.md
│   │
│   ├── REVIEW/              # 评审
│   │   ├── design.md
│   │   ├── code.md
│   │   └── acceptance.md
│   │
│   ├── CYCLE/               # 循环管理
│   │   ├── test-debug.md
│   │   ├── bug-track.md
│   │   └── incident.md
│   │
│   └── RETROSPECTIVE/       # 复盘
│       ├── review.md
│       └── closure.md
│
└── ENABLING/                 # 支撑能力
    ├── ARCHITECTURE/        # 架构
    │   ├── tech-selection.md
    │   ├── system-design.md
    │   └── code-review.md
    │
    ├── DEVOPS/             # 运维能力
    │   ├── ci-cd.md
    │   ├── docker.md
    │   ├── k8s.md
    │   ├── multi-env.md
    │   └── config-isolation.md
    │
    └── SYSTEM/             # 系统
        └── dispatcher.md
```

---

## 三、完整技能映射表

### 3.1 PROJECT - 项目管理

| 原技能 | 新位置 | 说明 |
|--------|--------|------|
| project-kickoff | ROLES/PROJECT/kickoff.md | 项目启动 |
| project-resume | ROLES/PROJECT/resume.md | 项目恢复 |
| project-team-configuration | ROLES/PROJECT/team-config.md | 团队配置 |
| project-task-distribution | ROLES/PROJECT/task-dist.md | 任务分配 |

### 3.2 PRODUCT - 产品角色

| 原技能 | 新位置 | 说明 |
|--------|--------|------|
| product-requirement-analysis | ROLES/PRODUCT/requirement/analysis.md | 需求分析 |
| product-requirement-structuring | ROLES/PRODUCT/requirement/structuring.md | 需求结构化 |
| product-technical-assessment | ROLES/PRODUCT/requirement/assessment.md | 技术评估 |
| global-project-analysis | ROLES/PRODUCT/requirement/analysis.md | 合并到需求分析 |
| product-collaborative-requirement-optimization | ROLES/PRODUCT/requirement/analysis.md | 合并到需求分析 |
| module-product-requirement | ROLES/PRODUCT/requirement/analysis.md | 合并到需求分析 |
| product-page-feature-best-practices | ROLES/PRODUCT/design/page.md | 页面设计 |
| product-ux-review | ROLES/PRODUCT/design/ux.md | UX评审 |
| product-edge-case | ROLES/PRODUCT/design/edge-case.md | 边界设计 |
| product-backlog-refinement | ROLES/PRODUCT/requirement/backlog.md | 待办整理 |
| product-acceptance-criteria | ROLES/PRODUCT/acceptance/criteria.md | 验收标准 |
| product-data-analysis | ROLES/PRODUCT/design/data.md | 数据分析 |

### 3.3 DEV - 开发角色

| 原技能 | 新位置 | 说明 |
|--------|--------|------|
| dev-context-first | ROLES/DEV/context/dev-first.md | 开发前获取上下文 |
| dev-implementation | ROLES/DEV/implementation/basic.md | 功能实现 |
| dev-frontend-implementation | ROLES/DEV/implementation/frontend.md | 前端实现 |
| dev-backend-implementation | ROLES/DEV/implementation/backend.md | 后端实现 |
| dev-api-contract-definition | ROLES/DEV/implementation/api.md | API定义 |
| dev-code-review-checklist | ROLES/DEV/quality/code-review.md | 代码审查 |
| dev-code-quality | ROLES/DEV/quality/quality.md | 代码质量 |
| dev-frontend-standards | ROLES/DEV/quality/standards.md | 前端标准 |
| dev-security-review | ROLES/DEV/quality/security.md | 安全审查 |
| dev-debugging | ROLES/DEV/engineering/debugging.md | 调试 |
| dev-refactoring | ROLES/DEV/engineering/refactoring.md | 重构 |
| dev-modular-design | ROLES/DEV/engineering/modular.md | 模块设计 |
| dev-technical-documentation | ROLES/DEV/engineering/docs.md | 技术文档 |
| system-log-implementation | ROLES/DEV/ops/log.md | 日志实现 |
| stability-logging-implementation | ROLES/DEV/ops/stability.md | 稳定性日志 |
| module-dev-context | ROLES/DEV/context/module-dev-context.md | 模块开发上下文 |
| module-collaborative-dev | ROLES/DEV/implementation/collaborative.md | 协同开发 |
| module-splitting | ROLES/DEV/engineering/modular.md | 模块拆分 |

### 3.4 QA - 测试角色

| 原技能 | 新位置 | 说明 |
|--------|--------|------|
| qa-context-first | ROLES/QA/context/qa-first.md | 测试前获取上下文 |
| qa-test-case-design | ROLES/QA/planning/case-design.md | 用例设计 |
| qa-test-case-prioritization | ROLES/QA/planning/prioritization.md | 用例优先级 |
| qa-test-strategy | ROLES/QA/planning/strategy.md | 测试策略 |
| test-executor | ROLES/QA/execution/executor.md | 测试执行 |
| qa-e2e-testing | ROLES/QA/execution/e2e.md | 端到端测试 |
| qa-performance-testing | ROLES/QA/analysis/performance.md | 性能测试 |
| qa-defect-analysis | ROLES/QA/analysis/defect.md | 缺陷分析 |
| qa-ux-testing | ROLES/QA/execution/ux.md | UX测试 |
| qa-bug-report | ROLES/QA/analysis/defect.md | Bug报告 |
| module-test-context | ROLES/QA/context/module-test-context.md | 模块测试上下文 |

### 3.5 COLLABORATION - 协同技能

| 原技能 | 新位置 | 说明 |
|--------|--------|------|
| collab-product-to-dev | COLLABORATION/HANDOFF/product-to-dev.md | 产品→开发 |
| collab-dev-to-qa | COLLABORATION/HANDOFF/dev-to-qa.md | 开发→测试 |
| collab-qa-to-product | COLLABORATION/HANDOFF/qa-to-product.md | 测试→产品 |
| collab-context-alignment | COLLABORATION/SYNC/context-align.md | 上下文对齐 |
| collab-dev-qa-sync | COLLABORATION/SYNC/dev-qa-sync.md | 开发测试同步 |
| collab-requirement-handoff | COLLABORATION/SYNC/requirement-align.md | 需求对齐 |
| collab-requirement-details | COLLABORATION/SYNC/requirement-align.md | 需求细节 |
| collab-product-alignment | COLLABORATION/SYNC/requirement-align.md | 需求对齐 |
| collab-module-to-module | COLLABORATION/SYNC/module-coord.md | 模块间协调 |
| collaboration-product-architecture-brainstorming | COLLABORATION/SYNC/architecture-brainstorm.md | 架构头脑风暴 |
| collab-design-review | COLLABORATION/REVIEW/design.md | 设计评审 |
| collab-code-review | COLLABORATION/REVIEW/code.md | 代码评审 |
| collab-acceptance-review | COLLABORATION/REVIEW/acceptance.md | 验收评审 |
| collab-test-debug-cycle | COLLABORATION/CYCLE/test-debug.md | 测试Debug循环 |
| bug-coordinator | COLLABORATION/CYCLE/bug-track.md | Bug追踪 |
| collab-incident-response | COLLABORATION/CYCLE/incident.md | 应急响应 |
| collab-retrospective | COLLABORATION/RETROSPECTIVE/review.md | 迭代复盘 |
| iteration_closure | COLLABORATION/RETROSPECTIVE/closure.md | 复盘闭环 |

### 3.6 ENABLING - 支撑能力

| 原技能 | 新位置 | 说明 |
|--------|--------|------|
| architecture-tech-selection | ENABLING/ARCHITECTURE/tech-selection.md | 技术选型 |
| architecture-system-design | ENABLING/ARCHITECTURE/system-design.md | 系统设计 |
| architecture-code-review | ENABLING/ARCHITECTURE/code-review.md | 架构评审 |
| devops-ci-cd-pipeline | ENABLING/DEVOPS/ci-cd.md | CI/CD |
| devops-dockerfile-generation | ENABLING/DEVOPS/docker.md | Docker |
| devops-k8s-deployment | ENABLING/DEVOPS/k8s.md | K8s部署 |
| devops-multi-env-config-design | ENABLING/DEVOPS/multi-env.md | 多环境配置 |
| devops-config-isolation-patterns | ENABLING/DEVOPS/config-isolation.md | 配置隔离 |
| devops-git-commit | ENABLING/DEVOPS/git-commit.md | Git提交 |
| devops-build-config | ENABLING/DEVOPS/build-config.md | 构建配置 |
| system-auto-skill-dispatcher | ENABLING/SYSTEM/dispatcher.md | 自动调度 |

---

## 四、统计对比

| 分类 | 数量 | 占比 |
|------|------|------|
| PROJECT | 4 | 5% |
| PRODUCT | 12 | 14% |
| DEV | 17 | 20% |
| QA | 11 | 13% |
| COLLABORATION | 18 | 21% |
| ENABLING | 11 | 13% |
| **原有冗余** | 14 | 16% (合并后) |
| **总计** | **87** | 100% |

---

## 五、协同视角的组织

```
                    ┌─────────────────────────────────────┐
                    │           项目启动 (PROJECT)          │
                    └──────────────────┬──────────────────┘
                                       │
           ┌───────────────────────────┼───────────────────────────┐
           │                           │                           │
           ▼                           ▼                           ▼
    ┌─────────────┐           ┌─────────────┐           ┌─────────────┐
    │   PRODUCT   │           │     DEV     │           │     QA      │
    │  需求分析   │           │   功能实现   │           │   测试执行   │
    └──────┬──────┘           └──────┬──────┘           └──────┬──────┘
           │                        │                        │
           └────────────────────────┼────────────────────────┘
                                    │
                    ┌───────────────┼───────────────┐
                    │               │               │
                    ▼               ▼               ▼
           ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
           │   HANDOFF   │  │    SYNC     │  │   REVIEW    │
           │  (交接)      │  │   (同步)    │  │   (评审)    │
           └──────┬──────┘  └──────┬──────┘  └──────┬──────┘
                  │                │                │
                  └────────────────┼────────────────┘
                                   │
                                   ▼
                         ┌─────────────────┐
                         │  RETROSPECTIVE  │
                         │     (复盘)       │
                         └────────┬────────┘
                                  │
                                  ▼
                         ┌─────────────────┐
                         │     ENABLING     │
                         │   (支撑能力)     │
                         └─────────────────┘
```

---

## 六、实施要点

1. **不删除任何技能** - 所有 87 个技能都有映射
2. **合并重复** - module_xxx 和 module-xxx 合并
3. **统一命名** - 消除下划线/横线混用
4. **独立协同** - 协同技能不再散落各目录
5. **支撑分离** - 架构/DevOps 作为支撑而非独立角色
