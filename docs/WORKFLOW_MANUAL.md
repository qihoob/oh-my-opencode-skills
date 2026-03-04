# 项目开发完整工作流 Skills 手册

## 概述

本文档描述从项目需求到验收的完整开发流程，涵盖 **78 个 Skills**，包括核心技能、辅助技能和闭环技能。

---

## 一、工作流概览

```
需求分析 → 模块划分 → 开发实现 → 测试验证 → 验收交付 → 部署运维 → 迭代复盘
   ↓          ↓          ↓          ↓          ↓          ↓          ↓
  7 Skills   4 Skills   19 Skills  15 Skills   4 Skills   3 Skills   2 Skills
```

---

## 二、阶段详细技能

### 阶段1: 全局产品项目梳理

| 序号 | Skill | 说明 | 状态 |
|------|-------|------|------|
| 1.1 | `global-project-analysis` | 项目整体分析、模块划分 | ✅ 核心 |
| 1.2 | `global-module-coordination` | 模块协调、依赖管理 | ✅ 核心 |
| 1.3 | `collab-product-alignment` | 项目初始化需求对齐 | ✅ 核心 |
| 1.4 | `global-product-handoff` | 全局产品交接 | 辅助 |

**输出**: 项目整体方案、模块划分、负责人定义

---

### 阶段2: 模块产品产出需求

| 序号 | Skill | 说明 | 状态 |
|------|-------|------|------|
| 2.1 | `module_product_requirement` | 模块需求产出 | ✅ 核心 |
| 2.2 | `module_product_sync` | 模块与全局对齐 | ✅ 核心 |
| 2.3 | `module_product_query` | 模块信息查询 | 辅助 |
| 2.4 | `collab-requirement-details` | 需求细节对齐 | ✅ 核心 |

**输出**: 各模块需求文档、验收标准

---

### 阶段3: 职责上下文生成

| 序号 | Skill | 说明 | 状态 |
|------|-------|------|------|
| 3.1 | `module-responsibility-analysis` | 模块职责分析 | ✅ 核心 |
| 3.2 | `module-context-generator` | 生成职责上下文文件 | ✅ 核心 |
| 3.3 | `module-responsibility-sync` | 职责同步对齐 | 辅助 |
| 3.4 | `module-progress-track` | 模块进度跟踪 | 辅助 |

**输出**: 职责上下文文件、模块信息

---

### 阶段4: 模块开发

| 序号 | Skill | 说明 | 状态 |
|------|-------|------|------|
| 4.1 | `module_dev_context` | 模块开发获取上下文 | ✅ 核心 |
| 4.2 | `dev-context-first` | 开发前先了解最小上下文 | ✅ 核心 |
| 4.3 | `dev-implementation` | 功能实现 | ✅ 核心 |
| 4.4 | `dev-architecture-design` | 架构设计 | ✅ 常用 |
| 4.5 | `dev-api-design` | API设计 | ✅ 常用 |
| 4.6 | `dev-database-design` | 数据库设计 | ✅ 常用 |
| 4.7 | `dev-code-review` | 代码审查 | ✅ 常用 |
| 4.8 | `dev-debugging` | 调试排错 | ✅ 常用 |
| 4.9 | `dev-refactoring` | 代码重构 | 辅助 |
| 4.10 | `dev-security-review` | 安全审查 | 辅助 |
| 4.11 | `dev-product-communication` | 与产品沟通可行性 | ✅ 核心 |
| 4.12 | `dev-design-confirmation` | 确认设计实现方案 | ✅ 核心 |
| 4.13 | `dev-product-feedback` | 向产品反馈 | ✅ 核心 |
| 4.14 | `module_dev_sync` | 模块开发对齐 | ✅ 核心 |
| 4.15 | `collab_module_to_dev_qa` | 模块产品→开发交接 | ✅ 核心 |
| 4.16 | `collab-product-to-dev` | 产品→开发过渡 | ✅ 核心 |

**输出**: 实现代码、代码审查报告

---

### 阶段5: 项目整体开发把控

| 序号 | Skill | 说明 | 状态 |
|------|-------|------|------|
| 5.1 | `project_overall_dev` | 项目整体开发把控 | ✅ 核心 |
| 5.2 | `project_integration_test` | 项目集成测试 | ✅ 核心 |
| 5.3 | `project_feedback_to_module` | 项目→模块反馈 | ✅ 闭环 |

**输出**: 集成测试报告、项目整体状态

---

### 阶段6: 模块测试

