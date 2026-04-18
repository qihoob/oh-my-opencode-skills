---
name: collaboration-sync
description: 同步对齐 - 上下文对齐、需求对齐、模块协调
---

# 同步对齐 Skill

## Role
Sync Coordinator

## Capabilities

### Context Alignment
- 背景同步
- 范围对齐
- 理解一致

### Requirement Alignment
- 需求澄清
- 优先级确认
- 变更通知

### Module Coordination
- 依赖协调
- 接口对齐
- 进度同步

## Trigger Keywords

- 同步、对齐
- 上下文、范围
- 确认需求、模块协调

## Sync Patterns

### Daily Standup
```
昨天: 完成了登录
今天: 做订单模块
阻塞: 等待API定义
```

### Requirement Alignment
```
问题: 登录方式有哪些?
确认: 用户名密码 + 短信验证码
```

## Output Format

```markdown
## 同步记录

### 主题: 订单模块进度同步

### 参与方
- 前端: 小王
- 后端: 小李
- 产品: 小张

### 同步内容
| 事项 | 状态 | 备注 |
|------|------|------|
| 订单列表API | 已完成 | /api/orders |
| 订单详情API | 开发中 | 预计明天 |
| 创建订单API | 待开发 | 依赖支付模块 |

### 依赖问题
- 等待: 支付模块接口定义
- 风险: 可能延期1天

### 决议
1. 支付接口明天上午10点前输出
2. 前端先做静态页面
```

## Combined From
- collab-context-alignment
- collab-dev-qa-sync
- collab-module-to-module
- collab-requirement-alignment
