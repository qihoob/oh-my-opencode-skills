# Skills 完整索引

## 一、Skills 来源

| 来源 | 路径 | Skills 数量 | 格式 |
|------|------|-------------|------|
| **新 Skills** | `C:\Users\Administrator\skills` | 78 | YAML |
| **原有 Skills** | `~/.config/opencode/skills` | 21 | MD |
| **系统调度器** | `~/.config/opencode/skills/system` | 1 | YAML |

---

## 二、Skills 目录结构

```
C:\Users\Administrator\skills\
├── global-product-skills.yaml      # 全局产品 (4)
├── module-product-skills.yaml       # 模块产品 (5)
├── module-skills.yaml               # 模块管理 (5)
├── context-skills.yaml              # 上下文管理 (4)
├── product-skills.yaml             # 产品角色 (8)
├── dev-skills.yaml                  # 开发角色 (14)
├── qa-skills.yaml                   # 测试角色 (11)
├── module-dev-test-skills.yaml      # 模块开发/测试/项目整体 (13)
├── collaboration-skills.yaml        # 协同角色 (14)
└── skills-registry.yaml             # 注册索引

~/.config/opencode/skills\
├── system/
│   ├── auto-skill-dispatcher.yaml   # 自动调度器
│   └── auto-skill-dispatcher.md
├── project/
│   └── project-kickoff.md           # 项目启动器
├── product/
│   ├── product-requirement-analysis.md
│   ├── global-project-analysis.md
│   └── module-product-requirement.md
├── dev/
│   ├── dev-context-first.md
│   ├── dev-implementation.md
│   ├── module-collaborative-dev.md
│   ├── module-dev-context.md
│   ├── module-splitting.md
│   └── parallel-module-orchestrator.md
├── qa/
│   ├── qa-context-first.md
│   ├── qa-test-case-design.md
│   ├── module-test-context.md
│   └── test-executor.md
└── collaboration/
    ├── bug-coordinator.md
    ├── collab-product-to-dev.md
    ├── collab-dev-to-qa.md
    ├── collab-acceptance-review.md
    ├── collab-retrospective.md
    └── iteration-closure.md
```

---

## 三、完整 Skills 列表

### 1. 系统 (System) - 1

| Skill | 来源 | 说明 |
|-------|------|------|
| `system/auto-skill-dispatcher` | .config/opencode | 自动技能调度器，一键调用入口 |

### 2. 项目 (Project) - 1

| Skill | 来源 | 说明 |
|-------|------|------|
| `project/project-kickoff` | .config/opencode | 项目启动器，统领全流程 |

### 3. 全局产品 (Global Product) - 4

| Skill | 来源 | 说明 |
|-------|------|------|
| `global-project-analysis` | skills | 项目整体梳理，模块划分 |
| `global-module-coordination` | skills | 模块协调，依赖管理 |
| `global-acceptance` | skills | 整体验收 |
| `global-product-handoff` | skills | 全局产品交接 |

### 4. 模块产品 (Module Product) - 5

| Skill | 来源 | 说明 |
|-------|------|------|
| `module_product_requirement` | skills | 模块需求产出 |
| `module_product_handoff` | skills | 模块交接 |
| `module_product_acceptance` | skills | 模块验收 |
| `module_product_sync` | skills | 模块对齐 |
| `module_product_query` | skills | 模块查询 |

### 5. 模块管理 (Module) - 5

| Skill | 来源 | 说明 |
|-------|------|------|
| `module-responsibility-analysis` | skills | 模块职责分析 |
| `module-context-generator` | skills | 生成职责上下文 |
| `module-responsibility-sync` | skills | 职责同步对齐 |
| `module-query` | skills | 查询模块信息 |
| `module-progress-track` | skills | 进度跟踪 |

### 6. 上下文管理 (Context) - 4

