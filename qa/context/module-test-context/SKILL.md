---
name: module-test-context
description: 模块测试上下文 - 深入分析单个模块的代码，提取API、数据模型、状态流转、权限检查，生成模块级测试上下文
version: "2.0"
---

# Skill: module-test-context

**角色**: 测试 (QA)
**功能**: 深入分析单个模块的代码，提取 API、数据模型、状态流转、权限检查、模块依赖和测试风险，生成模块级测试上下文
**触发关键词**: 模块测试、获取测试上下文、测试前、模块上下文、了解模块、模块结构
**版本**: 2.0

## 适用场景

```
当以下条件成立时使用本技能：
- 测试人员需要深入了解某个具体模块（而非整个项目）
- 需要为指定模块生成详细的测试上下文
- 模块级测试前的上下文准备
- 了解模块内部结构、接口、数据模型、状态和权限

前置条件：用户指定了目标模块名，或可从项目结构自动识别
与 qa-context-from-code 的区别：
  - qa-context-from-code：全项目扫描，无文档时从代码反推
  - 本技能：聚焦单模块，深入提取模块内部的全部测试相关信息
```

## 产出文档

- **模块测试上下文**: 即时输出，供 `qa/test-case/test-case-design` 使用
- **可选持久化**: `.opencode/docs/module-test-context-{module}.md`

---

## 执行流程

### Step 1: 定位目标模块

```
目标：确定要分析的模块及其文件结构。

1.1 确定模块名：
    - 用户直接指定模块名（如 "payment"、"订单"）
    - 或用户指定模块路径（如 src/modules/order/）
    - 若未指定，扫描项目结构列出所有模块供用户选择

1.2 识别模块根目录（按优先级尝试）：
    - src/modules/{module}/
    - src/{module}/
    - modules/{module}/
    - packages/{module}/
    - app/{module}/
    - internal/{module}/
    - 用户自定义路径

1.3 扫描模块内所有文件：
    工具：glob 扫描模块目录，列出所有文件
    模式：{moduleRoot}/**/*

1.4 识别模块类型：
    - 前端：包含 .vue / .tsx / .jsx / .svelte / 页面组件
    - 后端：包含 controller / service / router / handler / model
    - 全栈：同时包含前后端文件

输出：
| 属性 | 值 |
|------|----|
| 模块名 | {name} |
| 路径 | {moduleRoot} |
| 类型 | 前端/后端/全栈 |
| 文件数 | {N} |
| 文件清单 | {按目录分组的文件树} |
```

### Step 2: 提取模块 API 端点

```
目标：从代码中提取模块对外暴露的所有 API 端点。

2.1 搜索路由定义：
    工具：grep 搜索以下模式
    - router.get / router.post / router.put / router.delete / router.patch
    - @GetMapping / @PostMapping / @PutMapping / @DeleteMapping
    - app.get / app.post / app.put / app.delete
    - Route::get / Route::post
    - fastify.get / fastify.post
    - 或框架特定的路由注册方式

2.2 搜索控制器/处理器方法：
    工具：grep 搜索以下模式
    - *Controller / *Handler / *Service 中的公开方法
    - export function / export async function
    - def *view / def *handler
    - func *Handler / func *Controller

2.3 对每个端点，提取以下信息：
    - HTTP 方法（GET/POST/PUT/DELETE/PATCH）
    - 路径（含路径参数，如 /api/orders/:id）
    - 请求参数（query / body / path params）
    - 鉴权要求（是否有 Token / Session / API Key 检查）
    - 所在文件和行号

输出 API 清单：
| 方法 | 路径 | 参数 | 鉴权 | 代码位置 |
|------|------|------|------|----------|
| POST | /api/orders | items[], addressId | Token | order.controller.ts:34 |
| GET | /api/orders | page, status, pageSize | Token | order.controller.ts:56 |
| GET | /api/orders/:id | - | Token | order.controller.ts:78 |
| PUT | /api/orders/:id/status | status | Token + Admin | order.controller.ts:102 |
| DELETE | /api/orders/:id | - | Token + Admin | order.controller.ts:135 |
```

### Step 3: 提取数据模型约束

