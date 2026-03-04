# Skills 调用指南 - oh-my-opencode
# 产品、开发、测试角色 Skills 使用手册
# 增强版 - 多模块负责制 + 最小上下文原则 + 闭环协同

---
# 文件结构

```
C:\Users\Administrator\skills\
├── global-product-skills.yaml     # 全局产品 4 个 Skill
├── module-product-skills.yaml     # 模块产品 5 个 Skill
├── module-skills.yaml             # 模块管理 5 个 Skill
├── context-skills.yaml            # 上下文管理 4 个 Skill
├── product-skills.yaml            # 产品角色 8 个 Skill
├── dev-skills.yaml                # 开发角色 14 个 Skill
├── qa-skills.yaml                 # 测试角色 11 个 Skill
├── module-dev-test-skills.yaml   # 模块开发/测试 9 个 Skill
├── collaboration-skills.yaml      # 协同角色 18 个 Skill
├── skills-registry.yaml           # 注册索引
└── SKILLS_USAGE.md               # 本文档
```

---
# 调用方式

## 方式 1: 通过 task() 加载 Skill

```typescript
// 调用产品角色 - 需求分析
task(
  category="unspecified-high",
  load_skills=["product-requirement-analysis"],
  prompt="帮我分析这个需求：用户希望在系统中添加一个积分功能..."
)

// 调用开发角色 - 代码审查
task(
  category="quick",
  load_skills=["dev-code-review"],
  prompt="review 这段代码，检查是否有安全问题..."
)

// 调用测试角色 - 自动化测试
task(
  category="unspecified-high",
  load_skills=["qa-test-automation"],
  prompt="为用户登录功能编写单元测试..."
)

// 调用协同角色 - 迭代闭环
task(
  category="unspecified-high",
  load_skills=["iteration_closure"],
  prompt="复盘完成，准备启动下一轮项目分析"
)
```

## 方式 2: 通过 skill() 工具直接调用

```typescript
// 查看 Skill 详情
skill(name="product-requirement-analysis")
skill(name="dev-debugging")
skill(name="qa-test-case-design")
skill(name="iteration_closure")
```

## 方式 3: 触发词自动匹配

当用户输入包含以下关键词时，系统自动匹配对应 Skill：

| 角色 | 触发示例 |
|------|----------|
| 全局产品 | "项目梳理"、"整体验收"、"模块协调" |
| 模块产品 | "模块需求"、"模块验收"、"模块对齐" |
| 模块管理 | "模块职责"、"生成上下文"、"进度跟踪" |
| 上下文 | "最小上下文"、"上下文分类"、"整理" |
| 产品 | "需求分析"、"制定验收标准"、"UX评审" |
| 开发 | "实现功能"、"代码审查"、"有bug"、"重构" |
| 测试 | "设计用例"、"跑测试"、"性能测试" |
| 模块开发 | "模块开发"、"模块实现" |
| 模块测试 | "模块测试"、"用例设计" |
| 项目整体 | "项目整体把控"、"集成测试" |
| 协同 | "需求评审"、"验收"、"线上故障"、"迭代闭环" |

---
# 核心概念

## 1. 多模块负责制

每个模块都有明确的责任人：
- **模块产品负责人** - 负责模块的需求、验收
- **模块测试负责人** - 负责模块的测试设计、执行
- **模块开发负责人** - 负责模块的功能实现

模块信息通过 `module-context-generator` 生成，存储在 `project/.omo/module-context.md`

## 2. 最小上下文原则

**开发/测试开始任何工作前，必须先获取最小上下文：**

```typescript
// 开发前 - 获取模块开发上下文
task(load_skills=["module_dev_context"], prompt="我要开发订单模块，先给我最小上下文")

// 测试前 - 获取模块测试上下文
task(load_skills=["module_test_context"], prompt="我要测试用户模块，先给我最小上下文")
```

最小上下文 = 只传递完成任务所必需的最低限度信息，避免信息过载。

## 3. 闭环协同

三个关键反馈闭环确保信息完整流转：

