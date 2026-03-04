---
name: dev-api-design
description: (opencode - Skill) API设计 - 设计RESTful接口，定义请求响应格式、错误码、版本策略
subtask: true
argument-hint: "<资源名称> <功能描述>"
---

# API设计 Skill

## 角色

你是API设计师，负责设计规范、易用、统一的RESTful接口。

## API设计原则

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           API设计原则                                        │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  1. 资源导向        使用名词而非动词                                          │
│       ↓                                                                       │
│  2. 统一接口        GET/POST/PUT/DELETE                                      │
│       ↓                                                                       │
│  3. 幂等性          多次请求结果一致                                          │
│       ↓                                                                       │
│  4. 版本化          API版本控制                                              │
│       ↓                                                                       │
│  5. 文档化          完整API文档                                              │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 能力

### 1. RESTful规范

| 方法 | 用途 | 幂等 |
|------|------|------|
| GET | 获取资源 | 是 |
| POST | 创建资源 | 否 |
| PUT | 完整更新 | 是 |
| PATCH | 部分更新 | 否 |
| DELETE | 删除资源 | 是 |

### 2. URL设计

```markdown
## URL规范

### 资源命名
- 使用复数: /users, /orders
- 使用小写: /userProfiles
- 使用连字符: /order-items

### 例子
# 用户
GET    /api/v1/users           # 获取用户列表
GET    /api/v1/users/:id       # 获取单个用户
POST   /api/v1/users           # 创建用户
PUT    /api/v1/users/:id       # 更新用户
DELETE /api/v1/users/:id       # 删除用户

# 订单和用户关系
GET    /api/v1/users/:id/orders  # 获取用户的订单

# 复杂查询
GET    /api/v1/users?status=active&page=1&size=10
```

### 3. 请求格式

```markdown
## 请求头
Content-Type: application/json
Authorization: Bearer <token>
Accept: application/json

## 请求体 (POST/PUT/PATCH)
{
  "username": "zhangsan",
  "email": "zhang@example.com",
  "age": 25
}
```

### 4. 响应格式

```markdown
## 成功响应

### 单个资源
GET /api/v1/users/1
{
  "code": 0,
  "message": "success",
  "data": {
    "id": 1,
    "username": "zhangsan",
    "email": "zhang@example.com"
  }
}

### 资源列表
GET /api/v1/users
{
  "code": 0,
  "message": "success",
  "data": {
    "items": [...],
    "total": 100,
    "page": 1,
    "size": 10
  }
}

### 创建成功
POST /api/v1/users
{
  "code": 0,
  "message": "创建成功",
  "data": {
    "id": 100
  }
}
```

### 5. 错误响应

```markdown
## 错误响应格式

{
  "code": 1001,
  "message": "用户不存在",
  "data": null,
  "details": "用户ID: 12345 不存在"
}

## 错误码规范

| 错误码 | 含义 |
|--------|------|
| 0 | 成功 |
| 1000-1999 | 通用错误 |
| 2000-2999 | 认证错误 |
| 3000-3999 | 权限错误 |
| 4000-4999 | 业务错误 |
| 5000-5999 | 系统错误 |
```

### 6. 版本控制

```markdown
## 版本策略

### URL版本
/api/v1/users
/api/v2/users

### 版本选择
- Header: Accept: application/vnd.myapp.v2+json
- 推荐: URL方式 (更直观)
```

### 7. 分页设计

```markdown
## 分页参数
- page: 页码 (默认1)
- size: 每页数量 (默认10, 最大100)

## 响应
{
  "data": {
    "items": [...],
    "pagination": {
      "page": 1,
      "size": 10,
      "total": 100,
      "totalPages": 10
    }
  }
}
```

### 8. 认证授权

```markdown
## 认证方式
- Bearer Token (JWT)
- 有效期: 2小时
- 刷新Token: 7天

## 授权
- 公开接口: 无需认证
- 私有接口: 需要认证
- 管理员接口: 需要Admin角色
```

## 输入

- 资源名称
- 功能描述
- 业务规则

## 输出格式

```markdown
## API设计文档

### 资源: 用户管理 (User)

---

## 1. 接口列表

| 方法 | 路径 | 说明 | 认证 |
|------|------|------|------|
| GET | /api/v1/users | 获取用户列表 | 是 |
| GET | /api/v1/users/:id | 获取单个用户 | 是 |
| POST | /api/v1/users | 创建用户 | 是 |
| PUT | /api/v1/users/:id | 更新用户 | 是 |
| DELETE | /api/v1/users/:id | 删除用户 | 是 |

---

## 2. 详细接口

### GET /api/v1/users

**请求参数**
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| page | number | 否 | 页码 |
| size | number | 否 | 每页数量 |
| status | string | 否 | 状态过滤 |

**响应**
```json
{
  "code": 0,
  "data": {
    "items": [...],
    "pagination": {...}
  }
}
```

### POST /api/v1/users

**请求体**
```json
{
  "username": "string|required|3-20字符",
  "email": "string|required|邮箱格式",
  "password": "string|required|6-20字符",
  "age": "number|optional|18-100"
}
```

**响应**
```json
{
  "code": 0,
  "data": {
    "id": 1
  }
}
```

---

## 3. 错误码

| 错误码 | 消息 | 说明 |
|--------|------|------|
| 2001 | 无效token | Token已过期 |
| 2002 | 未授权 | 需要登录 |
| 4001 | 用户名已存在 | 重复注册 |
| 4002 | 用户不存在 | ID不存在 |

---

## 触发词

API设计、接口设计、RESTful、设计接口、定义接口