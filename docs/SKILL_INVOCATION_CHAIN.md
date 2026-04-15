# Skill 调用链路图

基于 53 个技能的完整调用链路分析，包含触发条件、依赖关系、输出流转

---

## 调用链路总览

```
┌──────────────────────────────────────────────────────────────────────────────────┐
│                              入口层 (Entry Layer)                                 │
│  ┌─────────────────────────────────────────────────────────────────────────────┐ │
│  │ system/auto-skill-dispatcher (自动调度器)                                    │ │
│  │ system/chain-executor (链路执行器)                                           │ │
│  │ system/state-tracker (状态追踪器)                                            │ │
│  │ 触发词：[所有] - 根据用户输入自动识别并调度合适技能                           │ │
│  └─────────────────────────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────────────────────────┘
                                      |
                                      v
┌──────────────────────────────────────────────────────────────────────────────────┐
│                            上下文层 (Context Layer)                                │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐               │
│  │ dev-context-first │  │ qa-context-first │  │ module-dev-context│               │
│  │ (开发前上下文)     │  │ (测试前上下文)    │  │ (模块上下文)       │               │
│  └──────────────────┘  └──────────────────┘  └──────────────────┘               │
│  ┌──────────────────┐                                                             │
│  │ module-test-     │                                                             │
│  │ context          │                                                             │
│  │ (模块测试上下文)   │                                                             │
│  └──────────────────┘                                                             │
└──────────────────────────────────────────────────────────────────────────────────┘
                                      |
                                      v
┌──────────────────────────────────────────────────────────────────────────────────┐
│                           产品层 (Product Layer)                                   │
│  ┌───────────────────┐ ┌──────────────────┐ ┌──────────────────┐                 │
│  │product-requirement │ │product-          │ │product-technical-│                 │
│  │-analysis           │ │requirement-      │ │assessment        │                 │
│  │(需求分析)           │ │structuring       │ │(技术评估)         │                 │
│  └───────────────────┘ │(需求整理)          │ └──────────────────┘                 │
│  ┌───────────────────┐ └──────────────────┘ ┌──────────────────┐                 │
│  │product-collabora- │ ┌──────────────────┐ │product-page-     │                 │
│  │tive-requirement-  │ │global-project-   │ │feature-best-     │                 │
│  │optimization       │ │analysis          │ │practices         │                 │
│  │(三方需求评审)       │ │(全局分析)         │ │(页面最佳实践)     │                 │
│  └───────────────────┘ └──────────────────┘ └──────────────────┘                 │
│  ┌───────────────────┐ ┌──────────────────┐ ┌──────────────────┐                 │
│  │module-product-    │ │module-document-  │ │data-analysis     │                 │
│  │requirement        │ │keeper            │ │(数据分析)         │                 │
│  │(模块需求)           │ │(文档管理)         │ └──────────────────┘                 │
│  └───────────────────┘ └──────────────────┘                                      │
│  ┌───────────────────┐                                                            │
│  │feedback-analysis  │                                                            │
│  │(反馈分析)           │                                                            │
│  └───────────────────┘                                                            │
└──────────────────────────────────────────────────────────────────────────────────┘
                                      |
                                      v
┌──────────────────────────────────────────────────────────────────────────────────┐
│                            执行层 (Execution Layer)                                │
│  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐            │
│  │dev-          │ │frontend      │ │backend       │ │module-       │            │
│  │implementation│ │(前端开发)     │ │(后端开发)     │ │splitting     │            │
│  │(功能实现)     │ └──────────────┘ └──────────────┘ │(模块拆解)     │            │
│  └──────────────┘ ┌──────────────┐ ┌──────────────┐ └──────────────┘            │
│  ┌──────────────┐ │module-       │ │parallel-     │ ┌──────────────┐            │
│  │dev-code-     │ │collaborative-│ │module-       │ │verify-       │            │
│  │review        │ │dev           │ │orchestrator  │ │implementation│            │
│  │(代码审查)     │ │(多模块协同)   │ │(并行开发)     │ │(需求验证)     │            │
│  └──────────────┘ └──────────────┘ └──────────────┘ └──────────────┘            │
│  ┌──────────────┐ ┌──────────────┐                                            │
│  │dev-code-     │ │dev-frontend- │                                            │
│  │quality       │ │standards     │                                            │
│  │(代码质量)     │ │(前端规范)     │                                            │
│  └──────────────┘ └──────────────┘                                            │
└──────────────────────────────────────────────────────────────────────────────────┘
                                      |
                                      v
┌──────────────────────────────────────────────────────────────────────────────────┐
│                             测试层 (QA Layer)                                      │
│  ┌──────────────┐ ┌──────────────┐ ┌──────────────┐ ┌──────────────┐            │
│  │test-case-    │ │test-case-    │ │test-executor │ │e2e-testing   │            │
│  │design        │ │prioritization│ │(测试执行)     │ │(E2E测试)      │            │
│  │(用例设计)     │ │(用例优先级)   │ └──────────────┘ └──────────────┘            │
│  └──────────────┘ └──────────────┘ ┌──────────────┐                            │
│                                       │performance- │                            │
│                                       │testing      │                            │
│                                       │(性能测试)    │                            │
│                                       └──────────────┘                            │
└──────────────────────────────────────────────────────────────────────────────────┘
                                      |
                                      v
┌──────────────────────────────────────────────────────────────────────────────────┐
│                           协同层 (Collaboration Layer)                             │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐               │
│  │collab-product-to │  │collab-dev-to-qa  │  │collab-acceptance │               │
│  │-dev              │  │(提测交接)         │  │-review (验收)    │               │
│  │(需求交接)         │  │                  │  │                  │               │
│  └──────────────────┘  └──────────────────┘  └──────────────────┘               │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐               │
│  │document-alignment│  │collab-retrospect-│  │bug-coordinator   │               │
│  │(文档对齐)         │  │ive (复盘)         │  │(Bug协调)          │               │
│  └──────────────────┘  └──────────────────┘  └──────────────────┘               │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐               │
│  │iteration-closure │  │context-alignment │  │incident          │               │
│  │(迭代闭环)         │  │(上下文同步)       │  │(线上故障)         │               │
│  └──────────────────┘  └──────────────────┘  └──────────────────┘               │
└──────────────────────────────────────────────────────────────────────────────────┘
                                      |
                                      v
┌──────────────────────────────────────────────────────────────────────────────────┐
│                          视觉设计层 (Visual Layer)                                  │
│  ┌──────────────────────────────┐  ┌──────────────────────────────┐             │
│  │ design-handoff               │  │ design-review                │             │
│  │ (设计稿交接)                   │  │ (设计评审)                    │             │
│  └──────────────────────────────┘  └──────────────────────────────┘             │
└──────────────────────────────────────────────────────────────────────────────────┘
                                      |
                                      v
┌──────────────────────────────────────────────────────────────────────────────────┐
│                         DevOps 层 (DevOps Layer)                                   │
│  ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐ ┌──────────┐              │
│  │ci-       │ │dockerfile│ │k8s       │ │multi-env │ │observa-  │              │
│  │pipeline  │ │(容器化)   │ │(K8s部署)  │ │(多环境)   │ │bility    │              │
│  │(流水线)   │ └──────────┘ └──────────┘ └──────────┘ │(监控)     │              │
│  └──────────┘ ┌──────────┐ ┌──────────┐              └──────────┘              │
│                │migration │ │cost-     │                                         │
│                │(数据迁移)  │ │optimiza- │                                         │
│                └──────────┘ │tion      │                                         │
│                              │(成本优化) │                                         │
│                              └──────────┘                                         │
└──────────────────────────────────────────────────────────────────────────────────┘
                                      |
                                      v
┌──────────────────────────────────────────────────────────────────────────────────┐
│                          验证层 (Validation Layer)                                 │
│  ┌──────────────────┐  ┌──────────────────┐                                      │
│  │document-integrity│  │security/         │                                      │
│  │-check (文档审计)  │  │compliance        │                                      │
│  └──────────────────┘  │(安全合规)         │                                      │
│                        └──────────────────┘                                      │
└──────────────────────────────────────────────────────────────────────────────────┘
```