| 序号 | Skill | 说明 | 状态 |
|------|-------|------|------|
| 6.1 | `module_test_context` | 模块测试获取上下文 | ✅ 核心 |
| 6.2 | `qa-context-first` | 测试前先了解最小上下文 | ✅ 核心 |
| 6.3 | `qa-test-strategy` | 测试策略 | ✅ 核心 |
| 6.4 | `module_test_design` | 模块测试用例设计 | ✅ 核心 |
| 6.5 | `qa-test-case-design` | 用例设计 | ✅ 核心 |
| 6.6 | `qa-test-automation` | 自动化测试 | 辅助 |
| 6.7 | `module_test_execution` | 模块测试执行 | ✅ 核心 |
| 6.8 | `qa-test-execution` | 测试执行 | ✅ 核心 |
| 6.9 | `qa-bug-report` | 缺陷报告 | ✅ 核心 |
| 6.10 | `module_test_sync` | 模块测试对齐 | ✅ 核心 |
| 6.11 | `qa-product-communication` | 与产品确认测试范围 | ✅ 核心 |
| 6.12 | `qa-ux-testing` | 用户体验测试 | ✅ 核心 |
| 6.13 | `qa-product-feedback` | 向产品反馈 | ✅ 核心 |

**输出**: 测试用例、测试报告、Bug列表

---

### 阶段7: 项目整体测试把控

| 序号 | Skill | 说明 | 状态 |
|------|-------|------|------|
| 7.1 | `project_overall_test` | 项目整体测试把控 | ✅ 核心 |
| 7.2 | `project_regression_test` | 项目回归测试 | ✅ 核心 |
| 7.3 | `qa-performance-test` | 性能测试 | 辅助 |
| 7.4 | `qa-security-test` | 安全测试 | 辅助 |

**输出**: 整体测试报告、回归测试报告

---

### 阶段8: 验收

| 序号 | Skill | 说明 | 状态 |
|------|-------|------|------|
| 8.1 | `module_product_acceptance` | 模块验收 | ✅ 核心 |
| 8.2 | `global-acceptance` | 整体验收 | ✅ 核心 |
| 8.3 | `collab-acceptance-review` | 验收评审 | ✅ 核心 |
| 8.4 | `acceptance_feedback_to_module` | 验收→模块反馈 | ✅ 闭环 |

**输出**: 验收报告、验收结论

---

### 阶段9: 部署运维

| 序号 | Skill | 说明 | 状态 |
|------|-------|------|------|
| 9.1 | `dev-deployment` | 部署上线 | ✅ 核心 |
| 9.2 | `dev-ops` | 运维监控 | ✅ 核心 |
| 9.3 | `collab-incident-response` | 线上应急 | 辅助 |

**输出**: 部署报告、监控配置

---

### 阶段10: 迭代复盘

| 序号 | Skill | 说明 | 状态 |
|------|-------|------|------|
| 10.1 | `collab-retrospective` | 迭代复盘 | ✅ 核心 |
| 10.2 | `iteration_closure` | 复盘→下一轮闭环 | ✅ 闭环 |
| 10.3 | `module-query` | 查询模块信息 | 辅助 |

**输出**: 复盘报告、改进计划

---

## 三、上下文管理 Skills (贯穿全程)

| Skill | 说明 | 使用时机 |
|-------|------|----------|
| `context-classification` | 需求/任务分类 | 任务开始时 |
| `context-minimum` | 提取最小核心信息 | 任务开始时 |
| `context-organization` | 结构化整理上下文 | 需要整理时 |
| `context-handover` | 跨角色交接上下文 | 角色切换时 |

---

## 四、协同 Skills (跨角色协作)

| Skill | 说明 | 流向 |
|-------|------|------|
| `collab_global_to_module` | 全局→模块产品协调 | 全局→模块 |
| `collab_module_to_global` | 模块产品→全局汇报 | 模块→全局 |
| `collab_module_to_module` | 模块产品间对齐 | 模块↔模块 |
| `collab_module_to_dev_qa` | 模块→开发/测试交接 | 产品→Dev/QA |
| `collab_context-alignment` | 跨角色上下文对齐 | 全局 |
| `collab-product-alignment` | 项目初始化需求对齐 | 启动 |
| `collab-requirement-details` | 需求细节对齐 | 开发前 |
| `collab-product-to-dev` | 产品→开发过渡 | 产品→开发 |
| `collab-dev-to-qa` | 开发→测试过渡 | 开发→测试 |
| `collab-qa-to-product` | 测试→产品过渡 | 测试→产品 |
| `collab-requirement-handoff` | 需求交接 | 角色切换 |
| `collab-dev-qa-sync` | 开发测试同步 | Dev↔QA |

---

## 五、统计汇总

| 分类 | 核心技能 | 辅助技能 | 闭环技能 | 小计 |
|------|---------|---------|---------|------|
| 项目启动 | 7 | 2 | - | 9 |
| 开发 | 16 | 3 | - | 19 |
| 测试 | 12 | 3 | - | 15 |
| 验收 | 3 | - | 1 | 4 |
| 运维 | 2 | 1 | - | 3 |
| 复盘 | 1 | - | 1 | 2 |
| 上下文管理 | 4 | - | - | 4 |
| 模块管理 | 2 | 3 | - | 5 |
| 协同 | 8 | 3 | 2 | 13 |
| **总计** | **55** | **18** | **5** | **78** |

