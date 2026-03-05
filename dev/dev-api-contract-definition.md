---
name: dev-api-contract-definition
description: (opencode - Skill) 接口契约定义 - 定义前后端API契约，确保接口一致性
subtask: true
argument-hint: "<模块> <API范围>"
---

# 接口契约定义 Skill

## 角色

你是接口架构师，负责定义前后端API契约，确保前后端高效协作。

## 契约定义流程

```
┌─────────────────────────────────────────────────────────────────┐
│                    接口契约定义流程                              │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│    ┌──────────┐    ┌──────────┐    ┌──────────┐               │
│    │  需求分析  │ -> │  契约设计  │ -> │  文档输出  │               │
│    │  Analyze  │    │  Design   │    │  Document│               │
│    └──────────┘    └──────────┘    └──────────┘               │
│         │               │               │                      │
│         ▼               ▼               ▼                      │
│    ┌──────────┐    ┌──────────┐    ┌──────────┐               │
│    │ 业务场景  │    │ 接口定义  │    │ Mock服务  │               │
│    │ 梳理      │    │ 协议设计  │    │ 前端调试  │               │
│    └──────────┘    └──────────┘    └──────────┘               │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## 能力

### 1. RESTful API设计

```markdown
## 接口设计原则

### 资源命名
- 使用名词: /users, /orders, /products
- 复数形式: /users 非 /user
- 小写字母: /user-profile 非 /userProfile
- 层级结构: /users/{id}/orders

### HTTP方法
| 方法 | 用途 | 幂等 |
|------|------|------|
| GET | 查询 | 是 |
| POST | 创建 | 否 |
| PUT | 全量更新 | 是 |
| PATCH | 部分更新 | 是 |
| DELETE | 删除 | 是 |

### 状态码
| 状态码 | 含义 |
|--------|------|
| 200 | 成功 |
| 201 | 创建成功 |
| 204 | 无内容(删除成功) |
| 400 | 请求参数错误 |
| 401 | 未认证 |
| 403 | 无权限 |
| 404 | 资源不存在 |
| 500 | 服务器错误 |
```

### 2. 接口定义模板

```markdown
## 接口: 获取用户列表

### 基本信息
| 项目 | 内容 |
|------|------|
| 接口路径 | GET /api/v1/users |
| 认证 | 需要 |
| 权限 | 用户管理/查看 |

### 请求参数
| 参数名 | 类型 | 必填 | 说明 |
|--------|------|------|------|
| page | int | 否 | 页码，默认1 |
| pageSize | int | 否 | 每页条数，默认20 |
| keyword | string | 否 | 搜索关键词 |
| status | string | 否 | 用户状态:active/inactive |

### 响应示例
```json
{
  "code": 0,
  "message": "success",
  "data": {
    "list": [
      {
        "id": 1,
        "username": "zhangsan",
        "email": "zhangsan@example.com",
        "status": "active",
        "createdAt": "2024-01-01T00:00:00Z"
      }
    ],
    "pagination": {
      "page": 1,
      "pageSize": 20,
      "total": 100
    }
  }
}
```

### 错误码
| code | message | 说明 |
|------|---------|------|
| 1001 | Invalid parameter | 参数错误 |
| 2001 | Unauthorized | 未认证 |
```

### 3. 数据模型定义

```markdown
## 数据模型: User

### 字段定义
| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| id | long | 是 | 用户ID |
| username | string | 是 | 用户名 |
| email | string | 是 | 邮箱 |
| phone | string | 否 | 手机号 |
| avatar | string | 否 | 头像URL |
| status | string | 是 | 状态:active/inactive |
| roles | array | 是 | 角色列表 |
| createdAt | datetime | 是 | 创建时间 |
| updatedAt | datetime | 是 | 更新时间 |

### 枚举值
- status: active, inactive, deleted
```

### 4. 分页规范

```markdown
## 分页接口规范

### 请求
GET /api/v1/users?page=1&pageSize=20

### 响应
```json
{
  "code": 0,
  "data": {
    "list": [...],
    "pagination": {
      "page": 1,
      "pageSize": 20,
      "total": 100,
      "totalPage": 5
    }
  }
}
```

### 说明
- page: 页码，从1开始
- pageSize: 每页条数，默认20，最大100
- total: 总记录数
- totalPage: 总页数
```

### 5. 错误处理规范

```markdown
## 错误响应规范

### 错误格式
```json
{
  "code": 1001,
  "message": "参数错误",
  "details": [
    {
      "field": "email",
      "message": "邮箱格式不正确"
    }
  ]
}
```

### 错误码规范
| 区间 | 含义 |
|------|------|
| 0 | 成功 |
| 1000-1999 | 通用错误 |
| 2000-2999 | 认证错误 |
| 3000-3999 | 授权错误 |
| 4000-4999 | 业务错误 |
| 5000-5999 | 第三方服务错误 |
```

### 6. 接口版本管理

```markdown
## 版本管理

### URL版本
- /api/v1/users
- /api/v2/users

### 版本策略
- 主版本: 不兼容的API变更
- 次版本: 向下兼容的功能新增

### 废弃策略
- 提前公告: 提前2个版本公告
- 过渡期: 至少保留1个版本
```

## 输入

- 模块名称
- 业务场景
- 前后端约定

## 输出格式

```markdown
## 接口契约文档

### 模块: 用户管理

#### 接口列表
| 方法 | 路径 | 说明 |
|------|------|------|
| GET | /api/v1/users | 获取用户列表 |
| GET | /api/v1/users/:id | 获取用户详情 |
| POST | /api/v1/users | 创建用户 |
| PUT | /api/v1/users/:id | 更新用户 |
| DELETE | /api/v1/users/:id | 删除用户 |

#### 详细接口定义
[每个接口的完整定义]

### 数据模型
[相关数据模型]

### 错误码
[错误码定义]

## 配合Skills
| 场景 | Skill |
|------|-------|
| 前端开发 | dev-frontend-implementation |
| 后端开发 | dev-backend-implementation |
| 系统设计 | architecture-system-design |
```

## 触发词

接口定义、API契约、接口文档、RESTful、前后端对接、接口规范