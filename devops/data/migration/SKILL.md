---
name: data-migration
description: 数据库迁移 - 管理数据库 schema 变更，编写迁移脚本，确保数据一致性
---

# Skill: data-migration

**角色**: DevOps / 后端开发
**功能**: 数据库迁移管理
**触发关键词**: 数据库迁移、数据变更、DDL、迁移脚本、schema 变更、回滚方案

## 产出文档
- **迁移脚本**: `migrations/` 目录下的迁移文件
- **迁移文档（可选持久化）**: `.opencode/docs/devops-migration-{feature}.md`

## 依赖文档
- 当前数据库 schema
- 目标 schema 设计

## 核心能力

1. **迁移脚本编写**
   - DDL 变更（表结构修改）
   - DML 变更（数据迁移）
   - 索引管理
   - 数据验证

2. **回滚方案**
   - 向下迁移脚本
   - 数据备份策略
   - 快速回滚流程

3. **发布流程**
   - 预演测试
   - 灰度发布
   - 监控告警

## 输出格式

```sql
-- migrations/20240115_add_user_avatar.sql
-- 向上迁移
BEGIN;

-- 添加新列
ALTER TABLE users 
  ADD COLUMN avatar_url VARCHAR(512) DEFAULT NULL,
  ADD COLUMN avatar_updated_at TIMESTAMP DEFAULT NULL;

-- 添加索引
CREATE INDEX idx_users_avatar_updated ON users(avatar_updated_at);

-- 数据迁移（如有需要）
-- UPDATE users SET avatar_url = CONCAT('https://default.com/', id) WHERE avatar_url IS NULL;

COMMIT;

-- 向下迁移（回滚）
BEGIN;

DROP INDEX IF EXISTS idx_users_avatar_updated;

ALTER TABLE users 
  DROP COLUMN avatar_updated_at,
  DROP COLUMN avatar_url;

COMMIT;
```

```yaml
# 迁移配置 (migrations/config.yml)
database:
  host: ${DB_HOST}
  port: ${DB_PORT}
  name: ${DB_NAME}
  user: ${DB_USER}

migration:
  table: _migrations
  lock_timeout: 30s
  statement_timeout: 300s

backup:
  enabled: true
  before_migration: true
  retention_days: 7
```

## 迁移检查清单

### 迁移前
- [ ] 在测试环境验证迁移脚本
- [ ] 评估迁移影响范围和数据量
- [ ] 准备回滚方案
- [ ] 通知相关人员
- [ ] 备份数据库

### 迁移中
- [ ] 执行迁移脚本
- [ ] 验证迁移结果
- [ ] 监控错误日志
- [ ] 验证应用功能

### 迁移后
- [ ] 清理临时数据
- [ ] 更新文档
- [ ] 归档迁移记录

## 最佳实践

```sql
-- ✅ 使用事务确保原子性
BEGIN;
ALTER TABLE ...;
UPDATE ...;
COMMIT;

-- ✅ 大表操作分批进行
-- 分批更新 100 万行数据
DO $$
DECLARE
  batch_size INT := 10000;
  updated INT;
BEGIN
  LOOP
    UPDATE users 
    SET new_column = 'default'
    WHERE id IN (
      SELECT id FROM users 
      WHERE new_column IS NULL 
      LIMIT batch_size
    );
    GET DIAGNOSTICS updated = ROW_COUNT;
    EXIT WHEN updated < batch_size;
  END LOOP;
END $$;

-- ✅ 添加 IF NOT EXISTS 避免重复执行
ALTER TABLE users ADD COLUMN IF NOT EXISTS ...;

-- ❌ 避免锁表操作
-- ALTER TABLE large_table ADD COLUMN ... DEFAULT 'value';
-- 应该：先加列不加默认值，再更新数据
```

## 工具可用
- write: 写入迁移脚本
- read: 读取现有 schema