| 闭环 | Skill | 作用 |
|------|-------|------|
| 闭环1 | project_feedback_to_module | 项目整体 → 模块的反馈 |
| 闭环2 | acceptance_feedback_to_module | 验收 → 模块产品的反馈 |
| 闭环3 | iteration_closure | 复盘 → 下一轮项目分析的连接 |

---
# 完整工作流

```
1. 全局产品项目梳理
   global-project-analysis
   → global-module-coordination
   → collab-product-alignment（需求对齐）

2. 模块产品产出需求
   module_product_requirement（每个模块产出自己的需求）
   → 定义测试负责人
   → 定义开发负责人
   → module_product_sync（与全局产品对齐）

3. 生成职责上下文
   module-context-generator

4. 模块开发获取上下文
   module_dev_context
   → module_dev_implementation
   → module_dev_sync（与其他模块开发对齐）

5. 项目整体开发把控
   project_overall_dev
   → project_integration_test
   [闭环1] project_feedback_to_module → 各模块了解整体情况

6. 模块测试获取上下文
   module_test_context
   → module_test_design
   → module_test_execution
   → module_test_sync（与其他模块测试对齐）

7. 项目整体测试把控
   project_overall_test
   → project_integration_test
   → project_regression_test

8. 验收
   module_product_acceptance（模块验收）
   → global-acceptance（整体验收）
   [闭环2] acceptance_feedback_to_module → 模块产品了解验收结果

9. 部署运维
   dev-deployment → dev-ops

10. 迭代复盘
    collab-retrospective
    [闭环3] iteration_closure → 连接到下一轮 global-project-analysis
```

---
# Skills 快速索引

## 全局产品 (Global Product) - 4 个 Skill

| Skill | 功能 | 触发词 |
|-------|------|--------|
| global-project-analysis | 项目整体梳理 | 项目分析、整体规划 |
| global-module-coordination | 模块协调 | 模块协调、分配任务 |
| global-acceptance | 整体验收 | 整体验收、上线前 |
| global-product-handoff | 整体交接 | 交接、移交 |

## 模块产品 (Module Product) - 5 个 Skill

| Skill | 功能 | 触发词 |
|-------|------|--------|
| module_product_requirement | 模块需求产出 | 模块需求、产出需求 |
| module_product_handoff | 模块交接 | 模块交接、对接 |
| module_product_acceptance | 模块验收 | 模块验收、UAT |
| module_product_sync | 模块对齐 | 模块对齐、同步 |
| module_product_query | 模块查询 | 查询模块、模块信息 |

## 模块职责管理 (Module) - 5 个 Skill

| Skill | 功能 | 触发词 |
|-------|------|--------|
| module-responsibility-analysis | 模块职责分析 | 模块职责、定义模块 |
| module-context-generator | 生成职责上下文 | 生成上下文、创建文件 |
| module-responsibility-sync | 职责同步对齐 | 职责对齐、同步 |
| module-query | 查询模块信息 | 查询模块、模块信息 |
| module-progress-track | 模块进度跟踪 | 进度、跟踪 |

## 上下文管理 (Context) - 4 个 Skill

| Skill | 功能 | 触发词 |
|-------|------|--------|
| context-classification | 上下文分类 | 分类、需求分类 |
| context-minimum | 最小上下文提取 | 最小、核心、精简 |
| context-organization | 上下文整理 | 整理、组织 |
| context-handover | 上下文交接 | 交接、传递 |

## 产品角色 (Product) - 8 个 Skill

| Skill | 功能 | 触发词 |
|-------|------|--------|
| product-requirement-analysis | 需求分析 | 需求分析、用户故事 |
| product-function-design | 功能设计 | 功能设计、流程设计 |
| product-page-design | 页面设计 | 页面设计、组件设计 |
| product-edge-case | 边界场景 | 边界、异常 |
| product-backlog-refinement | 待办梳理 | backlog、优先级 |
| product-acceptance-criteria | 验收标准 | 验收标准、AC |
| product-ux-review | UX评审 | 用户体验、UX |
| product-data-analysis | 数据分析 | 数据分析、指标 |

