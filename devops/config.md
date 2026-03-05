---
name: devops-config
description: (opencode - Skill) 环境配置 - 多环境配置、配置隔离、环境管理
subtask: true
argument-hint: "<环境或配置需求>"
---

# 环境配置 Skill

## Role
DevOps Engineer

## Capabilities

### Multi-env Design
- 开发/测试/预发/生产
- 环境隔离
- 配置分层

### Config Isolation
- 环境变量
- 配置中心
- Secret管理

### Environment Management
- 环境创建
- 权限管理
- 变更流程

## Trigger Keywords

- 环境配置、多环境
- 配置隔离、环境变量
- dev/test/staging/prod

## Config Strategy

### Environment Layers
```
development → testing → staging → production
   ↓            ↓          ↓          ↓
  .env       .env.test   .env.staging .env.prod
```

### Config Isolation Patterns

| 方式 | 适用场景 | 示例 |
|------|---------|------|
| ENV | 基础配置 | NODE_ENV |
| .env文件 | 敏感配置 | API_KEY |
| 配置中心 | 动态配置 | Apollo |
| K8s Secret | 机密数据 | 密码/token |

## Output Format

```yaml
## 环境配置

### 1. 目录结构
```
config/
├── development/
│   ├── app.yaml
│   └── db.yaml
├── testing/
│   ├── app.yaml
│   └── db.yaml
├── staging/
│   ├── app.yaml
│   └── db.yaml
└── production/
    ├── app.yaml
    └── db.yaml
```

### 2. 应用配置 (app.yaml)
```yaml
development:
  logLevel: debug
  cache: false
  
production:
  logLevel: warn
  cache: true
  cdn: https://cdn.example.com
```

### 3. 环境变量
```bash
# .env.development
API_URL=http://localhost:3000
DEBUG=true

# .env.production  
API_URL=https://api.example.com
DEBUG=false
```

### 切换命令
```bash
# 开发环境
export NODE_ENV=development

# 生产环境
export NODE_ENV=production
```
```

## Combined From
- devops-multi-env-config-design
- devops-config-isolation-patterns