---

## 核心调用链路

### 链路 1: 完整 SDLC 流程 (11 步)

```
用户输入："实现用户登录功能"

Step 1: 意图识别
auto-skill-dispatcher -> 识别为"实现功能"
           |
Step 2: 需求分析
product-requirement-analysis
产出：requirement-login.md
           |
Step 3: 需求交接
collab-product-to-dev
产出：需求交接单
           |
Step 4: 获取开发上下文
dev-context-first
读取：requirement-login.md
           |
Step 5: 功能实现
dev-implementation
产出：implementation-login.md
           |
Step 6: 需求匹配验证
verify-implementation
验证：实现是否匹配需求文档
           |
Step 7: 代码审查
dev-code-review
产出：代码审查报告
           |
Step 8: 提测交接
collab-dev-to-qa
产出：提测申请单
           |
Step 9: 测试用例设计 + 测试执行
test-case-design -> test-executor
读取：requirement-login.md
产出：test-cases-login.md, test-report-login.md
           |
Step 10: 验收评审
collab-acceptance-review
产出：验收评审报告
           |
Step 11: 迭代闭环
iteration-closure
产出：迭代总结、下一迭代计划
```

**调用序列**:
```
auto-skill-dispatcher
  -> product-requirement-analysis
    -> collab-product-to-dev
      -> dev-context-first
        -> dev-implementation
          -> verify-implementation
            -> dev-code-review
              -> collab-dev-to-qa
                -> test-case-design
                  -> test-executor
                    -> collab-acceptance-review
                      -> iteration-closure
```

---

### 链路 2: Bug 修复流程 (4 步)

```
用户输入："修复登录页面加载慢的问题"

Step 1: Bug 协调
bug-coordinator
分析：Bug 影响范围、优先级、分配责任人
           |
Step 2: 获取上下文
dev-context-first
读取：相关组件文件
           |
Step 3: 功能实现（修复）
dev-implementation
产出：implementation-bugfix-login.md
           |
Step 4: 测试验证
test-executor
产出：test-report-bugfix.md
```

**调用序列**:
```
bug-coordinator
  -> dev-context-first
    -> dev-implementation
      -> test-executor
```

---

