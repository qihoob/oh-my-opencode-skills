# Skills 优化方案

## 一、当前问题分析

### 1.1 目录结构混乱

| 问题 | 现状 | 影响 |
|------|------|------|
| 分类过多 | 15+ 类别 (Product/开发/测试/协同/模块/DevOps等) | 难以查找和维护 |
| 重复定义 | YAML 和 MD 重复定义相同技能 | 同步困难 |
| 边界模糊 | 模块技能 vs 产品技能 vs 开发技能 界限不清 | 不知道该用哪个 |

### 1.2 技能重叠分析

| 技能组 | 重复技能 | 建议 |
|--------|----------|------|
| 模块开发 | `module-dev-context`, `module-dev-implementation`, `module_dev_context` | 合并为 `module-dev` |
| 模块测试 | `module-test-context`, `module_test_context` | 合并为 `module-qa` |
| 模块产品 | `module-product-requirement`, `module_product_requirement` | 合并为 `module-product` |
| 上下文 | `dev-context-first`, `qa-context-first`, `context-minimum` | 保留独立但统一命名 |
| 交接 | `collab-product-to-dev`, `collab-dev-to-qa` | 扩展为 `handoff-*` 系列 |

### 1.3 角色不清晰

```
当前: 产品→开发→测试 + 协同(横跨所有)
问题: 协同技能到底属于哪个角色?

建议: 协同 = 角色之间的连接器，不单独作为"角色"
```

---

## 二、优化方案

### 2.1 三大核心角色

```
┌─────────────────────────────────────────────────────────────┐
│                      项目管理 (Project)                      │
│                    project-kickoff                          │
└─────────────────────────────────────────────────────────────┘
                              │
        ┌──────────────────────┼──────────────────────┐
        ▼                      ▼                      ▼
┌───────────────┐    ┌───────────────┐    ┌───────────────┐
│   产品 (Product)  │    │   开发 (Dev)    │    │   测试 (QA)     │
├───────────────┤    ├───────────────┤    ├───────────────┤
│ requirement   │    │ implementation │    │ test-case    │
│ analysis      │    │ context-first │    │ design       │
│ backlog       │    │ code-review   │    │ execution    │
│ acceptance    │    │ debugging     │    │ e2e-testing  │
│ ux-review     │    │ refactoring   │    │ performance  │
└───────────────┘    └───────────────┘    └───────────────┘
        │                      │                      │
        └──────────────────────┼──────────────────────┘
                              ▼
              ┌─────────────────────────────────┐
              │         协同 (Collaboration)       │
              │   handoff / sync / review       │
              └─────────────────────────────────┘
                              │
                              ▼
              ┌─────────────────────────────────┐
              │      支撑 (Enabling)              │
              │   architecture / devops / docs  │
              └─────────────────────────────────┘
```

### 2.2 优化后的目录结构 (4大类)

```
skills/
├── PROJECT/                    # 项目管理 (1)
│   └── project-kickoff.md      # 项目启动器
│
├── ROLE/                       # 核心角色 (3)
│   ├── PRODUCT/               # 产品角色 (5)
│   │   ├── requirement-analysis.md
│   │   ├── backlog-refinement.md
│   │   ├── acceptance-criteria.md
│   │   ├── ux-review.md
│   │   └── page-design.md
│   │
│   ├── DEV/                   # 开发角色 (10)
│   │   ├── context-first.md
│   │   ├── implementation.md
│   │   ├── code-review.md
│   │   ├── debugging.md
│   │   ├── refactoring.md
│   │   ├── api-design.md
│   │   ├── database-design.md
│   │   ├── security-review.md
│   │   └── deployment.md
│   │
│   └── QA/                    # 测试角色 (6)
│       ├── context-first.md
│       ├── test-case-design.md
│       ├── test-execution.md
│       ├── e2e-testing.md
│       ├── performance-testing.md
│       └── defect-analysis.md
│
├── COLLABORATION/              # 协同 (8)
│   ├── handoff/               # 交接
│   │   ├── product-to-dev.md
│   │   ├── dev-to-qa.md
│   │   └── qa-to-product.md
│   │
│   ├── sync/                  # 同步
│   │   ├── context-alignment.md
│   │   ├── dev-qa-sync.md
│   │   └── module-coordination.md
│   │
│   ├── review/                # 评审
│   │   ├── design-review.md
│   │   ├── code-review.md
│   │   └── acceptance-review.md
│   │
│   └── retrospective/         # 复盘
│       ├── iteration-retrospective.md
│       └── iteration-closure.md
│
└── ENABLING/                   # 支撑 (8)
    ├── ARCHITECTURE/          # 架构 (3)
    │   ├── tech-selection.md
    │   ├── system-design.md
    │   └── module-splitting.md
    │
    ├── DEVOPS/               # 运维 (4)
    │   ├── ci-cd-pipeline.md
    │   ├── dockerfile.md
    │   ├── k8s-deployment.md
    │   └── multi-env-config.md
    │
    └── DOCUMENTATION/         # 文档 (1)
        └── auto-dispatcher.md
```

