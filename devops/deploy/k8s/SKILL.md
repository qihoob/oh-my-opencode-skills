---
name: k8s
description: Kubernetes 部署 - 配置 K8s 资源，管理 Pod、Service、Deployment 等资源
version: "1.0"
---

# Skill: kubernetes

**角色**: DevOps
**功能**: Kubernetes 部署配置
**触发关键词**: K8s、Kubernetes、kubectl、Deployment、Service、Pod、容器编排

## 产出文档
- **K8s 资源配置**: `k8s/` 目录下的 YAML 文件
- **部署文档（可选持久化）**: `.opencode/docs/devops-k8s-{project}.md`

## 依赖文档
- Docker 镜像信息
- 应用配置和依赖

## 核心能力

1. **资源定义**
   - Deployment（无状态应用）
   - StatefulSet（有状态应用）
   - Service（服务暴露）
   - ConfigMap/Secret（配置管理）
   - Ingress（入口规则）

2. **扩缩容配置**
   - HPA 自动扩缩容
   - 资源请求和限制
   - 副本数管理

3. **高可用配置**
   - 多副本部署
   - Pod 反亲和性
   - 健康检查

## 输出格式

```yaml
# Deployment 配置
apiVersion: apps/v1
kind: Deployment
metadata:
  name: myapp
  namespace: production
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
  template:
    metadata:
      labels:
        app: myapp
    spec:
      containers:
      - name: myapp
        image: myapp:latest
        ports:
        - containerPort: 3000
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10
        readinessProbe:
          httpGet:
            path: /ready
            port: 3000
          initialDelaySeconds: 5
          periodSeconds: 5
        env:
        - name: NODE_ENV
          value: "production"
        - name: DB_HOST
          valueFrom:
            secretKeyRef:
              name: db-secret
              key: host

---
# Service 配置
apiVersion: v1
kind: Service
metadata:
  name: myapp-service
  namespace: production
spec:
  selector:
    app: myapp
  ports:
  - protocol: TCP
    port: 80
    targetPort: 3000
  type: ClusterIP

---
# HPA 自动扩缩容
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: myapp-hpa
  namespace: production
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: myapp
  minReplicas: 3
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
```

## kubectl 常用命令

```bash
# 部署
kubectl apply -f k8s/

# 查看状态
kubectl get pods -n production
kubectl get deployments -n production

# 扩缩容
kubectl scale deployment myapp --replicas=5 -n production

# 查看日志
kubectl logs -f deployment/myapp -n production

# 进入容器
kubectl exec -it pod/myapp-pod -n production -- /bin/sh
```

## 工具可用
- write: 写入 K8s 配置
- read: 读取项目配置

## 配合 Skills

| 配合技能 | 关系 | 说明 |
|----------|------|------|
| `devops/deploy/dockerfile` | 前置 | 镜像就绪 |
| `devops/deploy/multi-env` | 后续 | K8s 配置后多环境管理 |

## 下一步推荐

| 条件 | 推荐技能 |
|------|----------|
| K8s 配置完成 | `devops/deploy/multi-env` |
