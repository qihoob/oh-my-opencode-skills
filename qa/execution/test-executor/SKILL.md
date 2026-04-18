---
name: test-executor
description: 测试执行 - 支持接口测试、浏览器自动化测试、手动探索测试，失败自动生成Bug单
version: "3.0"
---

# Skill: test-executor

**角色**: 测试 (QA)
**功能**: 多模式测试执行、结果记录、Bug 自动转交
**触发关键词**: 执行测试、运行测试、测试执行、测试报告、跑测试、浏览器测试
**版本**: 3.0 (新增三种测试模式)

## 产出文档
- **测试报告**: `.opencode/docs/test-report-{feature}.md`
- **Bug 单**（失败时自动生成）: `.opencode/docs/bug-{id}.md`

## 依赖文档
**必须读取**: `.opencode/docs/test-cases-{feature}.md`

## 三种测试模式

测试不只是接口调用，需要根据用例类型选择合适的执行方式：

| 模式 | 适用场景 | 工具 | 产出 |
|------|----------|------|------|
| **接口测试** | API 接口、纯后端逻辑 | curl / httpie / Postman / 测试脚本 | 接口响应 + 状态码 |
| **浏览器测试** | 页面交互、UI渲染、用户流程 | Playwright / Cypress / 手动操作浏览器 | 截图 + 录屏 + 操作日志 |
| **手动探索** | 复杂交互、多条件组合、主观体验 | 人工操作 + 记录 | 操作记录 + 截图 |

### 模式选择规则

```
对每条测试用例，根据其类型自动选择执行模式：

接口测试：
  - 用例涉及 API 端点的请求/响应
  - 用例涉及数据校验、错误码、边界值
  - 用例不涉及 UI 展示

浏览器测试：
  - 用例涉及页面跳转、按钮点击、表单填写
  - 用例涉及 UI 渲染（布局、样式、响应式）
  - 用例涉及完整用户操作流程（登录→操作→查看结果）
  - 用例涉及多步骤交互（购物车→结算→支付）

手动探索：
  - 用例涉及主观体验（动画流畅度、操作直觉性）
  - 用例涉及复杂的多条件组合（难以自动化）
  - 用例需要创造性测试（探索边界）
```

---

## 执行流程

### Step 1: 分析用例，确定执行模式

```
读取 test-cases-{feature}.md，对每条用例标注执行模式：

| 用例 | 类型 | 执行模式 |
|------|------|----------|
| TC001: 正常登录成功 | 页面交互 | 🌐 浏览器测试 |
| TC002: 错误密码提示 | 表单验证 | 🌐 浏览器测试 |
| TC003: 登录接口返回正确数据 | API验证 | 🔌 接口测试 |
| TC004: 登录接口参数校验 | 边界值 | 🔌 接口测试 |
| TC005: 登录页面响应式布局 | UI渲染 | 🌐 浏览器测试 |
| TC006: 登录操作动画流畅 | 主观体验 | 👤 手动探索 |
```

### Step 2: 按模式执行

#### 2A. 接口测试执行

```
工具: curl / 项目测试框架 / httpie

执行方式:
1. 启动/确认测试环境可用
2. 逐条发送请求，记录响应

每个接口用例记录:
- 请求: {METHOD} {URL} Headers: {...} Body: {...}
- 响应: HTTP {状态码} Body: {...}
- 判定: ✅ 通过 / ❌ 失败（{原因}）

示例:
  测试: POST /api/auth/login
  请求: {"email": "test@example.com", "password": "wrong"}
  响应: HTTP 401 {"code": 2001, "message": "用户名或密码错误"}
  判定: ✅ 通过（预期返回 401 和错误码 2001）
```

#### 2B. 浏览器测试执行（核心）

