---
name: project-resume
description: (opencode - Skill) 项目继续 - 一键继续已开始的项目，自动识别当前阶段并推荐技能链
subtask: true
argument-hint: "<当前项目阶段> 或 <项目继续>"
---

# 项目继续 Skill

## 角色

你是项目继续专家，负责为一键继续已启动的项目，自动识别当前阶段并推荐下一步技能链。

## 核心功能

### 1. 阶段识别

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                           项目阶段智能识别                                   │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  用户输入: "继续开发" 或 "项目做到一半"                                       │
│                           ↓                                                 │
│  ┌─────────────────────────────────────────────────────────────────────┐   │
│  │ 智能分析 → 识别当前阶段 → 推荐后续技能                                 │   │
│  └─────────────────────────────────────────────────────────────────────┘   │
│                           ↓                                                 │
│  输出: 当前阶段 + 推荐技能链 + 一键调用入口                                   │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 2. 阶段与技能链映射

| 阶段 | 说明 | 推荐技能链 |
|------|------|------------|
| **项目启动** | 刚创建项目，还未开始需求分析 | `project-kickoff` → `product-requirement-analysis` |
| **需求分析** | 正在分析需求/写用户故事 | `product-requirement-analysis` → `global-project-analysis` |
| **需求评审** | 需求评审中或刚完成 | `collaborative-requirement-optimization` → `module-splitting` |
| **模块拆分** | 正在拆分模块/定义接口 | `module-splitting` → `project-task-distribution` |
| **开发中** | 正在进行功能开发 | `parallel-module-orchestrator` → `dev-implementation` |
| **开发完成** | 开发完成，等待测试 | `collab-dev-to-qa` → `qa-test-case-design` |
| **测试中** | 正在进行测试 | `test-executor` → `collab-test-debug-cycle` |
| **Bug修复** | 修复测试发现的Bug | `collab-test-debug-cycle` → `bug-coordinator` |
| **验收** | 等待产品验收 | `collab-acceptance-review` |
| **上线** | 准备部署上线 | `multi-env-config-design` → `dockerfile-generation` → `k8s-deployment` |
| **迭代** | 准备下一轮迭代 | `collab-retrospective` → `iteration_closure` |

### 3. 快速调用示例

```
用户: "继续开发"
↓
// 自动识别为"开发中"阶段
// 输出:
## 当前阶段: 开发中

### 推荐技能链

#### 立即可用:
1. [一键继续开发] `parallel-module-orchestrator` - 继续并行模块开发
2. [继续前端] `dev/dev-frontend-implementation` - 继续前端实现
3. [继续后端] `dev/dev-backend-implementation` - 继续后端实现

#### 技能调用:
skill(name="parallel-module-orchestrator", user_message="继续当前模块开发")

// 用户也可以指定具体模块
skill(name="dev/backend-implementation", user_message="继续开发订单模块")
```

```
用户: "继续测试"
↓
// 自动识别为"测试中"阶段
// 输出:
## 当前阶段: 测试中

### 推荐技能链

1. [继续测试] `test-executor` - 继续执行测试用例
2. [Bug循环] `collab-test-debug-cycle` - 测试→修复→验证循环
3. [Bug追踪] `bug-coordinator` - 查看和管理Bug列表
```

```
用户: "修复Bug"
↓
// 自动识别为"Bug修复"阶段
// 输出:
## 当前阶段: Bug修复中

### 推荐技能链

1. [快速修复] `collab-test-debug-cycle` - 进入测试修复循环
2. [查看Bug] `bug-coordinator` - 查看当前Bug列表
3. [继续开发] `dev/implementation` - 修复具体Bug
```

## 输入格式

### 方式1: 自然语言

```
"继续开发"
"项目做到一半了"
"刚才在做需求分析"
"继续测试"
"修复Bug"
"准备上线"
```

### 方式2: 明确阶段

```
"继续需求评审"
"继续模块拆分"
"继续Bug修复"
"继续验收"
```

### 方式3: 跳过询问，直接指定

```
"开发中，继续"
"测试阶段"
"开发完成，等待测试"
```

## 输出格式

```markdown
## 当前阶段: [阶段名]

### 📍 项目状态
- 上次工作: [描述]
- 当前状态: [状态描述]

### 🎯 推荐技能链

#### 继续当前工作
1. **技能A** - [作用描述]
   - 入口: `skill(name="skill-a", user_message="...")`

2. **技能B** - [作用描述]
   - 入口: `skill(name="skill-b", user_message="...")`

#### 快速操作
- [一键继续] - 使用上次未完成的工作继续
- [跳过此步] - 跳到下一步

### 📊 项目进度

```
需求分析 ████████████ 100%
模块拆分 ██████████░░ 80%
开发    ██████░░░░░░░ 60%
测试    ███░░░░░░░░░░ 20%
验收    ░░░░░░░░░░░░░  0%
```

### 🔗 常用快捷

| 操作 | 技能 |
|------|------|
| 继续开发 | `parallel-module-orchestrator` |
| 继续测试 | `test-executor` |
| 查看Bug | `bug-coordinator` |
| 部署上线 | `dockerfile-generation` |
```

## 触发词

继续、继续开发、继续测试、继续工作、项目做到一半、刚才在做、项目继续、接着做、还没完、做到一半、修复Bug、上线、验收、迭代

## 配合 Skills

| 场景 | Skill |
|------|-------|
| 项目刚启动 | `project-kickoff` |
| 查看完整流程 | `project-skills-workflow` |
| 查看团队配置 | `project-team-configuration` |
| 任务分配 | `project-task-distribution` |

## 使用示例

```typescript
// 用户: "继续开发"
skill(name="project-resume", user_message="继续开发")

// 用户: "项目做到一半"
skill(name="project-resume", user_message="项目做到一半了")

// 用户: "继续测试"
skill(name="project-resume", user_message="继续测试")
```