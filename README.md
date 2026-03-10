# oh-my-opencode-skills

统一管理的 Skills 项目，按**角色**和**协同**两个维度组织，覆盖完整 SDLC 流程。

## 📁 目录结构

```
skills/
├── collaboration/           # 协同技能 (5 项)
│   ├── handoff/
│   │   ├── collab-product-to-dev/SKILL.md   # 产品→开发需求交接
│   │   └── collab-dev-to-qa/SKILL.md        # 开发→测试提测交接
│   ├── review/
│   │   └── collab-acceptance-review/SKILL.md # 验收评审
│   ├── process/
│   │   └── collab-retrospective/SKILL.md    # 迭代复盘
│   └── sync/
│       └── document-alignment/SKILL.md      # 文档对齐
├── dev/                   # 开发技能 (4 项)
│   ├── context/
│   │   └── dev-context-first/SKILL.md       # 开发前获取最小上下文
│   ├── implementation/
│   │   └── dev-implementation/SKILL.md      # 功能实现
│   └── code-review/SKILL.md                 # 代码审查 (增强版 605 行)
├── devops/                # DevOps 技能 (7 项)
│   ├── ci/
│   │   └── pipeline/SKILL.md                # CI/CD 流水线
│   ├── deploy/
│   │   ├── dockerfile/SKILL.md              # Docker 部署
│   │   ├── k8s/SKILL.md                     # Kubernetes 部署
│   │   └── multi-env/SKILL.md               # 多环境管理
│   ├── monitoring/
│   │   └── observability/SKILL.md           # 监控与可观测性
│   ├── data/
│   │   └── migration/SKILL.md               # 数据库迁移
│   └── cost-optimization/SKILL.md           # 成本优化
├── product/               # 产品技能 (8 项)
│   ├── requirement/
│   │   └── product-requirement-analysis/SKILL.md  # 需求分析
│   ├── feedback/
│   │   └── analysis/SKILL.md                # 用户反馈分析
│   └── module/
│       └── module-document-keeper/SKILL.md  # 模块文档管理
├── project/               # 项目技能 (1 项)
│   └── kickoff/SKILL.md                     # 项目启动
├── qa/                    # 测试技能 (3 项)
│   ├── context/
│   │   └── qa-context-first/SKILL.md        # 测试前获取最小上下文
│   ├── test-case/
│   │   └── test-case-design/SKILL.md        # 测试用例设计
│   └── execution/
│       └── test-executor/SKILL.md           # 测试执行
└── system/                # 系统技能 (3 项)
    ├── auto-skill-dispatcher/SKILL.md       # 自动技能调度器
    ├── document-integrity-check/SKILL.md    # 文档完整性检查
    └── security/
        └── compliance/SKILL.md              # 安全合规
```

**总计**: 25 个技能，统一采用 `SKILL.md` 格式

---

## 📊 完整 Skills 清单

### 1. 项目管理 (Project) - 1 项

| Skill | 说明 | 触发词 |
|-------|------|--------|
| `project/kickoff` | 项目启动器 | 启动项目、新项目、项目初始化 |

### 2. 产品 (Product) - 8 项

| Skill | 说明 | 触发词 |
|-------|------|--------|
| `product/requirement/product-requirement-analysis` | 需求分析与用户故事编写 | 需求分析、用户故事、需求澄清 |
| `product/requirement/product-requirement-structuring` | 需求整理与结构化 | 需求整理、结构化需求 |
| `product/analysis/global-project-analysis` | 项目全局分析 | 项目分析、模块划分、全局梳理 |
| `product/analysis/data-analysis` | 数据分析与埋点 | 数据分析、埋点、指标 |
| `product/analysis/product-technical-assessment` | 技术评估 | 技术评估、技术可行性 |
| `product/module/module-product-requirement` | 模块需求细化 | 模块需求、详细需求 |
| `product/module/module-document-keeper` | 模块文档管理 | 模块文档、文档整理、把控全局 |
| `product/feedback/analysis` | 用户反馈分析 | 用户反馈、反馈分析、NPS、A/B 测试 |

