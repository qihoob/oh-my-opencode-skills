# oh-my-opencode-skills

统一管理的 Skills 项目，包含产品、开发、测试、协同等完整角色技能。

## 项目结构

```
skills/
├── collaboration/     # 协同技能 (6)
├── dev/              # 开发技能 (8)
├── devops/           # DevOps技能 (4)
├── product/          # 产品技能 (5)
├── project/          # 项目技能 (1)
├── qa/               # 测试技能 (4)
├── system/           # 系统技能 (2)
├── yaml/             # YAML 格式 Skills (10)
└── docs/             # 文档 (5)
```

## Skills 统计

| 目录 | 数量 |
|------|------|
| collaboration/ | 6 |
| dev/ | 8 |
| devops/ | 4 |
| product/ | 5 |
| project/ | 1 |
| qa/ | 4 |
| system/ | 2 |
| yaml/ | 10 |
| **总计** | **40** |

## 完整 Skills 列表

### 1. System (系统) - 2

| Skill | 说明 |
|-------|------|
| `auto-skill-dispatcher` | 自动技能调度器，一键调用入口 |
| `auto-skill-dispatcher.yaml` | 调度器配置 |

### 2. Project (项目) - 1

| Skill | 说明 |
|-------|------|
| `project-kickoff` | 项目启动器，统领全流程 |

### 3. Product (产品) - 5

| Skill | 说明 |
|-------|------|
| `product-requirement-analysis` | 需求分析，强调可用/易用/好用 |
| `global-project-analysis` | 全局项目分析，模块划分 |
| `module-product-requirement` | 模块需求产出 |
| `system-log-requirements` | 系统日志/操作日志需求分析 |
| `stability-logging-requirements` | 系统稳定性监控/业务埋点需求 |

### 4. Dev (开发) - 8

| Skill | 说明 |
|-------|------|
| `dev-context-first` | 开发前先了解最小上下文 |
| `dev-implementation` | 功能实现 |
| `module-collaborative-dev` | 多模块协同开发 |
| `module-splitting` | 模块拆解器 |
| `parallel-module-orchestrator` | 并行模块编排器 |
| `module-dev-context` | 模块开发上下文 |
| `system-log-implementation` | 统一日志服务实现 |
| `stability-logging-implementation` | 监控埋点/告警服务实现 |

### 5. DevOps (部署) - 4

| Skill | 说明 |
|-------|------|
| `multi-env-config-design` | 多环境配置设计 |
| `dockerfile-generation` | Docker 配置生成 |
| `k8s-deployment` | K8s 部署配置 |
| `config-isolation-patterns` | 配置隔离模式 |

### 6. QA (测试) - 4

| Skill | 说明 |
|-------|------|
| `qa-context-first` | 测试前先了解最小上下文 |
| `qa-test-case-design` | 用例设计 |
| `test-executor` | 测试执行器 |
| `module-test-context` | 模块测试上下文 |

### 7. Collaboration (协同) - 6

| Skill | 说明 |
|-------|------|
| `bug-coordinator` | Bug协调器 |
| `collab-product-to-dev` | 产品→开发过渡 |
| `collab-dev-to-qa` | 开发→测试过渡 |
| `collab-acceptance-review` | 验收评审 |
| `collab-retrospective` | 迭代复盘 |
| `iteration_closure` | 复盘闭环 |

### 8. YAML Skills (10)

| Skill | 说明 |
|-------|------|
| `collaboration-skills.yaml` | 协同技能集 (14) |
| `context-skills.yaml` | 上下文管理技能 (4) |
| `dev-skills.yaml` | 开发技能集 (14) |
| `global-product-skills.yaml` | 全局产品技能 (4) |
| `module-dev-test-skills.yaml` | 模块开发/测试技能 (13) |
| `module-product-skills.yaml` | 模块产品技能 (5) |
| `module-skills.yaml` | 模块管理技能 (5) |
| `product-skills.yaml` | 产品技能集 (8) |
| `qa-skills.yaml` | 测试技能集 (11) |
| `skills-registry.yaml` | 注册索引 |

## 安装

```bash
# 配置 oh-my-opencode 使用此目录
# 在 oh-my-opencode.json 中配置:
{
  "skills": {
    "sources": ["C:\\Users\\Administrator\\skills"]
  }
}
```

## 使用

### 一键自动调用

```typescript
skill(name="system/auto-skill-dispatcher", user_message="帮我实现用户登录功能")
```

### 手动调用

```typescript
task(
  category="unspecified-high",
  load_skills=["product/product-requirement-analysis"],
  prompt="分析需求"
)
```

## 新增 Skills 说明

### DevOps / 多环境配置 (2026-03-04 新增)

| Skill | 说明 |
|-------|------|
| `devops-multi-env-config-design` | 多环境配置设计 |
| `devops-dockerfile-generation` | Docker 配置生成 |
| `devops-k8s-deployment` | K8s 部署配置 |
| `devops-config-isolation-patterns` | 配置隔离模式 |

### 系统日志 (2026-03-04 新增)

| Skill | 说明 |
|-------|------|
| `product-system-log-requirements` | 系统日志/操作日志需求分析 |
| `dev-system-log-implementation` | 统一日志服务实现 |

### 稳定性日志 (2026-03-04 新增)

| Skill | 说明 |
|-------|------|
| `product-stability-logging-requirements` | 系统稳定性监控/业务埋点需求 |
| `dev-stability-logging-implementation` | 监控埋点/告警服务实现 |

## 文档

- [完整 Skills 索引](docs/COMPLETE_SKILLS_INDEX.md)
- [工作流手册](docs/WORKFLOW_MANUAL.md)
- [工作流 Skills](docs/WORKFLOW_SKILLS.md)