# oh-my-opencode-skills 行为规则

## 可用技能列表

以下是可用的 59 个技能，当用户输入匹配时**必须调用**相应技能：

### 系统类技能 (System)

- `system/auto-skill-dispatcher` - 当不确定使用哪个技能时，或用户输入匹配任何关键词时调用此自动调度器
- `system/chain-executor` - 当用户提到"执行链路"、"运行流程"、"开始流程"、"auto-run"时调用
- `system/state-tracker` - (内部技能，无用户触发词，由链路执行器自动调用)
- `system/document-integrity-check` - 当用户提到"文档检查"、"完整性检查"、"文档审计"、"文档质量"时调用
- `system/security/compliance` - 当用户提到"安全审计"、"合规检查"、"GDPR"、"数据加密"、"SOC2"、"安全漏洞"时调用

### 项目类技能 (Project)

- `project/kickoff` - 当用户提到"启动项目"、"新项目"、"项目初始化"时调用

### 产品类技能 (Product)

- `product/requirement/product-requirement-analysis` - 当用户提到"需求分析"、"用户故事"、"需求澄清"、"功能定义"时调用
- `product/requirement/product-requirement-structuring` - 当用户提到"需求整理"、"结构化需求"、"需求归类"、"需求层级"时调用
- `product/requirement/product-collaborative-requirement-optimization` - 当用户提到"需求评审"、"需求对齐"、"三方评审"、"需求优化"、"技术评审"、"需求澄清"、"验收标准确认"、"需求可行性"时调用
- `product/analysis/global-project-analysis` - 当用户提到"项目分析"、"模块划分"、"全局梳理"、"了解项目结构"时调用
- `product/analysis/data-analysis` - 当用户提到"数据分析"、"埋点"、"指标设计"、"数据追踪"、"转化漏斗"时调用
- `product/analysis/product-technical-assessment` - 当用户提到"技术评估"、"技术可行性"、"开发成本"、"技术风险"时调用
- `product/module/module-product-requirement` - 当用户提到"模块需求"、"详细需求"、"需求拆解"、"模块设计"时调用
- `product/module/module-document-keeper` - 当用户提到"模块文档"、"文档整理"、"文档管理"、"把控全局"、"文档汇总"时调用
- `product/module/product-page-feature-best-practices` - 当用户提到"页面最佳实践"、"功能设计规范"、"新页面设计"、"列表页设计"、"表单设计"、"弹窗设计"、"交互规范"、"UI设计参考"时调用
- `product/feedback/analysis` - 当用户提到"用户反馈"、"反馈分析"、"NPS"、"用户声音"、"VOC"、"A/B测试"时调用

### 开发类技能 (Dev)

- `dev/context/dev-context-first` - 当用户提到"给我上下文"、"先看看代码"、"先了解下"、"给我看看"、"看看结构"时调用
- `dev/context/module-dev-context` - 当用户提到"模块上下文"、"了解模块"、"模块结构"、"代码梳理"时调用
- `dev/context-restore` - 当用户提到"保存上下文"、"恢复上下文"、"保存进度"、"任务列表"、"切换任务"时调用
- `dev/implementation/dev-implementation` - 当用户提到"实现功能"、"编写代码"、"开发功能"、"做功能"、"写代码"、"测试驱动"、"TDD"、"先写测试"时调用
- `dev/implementation/frontend` - 当用户提到"前端开发"、"页面开发"、"组件开发"、"React开发"、"Vue开发"、"交互实现"时调用
- `dev/implementation/backend` - 当用户提到"后端开发"、"API开发"、"Service开发"、"接口实现"、"业务逻辑"、"数据库操作"时调用
- `dev/debugging` - 当用户提到"调试"、"debug"、"排查问题"、"定位bug"、"找bug原因"、"复现"、"根因分析"时调用
- `dev/refactoring` - 当用户提到"重构"、"refactor"、"代码重构"、"提取函数"、"消除重复"、"拆分大函数"、"拆大文件"时调用
- `dev/adr` - 当用户提到"ADR"、"架构决策"、"决策记录"、"技术选型"、"为什么用X"时调用
- `dev/dependency-eval` - 当用户提到"评估依赖"、"引入依赖"、"安全检查"、"npm audit"、"替代方案对比"、"许可证检查"时调用
- `dev/code-review` - 当用户提到"代码审查"、"Code Review"、"CR"、"代码检查"、"代码评审"、"代码质量"、"Review"时调用
- `dev/standards/dev-code-quality` - 当用户提到"lint"、"eslint"、"prettier"、"代码规范"、"命名规范"、"注释规范"、"pre-commit"、"类型检查"、"代码复杂度"时调用
- `dev/standards/dev-frontend-standards` - 当用户提到"前端规范"、"响应式"、"响应式布局"、"状态管理"、"加载状态"、"错误处理"、"性能优化"、"无障碍"、"a11y"时调用
- `dev/modules/module-collaborative-dev` - 当用户提到"多模块协同"、"模块开发"、"协同开发"、"接口定义"时调用
- `dev/modules/module-splitting` - 当用户提到"模块拆解"、"划分模块"、"拆解项目"、"模块边界"、"模块依赖"时调用
- `dev/modules/parallel-module-orchestrator` - 当用户提到"并行开发"、"并行模块"、"多模块编排"时调用
- `dev/verify-implementation` - 当用户提到"需求匹配"、"监督实现"、"代码验证"、"需求核对"、"模块验证"、"实现检查"、"需求对齐"时调用