### 链路 3: 新项目启动流程 (7 步)

```
用户输入："启动一个新的电商项目"

Step 1: 项目启动
project-kickoff
产出：项目启动文档
           |
Step 2: 项目全局分析
global-project-analysis
产出：项目架构文档
           |
Step 3: 技术评估
product-technical-assessment
产出：技术评估报告
           |
Step 4: 模块拆解
module-splitting
产出：模块拆解方案、模块边界定义
           |
Step 5: 并行开发编排
parallel-module-orchestrator
产出：并行开发计划、依赖关系图
           |
Step 6: 模块需求细化
module-product-requirement
产出：模块需求文档（多份）
           |
Step 7: 模块文档管理
module-document-keeper
产出：INDEX.md
```

**调用序列**:
```
project-kickoff
  -> global-project-analysis
    -> product-technical-assessment
      -> module-splitting
        -> parallel-module-orchestrator
          -> module-product-requirement
            -> module-document-keeper
```

---

### 链路 4: 文档审计流程 (3 步)

```
用户输入："检查我们的文档完整性"

Step 1: 文档整合
module-document-keeper
产出：INDEX.md
           |
Step 2: 完整性检查
document-integrity-check
产出：DOC_AUDIT.md
           |
Step 3: 文档对齐
document-alignment
产出：alignment-report.md
```

**调用序列**:
```
module-document-keeper
  -> document-integrity-check
    -> document-alignment
```

---

### 链路 5: DevOps 部署流程 (6 步)

```
用户输入："部署到 Kubernetes 集群"

Step 1: CI/CD 流水线配置
ci-pipeline
产出：.github/workflows/ci.yml
           |
Step 2: Docker 容器化
dockerfile
产出：Dockerfile
           |
Step 3: K8s 部署配置
k8s
产出：deployment.yml, service.yml
           |
Step 4: 多环境配置
multi-env
产出：dev/staging/prod 配置
           |
Step 5: 监控配置
observability
产出：监控方案、Grafana 看板
           |
Step 6: 成本优化
cost-optimization
产出：成本优化报告
```

**调用序列**:
```
ci-pipeline
  -> dockerfile
    -> k8s
      -> multi-env
        -> observability
          -> cost-optimization
```

---

### 链路 6: 数据迁移流程 (3 步)

```
用户输入："数据库表结构变更"

Step 1: 技术方案设计
dev-context-first (了解现有表结构)
           |
Step 2: 数据库迁移
migration
产出：迁移脚本、回滚脚本
           |
Step 3: 安全合规检查
security-compliance
产出：安全审计报告
```

**调用序列**:
```
dev-context-first
  -> migration
    -> security-compliance
```

---

### 链路 7: 用户反馈驱动优化 (4 步)

```
用户输入："分析用户反馈并改进"

Step 1: 用户反馈分析
feedback-analysis
产出：反馈分析报告
           |
Step 2: 需求分析（基于反馈）
product-requirement-analysis
产出：requirement-improvement.md
           |
Step 3: 功能实现
dev-implementation
           |
Step 4: 验收评审
collab-acceptance-review
```

**调用序列**:
```
feedback-analysis
  -> product-requirement-analysis
    -> dev-implementation
      -> collab-acceptance-review
```

---

### 链路 8: 线上故障响应流程 (4 步)

```
用户输入："支付服务挂了"

Step 1: 故障响应
incident
产出：故障报告、影响评估、应急措施
           |
Step 2: 获取上下文
dev-context-first
读取：相关服务代码、日志、配置
           |
Step 3: 故障修复
dev-implementation
产出：hotfix 补丁
           |
Step 4: 测试验证
test-executor
产出：验证报告
```

**调用序列**:
```
incident
  -> dev-context-first
    -> dev-implementation
      -> test-executor
```

---

### 链路 9: 前后端分离开发 (6 步)

```
用户输入："前后端分离开发" / "前后端协同"

Step 1: 需求协同评审
product-collaborative-requirement-optimization
产出：需求评审报告（前后端共同参与）
           |
Step 2: 多模块协同开发
module-collaborative-dev
产出：前后端协作方案、接口契约
           |
Step 3a: 前端开发 (并行)
frontend + dev-frontend-standards
产出：前端页面代码
           |
Step 3b: 后端开发 (并行)
backend
产出：API 接口代码
           |
Step 4: 实现验证
verify-implementation
验证：前后端实现是否匹配需求和接口契约
           |
Step 5: 提测交接
collab-dev-to-qa
产出：提测申请单
```

**调用序列**:
```
product-collaborative-requirement-optimization
  -> module-collaborative-dev
    -> [frontend + backend] (并行)
      -> verify-implementation
        -> collab-dev-to-qa
```

---

### 链路 10: 设计稿到代码 (3 步)

```
用户输入："设计稿" / "视觉交付" / "设计转代码"

Step 1: 设计评审
design-review
产出：设计评审报告
           |
Step 2: 设计稿交接
design-handoff
产出：设计稿交接文档（标注、切图、规格说明）
           |
Step 3: 前端开发
frontend
参考：dev-frontend-standards
产出：前端页面代码
```

**调用序列**:
```
design-review
  -> design-handoff
    -> dev/implementation/frontend
```

