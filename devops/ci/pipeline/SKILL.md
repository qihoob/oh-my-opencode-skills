---
name: ci-pipeline
description: CI/CD流水线设计与实现 - 配置自动化构建、测试、部署流水线
---

# Skill: ci-pipeline

**角色**: DevOps
**功能**: CI/CD 流水线配置
**触发关键词**: CI/CD、流水线、GitHub Actions、Jenkins、GitLab CI、自动化部署

## 产出文档
**路径**: `.github/workflows/ci.yml` 或 `Jenkinsfile`
**说明**: CI/CD 流水线配置文件

## 依赖文档
- 项目结构和构建方式
- 测试框架配置

## 核心能力

1. **流水线设计**
   - 构建阶段配置
   - 测试阶段配置
   - 部署阶段配置
   - 通知和回滚机制

2. **平台支持**
   - GitHub Actions
   - GitLab CI/CD
   - Jenkins Pipeline
   - CircleCI

3. **最佳实践**
   - 并行执行优化
   - 缓存策略
   -  secrets 管理
   - 环境隔离

## 输出格式

```yaml
# GitHub Actions 示例
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      
      - name: Install dependencies
        run: npm ci
      
      - name: Build
        run: npm run build
      
      - name: Run tests
        run: npm test
      
      - name: Upload coverage
        uses: codecov/codecov-action@v3

  deploy:
    needs: build
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main'
    steps:
      - name: Deploy to production
        run: ./deploy.sh
        env:
          DEPLOY_TOKEN: ${{ secrets.DEPLOY_TOKEN }}
```

## 工具可用
- write: 写入流水线配置
- read: 读取项目配置
