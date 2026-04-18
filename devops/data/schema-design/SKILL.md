---
name: schema-design
description: 数据库设计 - 表结构设计、索引策略、分区方案、ER模型、范式优化、性能预估
version: "1.0"
---

# Skill: schema-design

**角色**: DevOps / 后端架构师
**功能**: 数据库设计（表结构、索引、分区、ER模型）
**触发关键词**: 数据库设计、表结构设计、schema设计、ER图、数据建模、建表、索引设计

## 产出文档
- **数据库设计文档**: `.opencode/docs/db-schema-{feature}.md`

## 依赖文档
- **必须读取**: `.opencode/docs/requirement-{feature}.md`
- **可选读取**: `.opencode/docs/contract-{feature}.md`

## 核心能力

### 1. ER 模型设计

```
实体关系分析:

1. 识别实体
   - 从需求中提取核心业务实体
   - 确定每个实体的属性

2. 确定关系
   - 1:1 — 一个实体唯一对应另一个实体
   - 1:N — 一个实体对应多个实体（外键在N端）
   - M:N — 多对多关系（需要中间表）

3. 关系映射规则
   | 关系类型 | 实现方式 | 示例 |
   |----------|----------|------|
   | 1:1 | 主键关联或唯一外键 | 用户 ↔ 用户详情 |
   | 1:N | N端添加外键 | 用户 → 订单 |
   | M:N | 中间表 + 双外键 | 学生 ↔ 课程 |
```

### 2. 表结构设计

```
设计原则:

字段类型选择:
| 数据特征 | 推荐类型 | 说明 |
|----------|----------|------|
| 主键 | BIGINT / UUID | 自增ID或UUID |
| 布尔 | BOOLEAN / TINYINT(1) | 避免用 CHAR(1) |
| 短文本 | VARCHAR(n) | 明确长度上限 |
| 长文本 | TEXT | 无长度限制 |
| 精确小数 | DECIMAL(m,n) | 金额不用 FLOAT |
| 时间 | TIMESTAMP / DATETIME | 注意时区 |
| JSON | JSON / JSONB | 灵活结构数据 |
| 枚举 | ENUM / TINYINT | 考虑可扩展性 |

约束设计:
| 约束类型 | 使用场景 | 注意事项 |
|----------|----------|----------|
| NOT NULL | 业务必填字段 | 避免过度使用 NULL |
| UNIQUE | 唯一性约束（邮箱、手机号） | 考虑软删除场景 |
| DEFAULT | 默认值 | 状态字段默认值 |
| CHECK | 值域约束 | 金额 > 0 |
| FOREIGN KEY | 关联完整性 | 评估性能影响 |

审计字段（每表必备）:
- `id` — 主键
- `created_at` — 创建时间
- `updated_at` — 更新时间
- `created_by` — 创建人（可选）
- `updated_by` — 更新人（可选）
- `deleted_at` — 软删除时间（可选）
```

### 3. 索引策略

```
索引设计矩阵:

| 索引类型 | 适用场景 | 示例 |
|----------|----------|------|
| 主键索引 | 每表必备 | id |
| 唯一索引 | 唯一性约束 | email, phone |
| 联合索引 | 多条件查询 | (status, created_at) |
| 覆盖索引 | 查询只涉及索引列 | (user_id, status) 包含查询列 |
| 前缀索引 | 长文本模糊匹配 | VARCHAR(255) 前20字符 |
| 全文索引 | 全文搜索 | 标题、内容 |

索引设计原则:
1. 联合索引遵循最左前缀原则
2. 高选择性列放前面
3. 避免在低选择性列上建索引（如性别）
4. 覆盖索引减少回表
5. 单表索引数量建议 ≤ 5 个
6. 定期审查冗余索引

索引命名规范:
| 索引类型 | 命名格式 | 示例 |
|----------|----------|------|
| 主键 | pk_{table} | pk_users |
| 唯一 | uk_{table}_{columns} | uk_users_email |
| 普通 | idx_{table}_{columns} | idx_orders_status_created |
```

### 4. 分区/分表方案

```
大数据量评估:

单表行数预估:
| 行数量级 | 建议 |
|----------|------|
| < 100 万 | 不需要分区 |
| 100万 - 1000万 | 考虑索引优化 |
| 1000万 - 1亿 | 考虑分区 |
| > 1亿 | 考虑分表/分库 |

分区策略:
| 策略 | 适用场景 | 示例 |
|------|----------|------|
| 范围分区 | 时间序列数据 | 按月/季度分区 |
| 哈希分区 | 均匀分布 | 按用户ID哈希 |
| 列表分区 | 枚举值分布 | 按地区分区 |

冷热分离:
- 热数据：最近3个月 → 高性能存储
- 温数据：3-12个月 → 标准存储
- 冷数据：> 12个月 → 归档存储
```

