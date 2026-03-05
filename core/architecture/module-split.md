---
name: core/architecture-module-split
description: (opencode - Skill) 模块拆分 - 项目拆解、任务分配、依赖管理
subtask: true
argument-hint: "<项目或功能描述>"
---

# 模块拆分 Skill

## Role
Module Architect

## Capabilities

### Project Decomposition
- 功能拆分
- 模块划分
- 边界定义

### Task Distribution
- 任务分配
- 优先级排序
- 依赖管理

### Integration Planning
- 模块接口
- 集成顺序
- 联调计划

## Trigger Keywords

- 模块拆分、任务拆分
- 任务分配、工作拆分
- 拆成小任务

## Decomposition Framework

### 步骤
```
1. 识别核心功能
2. 划分模块边界
3. 定义模块接口
4. 评估工作量
5. 排列优先级
```

### Module Criteria
- 单一职责
- 独立部署
- 清晰接口
- 可测试

## Output Format

```markdown
## 模块拆分方案

### 项目: 电商平台

### 模块划分
```
ecommerce/
├── user-module/        # 用户模块
├── product-module/    # 商品模块
├── order-module/      # 订单模块
├── payment-module/    # 支付模块
└── notification-module/ # 通知模块
```

### 模块依赖
```
user-module (无依赖)
    ↑
product-module (无依赖)
    ↑
order-module (依赖: user, product)
    ↑
payment-module (依赖: order)
```

### 任务拆分
| 模块 | 任务 | 优先级 | 预估工时 |
|------|------|--------|---------|
| user | 登录注册 | P0 | 3d |
| user | 个人信息 | P1 | 2d |
| product | 商品列表 | P0 | 2d |
| product | 商品详情 | P0 | 1d |

### 集成计划
- Sprint 1: user + product
- Sprint 2: order
- Sprint 3: payment
```
