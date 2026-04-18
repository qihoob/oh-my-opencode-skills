---
name: module-dev-context
description: 模块上下文获取 - 深入了解特定模块的代码结构、依赖关系、核心逻辑
version: "1.0"
---

# Skill: module-dev-context

**角色**: 开发 (Dev)
**功能**: 模块上下文获取
**触发关键词**: 模块上下文、了解模块、模块结构、代码梳理

## 产出文档
- **上下文报告（可选持久化）**: `.opencode/docs/context-report-{module}.md`
- 如处于自驱动链路中（chain-executor 执行），必须持久化到文件
- 如为单次交互（用户直接说"了解模块"），可即时输出不写文件

## 核心能力

1. **模块扫描**
   - 识别模块文件组成
   - 分析模块内依赖关系
   - 定位核心函数/类

2. **接口分析**
   - 模块对外暴露的 API
   - 模块依赖的外部服务
   - 数据输入输出格式

3. **逻辑梳理**
   - 核心业务流程
   - 关键算法实现
   - 异常处理机制

## 使用场景

```typescript
// 示例 1: 了解支付模块
"帮我了解一下支付模块的结构"

// 示例 2: 准备修改模块
"我要修改用户模块，先看看代码结构"

// 示例 3: 排查模块问题
"订单模块最近有问题，帮我分析一下"
```

## 输出格式

```markdown
# 模块上下文：{模块名称}

## 模块位置
`src/modules/{module}/`

## 文件组成

| 文件 | 作用 | 行数 |
|------|------|------|
| service.ts | 业务逻辑 | 200 |
| controller.ts | 接口控制 | 100 |
| model.ts | 数据模型 | 80 |

## 核心类/函数

### ClassName
- **位置**: `file.ts:line`
- **职责**: {描述}
- **主要方法**: [method1, method2]

### functionName()
- **位置**: `file.ts:line`
- **作用**: {描述}
- **调用者**: [caller1, caller2]

## 依赖关系

### 内部依赖
- 依赖模块 A: `src/modules/a/`
- 依赖工具库：`src/utils/`

### 外部依赖
- 数据库：MySQL users 表
- 缓存：Redis
- 第三方：Stripe API

## 数据流

```
输入 → [Controller] → [Service] → [Model] → 数据库
                              ↓
                          [Cache]
```

## 注意事项

- ⚠️ {需要注意的地方}
- 🔒 {安全相关逻辑}
- 🐛 {已知问题}
```

## 最小上下文原则

1. **按需深入** - 先扫描结构，再按需读取具体文件
2. **聚焦核心** - 重点关注核心逻辑，不陷入细节
3. **便于后续** - 输出便于实现/修改技能快速上手

## 工具可用
- glob: 扫描模块文件
- read: 读取关键文件
- lsp_symbols: 分析符号定义
- lsp_find_references: 查找引用关系

## 配合 Skills

| 配合技能 | 关系 | 说明 |
|----------|------|------|
| `dev/implementation/dev-implementation` | 后续 | 模块上下文获取后开始实现 |
| `dev/modules/module-splitting` | 前置 | 拆解后了解特定模块 |

## 下一步推荐

| 条件 | 推荐技能 |
|------|----------|
| 模块上下文已获取 | `dev/implementation/dev-implementation` |