### 2.3 技能数量统计

| 分类 | 数量 | 说明 |
|------|------|------|
| PROJECT | 1 | 项目启动 |
| PRODUCT | 5 | 需求/ backlog/ 验收/ UX/ 页面 |
| DEV | 10 | 上下文/ 实现/ 审查/ 调试/ 重构/ API/ DB/ 安全/ 部署 |
| QA | 6 | 上下文/ 用例/ 执行/ E2E/ 性能/ 缺陷 |
| COLLABORATION | 8 | 交接(3)/ 同步(3)/ 评审(3)/ 复盘(2) = 11 |
| ENABLING | 8 | 架构(3)/ 运维(4)/ 文档(1) |
| **总计** | **38** | 精简 87 → 38 |

---

## 三、保留全部信息的映射表

### 3.1 产品角色技能映射

| 原技能 | 新位置 | 状态 |
|--------|--------|------|
| product-requirement-analysis | ROLE/PRODUCT/requirement-analysis.md | ✅ 保留 |
| product-backlog-refinement | ROLE/PRODUCT/backlog-refinement.md | ✅ 重命名 |
| product-acceptance-criteria | ROLE/PRODUCT/acceptance-criteria.md | ✅ 保留 |
| product-ux-review | ROLE/PRODUCT/ux-review.md | ✅ 保留 |
| page-feature-best-practices | ROLE/PRODUCT/page-design.md | ✅ 重命名 |
| collaborative-requirement-optimization | COLLABORATION/review/design-review.md | ✅ 移动 |
| global-project-analysis | PROJECT/project-kickoff.md | ✅ 合并 |
| module-product-requirement | COLLABORATION/sync/module-coordination.md | ✅ 重命名 |

### 3.2 开发角色技能映射

| 原技能 | 新位置 | 状态 |
|--------|--------|------|
| dev-context-first | ROLE/DEV/context-first.md | ✅ 保留 |
| dev-implementation | ROLE/DEV/implementation.md | ✅ 保留 |
| dev-code-review | ROLE/DEV/code-review.md | ✅ 保留 |
| dev-debugging | ROLE/DEV/debugging.md | ✅ 保留 |
| dev-refactoring | ROLE/DEV/refactoring.md | ✅ 保留 |
| api-contract-definition | ROLE/DEV/api-design.md | ✅ 重命名 |
| database-design | ROLE/DEV/database-design.md | ✅ 保留 |
| security-review | ROLE/DEV/security-review.md | ✅ 保留 |
| deployment | ROLE/DEV/deployment.md | ✅ 保留 |
| module-splitting | ENABLING/ARCHITECTURE/module-splitting.md | ✅ 移动 |
| parallel-module-orchestrator | COLLABORATION/sync/module-coordination.md | ✅ 合并 |
| module-collaborative-dev | COLLABORATION/sync/module-coordination.md | ✅ 合并 |
| system-log-implementation | ENABLING/DEVOPS/multi-env-config.md | ✅ 合并 |
| stability-logging-implementation | ENABLING/DEVOPS/multi-env-config.md | ✅ 合并 |

### 3.3 测试角色技能映射