### 3. 开发 (Dev) - 4 项

| Skill | 说明 | 触发词 |
|-------|------|--------|
| `dev/context/dev-context-first` | 开发前获取最小上下文 | 给我上下文、先看看代码、先了解下 |
| `dev/context/module-dev-context` | 模块上下文获取 | 模块上下文、了解模块 |
| `dev/implementation/dev-implementation` | 功能实现 | 实现功能、编写代码、开发功能 |
| `dev/code-review` | 代码审查 (增强版) | 代码审查、Code Review、CR、代码检查、代码评审、代码质量 |

### 4. 测试 (QA) - 3 项

| Skill | 说明 | 触发词 |
|-------|------|--------|
| `qa/context/qa-context-first` | 测试前获取最小上下文 | 测试上下文、了解被测功能 |
| `qa/test-case/test-case-design` | 测试用例设计 | 测试用例、设计用例、测试场景 |
| `qa/execution/test-executor` | 测试执行 | 执行测试、运行测试、测试报告 |

### 5. 协同 (Collaboration) - 5 项

| Skill | 说明 | 触发词 |
|-------|------|--------|
| `collaboration/handoff/collab-product-to-dev` | 产品→开发需求交接 | 需求交接、需求评审、开发确认 |
| `collaboration/handoff/collab-dev-to-qa` | 开发→测试提测交接 | 提测、测试交接、开发完成、申请测试 |
| `collaboration/review/collab-acceptance-review` | 验收评审 | 验收、UAT、验收评审、产品验收、上线确认 |
| `collaboration/process/collab-retrospective` | 迭代复盘 | 复盘、回顾、总结、retro、迭代总结 |
| `collaboration/sync/document-alignment` | 文档对齐 | 文档对齐、文档同步、三方对齐 |

### 6. 系统 (System) - 3 项

| Skill | 说明 | 触发词 |
|-------|------|--------|
| `system/auto-skill-dispatcher` | 自动技能调度器 | [所有] - 自动识别任务类型 |
| `system/document-integrity-check` | 文档完整性检查 | 文档检查、完整性检查、文档审计 |
| `system/security/compliance` | 安全合规 | 安全审计、合规检查、GDPR、数据加密、SOC2 |

### 7. DevOps - 7 项

| Skill | 说明 | 触发词 |
|-------|------|--------|
| `devops/ci/pipeline` | CI/CD 流水线 | CI/CD、流水线、GitHub Actions、Jenkins |
| `devops/deploy/dockerfile` | Docker 部署 | Docker、容器化、dockerfile |
| `devops/deploy/k8s` | Kubernetes 部署 | K8s、Kubernetes、kubectl |
| `devops/deploy/multi-env` | 多环境管理 | 多环境、环境配置、dev/staging/prod |
| `devops/monitoring/observability` | 监控与可观测性 | 监控、告警、日志、链路追踪、Grafana、Prometheus |
| `devops/data/migration` | 数据库迁移 | 数据库迁移、数据变更、DDL、迁移脚本 |
| `devops/cost-optimization` | 成本优化 | 成本优化、云成本、FinOps、预算管理 |

---

## 🔄 完整 SDLC 流程

```
产品规划 → 需求交接 → 开发实现 → 提测交接 → 测试验证 → 验收评审 → 上线部署 → 迭代复盘
    ↓           ↓           ↓           ↓           ↓           ↓           ↓           ↓
requirement  交接单    implementation 提测单    test-cases  验收报告   部署配置    复盘报告
```

### 核心调用链路

#### 链路 1: 完整 SDLC (11 步)
```
product-requirement-analysis
  → collab-product-to-dev
    → dev-context-first
      → dev-implementation
        → dev-code-review
          → collab-dev-to-qa
            → test-case-design
              → test-executor
                → collab-acceptance-review
                  → collab-retrospective
```

#### 链路 2: Bug 修复 (4 步)
```
dev-context-first
  → dev-implementation
    → dev-code-review
      → test-executor
```

#### 链路 3: 文档审计 (3 步)
```
module-document-keeper
  → document-integrity-check
    → document-alignment
```