| Skill | 来源 | 说明 |
|-------|------|------|
| `context-classification` | skills | 上下文分类 |
| `context-minimum` | skills | 最小上下文提取 |
| `context-organization` | skills | 上下文整理 |
| `context-handover` | skills | 上下文交接 |

### 7. 产品 (Product) - 8

| Skill | 来源 | 说明 |
|-------|------|------|
| `product-requirement-analysis` | .config/opencode | 需求分析，强调可用/易用/好用 |
| `product-function-design` | skills | 功能流程设计 |
| `product-page-design` | skills | 页面组件设计 |
| `product-edge-case` | skills | 边界异常设计 |
| `product-backlog-refinement` | skills | 待办整理 |
| `product-acceptance-criteria` | skills | 验收标准 |
| `product-ux-review` | skills | UX评审 |
| `product-data-analysis` | skills | 数据分析 |

### 8. 开发 (Dev) - 14

| Skill | 来源 | 说明 |
|-------|------|------|
| `dev-context-first` | .config/opencode | 开发前先了解最小上下文 |
| `dev-implementation` | .config/opencode | 功能实现 |
| `dev-architecture-design` | skills | 架构设计 |
| `dev-code-review` | skills | 代码审查 |
| `dev-debugging` | skills | 调试排错 |
| `dev-refactoring` | skills | 代码重构 |
| `dev-api-design` | skills | API设计 |
| `dev-database-design` | skills | 数据库设计 |
| `dev-security-review` | skills | 安全审查 |
| `dev-product-communication` | skills | 与产品沟通可行性 |
| `dev-design-confirmation` | skills | 确认实现方案 |
| `dev-product-feedback` | skills | 产品反馈 |
| `dev-deployment` | skills | 部署上线 |
| `dev-ops` | skills | 运维监控 |

### 9. 开发扩展 (Dev Ext) - 3

| Skill | 来源 | 说明 |
|-------|------|------|
| `dev/module-splitting` | .config/opencode | 模块拆解器 |
| `dev/parallel-module-orchestrator` | .config/opencode | 并行模块编排器 |
| `dev/module-collaborative-dev` | .config/opencode | 多模块协同开发 |

### 10. 测试 (QA) - 11

| Skill | 来源 | 说明 |
|-------|------|------|
| `qa-context-first` | .config/opencode | 测试前先了解最小上下文 |
| `qa-test-strategy` | skills | 测试策略 |
| `qa-test-case-design` | .config/opencode | 用例设计 |
| `qa-test-automation` | skills | 自动化测试 |
| `qa-bug-report` | skills | 缺陷报告 |
| `qa-test-execution` | .config/opencode | 测试执行 |
| `qa-performance-test` | skills | 性能测试 |
| `qa-security-test` | skills | 安全测试 |
| `qa-product-communication` | skills | 与产品确认测试范围 |
| `qa-ux-testing` | skills | 用户体验测试 |
| `qa-product-feedback` | skills | 产品反馈 |

### 11. 模块开发 (Module Dev) - 4

| Skill | 来源 | 说明 |
|-------|------|------|
| `module_dev_context` | skills | 模块开发获取上下文 |
| `module_dev_implementation` | skills | 模块功能实现 |
| `module_dev_sync` | skills | 模块开发对齐 |
| `module_dev_acceptance` | skills | 模块开发验收配合 |

### 12. 模块测试 (Module Test) - 5

| Skill | 来源 | 说明 |
|-------|------|------|
| `module_test_context` | skills | 模块测试获取上下文 |
| `module_test_design` | skills | 模块测试用例设计 |
| `module_test_execution` | skills | 模块测试执行 |
| `module_test_sync` | skills | 模块测试对齐 |
| `module_test_acceptance` | skills | 模块测试验收 |

### 13. 项目整体 (Project Overall) - 4

| Skill | 来源 | 说明 |
|-------|------|------|
| `project_overall_dev` | skills | 项目整体开发把控 |
| `project_overall_test` | skills | 项目整体测试把控 |
| `project_integration_test` | skills | 项目集成测试 |
| `project_regression_test` | skills | 项目回归测试 |