## 开发角色 (Dev) - 14 个 Skill

| Skill | 功能 | 触发词 |
|-------|------|--------|
| dev-context-first | 开发前先了解最小上下文 | 开发前、先了解 |
| dev-implementation | 功能实现 | 实现、写代码 |
| dev-architecture-design | 架构设计 | 架构、技术方案 |
| dev-code-review | 代码审查 | review、审查 |
| dev-debugging | 调试排错 | bug、调试 |
| dev-refactoring | 代码重构 | 重构、优化 |
| dev-api-design | API设计 | API、接口 |
| dev-database-design | 数据库设计 | 数据库、建表 |
| dev-security-review | 安全审查 | 安全、漏洞 |
| dev-product-communication | 与产品沟通 | 技术可行性 |
| dev-design-confirmation | 设计确认 | 确认实现 |
| dev-product-feedback | 产品反馈 | 反馈、优化建议 |
| dev-deployment | 部署上线 | 部署、上线 |
| dev-ops | 运维监控 | 运维、监控 |

## 测试角色 (QA) - 11 个 Skill

| Skill | 功能 | 触发词 |
|-------|------|--------|
| qa-context-first | 测试前先了解最小上下文 | 测试前、先了解 |
| qa-test-strategy | 测试策略 | 测试计划、策略 |
| qa-test-case-design | 用例设计 | 测试用例、用例 |
| qa-test-automation | 自动化测试 | 自动化、单元测试 |
| qa-bug-report | 缺陷报告 | bug、缺陷 |
| qa-test-execution | 测试执行 | 跑测试、回归 |
| qa-performance-test | 性能测试 | 性能、压测 |
| qa-security-test | 安全测试 | 安全、渗透 |
| qa-product-communication | 与产品沟通 | 测试范围、验收标准 |
| qa-ux-testing | 用户体验测试 | 用户体验、易用性 |
| qa-product-feedback | 产品反馈 | 测试反馈 |

## 模块开发 (Module Dev) - 4 个 Skill

| Skill | 功能 | 触发词 |
|-------|------|--------|
| module_dev_context | 模块开发获取上下文 | 模块开发、获取上下文 |
| module_dev_implementation | 模块功能实现 | 模块实现、开发 |
| module_dev_sync | 模块开发对齐 | 模块对齐、同步 |
| module_dev_acceptance | 模块开发验收配合 | 配合验收 |

## 模块测试 (Module Test) - 5 个 Skill

| Skill | 功能 | 触发词 |
|-------|------|--------|
| module_test_context | 模块测试获取上下文 | 模块测试、获取上下文 |
| module_test_design | 模块测试用例设计 | 模块用例、设计 |
| module_test_execution | 模块测试执行 | 模块测试、执行 |
| module_test_sync | 模块测试对齐 | 模块对齐、同步 |
| module_test_acceptance | 模块测试验收 | 模块验收 |

## 项目整体把控 (Project Overall) - 4 个 Skill

| Skill | 功能 | 触发词 |
|-------|------|--------|
| project_overall_dev | 项目整体开发把控 | 整体开发、把控 |
| project_overall_test | 项目整体测试把控 | 整体测试、把控 |
| project_integration_test | 项目集成测试 | 集成测试 |
| project_regression_test | 项目回归测试 | 回归测试 |

## 协同角色 (Collaboration) - 18 个 Skill

