---
name: branch-and-version
description: 分支策略与版本规范 - Git分支策略选择、命名规范、commit规范、SemVer版本号、CHANGELOG、Tag规范
version: "1.0"
---

# Skill: branch-and-version

**角色**: 开发 (Dev)
**功能**: 分支策略与版本规范
**触发关键词**: 分支策略、Git分支、版本规范、SemVer、CHANGELOG、commit规范、版本号、Git规范

## 产出文档
- **分支策略文档**: `.opencode/docs/branch-strategy-{project}.md`

## 核心能力

1. **分支策略选择**
   - Git Flow（适合版本发布型项目）
   - Trunk-Based Development（适合持续部署型项目）
   - GitHub Flow（适合快速迭代型项目）
   - 策略选择建议

2. **分支命名规范**
   - 主分支命名
   - 功能分支命名
   - 修复分支命名
   - 发布分支命名

3. **Commit 规范**
   - Conventional Commits 格式
   - commitlint 配置
   - 提交消息模板

4. **版本号规范**
   - SemVer（语义化版本）规则
   - 版本号变更判定
   - 预发布版本标识

5. **CHANGELOG 规范**
   - CHANGELOG 格式
   - 自动生成规则
   - 变更分类

6. **Tag 规范**
   - Tag 命名规则
   - Tag 创建时机
   - Tag 与版本号对应

## 依赖文档

按优先级检查：
1. `.opencode/docs/project-overview.md` — 项目概览（了解项目类型）
2. `.opencode/docs/devops-ci-*.md` — CI 配置（了解发布节奏）
3. 项目实际 Git 历史 — 分析当前分支模式

## 执行流程

### Step 1: 分析项目特征

```
目的: 根据项目特征选择合适的分支策略

1.1 读取项目信息
    - 项目类型（Web应用 / 移动应用 / 库/SDK / 微服务）
    - 发布节奏（定期发布 / 持续部署 / 按需发布）
    - 团队规模（单人 / 小团队 / 大团队）
    - 环境数量（单环境 / 多环境）

1.2 分析当前 Git 模式
    - bash: git branch -a（查看当前分支）
    - bash: git log --oneline -20（查看最近提交）
    - 检查是否有 develop、release、feature 等分支

1.3 策略选择矩阵
    ┌─────────────────┬─────────────────┬─────────────────┬─────────────────┐
    │ 项目特征        │ Git Flow        │ GitHub Flow     │ Trunk-Based     │
    ├─────────────────┼─────────────────┼─────────────────┼─────────────────┤
    │ 发布节奏        │ 定期版本发布    │ 快速迭代        │ 持续部署        │
    │ 团队规模        │ 中大型团队      │ 小团队          │ 大团队          │
    │ 环境数量        │ 多环境(dev/stg) │ 单环境          │ 多环境          │
    │ 版本管理        │ 需要维护多版本  │ 单版本          │ 单版本          │
    │ 回滚需求        │ 高              │ 低              │ 中              │
    │ CI/CD 成熟度    │ 中              │ 低              │ 高              │
    └─────────────────┴─────────────────┴─────────────────┴─────────────────┘

输出:
- 项目特征: {特征描述}
- 当前模式: {当前分支模式}
- 建议策略: {Git Flow / GitHub Flow / Trunk-Based}
```

### Step 2: 分支命名规范

```
目的: 定义各类型分支的命名规则

2.1 主分支命名
    - main / master — 生产代码（始终可部署）
    - develop — 开发代码（可选，Git Flow 使用）

2.2 功能分支命名
    - feature/{issue-id}-{short-desc} — 功能开发
    - 示例: feature/123-user-login

2.3 修复分支命名
    - fix/{issue-id}-{short-desc} — Bug 修复
    - hotfix/{issue-id}-{short-desc} — 生产紧急修复
    - 示例: fix/456-login-timeout, hotfix/789-payment-fail

2.4 发布分支命名
    - release/{version} — 发布准备（Git Flow 使用）
    - 示例: release/v1.2.0

2.5 分支命名规则
    - 使用小写字母和连字符
    - 必须包含 issue ID（关联任务）
    - 简短描述不超过 30 字符
    - 避免 feature/feat、fix/bugfix 重复命名

输出:
- 分支命名规范: {详细命名规则表}
```

### Step 3: Commit 规范

