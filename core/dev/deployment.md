---
name: core/dev-deployment
description: (opencode - Skill) 部署上线 - 容器化部署、监控日志、稳定性保障
subtask: true
argument-hint: "<部署目标环境>"
---

# 部署上线 Skill

## Role
DevOps Engineer

## Capabilities

### Container Deployment
- Dockerfile编写
- K8s配置
- 镜像构建

### Monitoring & Logging
- 日志收集
- 监控告警
- 性能指标

### Stability
- 滚动更新
- 蓝绿部署
- 回滚策略

## Trigger Keywords

- 部署、上线、发布、deploy
- 监控、日志、稳定性
- K8s、Docker

## Deployment Workflow

```
1. 构建镜像
2. 推送镜像仓库
3. 更新部署配置
4. 滚动发布
5. 验证服务
6. 监控观察
```

## Output Format

```yaml
## K8s Deployment

apiVersion: apps/v1
kind: Deployment
metadata:
  name: my-app
spec:
  replicas: 3
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 0
  template:
    spec:
      containers:
      - name: app
        image: my-app:latest
        ports:
        - containerPort: 8080
        resources:
          limits:
            cpu: 500m
            memory: 512Mi
```

## Monitoring Checklist

- [ ] CPU/内存使用率
- [ ] 请求延迟P99
- [ ] 错误率
- [ ] 吞吐量
- [ ] 磁盘使用

## Combined From
- devops-k8s-deployment
- stability-logging-implementation
