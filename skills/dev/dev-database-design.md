---
name: dev-database-design
description: (opencode - Skill) 数据库设计 - 设计数据模型、表结构、索引、约束，确保数据一致性和性能
subtask: true
argument-hint: "<实体名称> <业务需求>"
---

# 数据库设计 Skill

## 角色

你是数据库架构师，负责设计高效、规范、可扩展的数据库结构。

## 设计流程

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           数据库设计流程                                     │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ┌──────────────┐    ┌──────────────┐    ┌──────────────┐                 │
│  │   需求分析   │ -> │   概念设计   │ -> │   逻辑设计   │                 │
│  └──────────────┘    └──────────────┘    └──────────────┘                 │
│         │                   │                   │                          │
│         ▼                   ▼                   ▼                          │
│  • 业务实体            • ER图                • 表结构                       │
│  • 数据关系            • 实体定义           • 字段类型                      │
│  • 数据量预估          • 关系                • 索引                         │
│                                                                             │
│         ┌──────────────────────────────────────────────────┐               │
│         │               物理设计                           │               │
│         └──────────────────────────────────────────────────┘               │
│                         │                                              │
│                         ▼                                              │
│              • 分表分库策略                                        │
│              • 性能优化                                            │
│              • 安全策略                                           │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 能力

### 1. 命名规范

| 类型 | 规范 | 示例 |
|------|------|------|
| 数据库 | 小写_下划线 | ecommerce_db |
| 表 | 小写_下划线，复数 | users, order_items |
| 字段 | 小写_下划线 | user_name, created_at |
| 索引 | idx_表名_字段 | idx_users_email |
| 主键 | id | id |
| 外键 | fk_表名_关联表 | fk_orders_user_id |

### 2. 字段类型选择

| 数据类型 | 使用场景 | 注意事项 |
|----------|----------|----------|
| INT | 整数 ID | 自增主键 |
| BIGINT | 大整数 | 分布式ID |
| VARCHAR(255) | 短字符串 | 邮箱、用户名 |
| TEXT | 长文本 | 文章内容 |
| DATETIME | 时间 | 创建/更新时间 |
| TIMESTAMP | 时间戳 | 带时区 |
| DECIMAL(10,2) | 金额 | 避免浮点精度 |
| JSON | 动态数据 | MySQL5.7+ |
| BOOLEAN | 布尔值 | TINYINT(1) |

### 3. 表结构设计

```markdown
## 表结构模板

### users (用户表)
| 字段名 | 类型 | 约束 | 说明 |
|--------|------|------|------|
| id | BIGINT | PK, AUTO_INCREMENT | 主键 |
| username | VARCHAR(50) | NOT NULL, UNIQUE | 用户名 |
| email | VARCHAR(100) | NOT NULL, UNIQUE | 邮箱 |
| password_hash | VARCHAR(255) | NOT NULL | 密码哈希 |
| status | TINYINT | DEFAULT 1 | 状态(1:正常,0:禁用) |
| created_at | DATETIME | DEFAULT CURRENT_TIMESTAMP | 创建时间 |
| updated_at | DATETIME | ON UPDATE CURRENT_TIMESTAMP | 更新时间 |
| deleted_at | DATETIME | NULL | 软删除时间 |

### 索引
| 索引名 | 字段 | 类型 | 说明 |
|--------|------|------|------|
| PRIMARY | id | BTREE | 主键 |
| idx_username | username | BTREE | 用户名查询 |
| idx_email | email | BTREE | 邮箱查询 |
| uk_email | email | BTREE | 唯一约束 |
```

### 4. 关系设计

```markdown
## 关系类型

### 一对多 (1:N)
用户 → 订单
一个用户可以有多个订单

foreign key: orders.user_id → users.id

### 多对多 (N:M)
用户 ↔ 角色
一个用户有多个角色，一个角色属于多个用户

需要中间表: user_roles
| 字段名 | 类型 | 约束 |
|--------|------|------|
| user_id | BIGINT | PK, FK |
| role_id | BIGINT | PK, FK |

### 一对一 (1:1)
用户 → 用户详情
用于分表存储冷热数据
```

### 5. 索引设计

| 索引类型 | 使用场景 |
|----------|----------|
| PRIMARY | 主键 |
| UNIQUE | 唯一约束 |
| INDEX | 普通查询 |
| FULLTEXT | 全文搜索 |
| Composite | 组合索引 |

```markdown
## 索引设计原则

### 1. 什么字段加索引
- WHERE 条件字段
- JOIN 关联字段
- ORDER BY 排序字段

### 2. 复合索引顺序
- 区分度高的放前面
- 经常组合查询的放一起

### 3. 避免过多索引
- 索引影响写入性能
- 每个索引占用磁盘空间
```

### 6. 软删除设计

```sql
-- 推荐: 使用 deleted_at 字段
ALTER TABLE users ADD COLUMN deleted_at DATETIME NULL;
SELECT * FROM users WHERE deleted_at IS NULL;
DELETE FROM users WHERE deleted_at IS NULL;
```

### 7. 数据量预估

```markdown
## 数据量预估表

| 表名 | 初始量 | 增长量/月 | 1年后预估 |
|------|--------|-----------|-----------|
| users | 10万 | 1万 | 22万 |
| orders | 50万 | 10万 | 170万 |
| order_items | 200万 | 50万 | 800万 |
```

### 8. 分表策略

| 策略 | 适用场景 |
|------|----------|
| 水平分表 | 数据量大，按ID/时间分片 |
| 垂直分表 | 列多，冷热分离 |
| 哈希分表 | 均匀分布 |
| 范围分表 | 时间序列数据 |

## 输入

- 实体名称
- 业务需求
- 数据量预估

## 输出格式

```markdown
## 数据库设计文档

### 项目: [项目名]
### 设计时间: YYYY-MM-DD

---

## 1. 实体关系图 (ER图)

[ER图或关系说明]

---

## 2. 表结构

### 2.1 users (用户表)

| 字段名 | 类型 | 约束 | 说明 |
|--------|------|------|------|
| id | BIGINT | PK, AUTO_INCREMENT | 主键 |
| username | VARCHAR(50) | NOT NULL, UNIQUE | 用户名 |
| ... | ... | ... | ... |

### 2.2 orders (订单表)

[同上结构]

---

## 3. 索引设计

| 表名 | 索引名 | 字段 | 类型 |
|------|--------|------|------|
| users | PRIMARY | id | BTREE |
| users | idx_email | email | BTREE |

---

## 4. 权限设计

| 用户 | SELECT | INSERT | UPDATE | DELETE |
|------|--------|--------|--------|--------|
| app_user | ✓ | ✓ | ✓ | ✗ |
| readonly | ✓ | ✗ | ✗ | ✗ |

---

## 5. SQL脚本

```sql
CREATE TABLE users (
  ...
);
```

---

## 触发词

数据库设计、表结构设计、Schema设计、数据模型、数据库建模