```
目的: 定义 commit 消息格式，支持自动化工具

3.1 Conventional Commits 格式
    格式: <type>(<scope>): <subject>

    type 类型:
    | 类型 | 说明 | 示例 |
    |------|------|------|
    | feat | 新功能 | feat(auth): add user login |
    | fix | Bug 修复 | fix(auth): resolve timeout issue |
    | docs | 文档变更 | docs(readme): update install steps |
    | style | 代码风格 | style(lint): fix eslint warnings |
    | refactor | 重构 | refactor(auth): simplify login flow |
    | perf | 性能优化 | perf(query): optimize db query |
    | test | 测试 | test(auth): add login test cases |
    | build | 构建 | build(ci): update pipeline config |
    | ci | CI 配置 | ci(github): add auto deploy |
    | chore | 杂项 | chore(deps): update dependencies |
    | revert | 回滚 | revert: undo feat(auth): add login |

    scope 范围（可选）:
    - 模块名或功能域
    - 示例: auth, user, payment, api, ui

    subject 主题:
    - 简短描述（不超过 50 字符）
    - 使用祈使句（add/update/remove，不用 added）
    - 不以句号结尾

3.2 commitlint 配置
    // .commitlintrc.js
    module.exports = {
      extends: ['@commitlint/config-conventional'],
      rules: {
        'type-enum': [2, 'always', [
          'feat', 'fix', 'docs', 'style', 'refactor',
          'perf', 'test', 'build', 'ci', 'chore', 'revert'
        ]],
        'subject-max-length': [2, 'always', 50],
        'subject-case': [2, 'always', 'lower-case']
      }
    };

3.3 提交消息模板
    # .gitmessage
    # type(scope): subject
    #
    # body（可选，详细描述）
    #
    # footer（可选，关联 issue）
    #Refs: #123

输出:
- Commit 格式规范: {Conventional Commits 格式}
- commitlint 配置: {配置文件内容}
```

### Step 4: 版本号规范 (SemVer)

```
目的: 定义语义化版本号规则

4.1 SemVer 格式
    格式: MAJOR.MINOR.PATCH[-PRERELEASE][+BUILD]

    MAJOR: 主版本号
    - 不兼容的 API 变更
    - 架构重大变更
    - 示例: 1.0.0 → 2.0.0

    MINOR: 次版本号
    - 向后兼容的功能新增
    - 示例: 1.0.0 → 1.1.0

    PATCH: 补丁版本号
    - 向后兼容的 Bug 修复
    - 示例: 1.0.0 → 1.0.1

    PRERELEASE: 预发布标识（可选）
    - alpha, beta, rc
    - 示例: 1.0.0-alpha.1, 1.0.0-beta.2, 1.0.0-rc.1

    BUILD: 构建标识（可选）
    - 示例: 1.0.0+build.123

4.2 版本号变更判定
    | 变更类型 | 版本号变更 | 示例 |
    |----------|------------|------|
    | 新功能（兼容） | MINOR ↑ | 1.0.0 → 1.1.0 |
    | Bug 修复 | PATCH ↑ | 1.0.0 → 1.0.1 |
    | API 不兼容 | MAJOR ↑ | 1.0.0 → 2.0.0 |
    | 功能废弃（未删除） | MINOR ↑ | 1.0.0 → 1.1.0 |
    | 功能删除 | MAJOR ↑ | 1.0.0 → 2.0.0 |

4.3 版本号更新规则
    - MAJOR 变更时，MINOR 和 PATCH 重置为 0
    - MINOR 变更时，PATCH 重置为 0
    - 预发布版本升级为正式版时，去掉预发布标识

输出:
- SemVer 规范: {版本号规则}
- 变更判定表: {版本号变更判定}
```

### Step 5: CHANGELOG 规范

```
目的: 定义 CHANGELOG 格式和自动生成规则

5.1 CHANGELOG 格式
    # CHANGELOG

    ## [1.2.0] - 2024-03-15

    ### Features
    - Add user login feature (#123)
    - Add password reset (#124)

    ### Bug Fixes
    - Fix login timeout issue (#125)
    - Fix payment callback failure (#126)

    ### Breaking Changes
    - Remove deprecated `/api/v1/login` endpoint (#127)

    ### Documentation
    - Update README install steps

    ### Dependencies
    - Update axios to 1.6.0

    ## [1.1.0] - 2024-02-15
    ...

5.2 变更分类
    | 分类 | 对应 commit type |
    |------|------------------|
    | Features | feat |
    | Bug Fixes | fix |
    | Breaking Changes | feat/fix 带 BREAKING CHANGE |
    | Documentation | docs |
    | Refactoring | refactor（不影响 API） |
    | Performance | perf |
    | Dependencies | build(deps) |
    | CI/CD | ci |
    | Other | chore |

5.3 自动生成规则
    - 使用 conventional-changelog 工具
    - 从 git log 自动提取符合 Conventional Commits 的提交
    - 按版本分组（Tag 对应版本）
    - 按变更类型分类

    // package.json
    {
      "scripts": {
        "changelog": "conventional-changelog -p angular -i CHANGELOG.md -s"
      }
    }

输出:
- CHANGELOG 格式: {标准格式}
- 变更分类表: {分类规则}
- 自动生成配置: {工具配置}
```