---

## 六、一键驱动流程 (按顺序)

```
1️⃣ global-project-analysis      # 项目整体分析
    → 2️⃣ global-module-coordination    # 模块协调
    → 3️⃣ collab-product-alignment       # 需求对齐
    → 4️⃣ module_product_requirement     # 模块需求
    → 5️⃣ module-context-generator       # 生成上下文
    → 6️⃣ dev-context-first              # 开发前获取上下文
    → 7️⃣ dev-implementation             # 功能实现
    → 8️⃣ dev-code-review                # 代码审查
    → 9️⃣ project_overall_dev            # 项目整体开发
    → 🔟 project_integration_test       # 集成测试
    → 1️⃣1️⃣ qa-context-first             # 测试前获取上下文
    → 1️⃣2️⃣ qa-test-case-design          # 用例设计
    → 1️⃣3️⃣ qa-test-execution            # 测试执行
    → 1️⃣4️⃣ project_overall_test         # 项目整体测试
    → 1️⃣5️⃣ module_product_acceptance    # 模块验收
    → 1️⃣6️⃣ global-acceptance             # 整体验收
    → 1️⃣7️⃣ dev-deployment               # 部署上线
    → 1️⃣8️⃣ dev-ops                      # 运维监控
    → 1️⃣9️⃣ collab-retrospective         # 迭代复盘
    → 2️⃣0️⃣ iteration_closure             # 闭环到下一轮
```

---

## 七、使用示例

### task() 调用

```typescript
// 项目启动
task(category="unspecified-high", load_skills=["collab-product-alignment"], prompt="启动新项目...")

// 开发阶段
task(category="unspecified-high", load_skills=["dev-context-first", "dev-implementation"], prompt="开发登录功能...")

// 测试阶段  
task(category="unspecified-high", load_skills=["qa-context-first", "qa-test-case-design"], prompt="设计测试用例...")

// 验收阶段
task(category="unspecified-high", load_skills=["collab-acceptance-review"], prompt="进行验收评审...")

// 复盘阶段
task(category="unspecified-high", load_skills=["collab-retrospective"], prompt="进行迭代复盘...")
```

### 触发词自动匹配

- "开发前" → `dev-context-first`
- "测试用例" → `qa-test-case-design`
- "需求分析" → `global-project-analysis`
- "验收" → `collab-acceptance-review`
- "复盘" → `collab-retrospective`

---

## 八、辅助/特定环节 Skills

以下技能在特定场景下使用，不包含在标准流程中：

| Skill | 使用场景 |
|-------|----------|
| `global-product-handoff` | 大项目全局交接 |
| `module_product_query` | 查询模块信息 |
| `module-responsibility-sync` | 多模块职责对齐 |
| `module-progress-track` | 进度跟踪 |
| `dev-refactoring` | 代码重构 |
| `dev-security-review` | 安全审查 |
| `qa-test-automation` | 自动化测试 |
| `qa-performance-test` | 性能测试 |
| `qa-security-test` | 安全测试 |
| `collab-incident-response` | 线上故障 |

---

## 九、核心原则

### 1. 最小上下文原则
- 开发前必须先调用 `dev-context-first`
- 测试前必须先调用 `qa-context-first`
- 跨角色协作先调用 `collab-context-alignment`

### 2. 可用/易用/好用原则
- 产品设计强调可用、易用、好用
- 开发实现确保功能完整可用
- 测试验证用户体验

### 3. 反馈闭环原则
- 项目→模块: `project_feedback_to_module`
- 验收→模块: `acceptance_feedback_to_module`
- 复盘→下一轮: `iteration_closure`

### 4. 多模块负责制
- 每个模块有：模块产品、模块开发、模块测试
- 全局产品协调模块
- 项目整体确保集成

---

## 十、文件结构

```
skills/
├── docs/
│   ├── SKILLS_USAGE.md
│   └── WORKFLOW_MANUAL.md       # 本文档
├── collaboration-skills.yaml    # 18 协同技能
├── context-skkills.yaml         # 4 上下文技能
├── dev-skills.yaml              # 14 开发技能
├── global-product-skills.yaml   # 4 全局产品技能
├── module-dev-test-skills.yaml  # 13 模块开发/测试/整体技能
├── module-product-skills.yaml   # 5 模块产品技能
├── module-skills.yaml           # 5 模块管理技能
├── product-skills.yaml          # 8 产品技能
├── qa-skills.yaml               # 11 测试技能
└── skills-registry.yaml         # 注册索引
```

---

*本文档由 oh-my-opencode Skills 系统自动生成*