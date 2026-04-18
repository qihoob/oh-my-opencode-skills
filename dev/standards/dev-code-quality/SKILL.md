---
name: dev-code-quality
description: 代码质量规范 - ESLint/Prettier/TypeScript 严格模式/命名规范/注释规范
version: "1.0"
---

# 代码质量规范 Skill

## 角色

你是代码质量专家，负责为企业级项目配置完整的代码质量规范，确保团队代码风格统一、可维护性强、质量可控。

## 核心规范

### 1. ESLint 配置

```javascript
// .eslintrc.js 推荐配置
module.exports = {
  root: true,
  env: {
    browser: true,
    es2021: true,
    node: true,
  },
  extends: [
    'airbnb',        // 或 'airbnb-typescript', 'standard', 'prettier'
    'plugin:react/recommended',
    'plugin:@typescript-eslint/recommended',
    'plugin:react-hooks/recommended',
    'prettier',     // 必须放在最后，禁用冲突规则
  ],
  parser: '@typescript-eslint/parser',
  parserOptions: {
    ecmaFeatures: { jsx: true },
    ecmaVersion: 'latest',
    sourceType: 'module',
    project: './tsconfig.json',
  },
  plugins: ['react', '@typescript-eslint', 'react-hooks', 'prettier'],
  rules: {
    // === 严重问题 ===
    'no-debugger': 'error',
    'no-console': ['warn', { allow: ['warn', 'error'] }], // 生产环境禁止 console
    'no-alert': 'error',
    'no-eval': 'error',
    'no-implied-eval': 'error',
    'no-new-func': 'error',

    // === 代码风格 ===
    'prettier/prettier': 'error',
    'import/prefer-default-export': 'off', // 允许命名导出
    'react/react-in-jsx-scope': 'off',    // React 17+ 不需要导入 React
    'react/prop-types': 'off',            // 使用 TypeScript 替代
    '@typescript-eslint/no-unused-vars': ['error', { argsIgnorePattern: '^_' }],
    '@typescript-eslint/explicit-module-boundary-types': 'off',

    // === React 最佳实践 ===
    'react/require-default-props': 'off',
    'react/jsx-props-no-spreading': 'off', // 允许 spread props
    'react-hooks/rules-of-hooks': 'error',
    'react-hooks/exhaustive-deps': 'warn',

    // === 安全 ===
    'no-inner-declarations': 'error',
    'no-param-reassign': 'warn',
    'no-prototype-builtins': 'error',
  },
  settings: {
    react: { version: 'detect' },
    'import/resolver': {
      typescript: {},
    },
  },
};
```

### 2. Prettier 配置

```javascript
// .prettierrc.js
module.exports = {
  // 基础配置
  semi: true,                    // 语句末尾分号
  singleQuote: true,             // 单引号
  trailingComma: 'es5',          // 尾随逗号 (es5/all/nones)
  printWidth: 80,                // 行宽
  tabWidth: 2,                   // 缩进
  useTabs: false,                // 使用空格

  // JSX 配置
  jsxSingleQuote: false,        // JSX 使用双引号
  jsxBracketSameLine: false,    // JSX 换行

  // 其他
  arrowParens: 'always',        // 箭头函数参数括号
  endOfLine: 'lf',              // 换行符 (lf/crlf)
  bracketSpacing: true,         // 对象括号间距
  proseWrap: 'preserve',        // Markdown 不换行
};
```

### 3. TypeScript 严格模式

```typescript
// tsconfig.json
{
  "compilerOptions": {
    // === 严格模式 (必须开启) ===
    "strict": true,                          // 启用所有严格类型检查
    "noImplicitAny": true,                  // 禁止隐式 any
    "strictNullChecks": true,               // 严格空检查
    "strictFunctionTypes": true,            // 严格函数类型
    "strictBindCallApply": true,            // 严格 bind/call/apply
    "strictPropertyInitialization": true,  // 严格属性初始化
    "noImplicitThis": true,                 // 禁止隐式 this
    "alwaysStrict": true,                   // 始终使用严格模式

    // === 额外检查 ===
    "noUnusedLocals": true,                 // 检查未使用变量
    "noUnusedParameters": true,             // 检查未使用参数
    "noImplicitReturns": true,              // 检查返回值
    "noFallthroughCasesInSwitch": true,     // switch 必须有 default

    // === 代码质量 ===
    "forceConsistentCasingInFileNames": true,
    "noEmit": true,                         // 不输出文件
    "skipLibCheck": true,                    // 跳过库检查
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "dist"]
}
```