### Step 6: Tag 规范

```
目的: 定义 Git Tag 命名和使用规则

6.1 Tag 命名规则
    - 正式版本: v{MAJOR.MINOR.PATCH}
    - 示例: v1.0.0, v1.1.0, v2.0.0

    - 预发布版本: v{MAJOR.MINOR.PATCH}-{PRERELEASE}.{N}
    - 示例: v1.0.0-alpha.1, v1.0.0-beta.2, v1.0.0-rc.1

6.2 Tag 创建时机
    | Tag 类型 | 创建时机 |
    |----------|----------|
    | 正式版本 | 发布到生产环境时 |
    | 预发布版本 | 发布到测试环境时 |
    | RC 版本 | 验收通过、准备发布时 |

6.3 Tag 创建命令
    # 创建正式版本 Tag（带签名）
    git tag -a v1.0.0 -m "Release v1.0.0" -s

    # 创建预发布版本 Tag
    git tag -a v1.0.0-beta.1 -m "Beta release for v1.0.0"

    # 推送 Tag 到远程
    git push origin v1.0.0

    # 推送所有 Tag
    git push origin --tags

6.4 Tag 与分支对应
    - Git Flow: release 分支合并到 main 后打 Tag
    - GitHub Flow: PR 合并到 main 后打 Tag
    - Trunk-Based: 提交到 main 后打 Tag

输出:
- Tag 命名规范: {命名规则}
- Tag 创建时机: {时机表}
- Tag 创建命令: {命令示例}
```

### Step 7: 产出分支策略文档

```
输出路径: .opencode/docs/branch-strategy-{project}.md

内容模板:

# 分支策略与版本规范：{项目名称}

## 项目特征
- **项目类型**: {Web应用/移动应用/库/微服务}
- **发布节奏**: {定期发布/持续部署/按需发布}
- **团队规模**: {单人/小团队/大团队}
- **环境数量**: {单环境/多环境}

## 分支策略
**选择**: {Git Flow / GitHub Flow / Trunk-Based Development}

### 分支结构
| 分支类型 | 分支名称 | 说明 | 生命周期 |
|----------|----------|------|----------|
| 主分支 | main | 生产代码，始终可部署 | 永久 |
| 开发分支 | develop | 开发集成（Git Flow） | 永久 |
| 功能分支 | feature/{id}-{desc} | 功能开发 | 临时 |
| 修复分支 | fix/{id}-{desc} | Bug 修复 | 临时 |
| 紧急修复 | hotfix/{id}-{desc} | 生产紧急修复（Git Flow） | 临时 |
| 发布分支 | release/{version} | 发布准备（Git Flow） | 临时 |

### 分支流程图
```
Git Flow 流程:
  main ← release/v1.0.0 ← develop ← feature/123-login
                     ↑
               hotfix/789-payment

GitHub Flow 流程:
  main ← feature/123-login (PR merge)

Trunk-Based 流程:
  main ← feature/123-login (short-lived branch, <1 day)