---

## 技能依赖矩阵

### 文档依赖关系

| 技能 | 必须读取的文档 | 产出的文档 |
|------|---------------|-----------|
| `product-requirement-analysis` | 无（或 project-overview.md） | `requirement-{feature}.md` |
| `product-requirement-structuring` | 需求原始资料 | 需求结构化文档 |
| `product-collaborative-requirement-optimization` | requirement-*.md | 需求评审报告 |
| `global-project-analysis` | 项目源码 | 项目架构文档 |
| `data-analysis` | 数据源定义 | 数据分析报告 |
| `product-technical-assessment` | requirement-*.md | 技术评估报告 |
| `module-product-requirement` | requirement-*.md | 模块需求文档 |
| `product-page-feature-best-practices` | 页面需求 | 页面设计最佳实践方案 |
| `module-document-keeper` | `.opencode/docs/*` | `INDEX.md` |
| `feedback-analysis` | 用户反馈数据 | 反馈分析报告 |
| `dev-context-first` | `requirement-{feature}.md` | 上下文报告 |
| `module-dev-context` | 模块源码 | 模块上下文报告 |
| `dev-implementation` | `requirement-{feature}.md` | `implementation-{feature}.md` |
| `frontend` | UI 需求、设计稿 | 前端代码 |
| `backend` | API 需求 | 后端代码、API 文档 |
| `dev-code-quality` | 项目源码 | 代码质量报告 |
| `dev-frontend-standards` | 项目前端代码 | 前端规范配置 |
| `module-collaborative-dev` | 多模块需求 | 协同开发方案 |
| `module-splitting` | 项目全局分析 | 模块拆解方案 |
| `parallel-module-orchestrator` | 模块拆解方案 | 并行开发计划 |
| `verify-implementation` | requirement-*.md + 实现代码 | 需求匹配验证报告 |
| `dev-code-review` | 实现代码 | 代码审查报告 |
| `qa-context-first` | requirement-*.md | 测试上下文报告 |
| `module-test-context` | 模块需求 + 模块代码 | 模块测试上下文 |
| `test-case-design` | `requirement-{feature}.md` | `test-cases-{feature}.md` |
| `test-case-prioritization` | test-cases-*.md | 用例优先级排序 |
| `test-executor` | `test-cases-{feature}.md` | `test-report-{feature}.md` |
| `e2e-testing` | E2E 测试需求 | E2E 测试配置与脚本 |
| `performance-testing` | 性能需求 | 性能测试方案与报告 |
| `collab-product-to-dev` | requirement-*.md | 需求交接单 |
| `collab-dev-to-qa` | implementation-*.md | 提测申请单 |
| `collab-acceptance-review` | test-report-*.md | 验收评审报告 |
| `collab-retrospective` | 迭代产出物 | 迭代复盘报告 |
| `bug-coordinator` | Bug 描述 | Bug 分配与追踪报告 |
| `iteration-closure` | 迭代产出物 | 迭代总结、下迭代计划 |
| `context-alignment` | 各方文档 | 同步对齐报告 |
| `incident` | 故障信息 | 故障报告、影响评估 |
| `document-alignment` | 需求 + 实现 + 测试文档 | `alignment-*.md` |
| `design-handoff` | 设计稿文件 | 设计稿交接文档 |
| `design-review` | 设计稿文件 | 设计评审报告 |
| `ci-pipeline` | 项目配置 | CI/CD 流水线配置 |
| `dockerfile` | 项目配置 | Dockerfile |
| `k8s` | 部署需求 | deployment.yml, service.yml |
| `multi-env` | 环境需求 | 多环境配置 |
| `observability` | 监控需求 | 监控方案、看板配置 |
| `migration` | 数据库变更需求 | 迁移脚本、回滚脚本 |
| `cost-optimization` | 资源使用数据 | 成本优化报告 |
| `document-integrity-check` | `.opencode/docs/*` | `DOC_AUDIT.md` |
| `security-compliance` | 项目源码、配置 | 安全审计报告 |

---

### 技能前置依赖

```
+-------------------------------------------------------------------------+
| 技能前置条件图                                                            |
+-------------------------------------------------------------------------+
|                                                                         |
|  product-requirement-analysis                                           |
|    | (产出 requirement-*.md)                                             |
|  +-- dev-context-first -> dev-implementation -> verify-implementation   |
|  |                       -> dev-code-review                             |
|  +-- test-case-design -> test-case-prioritization -> test-executor      |
|  +-- collab-product-to-dev                                              |
|  +-- frontend / backend                                                 |
|                                                                         |
|  dev-implementation                                                     |
|    | (产出 implementation-*.md)                                          |
|  +-- verify-implementation                                              |
|  +-- collab-dev-to-qa                                                   |
|                                                                         |
|  test-executor                                                          |
|    | (产出 test-report-*.md)                                             |
|  +-- collab-acceptance-review                                           |
|                                                                         |
|  collab-acceptance-review                                               |
|    |                                                                    |
|  +-- iteration-closure                                                  |
|  +-- collab-retrospective                                               |
|                                                                         |
|  module-document-keeper                                                 |
|    | (产出 INDEX.md)                                                     |
|  +-- document-integrity-check -> document-alignment                     |
|                                                                         |
|  global-project-analysis                                                |
|    |                                                                    |
|  +-- module-splitting -> parallel-module-orchestrator                   |
|  |                     -> module-collaborative-dev                       |
|  +-- module-product-requirement                                         |
|                                                                         |
|  incident                                                               |
|    |                                                                    |
|  +-- dev-context-first -> dev-implementation -> test-executor           |
|                                                                         |
|  bug-coordinator                                                        |
|    |                                                                    |
|  +-- dev-context-first -> dev-implementation -> test-executor           |
|                                                                         |
|  feedback-analysis                                                      |
|    |                                                                    |
|  +-- product-requirement-analysis                                       |
|                                                                         |
+-------------------------------------------------------------------------+
```

