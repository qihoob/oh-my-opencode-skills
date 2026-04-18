---
name: qa-context-from-code
description: 测试逆向分析 - 无需求文档时，从代码反推功能、接口、状态机、数据模型，生成测试上下文和伪需求
version: "1.0"
---

# Skill: qa-context-from-code

**角色**: 测试 (QA)
**功能**: 从代码逆向推导测试上下文（半路介入场景）
**触发关键词**: 半路测试、没有需求文档、从代码分析、逆向测试、直接看代码、项目已做完要测试
**版本**: 1.0

## 适用场景

```
当以下条件成立时使用本技能：
- 测试人员中途加入项目
- 项目没有 .opencode/docs/ 下的需求文档
- 或者需求文档不完整/过时
- 代码已经存在，需要从代码反推要测什么

前置条件：无（只要有代码即可）
```

## 产出文档
- **测试上下文报告（可选持久化）**: `.opencode/docs/qa-context-report-{feature}.md`
- **伪需求文档**: `.opencode/docs/requirement-{feature}-reverse.md`（可选，如需补文档）
- 如处于自驱动链路中（chain-executor 执行），必须持久化到文件，以触发下游技能
- 如为单次交互，可即时输出不写文件

---

## 执行流程

### Step 1: 项目结构扫描

```
扫描项目目录，识别技术栈和模块划分：

1. 识别项目类型：
   - 前端: package.json / vite.config / next.config / nuxt.config
   - 后端: pom.xml / go.mod / requirements.txt / Cargo.toml / package.json
   - 全栈: 同时存在前后端配置

2. 识别模块划分：
   - 前端: src/pages/ 或 src/views/ 或 app/ 下的目录 → 每个目录 ≈ 一个功能模块
   - 后端: src/modules/ 或 src/controllers/ 或 internal/ 下的目录
   - 数据库: migrations/ 或 prisma/schema.prisma 或 *.sql

3. 输出模块清单：
   | 模块 | 路径 | 类型 | 文件数 |
   |------|------|------|--------|
   | 用户管理 | src/modules/user/ | 前后端 | 12 |
   | 订单系统 | src/modules/order/ | 前后端 | 18 |
   | 支付 | src/modules/payment/ | 后端 | 8 |
```

### Step 2: 功能模块识别

```
对目标测试模块（用户指定或全部），深入分析：

2.1 API 端点提取（后端）
   搜索模式:
   - 路由定义: router.get / router.post / @GetMapping / @PostMapping
   - 控制器方法: async function*Controller / def *view / func *Handler
   - API 路径前缀: /api/v1/ /api/v2/

   输出：
   | 方法 | 路径 | 功能推测 | 参数 | 所在文件 |
   |------|------|----------|------|----------|
   | POST | /api/auth/login | 用户登录 | email, password | auth.controller.ts |
   | POST | /api/auth/register | 用户注册 | email, password, name | auth.controller.ts |
   | GET | /api/users/me | 获取当前用户 | - (需Token) | user.controller.ts |

2.2 页面/组件提取（前端）
   搜索模式:
   - 页面组件: pages/ 或 views/ 下的 .vue/.tsx/.jsx
   - 表单组件: *Form.vue / *Form.tsx
   - 列表组件: *List.vue / *Table.tsx
   - 路由配置: router/ 下的路由定义

   输出：
   | 页面 | 路径 | 功能 | 关键组件 |
   |------|------|------|----------|
   | 登录页 | /login | 用户登录 | LoginForm |
   | 用户列表 | /users | 用户管理 | UserTable, UserSearch |
   | 订单详情 | /orders/:id | 订单查看 | OrderDetail, OrderStatus |

2.3 数据模型提取
   搜索模式:
   - ORM 模型: model/ schema/ entity/ 下的定义
   - SQL: CREATE TABLE 语句
   - Prisma: model 定义
   - TypeScript interface / type 定义

   输出：
   | 模型 | 字段数 | 关键字段 | 约束 |
   |------|--------|----------|------|
   | User | 8 | email(唯一), password, role | email格式, password≥6位 |
   | Order | 12 | userId, status, totalAmount | status枚举, amount>0 |
   | OrderItem | 6 | orderId, productId, quantity | quantity≥1 |
```