```

## 分支命名规范

### 规则
- 使用小写字母和连字符
- 必须包含 issue ID（关联任务）
- 简短描述不超过 30 字符
- 避免重复命名（只用 feature/fix/hotfix）

### 示例
| 场景 | 正确命名 | 错误命名 |
|------|----------|----------|
| 用户登录功能 | feature/123-user-login | feat/login, 123-login |
| 登录超时修复 | fix/456-login-timeout | bugfix/timeout |
| 生产支付故障 | hotfix/789-payment-fail | hotfix/payment |

## Commit 规范

### 格式
<type>(<scope>): <subject>

### Type 类型
| 类型 | 说明 | 示例 |
|------|------|------|
| feat | 新功能 | feat(auth): add user login |
| fix | Bug 修复 | fix(auth): resolve timeout |
| docs | 文档 | docs(readme): update steps |
| style | 代码风格 | style(lint): fix warnings |
| refactor | 重构 | refactor(auth): simplify flow |
| perf | 性能 | perf(query): optimize db |
| test | 测试 | test(auth): add cases |
| build | 构建 | build(deps): update axios |
| ci | CI配置 | ci(github): add deploy |
| chore | 杂项 | chore: cleanup |
| revert | 回滚 | revert: undo feat(auth) |

### commitlint 配置
// .commitlintrc.js
module.exports = {
  extends: ['@commitlint/config-conventional']
};

## 版本号规范 (SemVer)

### 格式
MAJOR.MINOR.PATCH[-PRERELEASE]

### 变更判定
| 变更类型 | 版本号变更 | 示例 |
|----------|------------|------|
| 新功能（兼容） | MINOR ↑ | 1.0.0 → 1.1.0 |
| Bug 修复 | PATCH ↑ | 1.0.0 → 1.0.1 |
| API 不兼容 | MAJOR ↑ | 1.0.0 → 2.0.0 |

### 预发布标识
| 标识 | 说明 | 示例 |
|------|------|------|
| alpha | 内部测试 | v1.0.0-alpha.1 |
| beta | 公开测试 | v1.0.0-beta.1 |
| rc | 发布候选 | v1.0.0-rc.1 |

## CHANGELOG 规范

### 格式
# CHANGELOG

## [1.2.0] - 2024-03-15

### Features
- Add user login (#123)

### Bug Fixes
- Fix login timeout (#125)

### Breaking Changes
- Remove deprecated API (#127)

### 自动生成
npm run changelog

## Tag 规范

### 命名
- 正式版本: v{MAJOR.MINOR.PATCH}
- 预发布版本: v{version}-{prerelease}.{n}

### 创建时机
| Tag 类型 | 创建时机 |
|----------|----------|
| 正式版本 | 发布到生产 |
| 预发布版本 | 发布到测试 |

### 创建命令
git tag -a v1.0.0 -m "Release v1.0.0" -s
git push origin v1.0.0

## 工具集成

### Husky + commitlint
// package.json
{
  "devDependencies": {
    "@commitlint/cli": "^17.0.0",
    "@commitlint/config-conventional": "^17.0.0",
    "husky": "^8.0.0"
  },
  "scripts": {
    "prepare": "husky install"
  }
}

// .husky/commit-msg
npx --no -- commitlint --edit $1

### standard-version（自动版本+CHANGELOG）
// package.json
{
  "scripts": {
    "release": "standard-version",
    "release:first": "standard-version --first-release"
  }
}

## 执行检查清单

### 创建新功能分支
- [ ] 从正确的基础分支创建（main/develop）
- [ ] 分支命名符合规范（feature/{id}-{desc}）
- [ ] 关联 issue ID

### 提交代码
- [ ] commit 消息符合 Conventional Commits
- [ ] type 正确（feat/fix/docs 等）
- [ ] scope 合理（模块名）
- [ ] subject 简洁（≤50字符）

### 合并代码
- [ ] 通过 PR/MR 合并
- [ ] 标题符合 commit 规范
- [ ] squash merge 保持历史整洁（可选）

### 发布版本
- [ ] 更新版本号（符合 SemVer）
- [ ] 生成 CHANGELOG
- [ ] 创建 Tag
- [ ] 推送 Tag 到远程
```

## 配合 Skills

| 配合技能 | 关系 | 说明 |
|----------|------|------|
| `project/kickoff` | 前置 | 项目启动时确立分支策略 |
| `devops/ci/pipeline` | 协同 | CI 中执行分支规范检查 |
| `dev/standards/dev-code-quality` | 协同 | commitlint 集成到 lint 流程 |
| `devops/release/release-management` | 协同 | 版本号和 Tag 来源 |
| `dev/code-review` | 参考 | PR 标题遵循 commit 规范 |

## 下一步推荐

| 条件 | 推荐技能 |
|------|----------|
| 分支策略确立 | `devops/ci/pipeline`（CI 配置分支检查） |
| 需要发布管理 | `devops/release/release-management`（版本发布） |
| 代码规范落地 | `dev/standards/dev-code-quality`（lint 配置） |

## 触发词
分支策略、Git分支、版本规范、SemVer、CHANGELOG、commit规范、版本号、Git规范、分支管理、版本管理