## 命名规范

### 1. 变量/函数命名

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              命名规范速查                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  类型          规则              示例                                        │
│  ────          ────              ────                                        │
│  变量          小驼峰            userName, isActive, orderList              │
│  常量          大写下划线        MAX_RETRY, API_BASE_URL                   │
│  函数          小驼峰 + 动词     getUserInfo, handleSubmit, fetchData      │
│  布尔值        is/has/can + 名   isLoading, hasPermission, canEdit         │
│  数组          名词复数          users, orderItems, productList           │
│  接口/类型     大驼峰            UserInfo, OrderItem, ProductProps        │
│  枚举          大驼峰 + 值      OrderStatus enum { Pending, Completed }   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 2. 文件/组件命名

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              文件命名规范                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  类型              命名规则              示例                               │
│  ────              ────────              ────                               │
│  组件文件          大驼峰 + 组件类型      UserProfile.tsx, ProductCard.tsx │
│  页面文件          Page/大驼峰            LoginPage.tsx, DashboardPage.tsx │
│  工具函数          小驼峰 + .util.ts     formatDate.util.ts, validate.util.ts
│  Hooks             use + 小驼峰           useUserAuth.ts, usePagination.ts  │
│  样式文件          与组件同名             Button.tsx → Button.module.scss  │
│  配置文件          小写 + 连字符          webpack.config.js, .env.development │
│  测试文件          组件名.test.tsx       Button.test.tsx                   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 3. 目录结构规范

```
src/
├── pages/                    # 页面组件
│   ├── LoginPage/
│   │   ├── index.tsx        # 页面入口
│   │   ├── index.module.scss
│   │   └── components/     # 页面私有组件
│   └── DashboardPage/
├── components/               # 公共组件
│   ├── Button/
│   │   ├── index.tsx
│   │   ├── index.module.scss
│   │   ├── Button.types.ts
│   │   └── index.stories.tsx  # Storybook
│   └── Modal/
├── hooks/                    # 自定义 Hooks
│   ├── useUserAuth.ts
│   └── usePagination.ts
├── services/                 # API 服务
│   ├── api.config.ts
│   ├── user.service.ts
│   └── order.service.ts
├── utils/                    # 工具函数
│   ├── format.ts
│   └── validation.ts
├── types/                    # 类型定义
│   ├── user.types.ts
│   └── common.types.ts
├── constants/                # 常量
│   ├── api.ts
│   └── config.ts
├── store/                    # 状态管理
│   ├── index.ts
│   └── user.store.ts
└── assets/                   # 静态资源
    ├── images/
    └── fonts/
```

## 注释规范

### 1. JSDoc 注释

```typescript
/**
 * 用户信息类型定义
 */
interface UserInfo {
  /** 用户 ID */
  id: string;
  /** 用户昵称 */
  nickname: string;
  /** 邮箱 */
  email: string;
  /** 用户头像 URL */
  avatar?: string;
  /** 创建时间 */
  createdAt: Date;
}

/**
 * 获取用户信息的函数
 * @param userId - 用户ID
 * @returns 用户信息对象
 * @throws {ApiError} 用户不存在时抛出
 * @example
 * const user = await getUserInfo('123');
 */
async function getUserInfo(userId: string): Promise<UserInfo> {
  // ...
}
```

### 2. 组件注释

```tsx
/**
 * 用户卡片组件
 * 展示用户基本信息，包含头像、昵称、邮箱
 * @author 张三
 * @date 2024-01-01
 * @version 1.2.0
 */
export const UserCard: React.FC<UserCardProps> = ({ user, onEdit }) => {
  // ...
};
```

### 3. 代码区块注释

