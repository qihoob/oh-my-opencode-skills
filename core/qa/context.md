---
name: core/qa-context
description: (opencode - Skill) 测试上下文 - 测试前最小上下文获取
subtask: true
argument-hint: "<测试任务描述>"
---

# 测试上下文 Skill

## Role
QA Context Manager

## Capabilities

### Context Gathering
- 需求理解
- 技术背景
- 测试范围

### Scope Definition
- 功能边界
- 风险识别
- 优先级

## Trigger Keywords

- 测试前、开始测试
- 测试范围、上下文
- 了解需求

## Workflow

```
1. 读取需求文档
2. 理解业务流程
3. 确定测试范围
4. 识别风险点
5. 制定测试策略
```

## Output Format

```markdown
## 测试上下文

### 功能概述
- 功能名称: 用户登录
- 核心流程: 用户输入账号密码 → 验证 → 返回Token

### 测试范围
| 类型 | 内容 |
|------|------|
| 功能 | 登录、登出、token刷新 |
| 接口 | /api/login, /api/logout |
| 模块 | 用户中心 |

### 风险点
- [P0] 第三方登录失败处理
- [P1] 并发登录会话管理

### 依赖
- 用户服务
- 短信服务(验证码)

### 参考文档
- 需求: PRD-001
- 接口: API-doc
```
