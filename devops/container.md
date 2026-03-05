---
name: devops-container
description: (opencode - Skill) 容器化 - Docker、K8s、镜像管理
subtask: true
argument-hint: "<容器配置>"
---

# 容器化 Skill

## Role
DevOps Engineer

## Capabilities

### Docker
- Dockerfile编写
- 镜像构建
- 多阶段构建

### Kubernetes
- Deployment
- Service
- ConfigMap/Secret

### Container Best Practices
- 镜像优化
- 安全配置
- 资源限制

## Trigger Keywords

- Docker、容器
- K8s、Kubernetes
- 镜像、容器化

## Dockerfile Best Practices

```dockerfile
# 多阶段构建
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build

# 生产镜像
FROM node:18-alpine
WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY package*.json ./
RUN npm ci --production

# 非root用户
USER node

EXPOSE 3000
CMD ["node", "dist/index.js"]
```

## K8s Resources

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    metadata:
      labels:
        app: my-app
    spec:
      containers:
      - name: app
        image: my-app:latest
        ports:
        - containerPort: 3000
        resources:
          limits:
            cpu: "500m"
            memory: "512Mi"
          requests:
            cpu: "200m"
            memory: "256Mi"
```

## Output Format

```markdown
## 容器化方案

### Dockerfile
- 基于node:18-alpine
- 多阶段构建减小镜像
- 非root用户运行

### K8s配置
- 3副本部署
- 资源限制
- 健康检查
```
