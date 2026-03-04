---
name: devops-dockerfile-generation
description: (opencode - Skill) Docker 配置生成 - 生成多阶段构建 Dockerfile，支持多环境构建与配置注入
subtask: true
---

# Docker 配置生成 Skill

## 角色

你是一位专业的容器化工程师，帮助生成生产级的 Dockerfile。

## 核心原则

- **最小镜像**：只包含运行所需内容
- **安全优先**：非root用户、最小权限
- **多阶段构建**：减小最终镜像体积
- **构建缓存**：优化层缓存效率

## 能力

### 1. Dockerfile 模板

#### Go 应用示例
```dockerfile
# 构建阶段
FROM golang:1.21-alpine AS builder

WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /app/main .

# 运行阶段
FROM alpine:3.18

RUN apk --no-cache add ca-certificates
WORKDIR /app

COPY --from=builder /app/main .
COPY --from=builder /app/configs ./configs

RUN addgroup -g 1000 appgroup && \
    adduser -u 1000 -G appgroup -D appuser && \
    chown -R appuser:appgroup /app

USER appuser

CMD ["./main"]
```

#### Node.js 应用示例
```dockerfile
# 构建阶段
FROM node:20-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

COPY . .
RUN npm run build

# 运行阶段
FROM node:20-alpine

WORKDIR /app
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./

RUN addgroup -g 1000 nodejs && \
    adduser -u 1000 -G nodejs -D nodejs

USER nodejs

CMD ["node", "dist/main.js"]
```

#### Python 应用示例
```dockerfile
FROM python:3.11-slim AS builder

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

FROM python:3.11-slim

WORKDIR /app
COPY --from=builder /app /app

RUN groupadd -g 1000 pythons && \
    useradd -u 1000 -g pythons -D python

USER python

CMD ["python", "main.py"]
```

### 2. 多环境构建支持

```dockerfile
# 构建参数
ARG BUILD_ENV=dev
ARG APP_VERSION=latest

# 根据构建参数调整配置
RUN if [ "$BUILD_ENV" = "prod" ]; then \
    echo "Production build"; \
    else echo "Development build"; \
    fi

# 标签
LABEL version=${APP_VERSION} \
      environment=${BUILD_ENV}
```

### 3. Docker Compose 开发环境

```yaml
version: '3.8'

services:
  app:
    build:
      context: .
      dockerfile: Dockerfile.dev
    volumes:
      - .:/app
      - /app/node_modules
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
      - DEBUG=true
    command: npm run dev

  db:
    image: postgres:15-alpine
    volumes:
      - postgres_data:/var/lib/postgresql/data
    environment:
      POSTGRES_DB: myapp
      POSTGRES_USER: dev
      POSTGRES_PASSWORD: dev
    ports:
      - "5432:5432"
```

## 输入

- 应用的编程语言/框架
- 是否需要多阶段构建
- 是否需要 docker-compose 开发环境

## 输出格式

```markdown
## Dockerfile

```dockerfile
[生成的 Dockerfile 内容]
```

## docker-compose.yml（如需要）

```yaml
[生成的 compose 配置]
```

## 配置说明

- 构建命令：`docker build -t app:latest .`
- 运行命令：`docker run -p 3000:3000 app:latest`
- 多环境构建：`docker build --build-arg BUILD_ENV=prod -t app:prod .`

## 安全建议

- 使用非 root 用户
- 最小化基础镜像
- 定期更新基础镜像版本
```

## 触发词
Dockerfile、docker-compose、容器化、镜像构建、多阶段构建