### 测试类技能 (QA)

- `qa/context/qa-context-first` - 当用户提到"测试上下文"、"了解被测功能"、"测试范围"时调用
- `qa/context/qa-context-from-code` - 当用户提到"半路测试"、"没有需求文档"、"从代码分析"、"逆向测试"、"直接看代码"、"项目已做完要测试"时调用
- `qa/context/module-test-context` - 当用户提到"模块测试"、"获取测试上下文"、"测试前"时调用
- `qa/test-case/test-case-design` - 当用户提到"测试用例"、"设计用例"、"测试场景"时调用
- `qa/test-case/test-case-prioritization` - 当用户提到"用例优先级"、"测试排序"、"资源分配"、"测试策略"、"测试覆盖"时调用
- `qa/execution/test-executor` - 当用户提到"执行测试"、"运行测试"、"测试执行"、"测试报告"时调用
- `qa/advanced/e2e-testing` - 当用户提到"E2E测试"、"端到端测试"、"Playwright"、"Cypress"、"自动化测试"、"Page Object"、"视觉回归"时调用
- `qa/advanced/performance-testing` - 当用户提到"性能测试"、"负载测试"、"压力测试"、"k6"、"Lighthouse"、"Web Vitals"、"SLA"时调用

### 协同类技能 (Collaboration)

- `collaboration/handoff/collab-product-to-dev` - 当用户提到"需求交接"、"转开发"、"交给开发"、"需求确认"时调用
- `collaboration/handoff/collab-dev-to-qa` - 当用户提到"提测"、"测试交接"、"开发完成"、"申请测试"、"转测试"时调用
- `collaboration/review/collab-acceptance-review` - 当用户提到"验收"、"UAT"、"验收评审"、"产品验收"、"上线确认"时调用
- `collaboration/process/collab-retrospective` - 当用户提到"复盘"、"回顾"、"总结"、"retro"、"迭代总结"时调用
- `collaboration/process/bug-coordinator` - 当用户提到"Bug协调"、"Bug追踪"、"Bug修复"、"Bug管理"时调用
- `collaboration/process/iteration-closure` - 当用户提到"迭代闭环"、"下一迭代"、"复盘后"、"继续项目"时调用
- `collaboration/sync/document-alignment` - 当用户提到"文档对齐"、"文档同步"、"三方对齐"、"文档一致性"时调用
- `collaboration/sync/context-alignment` - 当用户提到"同步"、"对齐"、"上下文对齐"、"确认范围"、"模块协调"时调用
- `collaboration/sync/incident` - 当用户提到"线上故障"、"紧急"、"P0"、"应急"、"服务挂了"时调用

### DevOps 类技能 (DevOps)

- `devops/ci/pipeline` - 当用户提到"CI/CD"、"流水线"、"GitHub Actions"、"Jenkins"时调用
- `devops/deploy/dockerfile` - 当用户提到"Docker"、"容器化"、"dockerfile"、"镜像构建"时调用
- `devops/deploy/k8s` - 当用户提到"K8s"、"Kubernetes"、"kubectl"时调用
- `devops/deploy/multi-env` - 当用户提到"多环境"、"环境配置"、"dev/staging/prod"时调用
- `devops/monitoring/observability` - 当用户提到"监控"、"告警"、"日志"、"链路追踪"、"Grafana"、"Prometheus"时调用
- `devops/data/migration` - 当用户提到"数据库迁移"、"数据变更"、"DDL"、"迁移脚本"、"回滚方案"时调用
- `devops/cost-optimization` - 当用户提到"成本优化"、"云成本"、"FinOps"、"预算管理"、"资源优化"时调用

### 视觉类技能 (Visual)

- `visual/design-handoff` - 当用户提到"设计稿交接"、"设计标注"、"视觉验收"、"UI交接"、"开发协同"时调用
- `visual/design-review` - 当用户提到"设计评审"、"设计规范"、"视觉确认"、"UI确认"、"视觉产品经理"时调用

