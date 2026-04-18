---
name: e2e-testing
description: E2E测试 - Playwright/Cypress/Page Object/视觉回归/跨浏览器测试，配合 playwright-skill 插件即时执行
version: "2.0"
---

# E2E 测试 Skill

**角色**: 测试 (QA)
**功能**: E2E 测试方案设计（含 Page Object、视觉回归、跨浏览器）
**触发关键词**: E2E测试、端到端测试、Playwright、Cypress、自动化测试、Page Object、视觉回归、跨浏览器测试

## 产出文档
**路径**: `.opencode/docs/e2e-test-plan-{feature}.md`

## 依赖文档
**可选读取**:
- **必须读取**: `.opencode/docs/test-cases-{feature}.md`
- **必须读取**: `.opencode/docs/contract-{feature}.md`

## 运行时工具

本技能配合 **playwright-skill** 插件（已安装到 `~/.claude/skills/playwright-skill/`）即时执行浏览器测试。

| 能力 | 说明 |
|------|------|
| 即时脚本执行 | `node ~/.claude/skills/playwright-skill/run.js <script.js>` |
| 自动检测开发服务器 | `detectDevServers()` 自动发现 localhost 上的 dev server |
| 可见浏览器 | 默认 `headless: false`，可观察操作过程 |
| 脚本写到 /tmp | 不污染项目目录 |
| 15个辅助函数 | safeClick, safeType, takeScreenshot, authenticate 等 |
| 自定义 HTTP 头 | 通过 `PLAYWRIGHT_EXTRA_HEADERS` 环境变量注入 |

详细 API 参考: `~/.claude/skills/playwright-skill/API_REFERENCE.md`

## 测试框架

### 1. Playwright 项目配置

```typescript
// playwright.config.ts
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './tests',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: [
    ['html', { open: 'never' }],
    ['json', { outputFile: 'test-results.json' }],
    ['list'],
  ],

  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
    video: 'retain-on-failure',
  },

  projects: [
    {
      name: 'chromium',
      use: { ...devices['Desktop Chrome'] },
    },
    {
      name: 'firefox',
      use: { ...devices['Desktop Firefox'] },
    },
    {
      name: 'webkit',
      use: { ...devices['Desktop Safari'] },
    },
    // 移动端
    {
      name: 'Mobile Chrome',
      use: { ...devices['Pixel 5'] },
    },
    {
      name: 'Mobile Safari',
      use: { ...devices['iPhone 12'] },
    },
  ],

  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
  },
});
```

### 2. Cypress 项目配置

```javascript
// cypress.config.js
const { defineConfig } = require('cypress');

module.exports = defineConfig({
  e2e: {
    baseUrl: 'http://localhost:3000',
    supportFile: 'cypress/support/e2e.js',
    specPattern: 'cypress/e2e/**/*.cy.{js,jsx,ts,tsx}',

    viewportWidth: 1280,
    viewportHeight: 720,

    video: true,
    videoCompression: 32,
    screenshotOnRunFailure: true,

    defaultCommandTimeout: 10000,
    requestTimeout: 15000,
    responseTimeout: 15000,

    retries: {
      runMode: 2,
      openMode: 0,
    },

    setupNodeEvents(on, config) {
      // 插件配置
      return config;
    },
  },

  component: {
    devServer: {
      framework: 'react',
      bundler: 'webpack',
    },
  },
});
```

## Page Object 模式

### 1. 基础 Page Object

```typescript
// pages/LoginPage.ts
import { Page, Locator, expect } from '@playwright/test';

export class LoginPage {
  readonly page: Page;
  readonly usernameInput: Locator;
  readonly passwordInput: Locator;
  readonly submitButton: Locator;
  readonly errorMessage: Locator;
  readonly rememberMeCheckbox: Locator;

  constructor(page: Page) {
    this.page = page;
    this.usernameInput = page.locator('[data-testid="username-input"]');
    this.passwordInput = page.locator('[data-testid="password-input"]');
    this.submitButton = page.locator('[data-testid="submit-button"]');
    this.errorMessage = page.locator('[data-testid="error-message"]');
    this.rememberMeCheckbox = page.locator('[data-testid="remember-me"]');
  }

  async goto() {
    await this.page.goto('/login');
  }

  async login(username: string, password: string, rememberMe = false) {
    await this.usernameInput.fill(username);
    await this.passwordInput.fill(password);

    if (rememberMe) {
      await this.rememberMeCheckbox.check();
    }

    await this.submitButton.click();
  }

  async expectLoginSuccess() {
    await expect(this.page).toHaveURL('/dashboard');
    await expect(this.page.locator('[data-testid="user-avatar"]')).toBeVisible();
  }

  async expectLoginError(message: string) {
    await expect(this.errorMessage).toContainText(message);
  }
}
```