| Skill | 功能 | 触发词 |
|-------|------|--------|
| collab_global_to_module | 全局→模块产品 协调 | 分配、协调 |
| collab_module_to_global | 模块产品→全局 汇报 | 汇报、提交 |
| collab_module_to_module | 模块产品间 对齐 | 模块对接、接口 |
| collab_module_to_dev_qa | 模块产品→测试开发 交接 | 交接、对接 |
| collab-context-alignment | 跨角色上下文对齐 | 上下文对齐、同步 |
| collab-product-alignment | 项目初始化需求对齐 | 需求对齐、项目启动 |
| collab-requirement-details | 需求细节对齐 | 细节、确认需求 |
| collab-product-to-dev | 产品→开发 过渡 | 转开发、交给开发 |
| collab-dev-to-qa | 开发→测试 过渡 | 转测试、提测 |
| collab-qa-to-product | 测试→产品 过渡 | 转产品、验收 |
| collab-requirement-handoff | 需求交接 | 需求评审、交接 |
| collab-dev-qa-sync | 开发测试同步 | 同步、测试数据 |
| collab-acceptance-review | 验收评审 | UAT、验收 |
| collab-incident-response | 线上应急 | 故障、P0 |
| collab-retrospective | 迭代复盘 | 复盘、retro |
| project_feedback_to_module | 项目整体→模块 反馈 | 项目反馈、模块表现 |
| acceptance_feedback_to_module | 验收→模块产品 反馈 | 验收反馈、UAT反馈 |
| iteration_closure | 复盘→下一轮分析 闭环 | 迭代闭环、下一迭代 |

---
# 使用示例

## 示例 1: 启动新项目

```typescript
// 1. 全局产品进行项目梳理
skill(name="global-project-analysis")
// 输入：项目背景、商业目标
// 输出：项目概述、模块划分建议

// 2. 全局产品协调模块
skill(name="global-module-coordination")
// 输入：模块列表、负责人
// 输出：任务分配表

// 3. 模块产品产出需求
skill(name="module_product_requirement")
// 输入：模块范围、用户需求
// 输出：模块需求文档
```

## 示例 2: 开发新功能

```typescript
// 1. 开发前获取最小上下文（必须）
skill(name="module_dev_context")
// 输入：我要开发订单模块
// 输出：最小上下文（涉及模块、依赖、边界）

// 2. 功能实现
skill(name="module_dev_implementation")
// 输出：完整代码

// 3. 与其他模块对齐
skill(name="module_dev_sync")
// 输出：接口确认、依赖确认
```

## 示例 3: 测试新功能

```typescript
// 1. 测试前获取最小上下文（必须）
skill(name="module_test_context")
// 输入：我要测试用户模块
// 输出：最小上下文

// 2. 用例设计
skill(name="module_test_design")
// 输出：测试用例列表

// 3. 测试执行
skill(name="module_test_execution")
// 输出：测试结果报告
```

## 示例 4: 项目整体把控

```typescript
// 1. 项目整体开发把控
skill(name="project_overall_dev")
// 输入：各模块开发进度
// 输出：整体进度、风险点

// 2. 项目整体测试把控
skill(name="project_overall_test")
// 输入：各模块测试进度
// 输出：整体测试状态

// 3. 集成测试
skill(name="project_integration_test")
// 输出：集成测试结果
```

## 示例 5: 闭环协同

```typescript
// 闭环1: 项目整体反馈给模块
skill(name="project_feedback_to_module")
// 输入：project_overall_dev/test 结果
// 输出：模块反馈报告

// 闭环2: 验收反馈给模块产品
skill(name="acceptance_feedback_to_module")
// 输入：验收结果
// 输出：验收反馈报告

// 闭环3: 复盘连接到下一轮
skill(name="iteration_closure")
// 输入：复盘结果
// 输出：下一迭代计划
```

---
# 最佳实践

1. **明确调用**：使用 `load_skills=["skill-name"]` 明确指定
2. **最小上下文优先**：开发/测试必须先调用 `*_context` skill
3. **提供上下文**：在 prompt 中提供足够的背景信息
4. **触发词匹配**：输入自然包含触发词的描述即可自动匹配
5. **闭环意识**：每个阶段完成后，考虑是否需要触发闭环 skill
6. **协同调用**：复杂任务可以同时加载多个相关 Skill

---
# 配置说明

如需修改或扩展 Skill：

1. 编辑对应角色的 YAML 文件
2. 更新 `skills-registry.yaml` 中的索引
3. Skill 会自动被系统识别

---
# 统计信息

| 指标 | 数量 |
|------|------|
| 总 Skills | 78 |
| 文件数 | 9 |
| 触发词 | 650+ |

---
