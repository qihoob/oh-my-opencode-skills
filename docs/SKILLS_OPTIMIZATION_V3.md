# Skills 整合优化方案 v3

## 核心思路

**真正整合，减少数量**
- 不是重命名，是合并相似技能
- 去除冗余，保留核心
- 按用户实际使用场景组织

---

## 一、分析：87 → 目标 30

### 1.1 当前技能分析

| 类别 | 数量 | 可整合 |
|------|------|--------|
| 上下文类 (context-first) | 4个 | 合并为1个 |
| 实现类 (implementation) | 6个 | 合并为2个 (前端/后端) |
| 代码审查类 | 4个 | 合并为1个 |
| 测试类 | 7个 | 合并为3个 (用例/执行/分析) |
| 交接类 | 6个 | 合并为2个 |
| 复盘类 | 3个 | 合并为1个 |
| 模块类 | 8个 | 去除，融入其他 |
| DevOps | 9个 | 合并为3个 |
| 日志/监控 | 4个 | 合并为1个 |

### 1.2 真正的核心技能

```
用户场景                     → 核心技能
─────────────────────────────────────────────
"帮我开发一个功能"           → dev-implementation
"帮我写个测试"               → qa-test-design
"帮我看看代码有问题吗"        → dev-code-review
"帮我分析下需求"             → product-requirement
"开发完了交给测试"           → collab-handoff
"帮我部署上线"               → devops-deploy
"有个bug帮我看看"            → dev-debugging
"帮我设计下架构"             → architecture-design
```

---

## 二、整合后的技能体系 (30个)

### 2.1 目录结构

```
skills/
├── core/                     # 核心技能 (20)
│   ├── dev/                  # 开发 (7)
│   │   ├── implementation.md  # 功能实现 ⭐
│   │   ├── code-review.md    # 代码审查
│   │   ├── debugging.md       # 调试排错
│   │   ├── refactoring.md    # 重构优化
│   │   ├── api-design.md     # API设计
│   │   ├── db-design.md      # 数据库设计
│   │   └── deployment.md     # 部署上线
│   │
│   ├── qa/                   # 测试 (4)
│   │   ├── test-case.md      # 测试用例
│   │   ├── test-execution.md # 测试执行
│   │   └── defect-analysis.md# 缺陷分析
│   │
│   ├── product/              # 产品 (4)
│   │   ├── requirement.md    # 需求分析
│   │   ├── acceptance.md     # 验收标准
│   │   ├── ux-review.md      # UX评审
│   │   └── page-design.md    # 页面设计
│   │
│   └── architecture/         # 架构 (3)
│       ├── tech-selection.md # 技术选型
│       ├── system-design.md  # 系统设计
│       └── module-split.md   # 模块拆分
│
├── collaboration/            # 协同 (6)
│   ├── handoff.md           # 角色交接 ⭐
│   ├── sync.md              # 同步对齐
│   ├── review.md            # 评审
│   ├── bug-track.md         # Bug追踪
│   ├── incident.md          # 应急响应
│   └── retrospective.md      # 迭代复盘
│
├── devops/                  # 运维 (3)
│   ├── ci-cd.md             # 流水线
│   ├── container.md         # 容器化
│   └── config.md            # 环境配置
│
└── system/                   # 系统 (1)
    └── dispatcher.md         # 自动调度
```

### 2.2 技能详细定义

#### CORE - 开发 (7)

| 技能 | 合并自 | 说明 |
|------|--------|------|
| `dev-implementation` | frontend + backend + module-collaborative | 功能实现，包含前后端 |
| `dev-code-review` | code-review-checklist + code-quality + standards + architecture-code-review | 代码审查 (统一) |
| `dev-debugging` | debugging | 调试排错 |
| `dev-refactoring` | refactoring | 重构优化 |
| `dev-api-design` | api-contract-definition | API设计 |
| `dev-db-design` | database-design | 数据库设计 |
| `dev-deployment` | k8s-deployment + stability-logging | 部署上线 |

#### CORE - 测试 (4)

| 技能 | 合并自 | 说明 |
|------|--------|------|
| `qa-test-case` | test-case-design + prioritization + strategy | 测试用例 (统一) |
| `qa-test-execution` | test-executor + e2e-testing | 测试执行 |
| `qa-defect-analysis` | defect-analysis + performance-testing + bug-report | 缺陷分析 (统一) |

#### CORE - 产品 (4)

| 技能 | 合并自 | 说明 |
|------|--------|------|
| `product-requirement` | requirement-analysis + structuring + assessment + backlog | 需求分析 (统一) |
| `product-acceptance` | acceptance-criteria + global-acceptance | 验收标准 |
| `product-ux-review` | ux-review + ux-testing | UX评审 |
| `product-page-design` | page-design + edge-case | 页面设计 |

#### CORE - 架构 (3)

| 技能 | 合并自 | 说明 |
|------|--------|------|
| `architecture-tech-selection` | tech-selection | 技术选型 |
| `architecture-system-design` | system-design | 系统设计 |
| `architecture-module-split` | module-splitting + modular-design | 模块拆分 |

#### COLLABORATION (6)

| 技能 | 合并自 | 说明 |
|------|--------|------|
| `collab-handoff` | product-to-dev + dev-to-qa + qa-to-product | 角色交接 (统一) |
| `collab-sync` | context-align + dev-qa-sync + module-coord | 同步对齐 |
| `collab-review` | design-review + code-review + acceptance | 评审 (统一) |
| `collab-bug-track` | bug-coordinator + test-debug-cycle | Bug追踪 |
| `collab-incident` | incident-response | 应急响应 |
| `collab-retrospective` | retrospective + iteration-closure | 复盘 |

#### DEVOPS (3)

| 技能 | 合并自 | 说明 |
|------|--------|------|
| `devops-ci-cd` | ci-cd-pipeline + build-config | 流水线 |
| `devops-container` | dockerfile + k8s | 容器化 |
| `devops-config` | multi-env + config-isolation | 环境配置 |

#### SYSTEM (1)

| 技能 | 说明 |
|------|------|
| `system-dispatcher` | 自动调度 |

---

## 三、数量对比

| 类别 | 原数量 | 整合后 | 减少 |
|------|--------|--------|------|
| 开发 | 17 | 7 | -10 |
| 测试 | 11 | 4 | -7 |
| 产品 | 12 | 4 | -8 |
| 架构 | 3 | 3 | 0 |
| 协同 | 18 | 6 | -12 |
| DevOps | 9 | 3 | -6 |
| 项目 | 4 | 0 | -4 (融入产品) |
| 系统 | 1 | 1 | 0 |
| **总计** | **87** | **30** | **-57 (65%)** |

---

## 四、触发词覆盖

每个技能支持多场景触发，确保不丢失原有关键词：

```
dev-implementation:
  - 开发、实现、写代码、功能开发、前端开发、后端开发
  - 帮我写个接口、帮我做个页面、实现了xxx

qa-test-case:
  - 测试用例、用例设计、测试场景、测试点
  - 怎么测试、测试什么、需要测什么

collab-handoff:
  - 提测、交给测试、开发完成、转交
  - 需求评审、可以开发了
```

---

## 五、实施

需要创建 30 个核心技能文件，合并 87 个原技能的内容。

是否按此方案执行？
