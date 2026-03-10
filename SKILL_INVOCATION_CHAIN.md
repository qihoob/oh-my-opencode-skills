# 🔗 Skill 调用链路图

基于 25 个技能的完整调用链路分析，包含触发条件、依赖关系、输出流转

---

## 📊 调用链路总览

```
┌──────────────────────────────────────────────────────────────────────────────┐
│                           入口层 (Entry Layer)                                │
│  ┌─────────────────────────────────────────────────────────────────────────┐ │
│  │ system/auto-skill-dispatcher (自动调度器)                                │ │
│  │ 触发词：[所有] - 根据用户输入自动识别并调度合适技能                       │ │
│  └─────────────────────────────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌──────────────────────────────────────────────────────────────────────────────┐
│                         上下文层 (Context Layer)                              │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐           │
│  │ dev-context-first│  │ qa-context-first │  │module-dev-context│           │
│  │ (开发前上下文)    │  │ (测试前上下文)    │  │ (模块上下文)      │           │
│  └──────────────────┘  └──────────────────┘  └──────────────────┘           │
└──────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌──────────────────────────────────────────────────────────────────────────────┐
│                         执行层 (Execution Layer)                              │
│  ┌────────────┐ ┌────────────┐ ┌────────────┐ ┌────────────┐ ┌──────────┐  │
│  │ 需求分析   │ │ 功能实现   │ │ 测试用例   │ │ 代码审查   │ │ DevOps   │  │
│  └────────────┘ └────────────┘ └────────────┘ └────────────┘ └──────────┘  │
└──────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌──────────────────────────────────────────────────────────────────────────────┐
│                         协同层 (Collaboration Layer)                          │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐           │
│  │collab-product-to-│  │collab-dev-to-qa  │  │collab-acceptance-│           │
│  │dev               │  │(提测交接)         │  │review (验收)     │           │
│  │(需求交接)         │  │                  │  │                  │           │
│  └──────────────────┘  └──────────────────┘  └──────────────────┘           │
│  ┌──────────────────┐  ┌──────────────────┐                                │
│  │document-alignment│  │collab-retrospect-│                                │
│  │(文档对齐)         │  │ive (复盘)         │                                │
│  └──────────────────┘  └──────────────────┘                                │
└──────────────────────────────────────────────────────────────────────────────┘
                                      ↓
┌──────────────────────────────────────────────────────────────────────────────┐
│                         验证层 (Validation Layer)                             │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐           │
│  │document-integrity│  │security/compliance│ │ test-executor    │           │
│  │-check (文档审计)  │  │(安全合规)         │  │(测试执行)        │           │
│  └──────────────────┘  └──────────────────┘  └──────────────────┘           │
└──────────────────────────────────────────────────────────────────────────────┘
```

---

## 🔀 核心调用链路

### 链路 1: 完整 SDLC 流程 (9 步)

```
用户输入："实现用户登录功能"

Step 1: 意图识别
auto-skill-dispatcher → 识别为"实现功能"
           ↓
Step 2: 需求分析
product-requirement-analysis
产出：requirement-login.md
           ↓
Step 3: 需求交接
collab-product-to-dev
产出：需求交接单
           ↓
Step 4: 获取开发上下文
dev-context-first
读取：requirement-login.md
           ↓
Step 5: 功能实现
dev-implementation
产出：implementation-login.md
           ↓
Step 6: 代码审查
dev-code-review
产出：代码审查报告
           ↓
Step 7: 提测交接
collab-dev-to-qa
产出：提测申请单
           ↓
Step 8: 测试用例设计
test-case-design
读取：requirement-login.md
产出：test-cases-login.md
           ↓
Step 9: 测试执行
test-executor
产出：test-report-login.md
           ↓
Step 10: 验收评审
collab-acceptance-review
产出：验收评审报告
           ↓
Step 11: 迭代复盘
collab-retrospective
产出：迭代复盘报告
```

**调用序列**:
```
auto-skill-dispatcher
  → product-requirement-analysis
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

---

### 链路 2: Bug 修复流程 (4 步)

```
用户输入："修复登录页面加载慢的问题"

Step 1: 获取上下文
dev-context-first
读取：相关组件文件
           ↓
Step 2: 功能实现（修复）
dev-implementation
产出：implementation-bugfix-login.md
           ↓
Step 3: 代码审查
dev-code-review
           ↓