---

## 触发条件详细映射

### 产品类技能触发器

| 触发词 | 技能 | 典型输入 |
|--------|------|---------|
| "需求分析" | `product-requirement-analysis` | "帮我分析一下用户登录的需求" |
| "用户故事" | `product-requirement-analysis` | "编写用户注册功能的用户故事" |
| "需求整理" | `product-requirement-structuring` | "把这些需求整理一下" |
| "三方评审" | `product-collaborative-requirement-optimization` | "组织三方需求评审" |
| "需求评审" | `product-collaborative-requirement-optimization` | "产品开发测试一起评审需求" |
| "项目分析" | `global-project-analysis` | "分析一下这个项目的模块划分" |
| "数据分析" | `data-analysis` | "设计用户行为埋点方案" |
| "技术评估" | `product-technical-assessment` | "评估使用微服务的可行性" |
| "模块需求" | `module-product-requirement` | "细化订单模块的需求" |
| "页面最佳实践" | `product-page-feature-best-practices` | "列表页设计最佳实践" |
| "文档整理" | `module-document-keeper` | "把控全局文档" |
| "用户反馈" | `feedback-analysis` | "分析 NPS 评分下降的原因" |

### 开发类技能触发器

| 触发词 | 技能 | 典型输入 |
|--------|------|---------|
| "给我上下文" | `dev-context-first` | "给我看看登录模块的代码" |
| "先看看" | `dev-context-first` | "先了解下项目结构" |
| "模块上下文" | `module-dev-context` | "了解订单模块的结构" |
| "实现功能" | `dev-implementation` | "实现用户头像上传功能" |
| "编写代码" | `dev-implementation` | "编写一个登录接口" |
| "前端开发" | `frontend` | "开发用户列表页面" |
| "页面开发" | `frontend` | "开发购物车页面" |
| "后端开发" | `backend` | "开发用户接口" |
| "API开发" | `backend` | "开发订单查询接口" |
| "代码质量" | `dev-code-quality` | "配置ESLint" |
| "lint" | `dev-code-quality` | "设置代码质量检查工具" |
| "前端规范" | `dev-frontend-standards` | "配置响应式布局" |
| "响应式" | `dev-frontend-standards` | "设置移动端适配方案" |
| "多模块协同" | `module-collaborative-dev` | "协同开发订单和支付模块" |
| "模块拆解" | `module-splitting` | "拆解电商项目模块" |
| "并行开发" | `parallel-module-orchestrator` | "并行开发3个模块" |
| "需求匹配" | `verify-implementation` | "验证实现是否匹配需求" |
| "代码验证" | `verify-implementation` | "检查实现是否完整覆盖需求" |
| "代码审查" | `dev-code-review` | "审查这段代码" |
| "Code Review" | `dev-code-review` | "帮我 CR 一下这个 PR" |
| "CR" | `dev-code-review` | "CR: src/auth/login.ts" |

### 测试类技能触发器

| 触发词 | 技能 | 典型输入 |
|--------|------|---------|
| "测试上下文" | `qa-context-first` | "了解被测功能" |
| "模块测试" | `module-test-context` | "获取订单模块测试上下文" |
| "测试用例" | `test-case-design` | "设计登录功能的测试用例" |
| "设计用例" | `test-case-design` | "设计支付流程的测试场景" |
| "用例优先级" | `test-case-prioritization` | "排序测试用例优先级" |
| "执行测试" | `test-executor` | "运行测试并生成报告" |
| "测试报告" | `test-executor` | "生成测试执行报告" |
| "E2E测试" | `e2e-testing` | "配置E2E自动化测试" |
| "Playwright" | `e2e-testing` | "用Playwright写端到端测试" |
| "性能测试" | `performance-testing` | "做负载压力测试" |
| "k6" | `performance-testing` | "用k6做性能基准测试" |

### 协同类技能触发器

