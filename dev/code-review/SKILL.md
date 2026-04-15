---
name: dev-code-review
description: (opencode - Skill) 代码审查 - 代码质量检查/最佳实践审查/安全审查/性能审查
subtask: true
argument-hint: "<代码审查> 或 <代码评审>"
---

# 代码审查 Skill

## 角色

你是资深开发工程师/技术负责人，负责代码审查，确保代码质量、可维护性和安全性。

## 核心能力

### 1. 代码质量检查
- 代码风格一致性
- 命名规范
- 圈复杂度检查
- 重复代码检测
- 代码行数控制

### 2. 最佳实践审查
- 设计模式使用
- 错误处理
- 日志规范
- 性能优化
- 安全编码

### 3. 架构审查
- 模块解耦
- 依赖管理
- 接口设计
- 扩展性考虑

### 4. 测试审查
- 单元测试覆盖
- 测试用例质量
- 边界条件测试
- Mock/Stub 使用

---

## 代码审查清单

### 1. 通用审查项

```markdown
## 代码审查清单 (Checklist)

### 功能正确性
- [ ] 代码实现符合需求文档
- [ ] 边界条件处理完整
- [ ] 异常场景覆盖
- [ ] 并发/竞态条件考虑

### 代码质量
- [ ] 遵循项目代码风格
- [ ] 命名清晰有意义
- [ ] 函数/方法单一职责
- [ ] 无重复代码 (DRY)
- [ ] 圈复杂度 < 10

### 错误处理
- [ ] 所有异常被捕获处理
- [ ] 错误信息清晰有用
- [ ] 无空 catch 块
- [ ] 资源正确释放 (try-finally/using)

### 性能
- [ ] 无 N+1 查询问题
- [ ] 循环内无低效操作
- [ ] 适当使用缓存
- [ ] 大数据量处理优化

### 安全
- [ ] 输入参数校验
- [ ] SQL 注入防护
- [ ] XSS 防护
- [ ] 敏感信息不硬编码
- [ ] 权限校验完整

### 可维护性
- [ ] 代码注释充分
- [ ] 复杂逻辑有说明
- [ ] TODO/FIXME 标注
- [ ] 文档同步更新

### 测试
- [ ] 单元测试覆盖率 > 80%
- [ ] 关键逻辑有测试
- [ ] 边界条件测试
- [ ] 测试用例清晰独立
```

### 2. 前端特定审查项

```markdown
## 前端代码审查清单

### React/Vue 组件
- [ ] 组件职责单一
- [ ] Props 类型定义完整 (TypeScript/PropTypes)
- [ ] 状态管理合理 (避免过度状态)
- [ ] 副作用清理 (useEffect cleanup)
- [ ] 列表渲染使用唯一 key
- [ ] 避免内联函数/对象 (性能)

### 性能优化
- [ ] 图片懒加载
- [ ] 组件懒加载 (Suspense/Lazy)
- [ ] 防抖/节流使用
- [ ] 避免不必要的重渲染
- [ ] 打包体积检查

### 用户体验
- [ ] Loading 状态
- [ ] 错误提示友好
- [ ] 空状态处理
- [ ] 表单验证完整
- [ ] 键盘/无障碍支持

### CSS/样式
- [ ] 样式复用性
- [ ] 响应式适配
- [ ] 避免 !important
- [ ] 颜色/间距统一
```

### 3. 后端特定审查项

```markdown
## 后端代码审查清单

### API 设计
- [ ] RESTful 规范
- [ ] 版本控制
- [ ] 参数校验 (DTO/Schema)
- [ ] 响应格式统一
- [ ] 状态码正确

### 数据库
- [ ] 索引合理使用
- [ ] 无慢查询风险
- [ ] 事务边界正确
- [ ] 连接池配置
- [ ] 迁移脚本完整

### 安全
- [ ] 身份认证
- [ ] 授权校验
- [ ] 密码加密存储
- [ ] 敏感数据脱敏
- [ ] 日志脱敏

### 性能
- [ ] 缓存策略
- [ ] 批量操作
- [ ] 异步处理 (消息队列)
- [ ] 连接复用
```

---

## 自动化检查配置

### 1. ESLint 配置 (TypeScript/JavaScript)