| 原技能 | 新位置 | 状态 |
|--------|--------|------|
| qa-context-first | ROLE/QA/context-first.md | ✅ 保留 |
| qa-test-case-design | ROLE/QA/test-case-design.md | ✅ 保留 |
| test-executor | ROLE/QA/test-execution.md | ✅ 重命名 |
| qa-e2e-testing | ROLE/QA/e2e-testing.md | ✅ 保留 |
| qa-performance-testing | ROLE/QA/performance-testing.md | ✅ 保留 |
| qa-defect-analysis | ROLE/QA/defect-analysis.md | ✅ 保留 |
| qa-test-case-prioritization | ROLE/QA/test-case-design.md | ✅ 合并 |
| module-test-context | ROLE/QA/context-first.md | ✅ 合并 |

### 3.4 协同技能映射

| 原技能 | 新位置 | 状态 |
|--------|--------|------|
| collab-product-to-dev | COLLABORATION/handoff/product-to-dev.md | ✅ 保留 |
| collab-dev-to-qa | COLLABORATION/handoff/dev-to-qa.md | ✅ 保留 |
| collab-qa-to-product | COLLABORATION/handoff/qa-to-product.md | ✅ 保留 |
| collab-acceptance-review | COLLABORATION/review/acceptance-review.md | ✅ 保留 |
| collab-retrospective | COLLABORATION/retrospective/iteration-retrospective.md | ✅ 重命名 |
| iteration_closure | COLLABORATION/retrospective/iteration-closure.md | ✅ 保留 |
| bug-coordinator | COLLABORATION/sync/bug-tracking.md | ✅ 重命名 |
| collab-test-debug-cycle | COLLABORATION/sync/test-debug-cycle.md | ✅ 重命名 |
| collab-dev-qa-sync | COLLABORATION/sync/dev-qa-sync.md | ✅ 保留 |

### 3.5 支撑技能映射

| 原技能 | 新位置 | 状态 |
|--------|--------|------|
| architecture-tech-selection | ENABLING/ARCHITECTURE/tech-selection.md | ✅ 保留 |
| architecture-system-design | ENABLING/ARCHITECTURE/system-design.md | ✅ 保留 |
| devops-ci-cd-pipeline | ENABLING/DEVOPS/ci-cd-pipeline.md | ✅ 保留 |
| devops-dockerfile-generation | ENABLING/DEVOPS/dockerfile.md | ✅ 重命名 |
| devops-k8s-deployment | ENABLING/DEVOPS/k8s-deployment.md | ✅ 保留 |
| devops-multi-env-config-design | ENABLING/DEVOPS/multi-env-config.md | ✅ 保留 |
| auto-skill-dispatcher | ENABLING/DOCUMENTATION/auto-dispatcher.md | ✅ 保留 |

---

## 四、实施步骤

### 步骤1: 创建新目录结构
```
mkdir -p skills/ROLE/PRODUCT skills/ROLE/DEV skills/ROLE/QA
mkdir -p skills/COLLABORATION/handoff skills/COLLABORATION/sync
mkdir -p skills/COLLABORATION/review skills/COLLABORATION/retrospective
mkdir -p skills/ENABLING/ARCHITECTURE skills/ENABLING/DEVOPS
mkdir -p skills/ENABLING/DOCUMENTATION
```

### 步骤2: 迁移技能文件
- 按映射表移动文件
- 合并重复技能
- 更新文件内的 name 和 description

### 步骤3: 更新 YAML 注册表
- 合并所有 YAML 定义到单一文件
- 更新触发词映射

### 步骤4: 更新 oh-my-opencode.json
- 更新 skills sources 路径

---

## 五、预期收益

| 指标 | 优化前 | 优化后 |
|------|--------|--------|
| 目录层级 | 3+ 层 | 2 层 |
| 技能总数 | 87 | 38 |
| 角色数量 | 15+ | 4 (PROJECT/ROLE/COLLAB/ENABLING) |
| 重复技能 | 20+ | 0 |
| 新人学习成本 | 高 | 低 |

---

*此文档保留所有原始技能定义信息，只是重新组织结构便于维护和使用。*