| 触发词 | 技能 | 典型输入 |
|--------|------|---------|
| "需求交接" | `collab-product-to-dev` | "产品给开发做需求交接" |
| "提测" | `collab-dev-to-qa` | "开发完成，申请提测" |
| "测试交接" | `collab-dev-to-qa` | "准备提测给测试" |
| "验收" | `collab-acceptance-review` | "组织 UAT 验收" |
| "UAT" | `collab-acceptance-review` | "产品验收评审" |
| "复盘" | `collab-retrospective` | "迭代复盘会议" |
| "总结" | `collab-retrospective` | "Sprint 总结" |
| "Bug协调" | `bug-coordinator` | "协调修复跨模块Bug" |
| "Bug追踪" | `bug-coordinator` | "追踪这个Bug的修复进度" |
| "迭代闭环" | `iteration-closure` | "开始下一迭代" |
| "下一迭代" | `iteration-closure` | "迭代收尾，准备下一个" |
| "同步" | `context-alignment` | "对齐前后端进度" |
| "对齐" | `context-alignment` | "同步各团队上下文" |
| "文档对齐" | `document-alignment` | "三方文档对齐" |
| "线上故障" | `incident` | "支付服务挂了" |
| "应急" | `incident` | "线上502，紧急处理" |

### DevOps 技能触发器

| 触发词 | 技能 | 典型输入 |
|--------|------|---------|
| "CI/CD" | `ci-pipeline` | "配置 GitHub Actions 流水线" |
| "流水线" | `ci-pipeline` | "设计 CI/CD 流程" |
| "Docker" | `dockerfile` | "容器化这个应用" |
| "K8s" | `k8s` | "部署到 Kubernetes" |
| "多环境" | `multi-env` | "配置 dev/staging/prod环境" |
| "监控" | `observability` | "配置 Prometheus 监控" |
| "数据库迁移" | `migration` | "表结构变更" |
| "成本优化" | `cost-optimization` | "降低云成本" |

### 视觉设计类技能触发器

| 触发词 | 技能 | 典型输入 |
|--------|------|---------|
| "设计交接" | `design-handoff` | "交接设计稿给开发" |
| "设计稿交接" | `design-handoff` | "把Figma设计稿交接给前端" |
| "设计评审" | `design-review` | "评审设计稿" |
| "视觉走查" | `design-review` | "走查首页设计稿" |

### 系统类技能触发器

| 触发词 | 技能 | 典型输入 |
|--------|------|---------|
| "[所有]" | `auto-skill-dispatcher` | 任何输入（自动调度） |
| "[链路执行]" | `chain-executor` | 内部调用（链路编排） |
| "[状态追踪]" | `state-tracker` | 内部调用（状态管理） |
| "文档检查" | `document-integrity-check` | "检查文档完整性" |
| "安全审计" | `security-compliance` | "GDPR 合规检查" |

---

## 条件分支链路

### 场景：代码审查发现问题

```
dev-code-review
    |
    +-- 问题轻微 -> dev-implementation (修复) -> dev-code-review (复验)
    |
    +-- 问题严重 -> collab-product-to-dev (重新评估需求)
    |                 |
    |              product-requirement-analysis (修订需求)
    |                 |
    |              dev-implementation (重新实现)
    |
    +-- 发现安全风险 -> security-compliance (深入审计)
                          |
                       migration (如需数据变更)
```

---

### 场景：测试失败

```
test-executor (发现失败用例)
    |
    +-- Bug -> bug-coordinator (协调修复)
    |             |
    |          dev-context-first (定位问题)
    |             |
    |          dev-implementation (修复)
    |             |
    |          test-executor (复测)
    |
    +-- 需求理解偏差 -> collab-product-to-dev (澄清需求)
    |                    |
    |                 product-requirement-analysis (修订需求)
    |                    |
    |                 dev-implementation (重新实现)
    |
    +-- 测试用例问题 -> test-case-design (修订用例)
                         |
                      test-case-prioritization (重新排序)
                         |
                      test-executor (重新执行)
```

---

### 场景：验收不通过

```
collab-acceptance-review (验收不通过)
    |
    +-- 功能缺失 -> verify-implementation (检查需求覆盖)
    |                  |
    |               dev-implementation (补充功能)
    |
    +-- Bug -> bug-coordinator (协调修复)
    |             |
    |          dev-implementation (修复) -> test-executor (验证)
    |
    +-- 需求变更 -> product-requirement-analysis (修订需求)
                     |
                  dev-implementation (重新实现)
```

---

### 场景：线上故障响应

```
incident (线上故障)
    |
    +-- 紧急修复 -> dev-context-first (快速定位)
    |                 |
    |              dev-implementation (Hotfix)
    |                 |
    |              test-executor (回归验证)
    |
    +-- 跨模块故障 -> bug-coordinator (协调多团队)
    |                    |
    |                 context-alignment (同步上下文)
    |                    |
    |                 module-collaborative-dev (协同修复)
    |
    +-- 需回滚 -> migration (数据回滚)
                     |
                  security-compliance (事后审计)
```

---

### 场景：多模块并行开发

```
module-splitting (拆解模块)
    |
    +-- 模块A -> frontend (前端开发) -> dev-code-review
    |
    +-- 模块B -> backend (后端开发) -> dev-code-review
    |
    +-- 模块C -> dev-implementation (全栈开发) -> dev-code-review
    |
    (并行完成后)
    v
parallel-module-orchestrator (集成协调)
    |
    +-- module-collaborative-dev (模块联调)
    |
    +-- context-alignment (进度同步)
```

---

### 场景：设计稿到实现

