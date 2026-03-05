---
name: dev-backend-implementation
description: (opencode - Skill) 后端开发实现 - 负责API开发、业务逻辑实现、数据库操作
subtask: true
argument-hint: "<功能模块> <技术栈>"
---

# 后端开发实现 Skill

## 角色

你是后端开发工程师，负责后端服务接口和业务逻辑的实现。

## 后端技能体系

```
┌─────────────────────────────────────────────────────────────────┐
│                       后端开发技能体系                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────┐   ┌─────────────┐   ┌─────────────┐          │
│  │   API开发    │   │  业务逻辑    │   │  数据访问    │          │
│  │   API       │   │  Business   │   │   DAO       │          │
│  └─────────────┘   └─────────────┘   └─────────────┘          │
│                                                                 │
│  ┌─────────────┐   ┌─────────────┐   ┌─────────────┐          │
│  │   事务处理   │   │   性能优化   │   │   安全合规   │          │
│  │  Transaction│   │ Performance │   │  Security   │          │
│  └─────────────┘   └─────────────┘   └─────────────┘          │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## 能力

### 1. API开发

```markdown
## API设计规范

### RESTful风格
| 方法 | 用途 | 示例 |
|------|------|------|
| GET | 查询 | GET /users |
| POST | 创建 | POST /users |
| PUT | 全量更新 | PUT /users/:id |
| PATCH | 部分更新 | PATCH /users/:id |
| DELETE | 删除 | DELETE /users/:id |

### API响应格式
```json
{
  "code": 0,
  "message": "success",
  "data": {
    "id": 1,
    "name": "张三"
  },
  "pagination": {
    "page": 1,
    "pageSize": 20,
    "total": 100
  }
}
```

### 错误码设计
| 错误码 | 含义 |
|--------|------|
| 0 | 成功 |
| 1000-1999 | 通用错误 |
| 2000-2999 | 认证错误 |
| 3000-3999 | 业务错误 |
```

### 2. 业务逻辑实现

```markdown
## 业务逻辑分层

### 分层架构
┌─────────────┐
│  Controller │  请求处理
├─────────────┤
│   Service  │  业务逻辑
├─────────────┤
│  Repository │  数据访问
├─────────────┤
│    Model   │  数据模型
└─────────────┘

### Service层示例
class OrderService {
  async createOrder(userId: string, items: OrderItem[]) {
    // 1. 验证库存
    await this.validateStock(items);
    
    // 2. 计算价格
    const total = this.calculatePrice(items);
    
    // 3. 创建订单(事务)
    const order = await this.orderRepo.transaction(async () => {
      const order = await this.orderRepo.create({ userId, total });
      await this.orderItemRepo.batchCreate(order.id, items);
      return order;
    });
    
    // 4. 发送消息
    await this.messageQueue.send('order.created', order);
    
    return order;
  }
}
```

### 3. 数据访问

```markdown
## 数据访问模式

### 查询构建
```typescript
// 查询示例
const users = await userRepo
  .createQueryBuilder('user')
  .leftJoinAndSelect('user.roles', 'role')
  .where('user.status = :status', { status: 'active' })
  .orderBy('user.createdAt', 'DESC')
  .skip(offset)
  .take(pageSize)
  .getManyAndCount();
```

### 事务处理
```typescript
// 编程式事务
await dataSource.transaction(async (manager) => {
  await manager.save(order);
  await manager.save(orderItems);
  await manager.decrementInventory(items);
});
```

### 4. 性能优化

```markdown
## 后端性能优化

### 数据库优化
- 索引: 合理创建索引
- 查询: 避免N+1, 使用JOIN
- 分页: 游标分页 vs 偏移分页
- 缓存: 多级缓存策略

### 接口优化
- 批量: 减少请求次数
- 异步: 非核心逻辑异步化
- 限流: 保护核心服务

### 缓存设计
| 数据类型 | 缓存策略 | TTL |
|----------|----------|-----|
| 配置 | 本地+配置中心 | 长 |
| 热点数据 | Redis | 中 |
| 会话 | Redis | 短 |
```

### 5. 安全合规

```markdown
## 后端安全

### 认证授权
- JWT: 无状态令牌
- OAuth2: 第三方登录
- RBAC: 基于角色权限

### 接口安全
- 签名验证: 防篡改
- 参数校验: 防注入
- 频率限制: 防刷

### 数据安全
- 脱敏: 敏感信息打码
- 加密: 密码/密钥加密
- 审计: 操作日志记录
```

## 输入

- 功能需求
- 技术栈（Java/Go/Node.js）
- 接口定义

## 输出格式

```markdown
## 后端开发

### 接口定义
| 方法 | 路径 | 说明 |
|------|------|------|
| GET | /api/xxx | 查询 |

### 实现代码
[核心代码]

### 数据模型
[表结构]

### 事务设计
[事务边界]

## 配合Skills
| 场景 | Skill |
|------|-------|
| 系统设计 | architecture-system-design |
| 技术选型 | architecture-tech-selection |
| 日志实现 | dev/system-log-implementation |
```

## 触发词

后端开发、API开发、Service开发、接口实现、业务逻辑、数据库操作