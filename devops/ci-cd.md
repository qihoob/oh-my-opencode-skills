---
name: devops-cicd
description: (opencode - Skill) CI/CD流水线 - 持续集成、持续部署、质量门禁
subtask: true
argument-hint: "<项目或流水线配置>"
---

# CI/CD流水线 Skill

## Role
DevOps Engineer

## Capabilities

### CI Pipeline
- 代码检查
- 单元测试
- 构建打包

### CD Pipeline
- 部署到环境
- 集成测试
- 灰度发布

### Quality Gates
- 覆盖率检查
- 安全扫描
- 性能基准

## Trigger Keywords

- CI/CD、流水线
- 持续集成、持续部署
- GitHub Actions

## Pipeline Stages

```
Code → Build → Test → Deploy → Verify → Release
```

## Output Format

```yaml
## GitHub Actions 示例

name: CI/CD Pipeline

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      
      - name: Install dependencies
        run: npm ci
        
      - name: Lint
        run: npm run lint
        
      - name: Test
        run: npm run test -- --coverage
        
      - name: Build
        run: npm run build
        
      - name: Deploy to Staging
        if: github.ref == 'refs/heads/main'
        run: ./deploy.sh staging
```

## Quality Gates

| Gate | Tool | Threshold |
|------|------|-----------|
| Lint | ESLint | 0 errors |
| Test | Jest | >80% |
| Security | Snyk | 0 vulnerabilities |
| Build | - | Success |
```