### 5. 范式与反范式权衡

```
权衡决策:

| 场景 | 建议 | 原因 |
|------|------|------|
| OLTP 核心业务 | 3NF | 保证数据一致性 |
| 高频读查询 | 适度反范式 | 减少 JOIN 提升性能 |
| 报表/统计 | 反范式 | 宽表提升查询效率 |
| 日志/流水 | 不强制范式 | 写入性能优先 |

反范式常见手法:
- 冗余字段（如订单冗余商品名称）
- 汇总字段（如用户订单数）
- 预计算字段（如月度统计）
```

### 6. 性能预估

```
评估维度:

| 维度 | 评估方法 | 阈值 |
|------|----------|------|
| 数据量 | 日增量 × 保留周期 | 单表 > 1000万需规划 |
| QPS | 峰值读写比 × 用户数 | 读 > 5000/s 考虑缓存 |
| 存储空间 | 行大小 × 行数 × 冗余系数 | 预留 50% 空间 |
| 查询延迟 | EXPLAIN 分析 | P99 < 200ms |

行大小估算:
INT(4B) + BIGINT(8B) + VARCHAR(255)(~255B) + TIMESTAMP(4B) × N个字段
```

### 7. 命名规范

```
命名规范:

| 对象 | 规范 | 示例 |
|------|------|------|
| 表名 | 小写下划线，复数 | users, order_items |
| 字段名 | 小写下划线 | user_name, created_at |
| 主键 | id | id |
| 外键 | {关联表}_id | user_id |
| 布尔字段 | is_{description} | is_active, is_deleted |
| 时间字段 | {action}_at | created_at, updated_at |
| 索引 | idx_{table}_{columns} | idx_users_email |
| 唯一索引 | uk_{table}_{columns} | uk_users_phone |
```

## 输出格式

```markdown
# 数据库设计：{功能名称}

**关联需求**: requirement-{feature}.md
**设计日期**: 2026-04-18

## ER 模型

### 实体关系图
(描述实体间关系)

| 实体A | 关系 | 实体B | 实现方式 |
|-------|------|-------|----------|
| User | 1:N | Order | orders.user_id 外键 |
| Order | M:N | Product | order_items 中间表 |

## 表结构设计

### {table_name}

| 字段 | 类型 | 约束 | 默认值 | 说明 |
|------|------|------|--------|------|
| id | BIGINT | PK, AUTO_INCREMENT | - | 主键 |
| ... | ... | ... | ... | ... |
| created_at | TIMESTAMP | NOT NULL | CURRENT_TIMESTAMP | 创建时间 |
| updated_at | TIMESTAMP | NOT NULL | CURRENT_TIMESTAMP ON UPDATE | 更新时间 |

**索引设计**:
| 索引名 | 类型 | 字段 | 说明 |
|--------|------|------|------|
| pk_{table} | PRIMARY | id | 主键 |
| uk_{table}_{col} | UNIQUE | {col} | 唯一约束 |
| idx_{table}_{cols} | NORMAL | {cols} | 查询优化 |

**分区方案**: 无 / 按月范围分区
**预估数据量**: 日增 {N} 行，年增 {M} 行
**预估 QPS**: 读 {R}/s，写 {W}/s

## 契约对齐检查

| 契约字段 | 表字段 | 对齐状态 |
|----------|--------|----------|
| id | id | ✅ 一致 |
| status | status | ✅ 一致 |
| ... | ... | ... |

## 设计决策记录

| 决策 | 选择 | 原因 |
|------|------|------|
| 使用软删除 | 是 | 业务需要恢复能力 |
| 金额字段类型 | DECIMAL(10,2) | 精确计算 |
```

## 工具可用
- read: 读取需求文档和契约文档
- write: 写入数据库设计文档
- grep: 搜索现有数据库 schema 和 Model 定义
- glob: 扫描现有迁移文件和模型文件

## 配合 Skills

| 配合技能 | 关系 | 说明 |
|----------|------|------|
| `devops/data/schema-review` | 后续 | 设计完成后进行评审 |
| `devops/data/migration` | 后续 | 评审通过后生成迁移脚本 |
| `devops/data/change-impact` | 后续 | 变更时评估影响 |
| `dev/modules/module-collaborative-dev` | 协同 | 设计产出更新契约的数据模型部分 |
| `dev/implementation/backend` | 下游 | 后端按设计实现 Model |
| `product/requirement/product-requirement-analysis` | 前置 | 需求驱动设计 |

## 下一步推荐

| 条件 | 推荐技能 |
|------|----------|
| 设计完成 | `devops/data/schema-review` |
| 设计完成且有变更 | `devops/data/change-impact` |

## 触发词
数据库设计、表结构设计、schema设计、ER图、数据建模、建表、索引设计、数据库方案、表结构规划