### 14. 协同 (Collaboration) - 14

| Skill | 来源 | 说明 |
|-------|------|------|
| `collab-product-to-dev` | .config/opencode | 产品→开发过渡 |
| `collab-dev-to-qa` | .config/opencode | 开发→测试过渡 |
| `collab-acceptance-review` | .config/opencode | 验收评审 |
| `collab-retrospective` | .config/opencode | 迭代复盘 |
| `iteration_closure` | .config/opencode | 复盘闭环 |
| `collab_global_to_module` | skills | 全局→模块协调 |
| `collab_module_to_global` | skills | 模块→全局汇报 |
| `collab_module_to_module` | skills | 模块间对齐 |
| `collab_module_to_dev_qa` | skills | 模块→开发测试交接 |
| `collab_context-alignment` | skills | 跨角色上下文对齐 |
| `collab-product-alignment` | skills | 项目初始化需求对齐 |
| `collab-requirement-details` | skills | 需求细节对齐 |
| `collab-requirement-handoff` | skills | 需求交接 |
| `collab-dev-qa-sync` | skills | 开发测试同步 |

### 15. 协同扩展 (Collaboration Ext) - 4

| Skill | 来源 | 说明 |
|-------|------|------|
| `collaboration/bug-coordinator` | .config/opencode | Bug协调器 |
| `collab-qa-to-product` | skills | 测试→产品过渡 |
| `collab-incident-response` | skills | 线上应急 |
| `project_feedback_to_module` | skills | 项目→模块反馈 |
| `acceptance_feedback_to_module` | skills | 验收→模块反馈 |

---

## 四、调用方式

### 1. 一键自动调用 (推荐)

通过 `auto-skill-dispatcher` 自动匹配：

```typescript
skill(name="system/auto-skill-dispatcher", user_message="帮我实现用户登录功能")
```

### 2. 手动调用

```typescript
task(
  category="unspecified-high",
  load_skills=["product/product-requirement-analysis"],
  prompt="分析电商平台需求"
)
```

### 3. 触发词调用

| 关键词 | 触发的 Skill |
|--------|-------------|
| 启动项目 | project-kickoff |
| 需求分析 | product-requirement-analysis |
| 开始开发 | dev-context-first + dev-implementation |
| 开始测试 | qa-context-first + qa-test-case-design |
| 验收 | collab-acceptance-review |
| 复盘 | collab-retrospective |

---

## 五、工作流调用顺序

```
1️⃣ project-kickoff (项目启动)
    ↓
2️⃣ global-project-analysis (全局产品分析)
    ↓
3️⃣ collab-product-alignment (需求对齐)
    ↓
4️⃣ module_product_requirement (模块需求产出)
    ↓
5️⃣ dev-context-first → dev-implementation (开发)
    ↓
6️⃣ qa-context-first → qa-test-case-design → qa-test-execution (测试)
    ↓
7️⃣ module_product_acceptance → global-acceptance (验收)
    ↓
8️⃣ dev-deployment → dev-ops (部署运维)
    ↓
9️⃣ collab-retrospective → iteration_closure (复盘闭环)
```

---

## 六、统计汇总

| 分类 | 数量 |
|------|------|
| 系统 | 1 |
| 项目 | 1 |
| 全局产品 | 4 |
| 模块产品 | 5 |
| 模块管理 | 5 |
| 上下文 | 4 |
| 产品 | 8 |
| 开发 | 14 |
| 开发扩展 | 3 |
| 测试 | 11 |
| 模块开发 | 4 |
| 模块测试 | 5 |
| 项目整体 | 4 |
| 协同 | 14 |
| 协同扩展 | 4 |
| **总计** | **87** |

> 注：部分 Skills 在不同来源中有重复或别名，总计约 87 个唯一 Skills。