### Step 3: 状态机逆向推导

```
从代码中提取业务状态流转：

搜索策略:
1. 搜索状态枚举/常量:
   - enum Status / const STATUS / type Status
   - status: 'pending' | 'paid' | 'shipped'
   - orderStatusMap / statusOptions

2. 搜索状态变更逻辑:
   - status = 'paid' / setStatus('paid') / updateStatus
   - CASE WHEN status = ...
   - 状态机框架: XState / state-machine

3. 搜索条件分支:
   - if (status === 'pending') / switch(status)
   - 这些分支暗示状态转换规则

输出状态流转图：
   [状态A] --触发条件--> [状态B]    代码位置: file:line
   [pending] --支付成功--> [paid]    代码位置: payment.service.ts:45
   [pending] --超时--> [cancelled]   代码位置: order.service.ts:89
   [paid] --申请退款--> [refunded]   代码位置: refund.service.ts:23

非法转换推测:
   - completed 后不能再 cancelled（代码中无此路径）
   - cancelled 后不能再 paid（代码中无此路径）
```

### Step 4: 权限与角色识别

```
从代码中提取权限模型：

搜索策略:
1. 角色定义:
   - role / permission / authority 相关常量或枚举
   - middleware/ 下鉴权逻辑
   - guard/ 下权限守卫

2. 权限检查点:
   - @RequireAuth / @RequireRole / authMiddleware
   - useAuth() / hasPermission() / canAccess
   - v-if="isAdmin" / *ngIf="hasRole"

输出权限矩阵：
| 角色 | 可访问模块 | 关键权限 |
|------|-----------|----------|
| admin | 全部 | 增删改查所有数据 |
| user | 个人中心、下单 | 查看/修改自己的数据 |
| guest | 登录、注册 | 仅公开接口 |
```

### Step 5: 已有测试分析

```
搜索已有测试，了解覆盖现状：

搜索模式:
- 测试文件: *.test.* / *.spec.* / __tests__/
- 测试目录: tests/ test/ spec/ __tests__/
- E2E测试: e2e/ cypress/ playwright/

输出：
| 测试类型 | 文件数 | 覆盖模块 | 覆盖率估算 |
|----------|--------|----------|------------|
| 单元测试 | 12 | user, auth | ~40% |
| 接口测试 | 5 | order | ~20% |
| E2E测试 | 0 | - | 0% |
| 无测试 | - | payment, notification | 0% |

→ 识别未覆盖的高风险模块
```

### Step 6: 生成测试上下文

```
整合以上分析，输出完整测试上下文报告。
```

---

## 输出格式

