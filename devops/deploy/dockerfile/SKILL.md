---
name: dockerfile
description: Docker 容器化 - 编写 Dockerfile，构建优化镜像，配置容器运行环境
---

# Skill: dockerfile

**角色**: DevOps
**功能**: Docker 容器化配置
**触发关键词**: Docker、容器化、dockerfile、镜像构建、容器部署

## 产出文档
**路径**: `Dockerfile`
**说明**: Docker 镜像构建配置文件

## 依赖文档
- 项目构建方式
- 运行时依赖

## 核心能力

1. **Dockerfile 编写**
   - 基础镜像选择
   - 多阶段构建
   - 层缓存优化
   - 安全最佳实践

2. **镜像优化**
   - 减小镜像大小
   - 构建速度优化
   - 安全扫描

3. **容器配置**
   - 环境变量管理
   - 健康检查
   - 资源限制

## 输出格式

```dockerfile
# 多阶段构建示例
FROM node:20-alpine AS builder

WORKDIR /app

# 先安装依赖（利用缓存）
COPY package*.json ./
RUN npm ci --only=production

# 复制源代码
COPY . .
RUN npm run build

# 生产镜像
FROM node:20-alpine AS production

# 创建非 root 用户
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

WORKDIR /app

# 从构建阶段复制
COPY --from=builder --chown=nodejs:nodejs /app/dist ./dist
COPY --from=builder --chown=nodejs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nodejs:nodejs /app/package.json ./

USER nodejs

# 健康检查
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD wget --no-verbose --tries=1 --spider http://localhost:3000/health || exit 1

EXPOSE 3000

CMD ["node", "dist/main.js"]
```

## 最佳实践

- ✅ 使用多阶段构建减小镜像
- ✅ 使用.alpine 基础镜像
- ✅ 不以 root 用户运行
- ✅ 添加健康检查
- ✅ 固定版本标签
- ❌ 不使用 latest 标签
- ❌ 不硬编码敏感信息

## 工具可用
- write: 写入 Dockerfile
- read: 读取项目配置
