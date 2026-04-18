---
name: multi-env
description: 多环境管理 - 配置开发、测试、预发、生产等多套环境，管理环境差异
---

# Skill: multi-env

**角色**: DevOps
**功能**: 多环境配置管理
**触发关键词**: 多环境、环境配置、dev/staging/prod、环境隔离、配置管理

## 产出文档
**路径**: `config/` 或 `k8s/` 目录下的环境配置文件
**说明**: 各环境差异化配置

## 依赖文档
- 项目配置结构
- 部署架构

## 核心能力

1. **环境划分**
   - development（开发环境）
   - testing（测试环境）
   - staging（预发环境）
   - production（生产环境）

2. **配置管理**
   - 环境变量差异
   - 数据库连接差异
   - 第三方服务配置差异
   - Feature Flag 管理

3. **发布流程**
   - 环境晋升流程
   - 配置审批流程
   - 回滚机制

## 输出格式

```yaml
# 环境配置示例 (config/environments.yml)
development:
  name: development
  debug: true
  database:
    host: localhost
    port: 5432
    name: myapp_dev
  cache:
    enabled: false
  features:
    new_dashboard: true
    dark_mode: true

testing:
  name: testing
  debug: true
  database:
    host: test-db.internal
    port: 5432
    name: myapp_test
  cache:
    enabled: false
  features:
    new_dashboard: true
    dark_mode: true

staging:
  name: staging
  debug: false
  database:
    host: staging-db.internal
    port: 5432
    name: myapp_staging
  cache:
    enabled: true
    ttl: 3600
  features:
    new_dashboard: true
    dark_mode: false

production:
  name: production
  debug: false
  database:
    host: prod-db.internal
    port: 5432
    name: myapp_prod
  cache:
    enabled: true
    ttl: 7200
  features:
    new_dashboard: false  # 灰度发布用
    dark_mode: false
```

```yaml
# Kubernetes 多环境命名空间
apiVersion: v1
kind: Namespace
metadata:
  name: development
---
apiVersion: v1
kind: Namespace
metadata:
  name: testing
---
apiVersion: v1
kind: Namespace
metadata:
  name: staging
---
apiVersion: v1
kind: Namespace
metadata:
  name: production
```

## 环境变量管理

```bash
# .env.development
NODE_ENV=development
DATABASE_URL=postgresql://localhost:5432/myapp_dev
DEBUG=true

# .env.production
NODE_ENV=production
DATABASE_URL=postgresql://prod-db:5432/myapp_prod
DEBUG=false
API_KEY=${PRODUCTION_API_KEY}
```

## 发布流程

```
开发完成 → dev 环境验证 → 提测 → testing 环境验证 
  → 预发布 → staging 环境验证 → 审批 → 生产发布
```

## 工具可用
- write: 写入环境配置
- read: 读取项目配置
