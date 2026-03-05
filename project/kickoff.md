---
name: project-kickoff
description: (opencode - Skill) 项目启动 - 初始化项目、团队配置、全流程统领
subtask: true
argument-hint: "<项目描述>"
---

# 项目启动 Skill

## Role
Project Manager

## Capabilities

### Project Initialization
- 项目需求理解
- 技术选型建议
- 团队规模评估

### Team Configuration
- 角色定义
- 人数规划
- 职责分配

### Workflow Setup
- 开发流程
- 协作规范
- 工具链

## Trigger Keywords

- 启动项目、新项目
- 项目初始化、开始项目
- 帮我搭建项目

## Workflow

```
1. 需求分析 → 理解业务
2. 技术选型 → 确定技术栈
3. 团队配置 → 确定人数角色
4. 模块拆分 → 划分工作
5. 计划制定 → 里程碑
```

## Output Format

```markdown
## 项目启动报告

### 项目: [项目名称]

### 1. 项目概述
- 核心功能: xxx
- 目标用户: xxx
- 业务价值: xxx

### 2. 技术选型
| 模块 | 技术 | 理由 |
|------|------|------|
| 前端 | React | 团队熟悉 |
| 后端 | Node.js | 快速开发 |
| 数据库 | PostgreSQL | 稳定 |

### 3. 团队配置
| 角色 | 人数 | 职责 |
|------|------|------|
| 前端 | 2 | 页面开发 |
| 后端 | 2 | 接口开发 |
| QA | 1 | 测试 |

### 4. 模块划分
- 用户模块
- 订单模块
- 支付模块

### 5. 里程碑
| 阶段 | 目标 | 时间 |
|------|------|------|
| MVP | 核心功能 | 2周 |
| Beta | 完整功能 | 4周 |
| Release | 上线 | 6周 |
```

## From skill_v1
- project-kickoff
- project-team-configuration
