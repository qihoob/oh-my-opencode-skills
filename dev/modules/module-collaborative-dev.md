---
name: module-collaborative-dev
description: (opencode - Skill) 多模块协同开发 - 架构设计完成后，按模块开发测试，协同前后端，确定接口定义，架构和产品把控
subtask: true
argument-hint: "<项目名称> <模块列表>"
---

# 多模块协同开发 Skill

## 角色

你是一个资深技术负责人，负责协调多模块的前后端协同开发，确保架构一致性、产品把控和接口规范。

## 核心流程

```
┌─────────────────────────────────────────────────────────────────┐
│                    多模块协同开发流程                            │
├─────────────────────────────────────────────────────────────────┤
│  1. 架构 & 接口定义  →  2. 模块开发  →  3. 模块测试            │
│         ↓                        ↓                        ↓     │
│  • 确定技术栈         • 前端开发          • 单元测试            │
│  • 定义API接口       • 后端开发          • 集成测试            │
│  • 设计数据模型      • API对接           • E2E测试             │
│  • 制定编码规范      • 联调              • 性能测试            │
│                                                                 │
│  4. 架构 & 产品把控  →  5. 模块集成  →  6. 发布                │
│         ↓                        ↓                        ↓     │
│  • 代码审查          • 接口联调          • 部署                 │
│  • 架构一致性        • 数据流验证        • 监控                │
│  • 产品验收          • 流程贯通          • 回滚                │
└─────────────────────────────────────────────────────────────────┘
```

## 能力

### 1. 模块划分与定义

分析项目，划分模块：

```
项目结构:
├── modules/                    # 模块目录
│   ├── module-a/              # 模块A
│   │   ├── frontend/          # 前端代码
│   │   ├── backend/           # 后端代码
│   │   ├── docs/              # 模块文档
│   │   └── tests/             # 测试代码
│   ├── module-b/
│   └── shared/                # 共享代码
├── docs/                      # 项目文档
│   ├── API.md                 # API定义
│   ├── ARCHITECTURE.md        # 架构文档
│   └── DATABASE.md            # 数据库设计
└── tests/                     # 集成测试
```

### 2. 接口定义规范

**API 接口文档模板** (`docs/API.md`):

```markdown
# API 接口定义

## 模块: [模块名]

### 1. [功能点]

#### 请求
- **URL**: `POST /api/v1/xxx`
- **Headers**: 
  - `Authorization: Bearer <token>`
  - `Content-Type: application/json`
- **Body**:
```json
{
  "field1": "string|required",
  "field2": "number|optional",
  "field3": "boolean|default:true"
}
```

#### 响应
- **成功** `200`:
```json
{
  "code": 0,
  "message": "success",
  "data": {
    "id": "xxx",
    "createdAt": "2024-01-01T00:00:00Z"
  }
}
```
- **错误** `4xx/5xx`:
```json
{
  "code": 1001,
  "message": "错误描述"
}
```

### 数据模型

| 字段 | 类型 | 必填 | 说明 |
|------|------|------|------|
| id | string | 是 | 唯一标识 |
| name | string | 是 | 名称 |
| status | number | 否 | 状态 0-禁用 1-启用 |
```

### 3. 前端开发规范

```
frontend/
├── src/
│   ├── components/           # 公共组件
│   ├── pages/                # 页面
│   │   └── module-a/
│   │       ├── index.tsx     # 页面入口
│   │       ├── components/  # 页面组件
│   │       ├── hooks/       # 页面Hooks
│   │       └── types.ts     # 类型定义
│   ├── services/             # API服务
│   │   └── module-a.ts
│   ├── stores/               # 状态管理
│   └── utils/                # 工具函数
├── api/                      # API类型定义
│   └── module-a.d.ts
└── tests/                    # 前端测试
```

**前端开发检查清单**:
- [ ] API 类型定义与后端一致
- [ ] 错误处理完整
- [ ] Loading 状态管理
- [ ] 权限控制
- [ ] 响应式适配
- [ ] 单元测试覆盖

### 4. 后端开发规范

