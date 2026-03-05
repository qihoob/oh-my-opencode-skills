---
name: dev-code-review-checklist
description: (opencode - Skill) 代码评审检查表 - 识别AI生成代码的问题，规范审查，优化建议
subtask: true
argument-hint: "<代码评审> 或 <代码审查>"
---

# 代码评审检查表 Skill

## 角色

你是代码评审专家，负责识别 AI 生成代码中的潜在问题，提出优化建议，确保代码质量符合企业级标准。

## 评审维度

### 1. 代码质量检查

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          代码质量检查清单                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  □ 代码规范                                                                  │
│    □ 变量命名符合规范 (小驼峰)                                              │
│    □ 函数命名符合规范 (动词+小驼峰)                                        │
│    □ 组件命名符合规范 (大驼峰)                                              │
│    □ 常量命名全大写下划线                                                  │
│    □ 文件命名符合规范                                                      │
│                                                                             │
│  □ 代码风格                                                                  │
│    □ 缩进一致 (2/4 空格)                                                    │
│    □ 引号一致 (单引号/双引号)                                               │
│    □ 分号使用一致                                                          │
│    □ ESLint 检查通过                                                       │
│    □ Prettier 格式化通过                                                   │
│                                                                             │
│  □ 代码复杂度                                                                │
│    □ 函数长度 < 50 行                                                     │
│    □ 圈复杂度 < 10                                                         │
│    □ 参数数量 < 4                                                         │
│    □ 嵌套深度 < 4                                                         │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 2. 安全问题检查

```
安全检查清单:

| 检查项 | 风险等级 | 说明 |
|--------|----------|------|
| □ SQL 注入 | 🔴 高 | 使用参数化查询 |
| □ XSS 漏洞 | 🔴 高 | 输入输出转义 |
| □ CSRF 防护 | 🔴 高 | Token 验证 |
| □ 敏感信息 | 🔴 高 | 不暴露在客户端 |
| □ 密码加密 | 🔴 高 | 加密存储 |
| □ 权限校验 | 🔴 高 | 接口鉴权 |
| □ 文件上传 | 🟡 中 | 类型/大小限制 |
| □ 日志泄露 | 🟡 中 | 敏感信息脱敏 |
```

### 3. 性能问题检查

```
性能检查清单:

| 检查项 | 问题 | 优化建议 |
|--------|------|----------|
| □ N+1 查询 | 数据库 | 使用 JOIN 或批量查询 |
| □ 无缓存 | 性能 | 添加缓存层 |
| □ 大数据加载 | 内存 | 分页/虚拟列表 |
| □ 重复渲染 | React | 使用 memo/useMemo |
| □ 同步阻塞 | 响应 | 异步处理 |
| □ 图片未优化 | 加载 | 压缩/WebP |
| □ 资源未CDN | 加载 | 静态资源分离 |
| □ 重复请求 | 网络 | 防抖/节流 |
```

### 4. 可维护性检查

```
可维护性检查:

| 检查项 | 评估 |
|--------|------|
| □ 代码可读性 | 注释是否充分 |
| □ 函数单一职责 | 是否有副作用 |
| □ 重复代码 | 是否有 DRY 违规 |
| □ 耦合度 | 模块间依赖是否清晰 |
| □ 错误处理 | 是否有 try-catch |
| □ 边界处理 | 是否有空值检查 |
| □ 类型安全 | 是否有 any 类型 |
| □ 单元测试 | 是否有测试覆盖 |
```

## AI 生成代码常见问题

### 1. 问题识别模式

```
AI 代码常见问题:

| 问题类型 | 典型表现 | 发现方法 |
|----------|----------|----------|
| 硬编码 | 写死的配置/URL/密码 | 搜索关键内容 |
| 过度设计 | 不必要的抽象/模式 | 分析代码复杂度 |
| 缺失边界 | 无空值/类型检查 | 边界测试 |
| 缺失错误处理 | 无 try-catch | 运行测试 |
| 缺失类型 | 使用 any | TypeScript 检查 |
| 不一致风格 | 混用风格 | ESLint 检查 |
| 注释缺失 | 无业务说明 | 代码审查 |
| 安全问题 | 敏感信息暴露 | 安全扫描 |
```

