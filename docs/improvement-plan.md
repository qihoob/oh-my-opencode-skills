# Skills 企业级改进方案

## 一、现状与差距分析

### 基于企业级 AI Coding 需求，当前差距如下：

| 需求维度 | 当前 Skills 状态 | 差距 |
|----------|-----------------|------|
| **基础能力** | 有基本代码生成 | ❌ 缺少企业级代码规范（ESLint/Prettier）、响应式布局标准、加载/错误状态处理 |
| **场景能力** | 有基本测试技能 | ❌ 缺少 E2E 测试、性能测试、验收测试、测试数据管理 |
| **工程化能力** | 有 Docker/K8s | ❌ 缺少 CI/CD 流水线、构建配置、质量门禁、自动化集成 |
| **进阶能力** | 有代码审查 | ❌ 缺少设计模式库、性能调优、安全架构 |

---

## 二、改进方案

### 阶段一：基础能力提升 (P0)

#### 1. 新增 `dev-code-quality` - 代码质量规范

```yaml
name: dev-code-quality
description: 企业级代码质量规范 - ESLint/Prettier/命名/注释/TypeScript 严格模式
subtask: true
argument-hint: "<代码质量配置> 或 <lint 配置>"
```

**内容要点**:
- ESLint/Prettier 配置模板 (airbnb/standard 风格)
- 代码命名规范 (变量小驼峰、组件大驼峰、文件 kebab-case)
- JSDoc 注释规范
- pre-commit hooks 配置
- TypeScript 严格模式 (strict: true)
- 代码复杂度控制 (圈复杂度 < 10)

---

#### 2. 新增 `dev-frontend-standards` - 前端开发规范

**内容要点**:
```
响应式布局 (原生响应式，非伪适配):
- CSS Grid/Flex + 媒体查询 + rem/vw
- 核心分辨率: 1366px(办公) / 1920px(大屏) / 768px(平板)

企业级状态管理:
- loading/error/empty/success 状态处理
- 骨架屏设计规范
- Error Boundary 错误边界

性能优化:
- 代码分割、按需加载、懒加载
- 虚拟列表 (react-window)
- 图片优化 (WebP、CDN)

无障碍访问:
- ARIA 属性
- 键盘导航支持
- 屏幕阅读器兼容

目录结构:
- pages/, components/, hooks/, services/, utils/
```

---

#### 3. 增强 `git-commit` 自检清单

已在 v2 版本中加入：
- ✅ 代码质量检查 (lint/TypeScript)
- ✅ 需求一致性检查
- ✅ 视觉还原度检查
- ✅ 交互体验检查
- ✅ 页面布局检查
- ✅ 使用习惯检查
- ✅ 🎨 创造性加分

---

### 阶段二：场景能力提升 (P0)

#### 4. 新增 `qa-e2e-testing` - E2E 测试

```yaml
name: qa-e2e-testing
description: 端到端测试 - Playwright/Cypress 用例设计、Page Object 模式、视觉回归
subtask: true
argument-hint: "<E2E测试> 或 <自动化测试>"
```

**内容要点**:
```
测试框架:
- Playwright/Cypress 项目配置
- Page Object 模式
- 测试fixtures管理

用例设计:
- 核心用户流程覆盖
- 登录/注册/CRUD 操作
- 异常场景处理

多维度测试:
- 跨浏览器 (Chrome/Firefox/Safari/Edge)
- 响应式 (多分辨率验证)
- 视觉回归 (Percy/Chromatic)

集成:
- CI/CD 集成
- 测试报告生成
```

---

#### 5. 新增 `qa-performance-testing` - 性能测试

**内容要点**:
```
性能工具:
- k6/JMeter 脚本生成
- Lighthouse 集成

指标定义:
- 响应时间 (RT)
- 吞吐量 (TPS)
- 并发用户数
- 错误率

测试类型:
- 基准测试
- 压力测试
- 容量测试
- 峰值测试

前端性能:
- Core Web Vitals
- 首屏加载时间
- 交互响应延迟

SLA/SLO 验证
```

---

#### 6. 新增 `qa-acceptance-testing` - 验收测试