---

## 调用协议

当用户输入包含上述关键词时，**必须**：

1. **用 Read 工具读取对应 SKILL.md 文件**
2. **等待文件内容读取完成**
3. **按照技能指令执行任务**

**注意**：不要调用 Skill() 工具或 Agent 工具，oh-my-opencode 技能是 SKILL.md 文件，不是 Claude Code 原生注册的 skill。

### 示例流程

用户输入："帮我分析一下用户登录的需求"

正确流程：
```
1. 识别关键词"分析"、"需求"
2. Read("/home/hugh/skill/product/requirement/product-requirement-analysis/SKILL.md")
3. 按照技能定义的格式输出用户故事和验收标准
```

---

## 技能联动规则

某些任务需要**多个技能协作**。以下是核心链路：

### 链路 1: 完整 SDLC 流程 (12 步)

```
product-requirement-analysis
  -> product-collaborative-requirement-optimization
    -> collab-product-to-dev
      -> dev-context-first
        -> dev-implementation
          -> dev-code-review
            -> dev-verify-implementation
              -> collab-dev-to-qa
                -> qa-context-first
                  -> test-case-design
                    -> test-executor
                      -> collab-acceptance-review
                      -> collab-retrospective
                        -> iteration-closure
```

### 链路 2: Bug 修复流程 (5 步)

```
dev-context-first
  -> dev-implementation
    -> dev-code-review
      -> test-executor
        -> bug-coordinator (关闭)
```

### 链路 3: 新项目启动流程 (6 步)

```
project/kickoff
  -> global-project-analysis
    -> product-technical-assessment
      -> module-splitting
        -> module-product-requirement
          -> module-document-keeper
```

### 链路 4: 文档治理流程 (3 步)

```
module-document-keeper
  -> document-integrity-check
    -> document-alignment
```

### 链路 5: DevOps 部署流程 (6 步)

```
devops/ci/pipeline
  -> devops/deploy/dockerfile
    -> devops/deploy/k8s
      -> devops/deploy/multi-env
        -> devops/monitoring/observability
          -> devops/cost-optimization
```

### 链路 6: 安全合规流程 (2 步)

```
system/security/compliance
  -> dev/code-review (如有问题)
```

### 链路 7: 用户反馈驱动优化 (4 步)

```
product/feedback/analysis
  -> product-requirement-analysis
    -> dev-implementation
      -> collab-acceptance-review
```

### 链路 8: 紧急故障处理 (4 步)

```
collaboration/sync/incident
  -> dev-context-first
    -> dev-implementation
      -> dev-code-review
```

### 链路 9: 前端专项开发 (5 步)

```
product-page-feature-best-practices
  -> dev-context-first
    -> dev/implementation/frontend
      -> dev-frontend-standards
        -> dev-code-review
```

### 链路 10: 性能测试专项 (3 步)

```
qa-context-first
  -> qa/advanced/performance-testing
    -> test-executor
```

### 链路 11: 系统化调试 (4 步)

```
dev/debugging (复现→定位根因)
  -> dev-implementation (Bug修复模式)
    -> test-executor (验证修复)
      -> bug-coordinator (关闭Bug)
```

### 链路 12: 安全重构 (5 步)

```
dev/refactoring (识别坏味道→建立安全网→小步重构)
  -> test-executor (验证行为不变)
    -> dev/code-review (审查重构)
      -> dev/adr (记录重构决策，如涉及架构变更)
```

### 链路 13: 依赖引入 (3 步)

```
dev/dependency-eval (安全+质量+体积+许可证评估)
  -> dev/implementation (引入依赖)
    -> dev/adr (记录选型决策)
```

当用户请求完整流程时，应**按顺序调用**这些技能。可通过 `system/chain-executor` 执行预定义链路。

---

## 全局文档把控流程

### 模块级文档管理

当用户提到"模块文档"、"把控全局"、"文档整理"时：

1. **文档整合** -> `module-document-keeper`
   - 扫描 `.opencode/docs/` 目录
   - 按模块归类文档
   - 生成模块文档索引 `INDEX.md`

2. **完整性检查** -> `document-integrity-check`
   - 检查文档覆盖率
   - 生成审计报告 `DOC_AUDIT.md`
   - 标识缺失文档

3. **文档对齐** -> `document-alignment`
   - 比对需求 - 实现 - 测试三方文档
   - 生成对齐报告
   - 记录待对齐事项

### 完整文档流

```
产品分析 -> requirement-*.md -> 开发读取 -> 实现功能 -> implementation-*.md
                             |
                             +-> 测试读取 -> test-cases-*.md
                             |
                             +-> 验收读取 -> acceptance-*.md
```

