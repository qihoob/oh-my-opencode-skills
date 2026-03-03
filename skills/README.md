# oh-my-opencode-skills

专为 oh-my-opencode 开发的项目管理 Skills 套件，支持从需求分析到产品验收的完整开发流程。

## 概述

本项目提供 21 个专业 Skills，覆盖项目管理全生命周期：

- **项目启动**: project-kickoff
- **需求分析**: product-requirement-analysis, global-project-analysis, module-product-requirement
- **模块开发**: module-splitting, module-collaborative-dev, parallel-module-orchestrator
- **编码实现**: dev-implementation, dev-context-first, module-dev-context
- **测试执行**: qa-test-case-design, qa-context-first, module-test-context, test-executor
- **协同工作**: bug-coordinator, collab-product-to-dev, collab-dev-to-qa, collab-acceptance-review
- **项目复盘**: collab-retrospective, iteration-closure
- **智能调度**: auto-skill-dispatcher

## 功能特点

### 1. 完整工作流

```
需求分析 → 模块拆解 → 并行开发 → 测试执行 → Bug修复 → 产品验收 → 迭代复盘
```

### 2. 模块化设计

- 每个 Skill 职责单一，可独立使用
- 支持按场景灵活组合
- 关键词自动触发

### 3. 多模块并行

- 支持多模块并行开发
- 自动分析模块依赖
- 动态任务编排

## 安装

### 方式1: 一键安装（推荐）

```bash
# 克隆到 skills 目录
cd ~/.config/opencode
git clone https://github.com/<your-username>/oh-my-opencode-skills.git skills-temp

# 复制配置和 skills
cp oh-my-opencode.json skills-temp/oh-my-opencode.json
cp -r skills/* skills-temp/

# 清理临时文件
rm -rf skills-temp
```

### 方式2: 手动安装

```bash
# 1. 克隆仓库
cd ~/.config/opencode
git clone https://github.com/<your-username>/oh-my-opencode-skills.git skills

# 2. 确保配置文件存在
# 如果已有 ~/.config/opencode/oh-my-opencode.json，请先备份
# 然后复制配置:
cp skills/oh-my-opencode.json ~/.config/opencode/oh-my-opencode.json
```

## 配置

### 自动分发配置

Skills 已配置自动关键词触发，示例:

| 关键词 | 触发 Skill |
|--------|-----------|
| 启动项目 | project-kickoff |
| 需求分析 | product-requirement-analysis |
| 模块拆解 | module-splitting |
| 并行开发 | parallel-module-orchestrator |
| 测试执行 | test-executor |
| Bug | bug-coordinator |
| 验收 | collab-acceptance-review |

### 手动调用

```bash
# 直接调用 skill
skill(project-kickoff)
skill(module-splitting)
skill(parallel-module-orchestrator)

# 在 task 中使用
task(load_skills=["project/project-kickoff"], prompt="...")
```

## 使用示例

### 示例1: 启动新项目

```bash
skill(project-kickoff)
# 输入: "创建一个电商平台，包含用户、订单、商品、支付模块"
```

### 示例2: 模块拆解

```bash
skill(module-splitting)
# 输入: "电商平台: 用户注册登录、商品浏览、购物车、订单、支付功能"
```

### 示例3: 并行模块开发

```bash
skill(parallel-module-orchestrator)
# 输入: "电商项目，用户、订单、商品、支付四个模块并行开发"
```

### 示例4: 关键词触发

直接在 opencode 中输入:
```
帮我启动一个新项目，是在线教育平台
```
系统会自动识别并启动 project-kickoff。

## Skills 列表

| Skill | 说明 |
|-------|------|
| project-kickoff | 项目启动器，统领全流程 |
| product-requirement-analysis | 产品需求分析 |
| global-project-analysis | 全局项目分析 |
| module-product-requirement | 模块需求产出 |
| module-splitting | 模块拆解器 |
| module-collaborative-dev | 多模块协同开发 |
| parallel-module-orchestrator | 并行模块编排器 |
| dev-implementation | 功能实现 |
| dev-context-first | 开发获取上下文 |
| module-dev-context | 模块开发上下文 |
| qa-test-case-design | 测试用例设计 |
| qa-context-first | 测试获取上下文 |
| module-test-context | 模块测试上下文 |
| test-executor | 测试执行器 |
| bug-coordinator | Bug协调器 |
| collab-product-to-dev | 产品到开发交接 |
| collab-dev-to-qa | 开发到测试交接 |
| collab-acceptance-review | 验收评审 |
| collab-retrospective | 迭代复盘 |
| iteration-closure | 迭代闭环 |
| auto-skill-dispatcher | 自动分发器 |

## 项目结构

```
oh-my-opencode-skills/
├── README.md                    # 本文件
├── oh-my-opencode.json          # 默认配置
└── skills/
    ├── system/
    │   └── auto-skill-dispatcher.md
    ├── project/
    │   └── project-kickoff.md
    ├── product/
    │   ├── product-requirement-analysis.md
    │   ├── global-project-analysis.md
    │   └── module-product-requirement.md
    ├── dev/
    │   ├── module-splitting.md
    │   ├── module-collaborative-dev.md
    │   ├── parallel-module-orchestrator.md
    │   ├── dev-implementation.md
    │   ├── dev-context-first.md
    │   └── module-dev-context.md
    ├── qa/
    │   ├── test-executor.md
    │   ├── qa-test-case-design.md
    │   ├── qa-context-first.md
    │   └── module-test-context.md
    └── collaboration/
        ├── bug-coordinator.md
        ├── collab-product-to-dev.md
        ├── collab-dev-to-qa.md
        ├── collab-acceptance-review.md
        ├── collab-retrospective.md
        └── iteration-closure.md
```

## 依赖

- oh-my-opencode >= 1.0
- Node.js >= 18

## 更新日志

### v1.0.0 (2024-03-03)
- 初始版本
- 21 个专业 Skills
- 完整项目管理流程支持
- 多模块并行开发能力

## 许可证

MIT License

## 贡献

欢迎提交 Issue 和 Pull Request！