```
目标：从代码中提取模块使用的所有数据模型及其约束。

3.1 搜索模型/Schema 定义：
    工具：grep 搜索以下模式
    - model/ schema/ entity/ 下的定义文件
    - CREATE TABLE / ALTER TABLE 语句
    - mongoose.Schema / Schema({ ... })
    - @Entity / @Table / @Column 注解
    - interface / type 类型定义（TypeScript）
    - prisma model 定义
    - Pydantic Model / SQLAlchemy Model
    - struct / class 带 JSON tag

3.2 对每个模型，深入提取字段级约束：
    工具：read 读取模型文件，提取每个字段：
    - 字段名
    - 数据类型（string / number / boolean / Date / enum / array / object）
    - 约束：
      - 必填 / 可选
      - 唯一性
      - 长度范围（min / max）
      - 数值范围
      - 格式（email / url / phone / regex）
      - 枚举值列表
    - 默认值
    - 关联关系（外键、一对多、多对多）

输出数据约束清单：
| 模型 | 字段 | 类型 | 约束 | 默认值 | 代码位置 |
|------|------|------|------|--------|----------|
| Order | id | string(UUID) | 必填, 唯一, 自动生成 | uuid() | order.model.ts:5 |
| Order | userId | string | 必填, 外键→User | - | order.model.ts:6 |
| Order | status | enum | pending/paid/shipped/completed/cancelled | pending | order.model.ts:7 |
| Order | totalAmount | number | 必填, > 0, 精度2位 | - | order.model.ts:8 |
| Order | createdAt | Date | 自动生成 | Date.now | order.model.ts:9 |
| OrderItem | orderId | string | 必填, 外键→Order | - | order-item.model.ts:3 |
| OrderItem | productId | string | 必填, 外键→Product | - | order-item.model.ts:4 |
| OrderItem | quantity | number | 必填, >= 1 | 1 | order-item.model.ts:5 |
```

### Step 4: 提取状态流转

```
目标：从代码中提取模块内所有实体的状态定义和状态变更逻辑。

4.1 搜索状态枚举/常量：
    工具：grep 搜索以下模式
    - enum Status / enum OrderStatus / enum *Status
    - const STATUS = / const *STATUS
    - type Status = / type *Status =
    - status: 'pending' | 'paid' | 'shipped'（联合类型）
    - *StatusMap / *StatusOptions / *StatusList

4.2 搜索状态变更逻辑：
    工具：grep 搜索以下模式
    - setStatus / updateStatus / status = / status:
    - .status = / setStatus( / updateStatus(
    - CASE WHEN status = ...（数据库层状态变更）
    - 状态机框架：XState / javascript-state-machine / transitions

4.3 搜索条件分支（验证合法转换）：
    工具：grep 搜索以下模式
    - if (status === / if (status !== / switch(status) / case 'pending':
    - 这些分支暗示哪些转换是被允许/拒绝的

4.4 推导状态转换规则：
    - 合法转换：代码中存在从 A 到 B 的赋值/更新逻辑
    - 非法转换：代码中有显式拒绝，或没有任何从 A 到 B 的路径

输出状态流转图：

状态枚举：pending, paid, shipped, completed, cancelled, refunded

合法转换：
| 从 | 到 | 触发条件 | 代码位置 |
|----|----|----------|---------|
| pending | paid | 支付成功回调 | payment.service.ts:45 |
| pending | cancelled | 用户取消 / 超时30分钟自动取消 | order.service.ts:89 |
| paid | shipped | 管理员发货 | order.service.ts:112 |
| paid | refunded | 用户申请退款，管理员批准 | refund.service.ts:23 |
| shipped | completed | 用户确认收货 / 自动确认(15天) | order.service.ts:156 |

非法转换：
| 尝试 | 应该 | 代码位置 |
|------|------|---------|
| completed → cancelled | 拒绝，已完成不可取消 | order.service.ts:160 |
| cancelled → paid | 拒绝，需重新下单 | order.service.ts:92 |
| shipped → pending | 拒绝，无此业务场景 | order.service.ts:115 |
```

### Step 5: 提取权限检查

```
目标：从代码中提取模块内每个接口的权限要求，构建权限矩阵。

5.1 搜索鉴权逻辑：
    工具：grep 搜索以下模式
    - @RequireAuth / @RequireRole / @RequirePermission
    - authMiddleware / authGuard / checkAuth / verifyToken
    - hasPermission / hasRole / canAccess / checkAccess
    - useAuth() / usePermission()
    - v-if="isAdmin" / v-if="hasRole" / *ngIf="hasPermission"
    - middleware 数组中包含 auth 相关中间件
    - 框架守卫：@UseGuards(AuthGuard) / canActivate

5.2 识别角色/权限定义：
    工具：grep 搜索以下模式
    - role / permission / authority / group
    - enum Role / const ROLES / type Role
    - RBAC / ACL 配置文件
    - permission map / role permissions

5.3 构建权限矩阵：
    对每个接口，标注各角色的访问权限：
    - 未登录（匿名）
    - 普通用户（authenticated）
    - 管理员（admin）
    - 其他自定义角色

输出权限矩阵：
| 接口 | 未登录 | 普通用户 | 管理员 | 自定义角色 |
|------|--------|---------|--------|-----------|
| POST /api/orders | 401 | 创建自己的订单 | 创建任意订单 | - |
| GET /api/orders | 401 | 查看自己的订单 | 查看全部订单 | - |
| GET /api/orders/:id | 401 | 仅自己的 | 全部 | - |
| PUT /api/orders/:id/status | 401 | 403 | 更新状态 | - |
| DELETE /api/orders/:id | 401 | 403 | 删除订单 | - |
```