Step 4: 测试验证
test-executor
```

**调用序列**:
```
dev-context-first
  → dev-implementation
    → dev-code-review
      → test-executor
```

---

### 链路 3: 新项目启动流程 (5 步)

```
用户输入："启动一个新的电商项目"

Step 1: 项目启动
project-kickoff
产出：项目启动文档
           ↓
Step 2: 项目全局分析
global-project-analysis
产出：项目架构文档
           ↓
Step 3: 技术评估
product-technical-assessment
产出：技术评估报告
           ↓
Step 4: 模块需求细化
module-product-requirement
产出：模块需求文档
           ↓
Step 5: 模块文档管理
module-document-keeper
产出：INDEX.md
```

**调用序列**:
```
project-kickoff
  → global-project-analysis
    → product-technical-assessment
      → module-product-requirement
        → module-document-keeper
```

---

### 链路 4: 文档审计流程 (3 步)

```
用户输入："检查我们的文档完整性"

Step 1: 文档整合
module-document-keeper
产出：INDEX.md
           ↓
Step 2: 完整性检查
document-integrity-check
产出：DOC_AUDIT.md
           ↓
Step 3: 文档对齐
document-alignment
产出：alignment-report.md
```

**调用序列**:
```
module-document-keeper
  → document-integrity-check
    → document-alignment
```

---

### 链路 5: DevOps 部署流程 (6 步)

```
用户输入："部署到 Kubernetes 集群"

Step 1: CI/CD 流水线配置
ci-pipeline
产出：.github/workflows/ci.yml
           ↓
Step 2: Docker 容器化
dockerfile
产出：Dockerfile
           ↓
Step 3: K8s 部署配置
k8s
产出：deployment.yml, service.yml
           ↓
Step 4: 多环境配置
multi-env
产出：dev/staging/prod 配置
           ↓
Step 5: 监控配置
observability
产出：监控方案、Grafana 看板
           ↓
Step 6: 成本优化
cost-optimization
产出：成本优化报告
```

**调用序列**:
```
ci-pipeline
  → dockerfile
    → k8s
      → multi-env
        → observability
          → cost-optimization
```

---

### 链路 6: 数据迁移流程 (3 步)

```
用户输入："数据库表结构变更"

Step 1: 技术方案设计
dev-context-first (了解现有表结构)
           ↓
Step 2: 数据库迁移
migration
产出：迁移脚本、回滚脚本
           ↓
Step 3: 安全合规检查
security-compliance
产出：安全审计报告
```

**调用序列**:
```
dev-context-first
  → migration
    → security-compliance
```

---

### 链路 7: 用户反馈驱动优化 (4 步)

```
用户输入："分析用户反馈并改进"

Step 1: 用户反馈分析
feedback-analysis
产出：反馈分析报告
           ↓
Step 2: 需求分析（基于反馈）
product-requirement-analysis
产出：requirement-improvement.md
           ↓
Step 3: 功能实现
dev-implementation
           ↓
Step 4: 验收评审
collab-acceptance-review
```

**调用序列**:
```
feedback-analysis
  → product-requirement-analysis
    → dev-implementation
      → collab-acceptance-review
