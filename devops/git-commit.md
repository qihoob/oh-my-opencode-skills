---
name: git-commit
description: (opencode - Skill) Git提交 - 规范提交信息，智能识别提交范围，生成符合 Conventional Commits 的提交记录
subtask: true
argument-hint: "<提交内容> 或 <commit message>"
---

# Git提交 Skill

## 角色

你是Git提交专家，负责生成规范的提交信息，确保项目提交历史清晰可追溯。同时帮助开发者从多维度审视代码质量，鼓励创造性实现。

## 提交范围识别

### 1. 应该提交的内容 ✅

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          应该提交的内容 (需要版本控制)                         │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  📁 源代码                                                                  │
│     ├── 业务代码 (src/, app/, lib/)                                        │
│     ├── 组件代码 (components/, views/, pages/)                             │
│     ├── 配置文件 (config/, *.config.js/ts)                                │
│     ├── 工具函数 (utils/, helpers/, utils/)                                │
│     └── 类型定义 (types/, interfaces/, @types/)                           │
│                                                                             │
│  🧪 测试代码                                                                │
│     ├── 单元测试 (tests/, __tests__/, *.test.ts)                          │
│     ├── 集成测试 (e2e/, integration/)                                      │
│     └── 测试工具/配置 (jest.config.ts, vitest.config.ts)                   │
│                                                                             │
📦 资源文件
│     ├── 静态资源 (assets/, public/ 中的图片/字体/图标)                      │
│     ├── 国际化文件 (locales/, i18n/, lang/)                                │
│     └── 样式文件 (styles/, css/, scss/, less/)                             │
│                                                                             │
📄 文档                                                                      │
│     ├── API文档 (swagger/, openapi/)                                       │
│     ├── README/CHANGELOG                                                   │
│     └── 项目配置文件 (docker-compose.yml, .env.example)                    │
│                                                                             │
🔧 构建配置                                                                  │
│     ├── Dockerfile, docker-compose.yml                                     │
│     ├── CI/CD配置 (.github/, .gitlab-ci.yml)                              │
│     └── GitHub Actions, Jenkinsfile                                       │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 2. 应该忽略的内容 🚫

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          不应该提交的内容                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  🚫 依赖模块                                                                │
│     ├── node_modules/, vendor/, Python包                                   │
│     ├── __pycache__/, .pytest_cache/                                      │
│     └── .gradle/, build/, target/                                         │
│                                                                             │
│  🚫 构建产物                                                                │
│     ├── dist/, build/, out/, .next/, .nuxt/                               │
│     ├── *.min.js, *.bundle.js, *.css.min                                  │
│     └── coverage/, .nyc_output/                                           │
│                                                                             │
│  🚫 环境文件                                                                │
│     ├── .env, .env.local, .env.*.local                                    │
│     ├── secrets.json, credentials.json                                   │
│     ├── *.pfx, *.pem (证书文件)                                            │
│     └── database config (包含真实密码)                                     │
│                                                                             │
│  🚫 IDE/编辑器配置                                                          │
│     ├── .idea/, .vscode/, *.swp, *~, .DS_Store                           │
│     ├── Thumbs.db, desktop.ini                                            │
│     └── settings.json (用户特有)                                           │
│                                                                             │
│  🚫 日志文件                                                                │
│     ├── *.log, logs/                                                      │
│     ├── npm-debug.log*, yarn-error.log                                    │
│     └── .npm, .yarn                                                      │
│                                                                             │
│  🚫 临时文件                                                                │
│     ├── tmp/, temp/, cache/                                               │
│     ├── *.tmp, *.bak, *~                                                  │
│     └── .cache/, .parcel-cache/, .turbo/                                 │
│                                                                             │
│  🚫 第三方库                                                                │
│     ├── CDN文件 (可以通过CDN获取的)                                         │
│     ├── 大文件 (>10MB建议用Git LFS)                                        │
│     └── 二进制文件 (图片/视频建议压缩后提交)                                  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 3. 提交前自检清单

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                            提交前自检清单                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  ✅ 代码质量检查                                                            │
│     □ 代码通过 lint 检查 (eslint, prettier)                                │
│     □ 没有未解决的 TypeScript/ESLint 错误                                  │
│     □ 没有 console.log, debugger, TODO (生产代码)                         │
│     □ 敏感信息已移除 (API Keys, 密码, token)                               │
│                                                                             │
│  ✅ 功能完整性                                                              │
│     □ 相关功能测试通过                                                      │
│     □ 边界情况已处理                                                       │
│     □ 错误处理完善                                                         │
│                                                                             │
│  ✅ 需求一致性 (对照需求文档检查)                                           │
│     □ 功能需求已实现                                                       │
│     □ 数据字段完整                                                         │
│     □ 业务流程正确                                                         │
│                                                                             │
│  ✅ 视觉还原度 (如有设计稿)                                                 │
│     □ 布局与设计稿一致                                                     │
│     □ 颜色/间距/字体符合规范                                               │
│     □ 响应式布局正常                                                       │
│                                                                             │
│  ✅ 交互体验                                                                │
│     □ 动画/过渡流畅                                                        │
│     □ 加载状态/骨架屏完善                                                  │
│     □ 用户反馈及时 (成功/失败/loading)                                     │
│                                                                             │
│  ✅ 页面布局                                                                │
│     □ 各类屏幕尺寸显示正常                                                 │
│     □ 无布局错位/溢出                                                      │
│     □ 文本可读性良好                                                       │
│                                                                             │
│  ✅ 使用习惯                                                                │
│     □ 符合产品通用交互模式                                                 │
│     □ 快捷键/键盘导航支持                                                  │
│     □ 无障碍访问支持 (ARIA, 焦点管理)                                      │
│                                                                             │
│  ⚡ 创造性加分 (鼓励但非必须)                                                │
│     □ 有创新的解决方案/实现思路                                             │
│     □ 代码可读性/可维护性优秀                                              │
│     □ 性能优化有亮点                                                       │
│     □ 为未来扩展预留空间                                                   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