### Step 6: 识别模块间依赖

```
目标：识别本模块与其他模块之间的调用和数据依赖关系。

6.1 反向依赖（谁调用了本模块）：
    工具：grep 在项目根目录搜索本模块的导出/引用
    - import ... from './{module}' / import ... from '../{module}'
    - import ... from '@/modules/{module}'
    - require('{module}')
    - 识别调用方模块名和调用目的

6.2 正向依赖（本模块调用了谁）：
    工具：grep 在本模块目录搜索外部 import/require
    - import ... from '../{other}' / import ... from './{other}'
    - import ... from '@/modules/{other}'
    - require('../{other}')
    - HTTP 调用其他模块的 API
    - 消息队列/事件依赖

6.3 共享数据模型：
    工具：grep 搜索本模块使用的模型被哪些模块引用
    - 同一个 model 文件被多个模块 import
    - 共享的 TypeScript interface / type
    - 共享的数据库表

输出依赖影响图：
- **被依赖**: 支付模块调用本模块(order)查询订单状态 → 订单状态变更需通知支付
- **被依赖**: 通知模块监听本模块(order)的订单事件 → 新事件类型需同步通知模块
- **依赖**: 本模块(order)调用商品模块(product)查询价格 → 需确保商品数据可用
- **依赖**: 本模块(order)调用用户模块(user)查询地址 → 需确保用户数据可用
- **共享数据**: User 模型（与 user 模块共享）、Product 模型（与 product 模块共享）
```

### Step 7: 识别测试风险

```
目标：基于以上分析，识别模块中可能存在的测试风险点。

7.1 缺少校验的字段：
    检查 API 端点接收的参数是否有完整校验
    - 是否有字段没有类型/范围/格式校验
    - 是否缺少必填校验
    - 是否缺少长度限制

7.2 未处理的异常：
    工具：grep 搜索
    - try/catch 是否覆盖所有可能出错的操作
    - 数据库操作是否有错误处理
    - 外部调用是否有超时和重试
    - 空值检查（null / undefined）

7.3 并发不安全的操作：
    工具：grep 搜索
    - 库存扣减是否有事务/锁
    - 状态变更是否有并发保护
    - 余额操作是否有原子性保证
    - 乐观锁/悲观锁使用

7.4 硬编码：
    工具：grep 搜索
    - 硬编码的 URL / IP / 端口
    - 硬编码的密钥 / Token
    - 硬编码的配置值（超时时间、重试次数等）
    - 魔数（magic numbers）

7.5 安全风险：
    - SQL 注入风险
    - XSS 风险
    - CSRF 风险
    - 敏感数据泄露（日志中打印密码等）

输出风险清单：
| 风险 | 类型 | 位置 | 优先级 | 说明 |
|------|------|------|--------|------|
| quantity 无上限校验 | 缺少校验 | order.controller.ts:45 | P0 | 恶意用户可下单 999999 件 |
| 订单创建无事务保护 | 并发不安全 | order.service.ts:67 | P0 | 并发创建可能导致库存超卖 |
| 支付回调无幂等检查 | 并发不安全 | payment.service.ts:89 | P0 | 重复回调可能重复发货 |
| 超时时间硬编码 | 硬编码 | order.service.ts:92 | P2 | 30分钟硬编码，无法动态配置 |
| 订单列表返回全部字段 | 安全风险 | order.controller.ts:58 | P1 | 可能泄露用户手机号等敏感信息 |
| catch 块为空 | 未处理异常 | order.service.ts:120 | P1 | 异常被吞掉，无法排查问题 |
```

### Step 8: 输出模块测试上下文

```
整合 Step 1 ~ Step 7 的所有分析结果，按标准输出格式生成模块测试上下文报告。

如果用户需要持久化，将报告写入 .opencode/docs/module-test-context-{module}.md。
```

---

## 输出格式

