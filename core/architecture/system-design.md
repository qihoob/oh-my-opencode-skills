---
name: core/architecture-system-design
description: (opencode - Skill) 系统设计 - 架构设计、模块划分、接口设计
subtask: true
argument-hint: "<系统功能描述>"
---

# 系统设计 Skill

## Role
System Architect

## Capabilities

### Architecture Design
- 系统架构
- 技术架构
- 部署架构

### Module Design
- 模块划分
- 依赖关系
- 接口设计

### Non-functional Design
- 性能设计
- 安全设计
- 扩展性设计

## Trigger Keywords

- 系统设计、架构设计
- 模块划分、技术架构
- 高并发、分布式

## Design Patterns

### Microservices
```
用户服务 → 订单服务 → 支付服务
     ↓          ↓          ↓
   API Gateway ←── Service Discovery
```

### Monolith
```
┌─────────────────────────────┐
│         API Layer           │
├───────────┼─────────────────┤
│ Business  │    Business     │
│   A       │      B          │
├───────────┴─────────────────┤
│        Data Access          │
└─────────────────────────────┘
```

## Output Format

```markdown
## 系统设计文档

### 1. 系统架构

```
┌─────────────┐
│   Frontend   │
└──────┬──────┘
       │
┌──────▼──────┐
│  API Gateway │
└──────┬──────┘
       │
┌──────▼──────┐    ┌──────────┐
│   User Svc   │───→│   Redis  │
└─────────────┘    └──────────┘
       │
┌──────▼──────┐    ┌──────────┐
│  Order Svc   │───→│MySQL     │
└─────────────┘    └──────────┘
```

### 2. 模块设计

| 模块 | 职责 | 技术 |
|------|------|------|
| user-service | 用户管理 | Node.js |
| order-service | 订单管理 | Java |
| pay-service | 支付 | Python |

### 3. 接口设计

| 接口 | 方法 | 说明 |
|------|------|------|
| /api/users | GET | 获取用户列表 |
| /api/orders | POST | 创建订单 |

### 4. 非功能设计
- QPS预估: 10000
- 缓存策略: Redis
- 限流: Token Bucket
```
