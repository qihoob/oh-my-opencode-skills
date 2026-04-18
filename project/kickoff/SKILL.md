---
name: kickoff
description: 项目启动 - 确定项目目标、制定里程碑、团队分工
version: "1.0"
---

# Skill: kickoff

**角色**: 项目 (Project)
**功能**: 项目启动
**触发关键词**: 启动项目、新项目、项目初始化

## 产出文档
- **项目概览**: `.opencode/docs/project-overview.md`

## 核心能力

1. **项目规划**
   - 确定项目目标
   - 制定里程碑
   - 资源规划

2. **团队分工**
   - 角色定义
   - 职责划分
   - 沟通机制

3. **技术准备**
   - 技术栈选择
   - 开发规范
   - 环境搭建

## 执行步骤

### Step 1: 项目初始化

```
操作: 确认项目基本信息
- 项目名称和目标
- 预计里程碑
- 团队规模和角色分工
```

### Step 2: 技术选型

```
操作: 确定技术栈
- 前端框架和 UI 库
- 后端框架和数据层
- 基础设施方案
- 开发工具和规范
```

### Step 3: 环境搭建

```
操作: 初始化开发环境
- 创建项目仓库
- 配置 CI/CD 流水线
- 配置开发、测试、预发布环境
```

### Step 4: 产出项目文档

```
输出路径: .opencode/docs/project-overview.md

内容包括:
- 项目目标和愿景
- 技术栈和架构决策
- 里程碑和时间线
- 团队分工
- 开发规范
```

## 配合 Skills

| 配合技能 | 关系 | 说明 |
|----------|------|------|
| `product/analysis/global-project-analysis` | 后续 | 项目启动后进行全局分析 |
| `product/analysis/product-technical-assessment` | 后续 | 技术可行性评估 |
| `dev/modules/module-splitting` | 后续 | 模块拆解和划分 |
| `devops/ci/pipeline` | 后续 | 配置 CI/CD 流水线 |
| `system/state-tracker` | 状态 | 记录链路执行状态 |

## 下一步推荐

| 条件 | 推荐技能 |
|------|----------|
| 项目已初始化 | `product/analysis/global-project-analysis`（全局分析） |
| 需要评估可行性 | `product/analysis/product-technical-assessment`（技术评估） |
| 需要拆解模块 | `dev/modules/module-splitting`（模块拆解） |

## 触发词
启动项目、新项目、项目初始化、从零开始
