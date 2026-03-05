---
name: devops-ci-cd-pipeline
description: (opencode - Skill) CI/CD流水线 - GitHub Actions/质量门禁/自动部署/回滚策略
subtask: true
argument-hint: "<CI/CD> 或 <流水线配置>"
---

# CI/CD 流水线 Skill

## 角色

你是 DevOps 工程师，负责为企业级项目设计完整的 CI/CD 流水线，包括代码检查、测试、质量门禁、自动部署。

## GitHub Actions 流水线

### 1. 主工作流

```yaml
# .github/workflows/ci-cd.yml
name: CI/CD Pipeline

on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]
  workflow_dispatch:

env:
  NODE_VERSION: '18'
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

jobs:
  # ============================================
  # 阶段1: 代码检查
  # ============================================
  lint:
    name: Code Linting
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
          
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'
          
      - name: Install dependencies
        run: npm ci
        
      - name: Check code format
        run: npm run format:check
        
      - name: Run ESLint
        run: npm run lint
        
      - name: Run TypeScript type check
        run: npm run type-check

  # ============================================
  # 阶段2: 单元测试
  # ============================================
  test-unit:
    name: Unit Tests
    runs-on: ubuntu-latest
    needs: lint
    steps:
      - uses: actions/checkout@v4
        
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'
          
      - name: Install dependencies
        run: npm ci
        
      - name: Run unit tests
        run: npm run test:coverage
        
      - name: Upload coverage
        uses: codecov/codecov-action@v3
        with:
          files: ./coverage/lcov.info
          fail_ci_if_error: true
          threshold: 80%
          
      - name: Check test coverage
        run: |
          COVERAGE=$(cat coverage/coverage-summary.json | jq -r '.total.lines.pct')
          if (( $(echo "$COVERAGE < 80" | bc -l) )); then
            echo "Coverage $COVERAGE% is below 80%"
            exit 1
          fi

  # ============================================
  # 阶段3: 构建
  # ============================================
  build:
    name: Build
    runs-on: ubuntu-latest
    needs: [lint, test-unit]
    steps:
      - uses: actions/checkout@v4
        
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'
          
      - name: Install dependencies
        run: npm ci
        
      - name: Build application
        run: npm run build
        
      - name: Upload build artifacts
        uses: actions/upload-artifact@v3
        with:
          name: build-output
          path: dist/
          retention-days: 7

  # ============================================
  # 阶段4: E2E 测试
  # ============================================
  test-e2e:
    name: E2E Tests
    runs-on: ubuntu-latest
    needs: build
    steps:
      - uses: actions/checkout@v4
        
      - name: Setup Node.js
        uses: actions/setup-node@v4
        with:
          node-version: ${{ env.NODE_VERSION }}
          cache: 'npm'
          
      - name: Download build artifacts
        uses: actions/download-artifact@v3
        with:
          name: build-output
          path: dist/
          
      - name: Install Playwright
        run: npx playwright install --with-deps
        
      - name: Start server
        run: npm run start &
        shell: bash
        env:
          CI: true
          
      - name: Wait for server
        run: sleep 10 && curl -f http://localhost:3000 || exit 1
        
      - name: Run E2E tests
        run: npm run test:e2e
        
      - name: Upload test results
        if: always()
        uses: actions/upload-artifact@v3
        with:
          name: e2e-results
          path: test-results/

  # ============================================
  # 阶段5: 安全扫描
  # ============================================
  security:
    name: Security Scan
    runs-on: ubuntu-latest
    needs: build
    steps:
      - uses: actions/checkout@v4
        
      - name: Run Trivy vulnerability scanner
        uses: aquasecurity/trivy-action@master
        with:
          scan-type: 'fs'
          scan-ref: '.'
          format: 'sarif'
          output: 'trivy-results.sarif'
          
      - name: Upload Trivy results
        uses: github/codeql-action/upload-sarif@v2
        with:
          sarif_file: 'trivy-results.sarif'
          
      - name: Run npm audit
        run: npm audit --audit-level=high
        continue-on-error: true

  # ============================================
  # 阶段6: 镜像构建 (可选)
  # ============================================
  build-image:
    name: Build Docker Image
    runs-on: ubuntu-latest
    needs: [build, test-e2e, security]
    if: github.event_name == 'push'
    outputs:
      image-tag: ${{ steps.meta.outputs.tags }}
    steps:
      - uses: actions/checkout@v4
        
      - name: Download build artifacts
        uses: actions/download-artifact@v3
        with:
          name: build-output
          path: dist/
          
      - name: Set up Docker Buildx
        uses: docker/setup-buildx-action@v3
        
      - name: Login to Container Registry
        uses: docker/login-action@v3
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}
          
      - name: Extract metadata
        id: meta
        uses: docker/metadata-action@v5
        with:
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}
          tags: |
            type=ref,event=branch
            type=sha,prefix=
            type=raw,value=latest,enable={{is_default_branch}}
            
      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          context: .
          push: ${{ github.event_name != 'pull_request' }}
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
          cache-from: type=gha
          cache-to: type=gha,mode=max

  # ============================================
  # 阶段7: 部署 (手动触发)
  # ============================================
  deploy:
    name: Deploy
    runs-on: ubuntu-latest
    needs: [build-image]
    if: github.event_name == 'workflow_dispatch'
    environment:
      name: production
      url: https://your-app.com
    steps:
      - name: Deploy to production
        run: |
          echo "Deploying image ${{ needs.build-image.outputs.image-tag }}"
          # 部署脚本
```