```markdown
## 测试逆向分析报告：{项目名称}

**分析日期**: {YYYY-MM-DD}
**分析方法**: 代码逆向推导（无需求文档）
**项目技术栈**: {前端框架} + {后端框架} + {数据库}

### 一、模块概览

| 模块 | API数量 | 页面数量 | 数据模型 | 风险等级 |
|------|---------|---------|---------|---------|
| 用户认证 | 4 | 2 | User | 高（涉及安全） |
| 订单管理 | 8 | 4 | Order, OrderItem | 高（涉及资金） |
| 商品管理 | 6 | 3 | Product | 中 |
| 通知 | 2 | 1 | Notification | 低 |

### 二、逆向提取的验收标准（伪 AC）

以下 AC 从代码逻辑反推，非正式需求文档：

#### 模块：用户认证

| AC# | 反推的验收标准 | 来源 | 优先级 |
|-----|---------------|------|--------|
| AC1 | 用户可用邮箱+密码注册，密码≥6位 | auth.controller.ts:23 | P0 |
| AC2 | 用户可用邮箱+密码登录，返回Token | auth.controller.ts:45 | P0 |
| AC3 | Token有效期24小时，过期需重新登录 | auth.middleware.ts:12 | P0 |
| AC4 | 连续5次密码错误锁定账号30分钟 | auth.service.ts:67 | P1 |
| AC5 | 支持"记住我"功能，有效期7天 | auth.controller.ts:89 | P2 |

#### 模块：订单管理

| AC# | 反推的验收标准 | 来源 | 优先级 |
|-----|---------------|------|--------|
| AC6 | 用户可创建订单，包含商品和数量 | order.controller.ts:34 | P0 |
| AC7 | 订单状态流转: pending → paid → shipped → completed | order.service.ts:56 | P0 |
| AC8 | pending 超时30分钟自动取消，库存恢复 | order.service.ts:89 | P0 |
| AC9 | 已支付订单可申请退款 | refund.service.ts:23 | P1 |
| AC10 | 已完成/已取消订单不可变更 | order.service.ts:112 | P1 |

### 三、接口清单

| 方法 | 路径 | 功能 | 参数 | 鉴权 | 来源 |
|------|------|------|------|------|------|
| POST | /api/auth/register | 注册 | email, password, name | 无 | auth.controller.ts:23 |
| POST | /api/auth/login | 登录 | email, password, remember | 无 | auth.controller.ts:45 |
| GET | /api/users/me | 当前用户 | - | Token | user.controller.ts:12 |
| POST | /api/orders | 创建订单 | items[], addressId | Token | order.controller.ts:34 |
| GET | /api/orders | 订单列表 | page, status | Token | order.controller.ts:56 |

### 四、状态流转图

```
[registered] → [active] → [frozen] → [active]
                   ↓
               [deleted]
```

合法转换：
| 从 | 到 | 触发条件 | 代码位置 |
|----|----|----------|---------|
| registered | active | 邮箱验证 | user.service.ts:34 |
| active | frozen | 管理员操作 | admin.service.ts:56 |
| frozen | active | 管理员解冻 | admin.service.ts:78 |
| active | deleted | 用户注销 | user.service.ts:90 |

非法转换：
| 尝试 | 应该 | 代码位置 |
|------|------|---------|
| frozen → deleted | 拒绝 | user.service.ts:92 |
| deleted → * | 拒绝 | user.service.ts:95 |

### 五、数据模型约束

| 模型 | 字段 | 类型 | 约束 | 来源 |
|------|------|------|------|------|
| User | email | string | 必填, 唯一, 邮箱格式 | user.model.ts:8 |
| User | password | string | 必填, ≥6位, 哈希存储 | user.model.ts:9 |
| Order | status | enum | pending/paid/shipped/completed/cancelled/refunded | order.model.ts:15 |
| Order | totalAmount | number | > 0, 精度2位 | order.model.ts:18 |
| OrderItem | quantity | number | ≥ 1 | order-item.model.ts:6 |

### 六、权限矩阵

| 接口 | 未登录 | 普通用户 | 管理员 |
|------|--------|---------|--------|
| POST /api/auth/login | ✅ | ✅ | ✅ |
| GET /api/users/me | ❌ 401 | ✅ 自己 | ✅ |
| GET /api/users | ❌ 401 | ❌ 403 | ✅ |
| DELETE /api/users/:id | ❌ 401 | ❌ 403 | ✅ |
| GET /api/orders | ❌ 401 | ✅ 自己的 | ✅ 全部 |

### 七、已有测试覆盖

| 模块 | 单元测试 | 接口测试 | E2E测试 | 覆盖率估算 | 风险 |
|------|---------|---------|---------|-----------|------|
| 用户认证 | ✅ 70% | ✅ 部分 | ❌ | 50% | 中 |
| 订单管理 | ❌ | ❌ | ❌ | 0% | **高** |
| 支付 | ❌ | ❌ | ❌ | 0% | **高** |
| 商品管理 | ✅ 80% | ✅ 部分 | ❌ | 60% | 低 |

### 八、测试建议

**高风险模块（优先测试）**:
- 订单管理：0%覆盖，涉及资金，必须测试
- 支付：0%覆盖，涉及资金安全

**中风险模块**:
- 用户认证：部分覆盖，但涉及安全，需补全

**测试范围建议**:
- 必须测试: 订单创建流程、支付流程、权限控制
- 应该测试: 用户注册登录、状态流转
- 可以跳过: 通知推送（低风险）

---

### 九、推荐下一步

→ 执行 `qa/test-case/test-case-design` 基于以上伪 AC 设计测试用例

（如需补充正式需求文档，可执行 `product/requirement/product-requirement-analysis` 基于逆向结果补文档）
```