### 2. 使用 Page Object

```typescript
// tests/login.cy.ts
import { test, expect } from '@playwright/test';
import { LoginPage } from '../pages/LoginPage';

test.describe('登录功能', () => {
  let loginPage: LoginPage;

  test.beforeEach(async ({ page }) => {
    loginPage = new LoginPage(page);
    await loginPage.goto();
  });

  test('正确账号密码登录成功', async () => {
    await loginPage.login('admin', 'password123');
    await loginPage.expectLoginSuccess();
  });

  test('记住密码功能', async () => {
    await loginPage.login('admin', 'password123', true);
    // 验证 cookie 或 localStorage
  });

  test('错误密码显示错误提示', async () => {
    await loginPage.login('admin', 'wrongpassword');
    await loginPage.expectLoginError('用户名或密码错误');
  });

  test('空用户名显示验证错误', async () => {
    await loginPage.login('', 'password123');
    await loginPage.expectLoginError('请输入用户名');
  });
});
```

### 3. 组件测试 Page Object

```typescript
// components/Button.tsx
export class ButtonComponent {
  readonly root: Locator;
  readonly loadingSpinner: Locator;
  readonly text: Locator;

  constructor(root: Locator) {
    this.root = root;
    this.loadingSpinner = root.locator('.ant-spin');
    this.text = root.locator('.ant-btn-text, .ant-btn-content');
  }

  async click() {
    await this.root.click();
  }

  async expectLoading() {
    await expect(this.loadingSpinner).toBeVisible();
    await expect(this.root).toBeDisabled();
  }

  async expectDisabled() {
    await expect(this.root).toBeDisabled();
  }

  async expectText(text: string) {
    await expect(this.text).toHaveText(text);
  }
}
```

## 核心测试场景

### 1. 用户认证流程

```typescript
// tests/auth/login.cy.ts
test.describe('用户登录', () => {
  test('正常登录流程', async ({ page }) => {
    await page.goto('/login');

    // 输入凭证
    await page.fill('[name="username"]', 'testuser@example.com');
    await page.fill('[name="password"]', 'Password123!');
    await page.click('[type="submit"]');

    // 验证跳转
    await expect(page).toHaveURL('/dashboard');

    // 验证用户信息
    await expect(page.locator('.user-name')).toContainText('测试用户');
  });

  test('登录失败 - 错误密码', async ({ page }) => {
    await page.goto('/login');
    await page.fill('[name="username"]', 'test@example.com');
    await page.fill('[name="password"]', 'wrongpassword');
    await page.click('[type="submit"]');

    await expect(page.locator('.ant-message-error')).toBeVisible();
    await expect(page.locator('.ant-message-error')).toContainText('登录失败');
  });

  test('登录失败 - 未注册用户', async ({ page }) => {
    await page.goto('/login');
    await page.fill('[name="username"]', 'nonexistent@example.com');
    await page.fill('[name="password"]', 'password123');
    await page.click('[type="submit"]');

    await expect(page.locator('.ant-form-item-explain-error')).toContainText('用户不存在');
  });

  test('记住我功能', async ({ page }) => {
    await page.goto('/login');
    await page.check('[name="remember"]');
    await page.fill('[name="username"]', 'test@example.com');
    await page.fill('[name="password"]', 'password123');
    await page.click('[type="submit"]');

    // 验证 cookie 存在
    const cookies = await page.context().cookies();
    expect(cookies.find(c => c.name === 'remember_token')).toBeDefined();
  });
});
```

### 2. CRUD 操作测试