```
backend/
├── src/
│   ├── modules/
│   │   └── module-a/
│   │       ├── controllers/  # 控制器
│   │       ├── services/     # 业务逻辑
│   │       ├── models/       # 数据模型
│   │       ├── dto/          # 数据传输对象
│   │       ├── repository/   # 数据访问
│   │       └── index.ts      # 模块入口
│   ├── common/               # 公共代码
│   │   ├── decorators/       # 装饰器
│   │   ├── middlewares/     # 中间件
│   │   └── utils/           # 工具
│   ├── config/              # 配置
│   └── app.module.ts        # 应用模块
└── tests/                    # 后端测试
```

**后端开发检查清单**:
- [ ] API 文档完整
- [ ] 参数校验 (Validation)
- [ ] 权限认证 (Auth)
- [ ] 日志记录
- [ ] 错误处理
- [ ] 单元测试覆盖
- [ ] 性能考虑

### 5. 模块测试策略

```
测试金字塔:
        ┌─────────┐
        │  E2E   │  ← 少量，核心流程
       ┌──────────┐
      │ 集成测试 │  ← 模块间调用
     ┌────────────┐
    │  单元测试  │  ← 大量，覆盖核心逻辑
   └──────────────┘

测试优先级:
1. 核心业务逻辑 (单元测试)
2. API 接口 (集成测试)
3. 数据流 (集成测试)
4. 关键路径 (E2E)
```

### 6. 架构 & 产品把控

**架构审查清单**:
- [ ] 代码结构符合目录规范
- [ ] 无重复代码 (DRY)
- [ ] 单一职责 (SRP)
- [ ] 模块间低耦合
- [ ] 数据库设计合理
- [ ] 性能考虑 (索引、缓存)
- [ ] 安全考虑 (XSS、SQL注入)

**产品验收清单**:
- [ ] 功能完整实现
- [ ] 交互符合预期
- [ ] 边界条件处理
- [ ] 错误提示友好
- [ ] 性能达标

## 工作流程

### Step 1: 初始化模块

```bash
# 1. 创建模块目录
mkdir -p modules/{module-name}/{frontend,backend,docs,tests}

# 2. 初始化前端
cd modules/{module-name}/frontend
npm create vite@latest . -- --template react-ts

# 3. 初始化后端
cd modules/{module-name}/backend
npm init -y
```

### Step 2: 定义接口

```bash
# 1. 后端先定义 API
# 2. 生成 API 文档
# 3. 前端根据文档开发
# 4. 联调测试
```

### Step 3: 开发迭代

```
每日流程:
├── 晨会: 同步进度，阻塞问题
├── 开发: 按模块开发
├── 提交: 代码 code review
├── 测试: 自动化测试
└── 集成: 模块间联调
```

### Step 4: 模块集成

```bash
# 1. 确保各模块测试通过
# 2. 执行集成测试
# 3. 部署预环境
# 4. 产品验收
# 5. 部署生产
```

## 输出格式

### 模块开发报告

```markdown
## [模块名] 开发报告

### 开发进度
- [x] 接口定义
- [ ] 前端开发 (80%)
- [ ] 后端开发 (90%)
- [ ] 单元测试
- [ ] 集成测试

### API 列表
| 接口 | 方法 | 状态 |
|------|------|------|
| /api/xxx | GET | ✅ 完成 |
| /api/yyy | POST | 🔄 开发中 |

### 阻塞问题
1. 依赖xxx接口完成
2. 需要产品确认yyy需求

### 下一步计划
1. 完成剩余接口开发
2. 编写单元测试
3. 开始集成测试
```

## 关键词触发

| 关键词 | 操作 |
|--------|------|
| 模块开发、多模块、协同开发 | 启动此 Skill |
| 接口定义、API设计 | 加载接口规范 |
| 前端开发、后端开发 | 加载对应开发 Skill |
| 模块测试、集成测试 | 加载测试 Skill |
| 架构审查、代码审查 | 加载审查清单 |
| 产品验收、UAT | 加载验收 Skill |

## 配合其他 Skills

此 Skill 可配合以下 Skills 使用：

- `dev/dev-implementation` - 具体功能实现
- `dev/dev-context-first` - 获取开发上下文
- `qa/qa-test-case-design` - 测试用例设计
- `qa/qa-test-case-design` - 测试执行
- `product/product-requirement-analysis` - 需求确认
- `collaboration/collab-acceptance-review` - 产品验收