```
推荐工具: playwright-skill（已安装为 Claude Code 技能插件）

位置: ~/.claude/skills/playwright-skill/
运行器: node ~/.claude/skills/playwright-skill/run.js <script.js>

playwright-skill 优势:
- 自动检测开发服务器（detectDevServers）
- 默认 headed 模式（可见浏览器）
- 脚本写到 /tmp（不污染项目）
- 首次运行自动安装 Playwright
- 15个内置辅助函数（safeClick, safeType, takeScreenshot 等）

方式一：playwright-skill 即时执行（推荐）
  适合: test-executor 中即时编写和运行浏览器测试用例

  执行步骤:
  1. 为每条浏览器测试用例编写 Playwright 脚本
  2. 通过 playwright-skill 的 run.js 执行:
     node ~/.claude/skills/playwright-skill/run.js /tmp/test-TC001.js
  3. 脚本可使用 playwright-skill 内置辅助函数:
     - safeClick(page, selector) — 安全点击（等待可交互）
     - safeType(page, selector, text) — 安全输入
     - takeScreenshot(page, name) — 截图保存
     - authenticate(page, url, credentials) — 自动登录
     - extractTableData(page, selector) — 提取表格数据
  4. 验证页面状态（元素可见、文本正确、URL正确）
  5. 失败时自动截图

  脚本模板（每条浏览器测试用例）:
  ```javascript
  // /tmp/test-TC001.js
  const { chromium } = require('playwright');

  (async () => {
    const browser = await chromium.launch({ headless: false });
    const page = await browser.newPage();

    // 前置: 打开登录页
    await page.goto('{测试环境URL}/login');

    // 操作: 使用 safeClick/safeType 安全操作
    await page.fill('[data-testid="username"]', '{测试账号}');
    await page.fill('[data-testid="password"]', '{密码}');
    await page.click('[data-testid="login-btn"]');

    // 验证: 跳转到首页
    if (page.url().includes('/dashboard')) {
      console.log('PASS: TC001 - 成功跳转到首页');
    } else {
      console.log('FAIL: TC001 - 未跳转到首页，当前URL: ' + page.url());
    }

    // 截图: 记录结果
    await page.screenshot({ path: '/tmp/screenshots/TC001-result.png' });
    await browser.close();
  })();
  ```

方式二：手动浏览器测试
  适合: 复杂交互、难以自动化的场景

  执行步骤:
  1. 打开浏览器访问测试环境
  2. 按用例步骤手动操作
  3. 每个关键步骤截图（command/ctrl+shift+s 或工具截图）
  4. 记录实际观察到的结果
  5. 对比预期结果，判定通过/失败

  截图命名规范:
  - 通过: TC{编号}-{步骤}-pass.png
  - 失败: TC{编号}-{步骤}-fail.png
```

#### 2C. 手动探索测试

```
工具: 人工操作 + 记录模板

执行方式:
1. 基于测试用例的探索方向，自由操作
2. 记录发现的意外行为
3. 对比预期，标注通过/失败/发现新问题
```

### Step 3: Bug 自动生成（有失败用例时触发）

```
对每条失败用例，自动生成结构化 Bug 单。

产出路径: .opencode/docs/bug-{module}-{seq}.md

接口测试失败 → Bug 单附加: 请求/响应详情
浏览器测试失败 → Bug 单附加: 截图 + 操作步骤录屏路径
```

### Step 4: 产出测试报告

### Step 5: 自动推荐下一步

```
全部通过 → 推荐 collab-acceptance-review
有失败 → 推荐 bug-coordinator（并提示已生成 Bug 单）
```

---

## Bug 单模板

每个失败用例自动生成一份 Bug 单：

```markdown
# Bug: {简短描述}

## 元信息
| 字段 | 值 |
|------|-----|
| Bug ID | bug-{module}-{seq} |
| 严重程度 | P0/P1/P2/P3 |
| 来源 | test-report-{feature}.md |
| 关联需求 | requirement-{feature}.md AC{N} |
| 关联用例 | test-cases-{feature}.md TC{N} |
| 发现人 | QA |
| 发现时间 | {YYYY-MM-DD HH:mm} |
| 测试环境 | {环境地址} |

## 问题描述

**预期行为**: {验收标准描述}

**实际行为**: {实际观察到的情况}

## 复现步骤

1. {前置条件：使用 {账号} 登录 {URL}}
2. {操作步骤 1}
3. {操作步骤 2}
4. {操作步骤 3}
5. **观察**: {应出现 X，实际出现 Y}

## 环境与数据

- **测试环境**: {URL}
- **部署版本**: {v1.0.0}
- **测试账号**: {账号/角色}
- **测试数据**: {使用的数据描述}
- **浏览器/客户端**: {Chrome 120 / iOS 17}
- **执行模式**: {🔌接口 / 🌐浏览器 / 👤手动}

## 证据附件

接口测试:
- 请求: `{METHOD} {URL}` Headers: `{...}` Body: `{...}`
- 响应: HTTP `{状态码}` Body: `{...}`

浏览器测试:
- 截图: {TC{N}-{步骤}-fail.png}
- 录屏: {TC{N}-recording.webm}（如有）
- 浏览器控制台日志: `{粘贴关键错误}`

## 初步分析（辅助开发定位）

```
以下信息帮助开发快速定位问题：

关联代码路径:
- 前端: src/modules/{module}/components/{component}.tsx
- 后端: src/modules/{module}/service.ts → {functionName}()
- API: {METHOD} {path}

可能的根因方向:
- {方向 1: 如 "接口返回了正确的数据但前端未正确渲染"}
- {方向 2: 如 "后端超时未处理，默认返回了成功"}