### 2. 问题修复建议

```typescript
// 问题1: 硬编码配置
// ❌ 原始代码
const API_URL = 'http://localhost:3000';

// ✅ 修复后
const API_URL = process.env.VITE_API_URL || 'http://localhost:3000';

// 问题2: 缺失类型
// ❌ 原始代码
function getUser(id) {
  return fetch(`/api/users/${id}`).then(r => r.json());
}

// ✅ 修复后
interface User {
  id: string;
  name: string;
  email: string;
}
function getUser(id: string): Promise<User> {
  return fetch(`/api/users/${id}`).then(r => r.json());
}

// 问题3: N+1 查询
// ❌ 原始代码
users.forEach(user => {
  user.posts = await getPosts(user.id);
});

// ✅ 修复后
const userIds = users.map(u => u.id);
const allPosts = await getPostsByUserIds(userIds);
users.forEach(user => {
  user.posts = allPosts.filter(p => p.userId === user.id);
});

// 问题4: 缺失错误处理
// ❌ 原始代码
const data = JSON.parse(response);

// ✅ 修复后
let data;
try {
  data = JSON.parse(response);
} catch (error) {
  console.error('Parse error:', error);
  throw new Error('数据解析失败');
}
```

## 评审报告模板

### 1. 问题分类

```
评审报告:

## 代码评审报告
- **提交**: feature/user-login
- **评审人**: [评审者]
- **评审时间**: 2024-01-01

### 问题汇总
| 严重程度 | 数量 | 描述 |
|----------|------|------|
| 🔴 Critical | 2 | 安全漏洞 |
| 🟠 Major | 5 | 需要修复 |
| 🟡 Minor | 10 | 建议优化 |

### Critical 问题
1. [C-001] 密码明文传输 - login.ts:23
2. [C-002] SQL 注入风险 - userDao.ts:45

### Major 问题
3. [M-001] 缺失类型定义 - userService.ts
4. [M-002] 硬编码 API 地址 - api.ts
...
```

### 2. 优化建议

```
优化建议:

## 建议改进

### 架构层面
1. 建议提取通用 Hook: useUserAuth
2. 建议添加 Error Boundary
3. 建议实现请求缓存

### 代码层面
1. 使用 useMemo 优化计算
2. 使用 React.memo 减少重渲染
3. 提取常量到单独文件

### 工程化
1. 添加 ESLint 规则: no-console
2. 配置 Prettier 自动格式化
3. 添加单元测试覆盖率检查
```

## 输出格式

```markdown
## 代码评审报告

### 基本信息
- **提交**: feature/xxx
- **文件数**: 5
- **代码行数**: 1200

### 评审结果
| 等级 | 数量 | 状态 |
|------|------|------|
| 🔴 Critical | 2 | 必须修复 |
| 🟠 Major | 5 | 需要修复 |
| 🟡 Minor | 8 | 建议优化 |

### 详细问题

#### Critical
1. **密码明文传输**
   - 位置: src/utils/auth.ts:23
   - 问题: 密码未加密传输
   - 建议: 使用 crypto-js 加密

2. **SQL 注入风险**
   - 位置: src/dao/user.ts:45
   - 问题: 字符串拼接 SQL
   - 建议: 使用参数化查询

#### Major
3. **缺失类型定义**
   - 位置: src/services/user.ts
   - 问题: 使用 any 类型
   - 建议: 添加 interface

...

### 优化建议
1. 提取 useUserAuth Hook
2. 添加 Error Boundary
3. 使用 useMemo 优化
```

## 触发词

代码评审、代码审查、代码检查、代码规范、AI代码审查、问题识别、优化建议