### 文档依赖矩阵

| 技能 | 必须读取的文档 | 产出的文档 |
|------|---------------|-----------|
| `product-requirement-analysis` | 无（或 project-overview.md） | `requirement-{feature}.md` |
| `product-collaborative-requirement-optimization` | `requirement-*.md` | 优化后的需求文档 |
| `dev-context-first` | `requirement-{feature}.md` + **目标模块代码** | 上下文报告（含业务逻辑和代码路径） |
| `dev-context-restore` | `context-snapshot-{task}.md` | `context-snapshot-{task}.md` |
| `dev-implementation` | `requirement-{feature}.md` + **现有实现代码** | `implementation-{feature}.md` |
| `dev-debugging` | 报错信息 + **相关代码** | `bugfix-{bug-id}.md` |
| `dev-refactoring` | **目标代码** + **测试** | `refactoring-{scope}.md` |
| `dev-adr` | 需求/契约/实现文档 | `adr-{seq}-{title}.md` |
| `dev-dependency-eval` | 无 | `dep-eval-{package-name}.md` |
| `dev-verify-implementation` | `requirement-*.md` + `implementation-*.md` | 验证报告 |
| `test-case-design` | `requirement-{feature}.md` + **实现代码（必须）** | `test-cases-{feature}.md` |
| `test-executor` | `test-cases-{feature}.md` | `test-report-{feature}.md` |
| `module-document-keeper` | `.opencode/docs/*` | `INDEX.md` |
| `document-integrity-check` | `.opencode/docs/*` | `DOC_AUDIT.md` |
| `document-alignment` | 需求 + 实现 + 测试文档 | `alignment-*.md` |

### 上下文检查协议

在执行任何技能前，先检查：
1. `.opencode/docs/` 是否有相关文档？
2. **目标代码是否存在？** — 有代码时必须分析实际实现
3. 文档是否在上下文中？
4. 如不在，使用 `read` 工具按需加载相关章节
5. **代码与文档是否一致？** — 不一致时以代码为准，标注差异

### 最小上下文原则

1. **代码优先** - 有代码时不只依赖文档，必须分析实际实现
2. **文档辅助** - 文档提供意图和标准，代码提供事实
3. **按需读取** - 只读取相关章节，不加载全文
4. **结构化输出** - 便于后续技能定位内容
5. **引用标记** - 在文档中标注哪些内容供哪个技能使用
6. **差异标注** - 代码与文档不一致时必须标注，以代码为准

---

## 禁止行为

- 不要跳过 skill 调用直接执行任务
- 不要在技能加载完成前开始工作
- 不要忽略技能中定义的输出格式
- 不要跳过前置依赖检查直接执行下游技能
- 不要在缺少前置文档时继续执行（应提示用户先完成前置步骤）

---

## 优先级规则

1. **精确匹配** > 模糊匹配
2. **用户明确指定** > 自动推断
3. **项目级技能** > 全局技能
4. **已有文档** > 重新分析
5. **紧急/故障类技能** (`incident`, `bug-coordinator`) > 常规技能
6. **具体领域技能** (如 `frontend`, `backend`) > 通用技能 (如 `dev-implementation`)
7. **专项标准技能** (如 `dev-code-quality`, `dev-frontend-standards`) 在对应领域问题触发时优先于通用技能

### 关键词冲突解决

当多个技能的关键词重叠时：

| 冲突场景 | 优先选择 | 原因 |
|----------|---------|------|
| "需求澄清" 同时匹配 `product-requirement-analysis` 和 `product-collaborative-requirement-optimization` | `product-collaborative-requirement-optimization` | 多方评审场景更具体 |
| "代码质量" 同时匹配 `dev-code-review` 和 `dev-code-quality` | `dev-code-quality` | 规范层面问题优先用标准技能 |
| "模块开发" 同时匹配 `module-dev-context` 和 `module-collaborative-dev` | 根据上下文判断：了解结构用前者，协同编码用后者 | 语义区分 |
| "测试" 匹配多个 QA 技能 | 根据"设计/执行/性能/E2E"等二级关键词精确匹配 | 二级关键词消歧 |
| "Bug修复" 同时匹配 `dev/debugging` 和 `dev-implementation` | `dev-debugging` 定位根因 → `dev-implementation` 执行修复 | 先定位再修复 |
| "技术选型" 同时匹配 `dependency-eval` 和 `adr` | `dependency-eval` 评估依赖 → `adr` 记录决策 | 先评估再记录 |
| "重构" 同时匹配 `dev-refactoring` 和 `dev-implementation` | `dev-refactoring` | 重构是专门场景，有自己的安全流程 |