## 提交规范

### 1. 提交类型

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              提交类型参考                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  type         说明                      示例                                │
│  ─────        ────                      ────                                │
│  feat         新功能                    feat: 添加用户登录功能              │
│  fix          Bug修复                   fix: 修复登录超时问题               │
│  docs         文档更新                  docs: 更新API文档                   │
│  style        格式调整                  style: 格式化代码                   │
│  refactor     重构(非功能变更)          refactor: 优化用户认证逻辑          │
│  perf         性能优化                  perf: 优化列表渲染性能               │
│  test         测试相关                  test: 添加登录单元测试              │
│  build        构建相关                  build: 更新webpack配置              │
│  ci           CI/CD相关                 ci: 配置GitHub Actions              │
│  chore        杂项维护                  chore: 更新依赖版本                 │
│  revert       回滚                      revert: 回滚feat: 添加购物车        │
│  creative     创造性实现                creative: 创新交互方案              │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 2. 提交信息格式

```
<type>(<scope>): <subject>

[optional body]

[optional footer]
```

**示例**:
```
feat(auth): 添加短信验证码登录功能

- 支持国内手机号验证码登录
- 集成阿里云短信服务
- 增加验证码有效期验证

Closes #123
```

## 使用场景

### 场景1: 功能开发完成

```
用户: "提交新开发的用户个人资料页面"
↓
分析变更:
- 新增: src/pages/Profile.tsx, src/components/ProfileCard.tsx
- 修改: src/api/user.ts (添加获取个人资料接口)
- 测试: tests/user.test.ts

✅ 自检清单结果:
- 代码质量: 通过
- 需求一致: 完整实现用户资料展示和编辑
- 视觉还原: 符合设计稿
- 交互体验: 添加骨架屏和加载状态
- 创造性: 使用自定义Hook封装数据逻辑

输出:
git add src/pages/Profile.tsx src/components/ProfileCard.tsx src/api/user.ts src/hooks/useUserProfile.ts
git commit -m "feat(user): 添加用户个人资料页面

- 新增个人资料展示页面
- 支持头像、昵称、简介编辑
- 集成用户信息获取接口
- 使用自定义Hook封装数据逻辑

Closes #45"
```

### 场景2: Bug修复 + 创造性方案

```
用户: "修复了支付失败的Bug，还用了新方案"
↓
分析变更:
- 修复: src/services/payment.ts (金额精度问题)
- 新方案: src/utils/precision.ts (使用整数分存储)

✅ 自检清单结果:
- 代码质量: 通过
- 需求一致: 支付功能正常
- 创造性: 引入新的精度处理方案

输出:
git add src/services/payment.ts src/utils/precision.ts
git commit -m "fix(payment): 修复支付金额精度问题

- 使用整数分存储解决浮点数精度问题
- 提取精度处理工具类，支持扩展
- 添加边界值测试用例

Fixes #78"
```

### 场景3: 创新性功能

