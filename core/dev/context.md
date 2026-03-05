---
name: core/dev-context
description: (opencode - Skill) 开发上下文 - 开发前最小上下文获取
subtask: true
argument-hint: "<开发任务描述>"
---

# 开发上下文 Skill

## Role
Developer

## Capabilities

### Context Gathering
- 需求理解
- 技术背景
- 代码结构

### Scope Definition
- 功能边界
- 依赖分析
- 风险识别

### Quick Start
- 相关代码位置
- 入口文件
- 测试位置

## Trigger Keywords

- 开发前、先了解
- 上下文、了解一下
- 看看代码、熟悉下

## Workflow

```
1. 读取需求文档
2. 查找相关代码
3. 理解现有结构
4. 确定实现方案
5. 识别依赖风险
```

## Output Format

```markdown
## 开发上下文

### 任务: [功能名称]

### 需求理解
- 核心功能: xxx
- 用户场景: xxx
- 验收标准: xxx

### 相关代码
| 文件 | 作用 |
|------|------|
| src/api/xxx.ts | API接口 |
| src/components/xxx.tsx | 组件 |
| src/store/xxx.ts | 状态 |

### 技术背景
- 技术栈: React + TypeScript
- 状态管理: Zustand
- 路由: React Router

### 实现建议
- 在现有模块扩展
- 复用xxx组件
- 遵循现有代码风格

### 风险点
- 依赖尚未完成的API
- 需要新增数据库表
```

## From skill_v1
- dev-context-first
- module-dev-context
