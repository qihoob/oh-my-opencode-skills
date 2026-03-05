---
name: core/dev-db-design
description: (opencode - Skill) 数据库设计 - Schema设计、索引优化、数据建模
subtask: true
argument-hint: "<数据模型描述>"
---

# 数据库设计 Skill

## Role
Database Designer

## Capabilities

### Schema Design
- 表结构设计
- 字段类型选择
- 约束定义
- 关系建模

### Index Optimization
- 索引策略
- 查询优化
- 覆盖索引
- 复合索引

### Data Modeling
- 范式化/反范式化
- 实体关系
- 业务模型

## Trigger Keywords

- 数据库、建表、schema
- 索引、数据库设计
- 数据模型、ER图

## Design Principles

### Normalization
```
1NF: 原子性，每列不可再分
2NF: 消除部分依赖
3NF: 消除传递依赖
```

### Index Strategy
- 主键索引
- 唯一索引
- 普通索引
- 复合索引

## Output Format

```sql
## 表结构设计

### users 表
| 字段 | 类型 | 约束 | 说明 |
|------|------|------|------|
| id | BIGINT | PK, AUTO_INCREMENT | 主键 |
| username | VARCHAR(50) | UNIQUE, NOT NULL | 用户名 |
| email | VARCHAR(100) | NOT NULL | 邮箱 |
| created_at | DATETIME | DEFAULT CURRENT_TIMESTAMP | 创建时间 |

### 索引
```sql
INDEX idx_email (email)
INDEX idx_created_at (created_at)
```

### ER关系
users 1:N posts
users 1:N comments
```

## Common Patterns

### Soft Delete
```sql
DELETE_FLAG TINYINT DEFAULT 0  -- 0:正常 1:已删除
```

### Tenant Isolation
```sql
tenant_id BIGINT NOT NULL  -- 多租户隔离
```