---

## 与正常流程的对比

```
正常流程（有文档）:
  需求文档 → qa-context-first → test-case-design → test-executor

半路介入（无文档）:
  代码 → qa-context-from-code（本技能）→ test-case-design → test-executor
                                        ↓
                              可选：输出伪需求文档 requirement-{feature}-reverse.md
```

---

## 使用场景

### 场景 1: 测试人员中途加入

```
用户: "我要测试这个项目，但没有需求文档"

执行:
1. 扫描项目结构 → 识别模块
2. 提取 API 端点 → 反推功能
3. 提取数据模型 → 反推约束
4. 推导状态流转 → 反推业务规则
5. 分析权限 → 反推角色矩阵
6. 输出逆向分析报告 + 伪 AC
7. → 接入 test-case-design 设计用例
```

### 场景 2: 遗留项目测试

```
用户: "这个老项目从来没写过测试，帮我分析要测什么"

执行:
1. 全模块扫描
2. 重点标注 0% 覆盖的高风险模块
3. 反推所有功能的伪 AC
4. 输出完整逆向报告
5. → 按风险优先级逐步测试
```

### 场景 3: 需求文档过时

```
用户: "需求文档是半年前的，代码已经改了很多"

执行:
1. 读取旧需求文档（如有）
2. 对比代码实现，标注差异
3. 从代码补充新的伪 AC
4. 输出差异报告 + 更新后的测试上下文
```

### 场景 4: 只测某个模块

```
用户: "帮我分析支付模块要测什么"

执行:
1. 只扫描支付相关代码
2. 提取支付 API、状态流转、权限
3. 输出精简的模块测试上下文
4. → 接入 test-case-design
```

---

## 配合 Skills

| 配合技能 | 关系 | 说明 |
|----------|------|------|
| `qa/context/qa-context-first` | 互补 | 有文档时用 qa-context-first，无文档时用本技能 |
| `qa/test-case/test-case-design` | 后续 | 基于本技能产出的伪 AC 设计测试用例 |
| `qa/execution/test-executor` | 后续 | 执行生成的测试用例 |
| `dev/context/dev-context-first` | 参考 | 类似的代码分析思路，但面向开发 |
| `product/requirement/product-requirement-analysis` | 可选后续 | 基于逆向结果补充正式需求文档 |

## 依赖文档

- 无前置文档（本技能用于无文档场景）
- **可选读取**: 如存在 `.opencode/docs/implementation-{feature}.md` 可辅助分析

## 下一步推荐

| 条件 | 推荐技能 |
|------|----------|
| 逆向分析完成 | `qa/test-case/test-case-design` |
| 需要补充正式需求文档 | `product/requirement/product-requirement-analysis` |

## 工具可用
- grep: 搜索路由定义、状态枚举、权限检查、模型定义
- glob: 扫描项目结构、查找测试文件
- read: 读取关键文件的具体实现
- write: 写入逆向分析报告和伪需求文档