```

---

## 🎯 技能依赖矩阵

### 文档依赖关系

| 技能 | 必须读取的文档 | 产出的文档 |
|------|---------------|-----------|
| `product-requirement-analysis` | 无（或 project-overview.md） | `requirement-{feature}.md` |
| `dev-context-first` | `requirement-{feature}.md` | 上下文报告 |
| `dev-implementation` | `requirement-{feature}.md` | `implementation-{feature}.md` |
| `test-case-design` | `requirement-{feature}.md` | `test-cases-{feature}.md` |
| `test-executor` | `test-cases-{feature}.md` | `test-report-{feature}.md` |
| `module-document-keeper` | `.opencode/docs/*` | `INDEX.md` |
| `document-integrity-check` | `.opencode/docs/*` | `DOC_AUDIT.md` |
| `document-alignment` | 需求 + 实现 + 测试文档 | `alignment-*.md` |

---

### 技能前置依赖

```
┌─────────────────────────────────────────────────────────────────────────┐
│ 技能前置条件图                                                           │
├─────────────────────────────────────────────────────────────────────────┤
│                                                                         │
│  product-requirement-analysis                                          │
│    ↓ (产出 requirement-*.md)                                            │
│  ├── dev-context-first ─→ dev-implementation ─→ dev-code-review        │
│  ├── test-case-design ─→ test-executor                                  │
│  └── collab-product-to-dev                                              │
│                                                                         │
│  dev-implementation                                                      │
│    ↓ (产出 implementation-*.md)                                         │
│  └── collab-dev-to-qa                                                   │
│                                                                         │
│  test-executor                                                          │
│    ↓ (产出 test-report-*.md)                                            │
│  └── collab-acceptance-review                                           │
│                                                                         │
│  module-document-keeper                                                 │
│    ↓ (产出 INDEX.md)                                                    │
│  └── document-integrity-check ─→ document-alignment                     │
│                                                                         │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 🚦 触发条件详细映射

### 产品类技能触发器

| 触发词 | 技能 | 典型输入 |
|--------|------|---------|
| "需求分析" | `product-requirement-analysis` | "帮我分析一下用户登录的需求" |
| "用户故事" | `product-requirement-analysis` | "编写用户注册功能的用户故事" |
| "需求整理" | `product-requirement-structuring` | "把这些需求整理一下" |
| "项目分析" | `global-project-analysis` | "分析一下这个项目的模块划分" |
| "数据分析" | `data-analysis` | "设计用户行为埋点方案" |
| "技术评估" | `product-technical-assessment` | "评估使用微服务的可行性" |
| "模块需求" | `module-product-requirement` | "细化订单模块的需求" |
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
| "代码审查" | `dev-code-review` | "审查这段代码" |
| "Code Review" | `dev-code-review` | "帮我 CR 一下这个 PR" |
| "CR" | `dev-code-review` | "CR: src/auth/login.ts" |

### 测试类技能触发器

| 触发词 | 技能 | 典型输入 |
|--------|------|---------|
| "测试上下文" | `qa-context-first` | "了解被测功能" |
| "测试用例" | `test-case-design` | "设计登录功能的测试用例" |
| "设计用例" | `test-case-design` | "设计支付流程的测试场景" |
| "执行测试" | `test-executor` | "运行测试并生成报告" |
| "测试报告" | `test-executor` | "生成测试执行报告" |

### 协同类技能触发器

| 触发词 | 技能 | 典型输入 |
|--------|------|---------|
| "需求交接" | `collab-product-to-dev` | "产品给开发做需求交接" |
| "需求评审" | `collab-product-to-dev` | "组织需求评审会议" |
| "提测" | `collab-dev-to-qa` | "开发完成，申请提测" |
| "测试交接" | `collab-dev-to-qa` | "准备提测给测试" |
| "验收" | `collab-acceptance-review` | "组织 UAT 验收" |
| "UAT" | `collab-acceptance-review` | "产品验收评审" |
| "复盘" | `collab-retrospective` | "迭代复盘会议" |
| "总结" | `collab-retrospective` | "Sprint 总结" |
| "文档对齐" | `document-alignment` | "三方文档对齐" |

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

### 系统类技能触发器

| 触发词 | 技能 | 典型输入 |
|--------|------|---------|
| "[所有]" | `auto-skill-dispatcher` | 任何输入（自动调度） |
| "文档检查" | `document-integrity-check` | "检查文档完整性" |
| "安全审计" | `security-compliance` | "GDPR 合规检查" |

---

## 🔄 条件分支链路

### 场景：代码审查发现问题

```
dev-code-review
    ↓
    ├── 问题轻微 → dev-implementation (修复) → dev-code-review (复验)
    │
    ├── 问题严重 → collab-product-to-dev (重新评估需求)
    │                 ↓
    │              product-requirement-analysis (修订需求)
    │                 ↓
    │              dev-implementation (重新实现)
    │
    └── 发现安全风险 → security-compliance (深入审计)
                          ↓
                       migration (如需数据变更)
```

---

### 场景：测试失败

```
test-executor (发现失败用例)
    ↓
    ├── Bug → dev-context-first (定位问题)
    │            ↓
    │         dev-implementation (修复)
    │            ↓
    │         test-executor (复测)
    │
    ├── 需求理解偏差 → collab-product-to-dev (澄清需求)
    │                    ↓
    │                 product-requirement-analysis (修订需求)
    │                    ↓
    │                 dev-implementation (重新实现)
    │
    └── 测试用例问题 → test-case-design (修订用例)
                         ↓
                      test-executor (重新执行)
```

---

### 场景：验收不通过

```
collab-acceptance-review (验收不通过)
    ↓
    ├── 功能缺失 → dev-implementation (补充功能)
    │
    ├── Bug → dev-implementation (修复) → test-executor (验证)
    │
    └── 需求变更 → product-requirement-analysis (修订需求)
                     ↓
                  dev-implementation (重新实现)
```

---

## 📈 技能调用频率分析

### 高频技能 (每日多次)
- `auto-skill-dispatcher` - 每次交互都触发
- `dev-context-first` - 开发前必经步骤
- `dev-implementation` - 核心开发活动
- `dev-code-review` - 代码提交前审查

### 中频技能 (每周数次)
- `product-requirement-analysis` - 新需求分析
- `test-case-design` - 测试准备
- `test-executor` - 测试执行
- `collab-dev-to-qa` - 提测交接

### 低频技能 (里程碑式)
- `project-kickoff` - 项目启动
- `collab-acceptance-review` - 上线前验收
- `collab-retrospective` - 迭代结束复盘
- `document-integrity-check` - 定期审计

---

## 🎭 角色技能映射

### 产品经理 (Product Manager)
```
日常调用:
  product-requirement-analysis
  product-requirement-structuring
  feedback-analysis

协同调用:
  collab-product-to-dev
  collab-acceptance-review

项目管理:
  project-kickoff
  global-project-analysis
```

### 开发工程师 (Developer)
```
日常调用:
  dev-context-first
  dev-implementation
  dev-code-review

协同调用:
  collab-product-to-dev (参与)
  collab-dev-to-qa

上下文:
  module-dev-context
```

### 测试工程师 (QA)
```
日常调用:
  qa-context-first
  test-case-design
  test-executor

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
```

### 技术负责人 (Tech Lead)
```
代码审查:
  dev-code-review (主导)

文档把控:
  module-document-keeper
  document-integrity-check
  document-alignment

安全合规:
  security-compliance

团队复盘:
  collab-retrospective (主持)
```

---

## 🛠️ 技能组合模式

### 模式 1: 快速修复 (Quick Fix)
```typescript
task(category="quick", load_skills=[
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
  "dev/implementation/dev-implementation"
], prompt="实现用户注册功能")

// 阶段 3: 测试
task(category="unspecified-high", load_skills=[
  "qa/test-case/test-case-design",
  "qa/execution/test-executor"
], prompt="测试用户注册功能")
```

### 模式 3: 文档审计 (Documentation Audit)
```typescript
task(category="unspecified-high", load_skills=[
  "product/module/module-document-keeper",
  "system/document-integrity-check",
  "collaboration/sync/document-alignment"
], prompt="审计项目文档完整性")
```

### 模式 4: DevOps 部署 (DevOps Deployment)
```typescript
task(category="deep", load_skills=[
  "devops/ci/pipeline",
  "devops/deploy/dockerfile",
  "devops/deploy/k8s",
  "devops/monitoring/observability"
], prompt="部署应用到 K8s 集群")
```

---

## 📌 最佳实践

### 1. 技能调用顺序不可颠倒

**错误示例**:
```
test-case-design → product-requirement-analysis ❌
(测试用例设计在需求分析之前)
```

**正确示例**:
```
product-requirement-analysis → test-case-design ✅
(先有需求，再设计测试)
```

---

### 2. 文档驱动的技能链

```
需求文档 → 开发实现 → 测试用例
   ↓           ↓           ↓
requirement → implementation → test-cases
```

每个技能都依赖前一个技能的产出文档，形成完整的文档链。

---

### 3. 协同技能作为检查点

```
开发完成 → [collab-dev-to-qa] → 测试开始
                  ↓
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

## 🔍 调试技能调用

### 问题：技能未触发

**排查步骤**:
1. 检查触发词是否匹配
2. 检查技能是否已加载到 `oh-my-opencode.json`
3. 检查技能文件路径是否正确

### 问题：技能调用顺序错误

**排查步骤**:
1. 检查前置文档是否存在
2. 检查依赖技能是否已执行
3. 查看文档流是否连续

---

## 📊 链路监控指标

### 技能执行指标
- 技能调用次数
- 平均执行时间
- 技能成功率

### 文档流指标
- 文档产出率
- 文档覆盖率
- 文档更新频率

### 协同效率指标
- 交接次数
- 返工次数
- 验收通过率

---

**文档版本**: v1.0  
**最后更新**: 2026-03-10  
**技能总数**: 25  
**调用链路**: 7 条核心链路 + N 条条件分支