### 2. 分支保护规则

```yaml
# .github/branch-protection.yml
branch_protection:
  main:
    required_status_checks:
      - lint
      - test-unit
      - build
      - test-e2e
      - security
    required_reviews: 2
    dismiss_stale_reviews: true
    require_code_owner_reviews: true
    required_linear_history: true
    allow_force_pushes: false
    allow_deletions: false
```

## 质量门禁

### 1. 质量门禁配置

```yaml
# quality-gates.yml
quality_gates:
  # 代码覆盖率
  coverage:
    min_line: 80
    min_branch: 75
    min_function: 80
    
  # 代码质量
  code_quality:
    critical_issues: 0
    major_issues: 10
    blocker_issues: 0
    
  # 安全
  security:
    vulnerabilities_critical: 0
    vulnerabilities_high: 0
    
  # 测试
  tests:
    min_pass_rate: 95
    max_skipped: 10
```

### 2. 检查脚本

```bash
#!/bin/bash
# scripts/quality-gate.sh

set -e

echo "=== Running Quality Gates ==="

# 1. 检查测试覆盖率
COVERAGE=$(cat coverage/coverage-summary.json | jq -r '.total.lines.pct')
echo "Coverage: $COVERAGE%"
if (( $(echo "$COVERAGE < 80" | bc -l) )); then
  echo "❌ Coverage below 80%"
  exit 1
fi

# 2. 检查 ESLint
npm run lint --if-present
if [ $? -ne 0 ]; then
  echo "❌ ESLint failed"
  exit 1
fi

# 3. 检查安全漏洞
npm audit --audit-level=high
if [ $? -ne 0 ]; then
  echo "❌ Security vulnerabilities found"
  exit 1
fi

echo "✅ All quality gates passed"
```

## 部署策略

### 1. Blue-Green 部署

```yaml
# .github/workflows/deploy-blue-green.yml
name: Blue-Green Deployment

on:
  workflow_dispatch:
    inputs:
      environment:
        description: 'Environment'
        required: true
        default: 'staging'

jobs:
  deploy:
    runs-on: ubuntu-latest
    environment: ${{ github.event.inputs.environment }}
    steps:
      - name: Deploy to Blue
        run: |
          # 部署到 Blue 环境
          kubectl set image deployment/app app=${{ secrets.IMAGE }} -n blue
          
      - name: Verify Blue
        run: |
          curl -f https://blue.${{ secrets.DOMAIN }}/health || exit 1
          
      - name: Switch traffic to Blue
        run: |
          kubectl patch service app -p '{"spec":{"selector":{"version":"blue"}}}' -n production
          
      - name: Monitor for errors
        run: sleep 60
          
      - name: Rollback if needed
        if: failure()
        run: |
          kubectl patch service app -p '{"spec":{"selector":{"version":"green"}}}' -n production
          echo "Rolled back to Green"
```