```typescript
// tests/crud/user-management.cy.ts
test.describe('用户管理 - CRUD', () => {
  const testUser = {
    name: '测试用户',
    email: `test${Date.now()}@example.com`,
    role: 'user',
  };

  test('创建用户', async ({ page }) => {
    await page.goto('/users');
    await page.click('[data-testid="create-user-btn"]');

    // 填写表单
    await page.fill('[name="name"]', testUser.name);
    await page.fill('[name="email"]', testUser.email);
    await page.selectOption('[name="role"]', testUser.role);
    await page.click('[data-testid="submit-btn"]');

    // 验证成功消息
    await expect(page.locator('.ant-message-success')).toBeVisible();

    // 验证列表中出现新用户
    await expect(page.locator('.user-table')).toContainText(testUser.name);
  });

  test('编辑用户', async ({ page }) => {
    await page.goto('/users');
    await page.click('[data-testid="edit-user-btn"]:first-child');

    await page.fill('[name="name"]', '更新后的名称');
    await page.click('[data-testid="submit-btn"]');

    await expect(page.locator('.ant-message-success')).toContainText('更新成功');
    await expect(page.locator('.user-table')).toContainText('更新后的名称');
  });

  test('删除用户', async ({ page }) => {
    await page.goto('/users');

    // 确认删除弹窗
    await page.click('[data-testid="delete-user-btn"]:first-child');
    await expect(page.locator('.ant-modal')).toBeVisible();
    await page.click('[data-testid="confirm-delete-btn"]');

    await expect(page.locator('.ant-message-success')).toContainText('删除成功');
  });
});
```

## 视觉回归测试

### 1. Playwright 视觉对比

```typescript
// tests/visual/page-screenshots.cy.ts
import { test, expect } from '@playwright/test';

test.describe('视觉回归测试', () => {
  test('登录页视觉', async ({ page }) => {
    await page.goto('/login');
    await expect(page).toHaveScreenshot('login-page.png', {
      maxDiffPixelRatio: 0.1, // 允许 10% 差异
    });
  });

  test('仪表盘视觉', async ({ page }) => {
    await page.goto('/dashboard');
    // 等待数据加载完成
    await page.waitForSelector('.dashboard-loaded');

    await expect(page).toHaveScreenshot('dashboard.png', {
      fullPage: true,
    });
  });

  test('响应式布局', async ({ page }) => {
    const viewports = [
      { width: 1920, height: 1080, name: 'desktop' },
      { width: 1366, height: 768, name: 'laptop' },
      { width: 768, height: 1024, name: 'tablet' },
      { width: 375, height: 667, name: 'mobile' },
    ];

    for (const viewport of viewports) {
      await page.setViewportSize({ width: viewport.width, height: viewport.height });
      await page.goto('/dashboard');
      await expect(page).toHaveScreenshot(`dashboard-${viewport.name}.png`);
    }
  });
});
```

### 2. Percy 集成

```typescript
// tests/visual/percy.cy.ts
import { percySnapshot } from '@percy/playwright';

test('视觉快照测试', async ({ page }) => {
  await page.goto('/dashboard');
  await percySnapshot(page, 'Dashboard Page');

  // 登录后
  await page.goto('/login');
  await page.fill('[name="username"]', 'admin');
  await page.fill('[name="password"]', 'password');
  await page.click('[type="submit"]');
  await percySnapshot(page, 'Dashboard - Logged In');
});
```

## 跨浏览器测试

```typescript
// 多浏览器配置
export const testConfig = {
  projects: [
    {
      name: 'Chrome',
      use: { browserName: 'chromium' },
    },
    {
      name: 'Firefox',
      use: { browserName: 'firefox' },
    },
    {
      name: 'Safari',
      use: { browserName: 'webkit' },
    },
    {
      name: 'Edge',
      use: { browserName: 'chromium', channel: 'msedge' },
    },
  ],
};

// 测试用例
test('表单提交 - 跨浏览器', async ({ page }) => {
  await page.goto('/form');
  await page.fill('[name="email"]', 'test@example.com');
  await page.click('[type="submit"]');

  // 所有浏览器都应该成功
  await expect(page.locator('.success-message')).toBeVisible();
});
```

## 测试数据管理