```javascript
// .eslintrc.js
module.exports = {
  env: {
    browser: true,
    es2021: true,
    node: true,
  },
  extends: [
    'eslint:recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:react/recommended',
    'plugin:react-hooks/recommended',
    'prettier',
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaFeatures: {
      jsx: true,
    },
    ecmaVersion: 12,
    sourceType: 'module',
  },
  plugins: ['@typescript-eslint', 'react', 'react-hooks'],
  rules: {
    // 代码质量
    'no-unused-vars': 'off',
    '@typescript-eslint/no-unused-vars': ['error', { argsIgnorePattern: '^_' }],
    'no-console': ['warn', { allow: ['warn', 'error'] }],
    'no-debugger': 'error',
    
    // 最佳实践
    'curly': ['error', 'all'],
    'eqeqeq': ['error', 'always'],
    'no-eval': 'error',
    'no-implied-eval': 'error',
    'no-new-func': 'error',
    
    // React
    'react/react-in-jsx-scope': 'off',
    'react/prop-types': 'off',
    'react-hooks/rules-of-hooks': 'error',
    'react-hooks/exhaustive-deps': 'warn',
    
    // TypeScript
    '@typescript-eslint/explicit-function-return-type': 'warn',
    '@typescript-eslint/no-explicit-any': 'warn',
    '@typescript-eslint/no-non-null-assertion': 'warn',
    
    // 安全
    'no-eval': 'error',
    'no-implied-eval': 'error',
  },
  settings: {
    react: {
      version: 'detect',
    },
  },
};
```

### 2. SonarQube 质量阈

```yaml
# sonar-project.properties
sonar.organization=your-org
sonar.projectKey=your-project

# 源码
sonar.sources=src
sonar.tests=src
sonar.test.inclusions=**/*.test.ts,**/*.spec.ts

# 覆盖率
sonar.javascript.lcov.reportPaths=coverage/lcov.info
sonar.coverage.exclusions=**/*.test.ts,**/*.spec.ts,**/node_modules/**

# 质量阈
sonar.qualitygate.wait=true

# 排除
sonar.exclusions=**/node_modules/**,**/dist/**,**/build/**,**/*.config.js
```

### 3. Pre-commit 检查

```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v4.4.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml
      - id: check-json
      - id: detect-private-key

  - repo: https://github.com/pre-commit/mirrors-eslint
    rev: v8.40.0
    hooks:
      - id: eslint
        types: [file]
        files: \.[jt]sx?$
        args: [--fix]

  - repo: local
    hooks:
      - id: type-check
        name: TypeScript Type Check
        entry: npm run type-check
        language: system
        pass_filenames: false
        types: [typescript]

      - id: test
        name: Run Tests
        entry: npm test
        language: system
        pass_filenames: false
        types: [typescript]
```

### 4. GitHub Actions CI 检查

```yaml
# .github/workflows/code-review.yml
name: Code Review

on:
  pull_request:
    branches: [main, develop]

jobs:
  lint:
    name: Lint
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'
      
      - run: npm ci
      - run: npm run lint
        continue-on-error: true

  type-check:
    name: Type Check
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'
      
      - run: npm ci
      - run: npm run type-check

  test:
    name: Test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'
      
      - run: npm ci
      - run: npm test -- --coverage
      - uses: codecov/codecov-action@v3

  security:
    name: Security Scan
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'
      
      - run: npm ci
      - run: npm audit --audit-level=moderate
      
      - name: Run Snyk
        uses: snyk/actions/node@master
        env:
          SNYK_TOKEN: ${{ secrets.SNYK_TOKEN }}

  sonarqube:
    name: SonarQube
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
        with:
          fetch-depth: 0
      
      - uses: sonarsource/sonarqube-scan-action@master
        env:
          SONAR_TOKEN: ${{ secrets.SONAR_TOKEN }}
          SONAR_HOST_URL: ${{ secrets.SONAR_HOST_URL }}
```

---

## 语言特定最佳实践

### TypeScript

```typescript
// ✅ Good: 明确类型
interface User {
  id: string;
  name: string;
  email: string;
}

async function getUser(id: string): Promise<User> {
  const response = await fetch(`/api/users/${id}`);
  if (!response.ok) {
    throw new Error(`Failed to fetch user: ${response.status}`);
  }
  return response.json();
}

// ❌ Bad: 使用 any
async function getUser(id: any): Promise<any> {
  const user: any = await api.get(id);
  return user;
}
```

### Python

```python
# ✅ Good: 类型注解、异常处理
from typing import Optional, List
from dataclasses import dataclass

@dataclass
class User:
    id: str
    name: str
    email: str

def get_user(user_id: str) -> Optional[User]:
    try:
        response = requests.get(f"/api/users/{user_id}")
        response.raise_for_status()
        data = response.json()
        return User(**data)
    except requests.RequestException as e:
        logger.error(f"Failed to fetch user: {e}")
        return None

# ❌ Bad: 无类型、裸异常
def get_user(id):
    try:
        r = requests.get(f"/api/users/{id}")
        data = r.json()
        return data
    except:
        return None
```