### 2. Canary 部署

```yaml
# canary-deployment.yml
apiVersion: argoproj.io/v1alpha1
kind: Rollout
metadata:
  name: app-rollout
spec:
  replicas: 10
  strategy:
    canary:
      steps:
        - setWeight: 10
        - pause: {duration: 10m}
        - setWeight: 30
        - pause: {duration: 10m}
        - setWeight: 50
        - pause: {duration: 10m}
        - setWeight: 100
      canaryService: app-canary
      stableService: app-stable
      trafficRouting:
        istio:
          virtualService:
            name: app-vsvc
            routes:
              - primary
```

### 3. 回滚脚本

```bash
#!/bin/bash
# scripts/rollback.sh

set -e

VERSION=${1:-previous}
ENV=${2:-production}

echo "=== Rolling back to $VERSION in $ENV ==="

# Docker 镜像回滚
if [ "$VERSION" = "previous" ]; then
  PREVIOUS_IMAGE=$(git describe --tags --abbrev=0 HEAD^)
else
  PREVIOUS_IMAGE=$VERSION
fi

echo "Rolling back to: $PREVIOUS_IMAGE"

# Kubernetes 回滚
kubectl set image deployment/app app=$PREVIOUS_IMAGE -n $ENV

# 等待部署完成
kubectl rollout status deployment/app -n $ENV

# 验证
curl -f https://app.$ENV/health || {
  echo "Health check failed, reverting..."
  kubectl rollout undo deployment/app -n $ENV
  exit 1
}

echo "Rollback completed successfully"
```

## 环境管理

### 1. 环境配置矩阵

```yaml
# environments.yml
environments:
  development:
    url: https://dev.example.com
    replicas: 1
    resources:
      memory: 512Mi
      cpu: 250m
    autoscaling:
      enabled: false
    
  staging:
    url: https://staging.example.com
    replicas: 2
    resources:
      memory: 1Gi
      cpu: 500m
    autoscaling:
      enabled: true
      minReplicas: 2
      maxReplicas: 10
      targetCPUUtilization: 70
      
  production:
    url: https://example.com
    replicas: 4
    resources:
      memory: 2Gi
      cpu: 1000m
    autoscaling:
      enabled: true
      minReplicas: 4
      maxReplicas: 20
      targetCPUUtilization: 70
```

### 2. 环境变量管理

```yaml
# .github/workflows/env-config.yml
- name: Configure environment variables
  run: |
    echo "APP_ENV=${{ github.event.inputs.environment }}" >> $GITHUB_ENV
    echo "LOG_LEVEL=${{ secrets.LOG_LEVEL }}" >> $GITHUB_ENV
    echo "DATABASE_URL=${{ secrets.DATABASE_URL }}" >> $GITHUB_ENV
```

## 输出格式

```markdown
## CI/CD 流水线配置

### 📋 工作流阶段

| 阶段 | 作业 | 质量门禁 |
|------|------|----------|
| 1 | Lint | ESLint/Prettier/TypeScript |
| 2 | Unit Tests | 覆盖率 ≥ 80% |
| 3 | Build | 构建成功 |
| 4 | E2E Tests | 测试通过率 ≥ 95% |
| 5 | Security | 无高危漏洞 |
| 6 | Build Image | 镜像构建成功 |
| 7 | Deploy | 部署成功 |

### 🔧 关键命令

```bash
# 触发流水线
git push origin main

# 手动部署
gh workflow run deploy.yml -f environment=production

# 回滚
./scripts/rollback.sh v1.2.3 production
```

### ✅ 质量门禁

- [x] ESLint 检查通过
- [x] TypeScript 编译无错误
- [x] 单元测试覆盖率 ≥ 80%
- [x] E2E 测试通过
- [x] 安全扫描无高危漏洞
- [x] 镜像构建成功
- [x] 部署验证通过
```

## 触发词

CI/CD、流水线、GitHub Actions、持续集成、持续部署、质量门禁、Blue-Green部署、Canary部署、自动回滚、环境配置