```markdown
## 模块测试上下文：{模块名}

**分析日期**: {YYYY-MM-DD}
**分析方法**: 模块代码深度分析

### 模块信息
- **路径**: src/modules/{module}/
- **类型**: 前端/后端/全栈
- **文件数**: {N}

### API 端点清单
| 方法 | 路径 | 参数 | 鉴权 | 代码位置 |
|------|------|------|------|----------|
| POST | /api/orders | items[], addressId | Token | order.controller.ts:34 |
| GET | /api/orders | page, status, pageSize | Token | order.controller.ts:56 |

### 数据模型约束
| 模型 | 字段 | 类型 | 约束 | 默认值 | 代码位置 |
|------|------|------|------|--------|----------|
| Order | status | enum | pending/paid/shipped/completed/cancelled | pending | order.model.ts:7 |
| Order | totalAmount | number | 必填, > 0, 精度2位 | - | order.model.ts:8 |

### 状态流转
状态枚举：{枚举值列表}

合法转换：
| 从 | 到 | 触发条件 | 代码位置 |
|----|----|----------|---------|
| pending | paid | 支付成功回调 | payment.service.ts:45 |

非法转换：
| 尝试 | 应该 | 代码位置 |
|------|------|---------|
| completed → cancelled | 拒绝 | order.service.ts:160 |

### 权限矩阵
| 接口 | 未登录 | 普通用户 | 管理员 |
|------|--------|---------|--------|
| POST /api/orders | 401 | 创建自己的订单 | 创建任意订单 |
| GET /api/orders | 401 | 查看自己的订单 | 查看全部订单 |

### 模块依赖
- **被依赖**: {谁调用了本模块，调用目的}
- **依赖**: {本模块调用了谁，调用目的}
- **共享数据**: {共享的数据模型，与哪个模块共享}

### 测试风险
| 风险 | 类型 | 位置 | 优先级 | 说明 |
|------|------|------|--------|------|
| quantity 无上限校验 | 缺少校验 | order.controller.ts:45 | P0 | 恶意用户可下单 999999 件 |

### 推荐下一步
→ 执行 `qa/test-case/test-case-design` 基于以上分析设计测试用例
```

---

## 使用场景

### 场景 1: 指定模块名进行分析

```
用户: "帮我分析支付模块的测试上下文"

执行:
1. 定位支付模块目录 → src/modules/payment/
2. 提取支付 API（创建支付、支付回调、退款等）
3. 提取 Payment 数据模型和字段约束
4. 提取支付状态流转（pending → success / failed）
5. 提取权限（支付回调是否验签、退款是否限管理员）
6. 识别依赖（依赖订单模块、用户模块）
7. 识别风险（回调幂等、金额精度、并发支付）
8. 输出模块测试上下文
```

### 场景 2: 从项目结构选择模块

```
用户: "我要测试某个模块，帮我先看看有哪些"

执行:
1. 扫描项目 src/modules/ 目录
2. 列出所有模块供用户选择
3. 用户选择后，执行 Step 2 ~ Step 8 完整流程
```

### 场景 3: 模块级回归测试前的上下文更新

```
用户: "订单模块改了，帮我重新获取测试上下文"

执行:
1. 定位订单模块
2. 重新提取所有 API、模型、状态、权限
3. 与上次分析结果对比（如有持久化文档）
4. 标注变更部分
5. 输出更新后的模块测试上下文
```

### 场景 4: 配合 qa-context-from-code 深入单个模块

```
用户先用 qa-context-from-code 做了全项目扫描，发现订单模块风险最高。
用户: "帮我深入分析订单模块"

执行:
1. 不再扫描全项目，聚焦订单模块
2. 提取比 qa-context-from-code 更细粒度的信息：
   - 每个字段的完整约束（不仅仅是关键字段）
   - 所有状态转换路径（不仅仅是主要流转）
   - 所有接口的权限矩阵（不仅仅是角色概述）
   - 模块间依赖的调用链路
   - 具体的代码级风险点
3. 输出详细模块测试上下文
```

---

## 配合 Skills

| 配合技能 | 关系 | 说明 |
|----------|------|------|
| `qa/context/qa-context-from-code` | 上游 | 全项目无文档时先做项目级逆向分析，再用本技能深入单个模块 |
| `qa/context/qa-context-first` | 互补 | 有需求文档时用 qa-context-first 获取上下文，无文档时用本技能 |
| `qa/test-case/test-case-design` | 后续 | 基于本技能产出的模块测试上下文设计测试用例 |
| `qa/execution/test-executor` | 后续 | 执行生成的测试用例 |
| `dev/context/dev-context-first` | 参考 | 类似的代码分析思路，但面向开发视角 |

## 工具可用
- grep: 搜索路由定义、状态枚举、权限检查、模型定义、外部引用
- glob: 扫描模块目录结构、查找文件
- read: 读取关键文件的具体实现（模型定义、状态逻辑、权限检查）
- write: 持久化模块测试上下文报告到 `.opencode/docs/`