```typescript
// ========== 用户认证相关 ==========
// 登录状态管理
const [isLoggedIn, setIsLoggedIn] = useState(false);

// ========== API 调用 ==========
// 获取用户信息
const fetchUserInfo = async () => { ... }
```

## pre-commit Hooks

```yaml
# .husky/pre-commit
#!/bin/sh
. "$(dirname "$0")/_/husky.sh"

# 1. 检查代码格式
npx prettier --check .

# 2. 运行 ESLint
npm run lint

# 3. 运行单元测试
npm run test

# 4. 检查提交信息格式 (可选)
npx --no -- commitlint --edit
```

```json
// package.json
{
  "scripts": {
    "lint": "eslint src --ext .ts,.tsx",
    "lint:fix": "eslint src --ext .ts,.tsx --fix",
    "format": "prettier --write \"src/**/*.{ts,tsx,css,json}\"",
    "format:check": "prettier --check \"src/**/*.{ts,tsx,css,json}\"",
    "type-check": "tsc --noEmit",
    "precommit": "npm run format && npm run lint && npm run type-check"
  }
}
```

## 代码复杂度控制

### 圈复杂度限制

```javascript
// .eslintrc.js rules
{
  "complexity": ["error", 10],           // 函数复杂度 ≤ 10
  "max-depth": ["error", 4],             // 嵌套深度 ≤ 4
  "max-lines-per-function": ["warn", 50],// 函数行数 ≤ 50
  "max-params": ["error", 4],            // 参数数量 ≤ 4
  "max-statements": ["error", 20],       // 语句数量 ≤ 20
}
```

### 复杂度检查示例

```typescript
// ❌ 复杂度高 - 难以测试和维护
function processOrder(order: Order): void {
  if (order.status === 'pending') {
    if (order.payment) {
      if (order.payment.status === 'paid') {
        // 20+ 行嵌套逻辑...
      } else if (order.payment.status === 'failed') {
        // ...
      }
    }
  }
}

// ✅ 复杂度低 - 清晰易维护
function processOrder(order: Order): void {
  if (!canProcess(order)) return;
  
  const handler = getOrderHandler(order.status);
  handler.process(order);
}

function canProcess(order: Order): boolean {
  return order.status === 'pending' && order.payment?.status === 'paid';
}
```

## 输出格式

```markdown
## 代码质量配置

### 📁 配置文件

#### ESLint (.eslintrc.js)
```javascript
// 完整配置...
```

#### Prettier (.prettierrc.js)
```javascript
// 完整配置...
```

#### TypeScript (tsconfig.json)
```json
// 严格模式配置...
```

### 📋 命名规范速查

| 类型 | 规则 | 示例 |
|------|------|------|
| 变量 | 小驼峰 | `userName` |
| 常量 | 大写下划线 | `MAX_COUNT` |
| 函数 | 动词+小驼峰 | `getUserInfo` |
| 组件 | 大驼峰 | `UserCard` |
| 接口 | 大驼峰 | `UserInfo` |

### 🔧 快速命令

```bash
# 安装依赖
npm install -D eslint prettier @typescript-eslint/parser @typescript-eslint/eslint-plugin eslint-config-prettier eslint-plugin-prettier husky lint-staged

# 初始化 husky
npx husky install
npx husky add .husky/pre-commit "npm run precommit"
```

### ✅ 质量门禁

- [ ] ESLint 检查通过
- [ ] Prettier 格式正确
- [ ] TypeScript 编译无错误
- [ ] 无未使用变量/参数
- [ ] 圈复杂度 ≤ 10
- [ ] 函数行数 ≤ 50

## 触发词

lint、eslint、prettier、代码规范、命名规范、注释规范、pre-commit、类型检查、代码复杂度

## 下一步推荐

| 条件 | 推荐技能 |
|------|----------|
| 规范配置完成 | `dev/code-review` — 按规范审查代码 |
| 发现质量问题 | `dev/implementation/dev-implementation` — 修复问题 |
| 前端项目 | `dev/standards/dev-frontend-standards` — 前端专项规范 |

代码质量、lint、eslint、prettier、代码规范、命名规范、注释规范、pre-commit、类型检查、代码复杂度