```
design-review (设计评审)
    |
    v
design-handoff (设计稿交接)
    |
    +-- 前端部分 -> frontend (前端开发)
    |                 |
    |              dev-frontend-standards (规范检查)
    |
    +-- API 部分 -> backend (后端开发)
    |
    +-- 完整功能 -> dev-implementation
                     |
                  verify-implementation (对比设计稿验证)
```

---

## 技能调用频率分析

### 高频技能 (每日多次)
- `auto-skill-dispatcher` - 每次交互都触发
- `dev-context-first` - 开发前必经步骤
- `dev-implementation` - 核心开发活动
- `frontend` - 前端日常开发
- `backend` - 后端日常开发
- `dev-code-review` - 代码提交前审查

### 中频技能 (每周数次)
- `product-requirement-analysis` - 新需求分析
- `test-case-design` - 测试准备
- `test-executor` - 测试执行
- `collab-dev-to-qa` - 提测交接
- `bug-coordinator` - Bug 协调管理
- `verify-implementation` - 实现验证
- `dev-code-quality` - 代码质量检查
- `context-alignment` - 团队同步对齐
- `design-handoff` - 设计稿交接

### 低频技能 (里程碑式)
- `project-kickoff` - 项目启动
- `module-splitting` - 模块拆解
- `parallel-module-orchestrator` - 并行开发编排
- `collab-acceptance-review` - 上线前验收
- `collab-retrospective` - 迭代结束复盘
- `iteration-closure` - 迭代闭环
- `document-integrity-check` - 定期审计
- `incident` - 线上故障（不定期）
- `performance-testing` - 性能测试（定期）
- `e2e-testing` - E2E 测试（定期）
- `product-collaborative-requirement-optimization` - 三方评审

---

## 角色技能映射

### 产品经理 (Product Manager)
```
日常调用:
  product-requirement-analysis
  product-requirement-structuring
  product-collaborative-requirement-optimization
  product-page-feature-best-practices
  feedback-analysis

协同调用:
  collab-product-to-dev
  collab-acceptance-review

项目管理:
  project-kickoff
  global-project-analysis
  iteration-closure

数据分析:
  data-analysis
```

### 开发工程师 (Developer)
```
日常调用:
  dev-context-first
  dev-implementation
  frontend
  backend
  dev-code-review
  dev-code-quality
  dev-frontend-standards
  verify-implementation

模块开发:
  module-dev-context
  module-collaborative-dev
  module-splitting
  parallel-module-orchestrator

协同调用:
  collab-product-to-dev (参与)
  collab-dev-to-qa
  context-alignment
```

### 测试工程师 (QA)
```
日常调用:
  qa-context-first
  module-test-context
  test-case-design
  test-case-prioritization
  test-executor

高级测试:
  e2e-testing
  performance-testing

协同调用:
  collab-dev-to-qa (参与)
  collab-acceptance-review
```

### DevOps 工程师
```
部署配置:
  ci-pipeline
  dockerfile
  k8s
  multi-env

运维监控:
  observability
  migration
  cost-optimization

应急响应:
  incident
```

### 视觉设计师 (Visual Designer)
```
日常调用:
  design-handoff
  design-review

协同调用:
  collab-product-to-dev (参与设计交接)
  context-alignment (与开发对齐)
```

### 技术负责人 (Tech Lead)
```
代码审查:
  dev-code-review (主导)
  dev-code-quality
  verify-implementation

模块管理:
  module-splitting
  parallel-module-orchestrator
  module-collaborative-dev

文档把控:
  module-document-keeper
  document-integrity-check
  document-alignment

安全合规:
  security-compliance

团队复盘:
  collab-retrospective (主持)
  iteration-closure
  bug-coordinator

应急响应:
  incident
```

---

## 技能组合模式

### 模式 1: 快速修复 (Quick Fix)
```typescript
task(category="quick", load_skills=[
  "collaboration/process/bug-coordinator",
  "dev/context/dev-context-first",
  "dev/implementation/dev-implementation"
], prompt="修复登录按钮点击无响应的问题")
```

### 模式 2: 功能开发 (Feature Development)
```typescript
// 阶段 1: 需求
task(category="unspecified-high", load_skills=[
  "product/requirement/product-requirement-analysis"
], prompt="分析用户注册功能需求")

// 阶段 2: 开发
task(category="deep", load_skills=[
  "dev/context/dev-context-first",
  "dev/implementation/dev-implementation",
  "dev/verify-implementation"
], prompt="实现用户注册功能")

// 阶段 3: 测试
task(category="unspecified-high", load_skills=[
  "qa/test-case/test-case-design",
  "qa/test-case/test-case-prioritization",
  "qa/execution/test-executor"
], prompt="测试用户注册功能")
```

### 模式 3: 前后端分离开发
```typescript
// 前端
task(category="deep", load_skills=[
  "dev/context/dev-context-first",
  "dev/implementation/frontend",
  "dev/standards/dev-frontend-standards"
], prompt="开发用户列表页面")

// 后端
task(category="deep", load_skills=[
  "dev/context/dev-context-first",
  "dev/implementation/backend"
], prompt="开发用户接口")

// 对齐
task(category="unspecified-high", load_skills=[
  "collaboration/sync/context-alignment"
], prompt="对齐前后端进度")
```

