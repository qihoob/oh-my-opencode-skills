# oh-my-opencode-skills

统一管理的 Skills 项目，按**角色**和**协同**两个维度组织。

## 目录结构

```
skills/
├── collaboration/    # 协同技能
│   ├── handoff/     # 角色间交接
│   ├── review/      # 评审活动
│   ├── process/     # 流程管理
│   └── sync/        # 同步对齐
├── dev/             # 开发技能
│   ├── implementation/
│   ├── context/
│   ├── modules/
│   └── standards/
├── devops/          # DevOps技能
│   ├── deploy/
│   └── ci/
├── product/         # 产品技能
│   ├── requirement/
│   ├── analysis/
│   └── module/
├── project/         # 项目技能
├── qa/              # 测试技能
│   ├── context/
│   ├── test-case/
│   ├── execution/
│   └── advanced/
├── visual/          # 视觉技能
└── system/          # 系统技能
```

## Skills 清单

### 角色 Skills

| 角色 | 目录 | 核心技能 |
|------|------|----------|
| 项目 | project/ | kickoff |
| 产品 | product/ | 需求分析、项目分析、模块需求 |
| 开发 | dev/ | 功能实现、上下文、模块开发 |
| 测试 | qa/ | 用例设计、测试执行、上下文 |
| 视觉 | visual/ | 设计评审、设计稿交接 |
| DevOps | devops/ | 部署配置、CI/CD |

### 协同 Skills

| 类型 | 目录 | 技能 |
|------|------|------|
| 交接 | collaboration/handoff/ | 产品→开发、开发→测试、视觉→产品、视觉→开发 |
| 评审 | collaboration/review/ | 验收评审 |
| 流程 | collaboration/process/ | 复盘、迭代闭环、Bug协调 |
| 同步 | collaboration/sync/ | 上下文对齐、故障响应 |

## 使用方式

### 自动调度（推荐）
```typescript
skill(name="system/auto-skill-dispatcher", user_message="帮我实现用户登录功能")
```

### 手动调用
```typescript
task(
  category="product",
  load_skills=["product/requirement/requirement-analysis"],
  prompt="分析需求"
)
```

## 配置

在 `oh-my-opencode.json` 中配置：

```json
{
  "skills": {
    "sources": ["C:\\Users\\Administrator\\skills"]
  }
}
```

## 调度逻辑

自动调度器根据关键词匹配：

| 关键词 | → | Skill |
|--------|---|-------|
| 启动项目 | → | project/kickoff |
| 需求分析 | → | product/requirement/requirement-analysis |
| 开发功能 | → | dev/implementation/implementation |
| 测试用例 | → | qa/test-case/test-case-design |
| 设计评审 | → | visual/design-review |
| 验收 | → | collaboration/review/acceptance-review |
| 复盘 | → | collaboration/process/retrospective |