**内容要点**:
```
BDD 规范:
- Cucumber/Gherkin 语法
- 场景步骤定义
- 数据表格用法

验收标准:
- 用户故事验收
- DoD (Definition of Done) 检查项
- 业务规则验证

自动化:
- 自动化验收脚本
- 报告生成
-  stakeholder 可读报告
```

---

### 阶段三：工程化能力提升 (P1)

#### 7. 新增 `devops-ci-cd-pipeline` - CI/CD 流水线

**内容要点**:
```
GitHub Actions 模板:
- PR 检查: lint → test → build → deploy
- 分支保护规则
- 自动版本发布

质量门禁:
- 覆盖率阈值 (80%)
- 代码复杂度限制
- 安全扫描

部署策略:
- Blue/Green 部署
- Canary 发布
- 自动回滚

环境管理:
- Dev → Staging → Prod
- 配置隔离
- 密钥管理
```

---

#### 8. 新增 `devops-build-config` - 构建配置

**内容要点**:
```
Vite/Webpack 配置:
- 多环境构建 (dev/test/staging/prod)
- 代码分割 (code splitting)
- 按需加载 (lazy import)
- Tree shaking

性能优化:
- bundle 分析
- 依赖优化
- 产物压缩

开发体验:
- HMR 热更新
- Source Map 配置
- Mock 服务
```

---

### 阶段四：进阶能力提升 (P2)

#### 9. 新增 `architecture-design-patterns` - 设计模式

**内容要点**:
```
GoF 设计模式:
- 创建型: Factory/Builder/Singleton/Prototype
- 结构型: Adapter/Bridge/Decorator/Facade/Proxy
- 行为型: Strategy/Observer/Command/State

架构模式:
- CQRS (命令查询职责分离)
- Event Sourcing (事件溯源)
- DDD (领域驱动设计)
- BFF (Backend For Frontend)

反模式:
- God Object
- Spaghetti Code
- 过度设计
```

---

#### 10. 新增 `architecture-security-review` - 安全架构

**内容要点**:
```
OWASP Top 10:
- 注入攻击防护
- 认证与会话管理
- 敏感数据保护
- XXE/XSS/CSRF 防护

安全实践:
- 输入验证
- 输出编码
- 加密标准
- 密钥管理

代码安全:
- SQL 注入预防
- 文件上传安全
- API 鉴权设计
```

---

## 三、实施优先级

| 优先级 | Skill | 预计工作量 | 价值 |
|--------|-------|-----------|------|
| P0 | `dev-code-quality` | 1天 | 高 |
| P0 | `dev-frontend-standards` | 1天 | 高 |
| P0 | `qa-e2e-testing` | 1天 | 高 |
| P0 | `qa-performance-testing` | 1天 | 中 |
| P1 | `devops-ci-cd-pipeline` | 1天 | 高 |
| P1 | `devops-build-config` | 1天 | 中 |
| P1 | `qa-acceptance-testing` | 1天 | 中 |
| P2 | `architecture-design-patterns` | 2天 | 中 |
| P2 | `architecture-security-review` | 1天 | 中 |

---

## 四、现有 Skills 增强建议

| 现有 Skill | 增强方向 |
|------------|----------|
| `dev-frontend-implementation` | 添加响应式布局模板、加载/错误状态处理 |
| `dev-backend-implementation` | 添加 DTO 验证、API 版本管理 |
| `qa-test-case-design` | 添加 E2E 用例设计指导 |
| `test-executor` | 添加 CI/CD 集成命令 |
| `git-commit` | 已有完整自检清单 ✅ |
| `architecture-code-review` | 添加静态分析集成、复杂度检查 |

---

## 五、总结

通过以上改进，可以实现：

1. **规范层**: 企业级代码规范、响应式布局、状态处理
2. **业务层**: 完整测试体系 (E2E/性能/验收)、可测试业务代码
3. **工程层**: CI/CD 流水线、构建配置、质量门禁
4. **专业层**: 设计模式、安全架构、性能调优

是否需要我开始实施这些改进？可以从 P0 优先级开始。