相关日志:
```
{粘贴关键错误日志}
```
```

## 修复建议（可选）

- {如能判断，建议修复方向}
- {如涉及跨模块，标注关联模块}

## 验证标准

修复后需验证:
- [ ] 原 Bug 复现步骤不再出现
- [ ] 关联的验收标准 AC{N} 通过
- [ ] 相关功能回归正常
- [ ] 无新引入问题

## 状态追踪
| 时间 | 状态 | 操作人 | 备注 |
|------|------|--------|------|
| {发现时间} | 🔴 待处理 | QA | 初始报告 |
| | 🔄 修复中 | Dev | |
| | ✅ 待验证 | Dev | |
| | 🟢 已关闭 | QA | |
```

---

## 测试报告模板

```markdown
# 测试报告：{功能名称}

**测试时间**: {YYYY-MM-DD}
**测试人员**: QA
**测试环境**: {环境}

## 测试模式分布

| 执行模式 | 用例数 | 通过 | 失败 | 说明 |
|----------|--------|------|------|------|
| 🔌 接口测试 | 5 | 4 | 1 | curl / 测试框架 |
| 🌐 浏览器测试 | 8 | 6 | 2 | Playwright 自动化 |
| 👤 手动探索 | 2 | 2 | 0 | 人工操作 |
| **合计** | **15** | **12** | **3** | |

## 测试结果概览
| 总计 | 通过 | 失败 | 阻塞 | 通过率 |
|------|------|------|------|--------|
| 15 | 12 | 3 | 0 | 80% |

## 接口测试结果

| 用例 | 接口 | 方法 | 状态码 | 结果 |
|------|------|------|--------|------|
| TC003: 登录接口正常 | /api/auth/login | POST | 200 | ✅ |
| TC004: 密码错误返回401 | /api/auth/login | POST | 401 | ✅ |
| TC005: 缺少参数返回400 | /api/auth/login | POST | 400 | ✅ |
| TC006: 登录接口参数校验 | /api/auth/login | POST | 200 | ❌ 缺少字段校验 |

## 浏览器测试结果

| 用例 | 操作流程 | 截图 | 结果 |
|------|----------|------|------|
| TC001: 正常登录 | 打开→输入→点击→验证跳转 | TC001-pass.png | ✅ |
| TC002: 错误密码提示 | 打开→输入错误密码→验证提示 | TC002-pass.png | ✅ |
| TC007: 登录页响应式 | 缩小窗口→验证布局 | TC007-fail.png | ❌ 移动端布局错位 |
| TC008: 登录记住我 | 勾选→登录→关闭→重开→验证 | TC008-fail.png | ❌ 记住我未生效 |

## 失败用例 → Bug 单对照

| 用例 | 执行模式 | 严重程度 | 生成 Bug 单 | 证据 |
|------|----------|----------|-------------|------|
| TC006: 接口参数校验 | 🔌 接口 | P1 | bug-auth-001.md | 请求/响应 |
| TC007: 移动端布局 | 🌐 浏览器 | P2 | bug-auth-002.md | 截图 |
| TC008: 记住我功能 | 🌐 浏览器 | P1 | bug-auth-003.md | 截图+录屏 |

## 测试结论
- ✅ 核心接口功能通过
- ✅ 基本页面交互正常
- ❌ 发现 3 个 Bug，已生成 Bug 单
- 📋 建议修复后重新执行浏览器测试

## 下一步
→ Bug 已转交 bug-coordinator，推荐执行 bug-coordinator 分配修复
```

## 配合 Skills

| 配合技能 | 关系 | 说明 |
|----------|------|------|
| `qa/test-case/test-case-design` | 前置 | 产出测试用例 |
| `playwright-skill` | 运行时 | 浏览器测试执行引擎（`~/.claude/skills/playwright-skill/run.js`） |
| `qa/advanced/e2e-testing` | 协同 | 完整 E2E 测试方案（Page Object、视觉回归、跨浏览器） |
| `qa/advanced/performance-testing` | 协同 | 性能测试（k6/Lighthouse） |
| `collaboration/process/bug-coordinator` | 后续（自动） | 失败用例自动流转到 Bug 协调 |
| `dev/implementation/dev-implementation` | 后续 | Bug 修复实现 |
| `dev/context/dev-context-first` | 后续 | 开发获取修复上下文 |
| `collaboration/review/collab-acceptance-review` | 后续 | 全部通过后进入验收 |

## 工具可用
- read: 读取测试用例
- write: 写入测试报告和 Bug 单
- grep: 搜索相关代码定位
- bash: 执行 curl / Playwright / 测试脚本
- 截图工具: 浏览器测试时截图记录证据