### 模式 4: 文档审计 (Documentation Audit)
```typescript
task(category="unspecified-high", load_skills=[
  "product/module/module-document-keeper",
  "system/document-integrity-check",
  "collaboration/sync/document-alignment"
], prompt="审计项目文档完整性")
```

### 模式 5: DevOps 部署 (DevOps Deployment)
```typescript
task(category="deep", load_skills=[
  "devops/ci/pipeline",
  "devops/deploy/dockerfile",
  "devops/deploy/k8s",
  "devops/monitoring/observability"
], prompt="部署应用到 K8s 集群")
```

### 模式 6: 多模块并行开发
```typescript
task(category="deep", load_skills=[
  "dev/modules/module-splitting",
  "dev/modules/parallel-module-orchestrator",
  "dev/modules/module-collaborative-dev",
  "collaboration/sync/context-alignment"
], prompt="并行开发电商项目的3个模块")
```

### 模式 7: 线上故障响应
```typescript
task(category="critical", load_skills=[
  "collaboration/sync/incident",
  "dev/context/dev-context-first",
  "dev/implementation/dev-implementation",
  "qa/execution/test-executor"
], prompt="支付服务挂了，紧急修复")
```

### 模式 8: 设计到实现 (Design to Code)
```typescript
task(category="deep", load_skills=[
  "visual/design-review",
  "visual/design-handoff",
  "dev/implementation/frontend",
  "dev/standards/dev-frontend-standards",
  "dev/verify-implementation"
], prompt="根据设计稿开发首页")
```

### 模式 9: 三方需求评审
```typescript
task(category="unspecified-high", load_skills=[
  "product/requirement/product-collaborative-requirement-optimization",
  "collaboration/sync/context-alignment"
], prompt="组织三方需求评审")
```

---

## 最佳实践

### 1. 技能调用顺序不可颠倒

**错误示例**:
```
test-case-design -> product-requirement-analysis (错误)
(测试用例设计在需求分析之前)
```

**正确示例**:
```
product-requirement-analysis -> test-case-design (正确)
(先有需求，再设计测试)
```

---

### 2. 文档驱动的技能链

```
需求文档 -> 开发实现 -> 测试用例
   |           |           |
requirement -> implementation -> test-cases
   |
   +-> verify-implementation (验证需求覆盖)
```

每个技能都依赖前一个技能的产出文档，形成完整的文档链。

---

### 3. 协同技能作为检查点

```
开发完成 -> [collab-dev-to-qa] -> 测试开始
                  |
           提测检查点
           - 自测通过？
           - 代码审查完成？
           - 测试环境就绪？
```

---

### 4. 自动调度器优先

当不确定使用哪个技能时，先调用 `auto-skill-dispatcher`：

```typescript
// 让系统自动识别意图
skill(name="system/auto-skill-dispatcher")
```

---

### 5. 验证环节不可省略

实现完成后务必经过 `verify-implementation` 验证需求覆盖：

```
dev-implementation -> verify-implementation -> dev-code-review
                          |
                     确认需求完整覆盖
                     发现遗漏可立即补充
```

---

### 6. 并行开发的协调

多模块并行开发时，使用 `context-alignment` 定期同步：

```
module-splitting -> parallel-module-orchestrator
                        |
                   定期调用 context-alignment 同步进度
                   使用 module-collaborative-dev 处理跨模块依赖
```

---

## 调试技能调用

### 问题：技能未触发

**排查步骤**:
1. 检查触发词是否匹配（参照触发条件映射表）
2. 检查技能是否已加载到 `oh-my-opencode.json` 的 `defaultSkills` 列表
3. 检查技能文件路径是否正确（SKILL.md 是否存在）
4. 检查 `state-tracker` 中技能状态是否为可用

### 问题：技能调用顺序错误

**排查步骤**:
1. 检查前置文档是否存在
2. 检查依赖技能是否已执行
3. 查看文档流是否连续
4. 使用 `chain-executor` 确保链路正确编排

### 问题：协同技能阻塞

**排查步骤**:
1. 检查上游技能是否已完成并产出必要文档
2. 检查 `context-alignment` 是否需要先同步上下文
3. 确认 `bug-coordinator` 是否已处理所有阻塞项
4. 查看 `iteration-closure` 是否有待闭环项

### 问题：并行模块冲突

**排查步骤**:
1. 检查 `module-splitting` 拆解是否合理、边界是否清晰
2. 确认 `parallel-module-orchestrator` 的依赖关系图是否正确
3. 使用 `module-collaborative-dev` 处理跨模块冲突
4. 调用 `context-alignment` 进行进度同步

---

## 链路监控指标

### 技能执行指标
- 技能调用次数
- 平均执行时间
- 技能成功率
- 链路完成率（首技能到末技能的完整走通率）

### 文档流指标
- 文档产出率
- 文档覆盖率
- 文档更新频率
- 需求验证通过率（verify-implementation）

### 协同效率指标
- 交接次数
- 返工次数
- 验收通过率
- Bug 协调闭环时间
- 故障响应时间（incident 到修复完成）
- 迭代闭环率（iteration-closure）

---

**文档版本**: v2.0
**最后更新**: 2026-04-15
**技能总数**: 53
**调用链路**: 10 条核心链路 + N 条条件分支