### Java

```java
// ✅ Good: Optional、Stream API
public Optional<User> getUserById(String id) {
    return userRepository.findById(id)
        .map(user -> UserDTO.fromEntity(user))
        .filter(dto -> dto.isActive());
}

public List<String> getActiveUserEmails(List<User> users) {
    return users.stream()
        .filter(User::isActive)
        .map(User::getEmail)
        .collect(Collectors.toList());
}

// ❌ Bad: null 检查、命令式
public User getUserById(String id) {
    User user = userRepository.findById(id);
    if (user != null) {
        return user;
    }
    return null;
}
```

---

## 代码审查输出格式

### 1. 审查报告模板

```markdown
## 代码审查报告

### 基本信息
- **PR**: #123 - 用户登录功能
- **作者**: @张三
- **审查人**: @李四
- **审查日期**: 2024-03-10
- **审查时长**: 45 分钟

### 审查摘要
| 类别 | 问题数 | 已修复 | 待修复 |
|------|--------|--------|--------|
| 🔴 严重 | 2 | 1 | 1 |
| 🟡 警告 | 5 | 3 | 2 |
| 🟢 建议 | 8 | 5 | 3 |

### 严重问题 (必须修复)
| # | 文件 | 行号 | 问题描述 | 建议修复 | 状态 |
|---|------|------|----------|----------|------|
| 1 | src/auth/login.ts | 45 | 密码未加密传输 | 使用 HTTPS + 前端加密 | ⏳ 待修复 |
| 2 | src/db/user.ts | 23 | SQL 注入风险 | 使用参数化查询 | ✅ 已修复 |

### 警告问题 (建议修复)
| # | 文件 | 行号 | 问题描述 | 建议修复 | 状态 |
|---|------|------|----------|----------|------|
| 1 | src/utils/helper.ts | 12-45 | 函数过长 (80 行) | 拆分为多个小函数 | ✅ 已修复 |
| 2 | src/api/user.ts | 67 | 缺少错误处理 | 添加 try-catch | ⏳ 待修复 |

### 代码建议 (可选优化)
1. **性能**: 列表渲染添加虚拟滚动 (大数据量场景)
2. **可读性**: 复杂正则添加注释说明
3. **测试**: 添加边界条件测试用例

### 自动化检查
```
✅ ESLint: 通过 (0 errors, 3 warnings)
✅ TypeScript: 通过
✅ 单元测试: 通过 (覆盖率 85%)
⚠️  SonarQube: 需要改进 (代码重复率 8%)
✅ 安全扫描: 通过
```

### 审查结论
- [ ] ✅ **批准合并** - 无严重问题，可合并
- [ ] ⚠️ **有条件批准** - 修复警告后可合并
- [ ] ❌ **需要修改** - 修复严重问题后重新审查

### 后续行动
- [ ] 修复严重问题 (1 项)
- [ ] 修复警告问题 (2 项)
- [ ] 补充测试用例
- [ ] 更新文档
```

### 2. 快速审查反馈

```markdown
## 快速审查反馈

### ✅ 做得好的
- 代码结构清晰，职责分离
- 错误处理完整
- 测试覆盖充分

### ⚠️ 需要改进
1. `src/auth/login.ts:45` - 密码明文传输，建议前端加密
2. `src/api/user.ts:67` - 缺少 try-catch 错误处理

### 💡 建议
- 考虑添加防暴力破解机制
- 建议添加登录日志

**结论**: ⚠️ 修复上述问题后可合并
```

---

## 审查工具集成

### 1. Reviewdog (自动化审查)

```yaml
# .github/workflows/reviewdog.yml
name: Reviewdog

on:
  pull_request:
    branches: [main, develop]

jobs:
  eslint:
    name: ESLint Review
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: '18'
          cache: 'npm'
      
      - run: npm ci
      - run: npm run lint -f checkstyle | \
          npx reviewdog -f=checkstyle -name="eslint" \
          -reporter=github-pr-review -filter-mode=nofilter
        env:
          REVIEWDOG_GITHUB_API_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### 2. Codecov (覆盖率检查)

```yaml
# codecov.yml
coverage:
  status:
    project:
      default:
        target: 80%
        threshold: 5%
    patch:
      default:
        target: 80%
        threshold: 5%

comment:
  layout: "reach, diff, flags, files"
  behavior: default
  require_changes: false
```

---

## 触发词

代码审查、Code Review、CR、代码检查、代码评审、代码质量、Review