#### 链路 4: DevOps 部署 (6 步)
```
ci-pipeline
  → dockerfile
    → k8s
      → multi-env
        → observability
          → cost-optimization
```

---

## 📚 文档

| 文档 | 说明 |
|------|------|
| [`TASK_CHECKLIST.md`](./TASK_CHECKLIST.md) | 完整任务清单 - 25 个技能的详细 checklists |
| [`SKILL_INVOCATION_CHAIN.md`](./SKILL_INVOCATION_CHAIN.md) | 技能调用链路 - 触发条件、依赖关系、输出流转 |

---

## 🚀 使用方式

### 方式 1: 自动调度 (推荐)

```typescript
skill(name="system/auto-skill-dispatcher", user_message="帮我实现用户登录功能")
```

### 方式 2: 手动调用 Skill

```typescript
skill(name="product/requirement/product-requirement-analysis", user_message="分析用户注册需求")
```

### 方式 3: 通过 Task 加载 Skill

```typescript
task(
  category="unspecified-high",
  load_skills=["product/requirement/product-requirement-analysis"],
  prompt="分析用户登录功能需求"
)
```

### 方式 4: 完整流程调用

```typescript
// 阶段 1: 需求分析
task(category="unspecified-high", load_skills=["product/requirement/product-requirement-analysis"])

// 阶段 2: 开发实现
task(category="deep", load_skills=["dev/context/dev-context-first", "dev/implementation/dev-implementation"])

// 阶段 3: 测试验证
task(category="unspecified-high", load_skills=["qa/test-case/test-case-design", "qa/execution/test-executor"])
```

---

## 🎭 角色技能映射

| 角色 | 主要技能 |
|------|---------|
| **产品经理** | 需求分析、需求整理、项目分析、用户反馈分析、需求交接、验收评审 |
| **开发工程师** | 上下文获取、功能实现、代码审查、提测交接 |
| **测试工程师** | 测试上下文、用例设计、测试执行、提测交接、验收评审 |
| **DevOps 工程师** | CI/CD、Docker、K8s、多环境、监控、数据库迁移、成本优化 |
| **技术负责人** | 代码审查、文档审计、安全合规、迭代复盘 |

---

## ⚙️ 配置

### oh-my-opencode.json

```json
{
  "skills": {
    "sources": ["C:\\Users\\Administrator\\skills"]
  },
  "agents": {
    "sisyphus": {
      "skills": [
        "system/auto-skill-dispatcher",
        "system/document-integrity-check",
        "system/security/compliance",
        "project/kickoff",
        "product/requirement/product-requirement-analysis",
        "product/requirement/product-requirement-structuring",
        "product/analysis/global-project-analysis",
        "product/analysis/data-analysis",
        "product/analysis/product-technical-assessment",
        "product/module/module-product-requirement",
        "product/module/module-document-keeper",
        "product/feedback/analysis",
        "dev/context/dev-context-first",
        "dev/implementation/dev-implementation",
        "dev/code-review",
        "qa/context/qa-context-first",
        "qa/test-case/test-case-design",
        "qa/execution/test-executor",
        "collaboration/handoff/collab-product-to-dev",
        "collaboration/handoff/collab-dev-to-qa",
        "collaboration/review/collab-acceptance-review",
        "collaboration/process/collab-retrospective",
        "collaboration/sync/document-alignment",
        "devops/ci/pipeline",
        "devops/deploy/dockerfile",
        "devops/deploy/k8s",
        "devops/deploy/multi-env",
        "devops/monitoring/observability",
        "devops/data/migration",
        "devops/cost-optimization"
      ]
    }
  }
}
```

---

## 📈 统计

- **技能总数**: 25
- **文档总数**: 2 (TASK_CHECKLIST.md, SKILL_INVOCATION_CHAIN.md)
- **覆盖阶段**: 7 (产品规划、协同交接、开发实现、测试验证、系统检查、项目管理、DevOps)
- **产出文档**: 22 类 (requirement-*.md, implementation-*.md, test-cases-*.md, etc.)

---

**最后更新**: 2026-03-10  
**版本**: v2.0