### 1. Fixture 定义

```typescript
// fixtures/user.fixture.ts
import { test as base } from '@playwright/test';

export const test = base.extend({
  // 创建测试用户
  testUser: async ({ request }, use) => {
    const user = await request.post('/api/users', {
      data: {
        name: 'Test User',
        email: `test${Date.now()}@example.com`,
        role: 'user',
      },
    });

    const userData = await user.json();

    await use(userData);

    // 清理
    await request.delete(`/api/users/${userData.id}`);
  },

  // 登录用户
  loggedInUser: async ({ page, testUser }, use) => {
    await page.goto('/login');
    await page.fill('[name="email"]', testUser.email);
    await page.fill('[name="password"]', 'password');
    await page.click('[type="submit"]');

    await use(testUser);
  },
});
```

### 2. 动态测试数据

```typescript
// utils/test-data.ts
import { faker } from '@faker-js/faker';

export const generateUser = () => ({
  name: faker.person.fullName(),
  email: faker.internet.email(),
  phone: faker.phone.number(),
  address: faker.location.streetAddress(),
  company: faker.company.name(),
});

export const generateOrder = (userId: string) => ({
  userId,
  items: Array.from({ length: faker.number.int({ min: 1, max: 5 }) }, () => ({
    productId: faker.string.uuid(),
    quantity: faker.number.int({ min: 1, max: 10 }),
    price: faker.number.float({ min: 10, max: 1000 }),
  })),
  totalAmount: 0, // 计算得出
});
```

## 输出格式

```markdown
## E2E 测试配置

### 🎯 测试框架
- Playwright (推荐) / Cypress
- Page Object 模式

### 📁 目录结构
```
tests/
├── pages/              # Page Objects
│   ├── LoginPage.ts
│   ├── UserPage.ts
├── components/         # 组件测试
├── fixtures/          # 测试数据
├── utils/             # 工具函数
└── e2e/               # 测试用例
    ├── login.cy.ts
    ├── user.cy.ts
```

### ✅ 必测场景

| 场景 | 测试点 |
|------|--------|
| 登录 | 成功/失败/记住我/验证码 |
| CRUD | 创建/编辑/删除/批量操作 |
| 搜索 | 关键词/筛选/分页 |
| 表单 | 验证/提交/文件上传 |
| 权限 | 菜单/按钮/接口 |

### 🌐 浏览器覆盖
- [x] Chrome (桌面)
- [x] Firefox (桌面)
- [x] Safari (桌面)
- [x] Edge
- [x] 移动端 Chrome
- [x] 移动端 Safari

### 📸 视觉回归
- [x] 关键页面快照
- [x] 响应式布局验证
- [x] 暗色主题验证

### 🔧 使用命令
```bash
# 运行所有测试
npx playwright test

# 运行指定文件
npx playwright test tests/login.cy.ts

# UI 模式
npx playwright test --ui

# 带报告
npx playwright test --report=html
```

## 即时执行（playwright-skill）

使用已安装的 playwright-skill 插件即时编写和运行测试：

```bash
# 编写测试脚本到 /tmp
# 通过 playwright-skill 执行
node ~/.claude/skills/playwright-skill/run.js /tmp/e2e-test-login.js
```

## 配合 Skills

| 配合技能 | 关系 | 说明 |
|----------|------|------|
| `qa/test-case/test-case-design` | 前置 | 产出含浏览器测试的用例 |
| `qa/execution/test-executor` | 协调 | test-executor 调用本技能执行浏览器测试部分 |
| `playwright-skill` | 运行时 | 浏览器自动化执行引擎 |
| `qa/advanced/performance-testing` | 协同 | 性能测试配合 |

## 工具可用
- read: 读取测试用例和契约文档
- write: 写入 E2E 测试方案
- bash: 执行 playwright-skill run.js
- grep: 搜索页面组件和路由定义

## 下一步推荐

| 条件 | 推荐技能 |
|------|----------|
| E2E 方案确定 | `qa/execution/test-executor` |


## 触发词
E2E测试、端到端测试、Playwright、Cypress、自动化测试、Page Object、视觉回归、跨浏览器测试、测试用例、CRUD测试、登录测试
