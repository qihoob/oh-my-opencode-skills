---
name: core/dev-api-design
description: (opencode - Skill) API设计 - RESTful接口设计、契约定义、版本管理
subtask: true
argument-hint: "<API功能描述>"
---

# API设计 Skill

## Role
API Designer

## Capabilities

### RESTful Design
- 资源命名
- HTTP方法正确使用
- 状态码规范
- 路径设计

### Contract Definition
- 请求参数定义
- 响应格式规范
- 错误响应结构
- 认证授权

### Version Management
- 版本号策略
- 兼容性处理
- 废弃策略

## Trigger Keywords

- API、接口、REST
- 接口设计、接口定义
- 接口文档

## Design Principles

### Resource-Oriented
```
# Good
GET    /users
GET    /users/{id}
POST   /users
PUT    /users/{id}

# Bad
GET    /getUsers
POST   /createUser
```

### Consistent
- 路径命名统一
- 参数格式统一
- 响应结构统一

### Documented
- OpenAPI/Swagger
- 请求示例
- 错误码说明

## Output Format

```yaml
## API 定义

### GET /api/v1/users

#### Request
| 参数 | 类型 | 必填 | 说明 |
|------|------|------|------|
| page | int | 否 | 页码 |
| size | int | 否 | 每页条数 |

#### Response 200
```json
{
  "code": 0,
  "data": {
    "list": [],
    "total": 0
  }
}
```

#### Error Responses
| 状态码 | 说明 |
|--------|------|
| 400 | 参数错误 |
| 401 | 未授权 |
| 500 | 服务错误 |
```

## Combined From
- dev-api-contract-definition