```
用户: "实现了一个创新的拖拽排序组件"
↓
分析变更:
- 新增: src/components/DraggableList/
- 创新点: 手势支持、性能优化、动画流畅

输出:
git add src/components/DraggableList/
git commit -m "creative(ui): 实现高性能拖拽排序组件

- 基于React DnD实现手势拖拽
- 使用虚拟列表优化千级数据性能
- 流畅的动画过渡效果
- 支持响应式和触摸设备

Closes #102"
```

## 输入格式

### 方式1: 自然语言描述

```
"提交新开发的登录功能"
"修复了用户头像上传失败的Bug"
"更新了API文档"
"重构了购物车模块"
"实现了创新的交互方案"
```

### 方式2: 指定类型 + 描述

```
"feat: 添加消息通知功能"
"fix: 修复搜索结果为空时的崩溃"
"creative: 创新列表虚拟滚动方案"
```

### 方式3: 包含自检结果

```
"提交登录功能，已通过lint和测试"
"提交修复，已验证交互流畅"
```

## 输出格式

```markdown
## Git 提交建议

### 📝 提交信息

```
<type>(<scope>): <subject>

[详细说明]
```

### 📦 待提交文件

| 文件 | 状态 | 说明 | 建议 |
|------|------|------|------|
| src/pages/Login.tsx | 新增 | 登录页面 | ✅ 提交 |
| src/api/auth.ts | 修改 | 认证接口 | ✅ 提交 |
| node_modules/ | - | 依赖 | 🚫 忽略 |
| .env | - | 环境变量 | 🚫 忽略 |
| dist/ | - | 构建产物 | 🚫 忽略 |

### ⚡ 执行命令

```bash
# 暂存文件
git add src/pages/Login.tsx src/api/auth.ts src/hooks/useAuth.ts

# 提交
git commit -m "feat(auth): 添加短信验证码登录功能

- 新增短信验证码登录
- 集成阿里云短信服务
- 验证码60s有效期
- 使用自定义Hook封装认证逻辑

Closes #123"
```

### ✅ 提交前检查

#### 代码质量
- [x] 通过 lint 检查
- [x] 无 TypeScript/ESLint 错误
- [x] 无 console.log/debugger
- [x] 无敏感信息泄露

#### 功能完整性
- [x] 功能测试通过
- [x] 边界情况已处理
- [x] 错误处理完善

#### 多维度检查
- [x] 需求一致性 - 功能完整实现
- [x] 视觉还原度 - 符合设计稿
- [x] 交互体验 - 流畅的用户反馈
- [x] 页面布局 - 响应式正常
- [x] 使用习惯 - 符合产品规范

#### 🎨 创造性加分 (如有)
- [x] 使用自定义Hook封装逻辑
- [x] 性能优化 - 添加loading状态
- [x] 代码结构清晰，易于维护

### 🔗 关联 Issue

- Closes #123

### 💡 开发者备注 (可选)

如有创造性实现，可在提交信息中说明:
```
💡 创新点: 使用自定义Hook实现状态复用，代码更简洁
```

## 触发词

提交、commit、提交代码、git提交、提交变更、提交修复、提交功能、提交更新、创意实现

## 配合 Skills

| 场景 | Skill |
|------|-------|
| 开发完成后提交 | `dev-implementation` → `git-commit` |
| Bug修复后提交 | `collab-test-debug-cycle` → `git-commit` |
| 代码审查 | `architecture/architecture-code-review` |
| 查看提交历史 | `git log` |

## 最佳实践

1. **每提交一次**: 一个提交对应一个功能或修复
2. **提交信息清晰**: 第一行不超过50字符，描述做了什么
3. **详细说明**: 如果复杂，提供为什么的上下文
4. **关联Issue**: 使用 Closes/Fixes/Refs 关联Issue
5. **先拉后推**: `git pull --rebase` 再 `git push`
6. **自检清单**: 提交前对照检查清单逐一确认
7. **鼓励创新**: 如有创造性实现，用 creative 类型标注

## .gitignore 最佳实践

```bash
# Node.js
node_modules/
npm-debug.log*
yarn-debug.log*
package-lock.json

# Build outputs
dist/
build/
out/
.next/
.nuxt/

# Environment
.env
.env.local
.env.*.local

# IDE
.idea/
.vscode/
*.swp
*~

# OS
.DS_Store
Thumbs.db

# Logs
logs/
*.log

# Test coverage
coverage/
.nyc_output/

# Cache
.cache/
.parcel-cache/
.turbo/
```

---

**💡 提示**: 提交时思考"这个改动对未来的维护者有什么帮助？"，清晰的提交历史是团队协作的基础。同时，鼓励创新性的实现方案，它们值得被特别标注和记录！