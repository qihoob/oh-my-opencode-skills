# oh-my-opencode-skills 行为规则

## 可用技能列表

以下是可用的技能，当用户输入匹配时**必须调用**相应技能：

### 产品类技能
- `product/requirement/product-requirement-analysis` - 当用户提到"需求分析"、"用户故事"、"功能定义"时调用
- `product/requirement/product-requirement-structuring` - 当用户提到"需求整理"、"结构化需求"时调用
- `product/analysis/global-project-analysis` - 当用户提到"项目分析"、"模块划分"、"全局梳理"时调用
- `product/analysis/data-analysis` - 当用户提到"数据分析"、"埋点"、"指标"时调用
- `product/analysis/product-technical-assessment` - 当用户提到"技术评估"、"技术可行性"时调用
- `product/module/module-product-requirement` - 当用户提到"模块需求"、"详细需求"时调用
- `product/module/module-document-keeper` - 当用户提到"模块文档"、"文档整理"、"文档管理"、"把控全局"时调用
- `product/feedback/analysis` - 当用户提到"用户反馈"、"反馈分析"、"NPS"、"A/B 测试"时调用

### 开发类技能
- `dev/context/dev-context-first` - 当用户提到"给我上下文"、"先看看代码"、"先了解下"、"给我看看"时调用
- `dev/context/module-dev-context` - 当用户提到"模块上下文"、"了解模块"时调用
- `dev/implementation/dev-implementation` - 当用户提到"实现功能"、"编写代码"、"开发"、"做个功能"时调用
- `dev/code-review` - 当用户提到"代码审查"、"Code Review"、"审查代码"、"CR"、"代码检查"、"代码评审"、"代码质量"时调用

### 测试类技能
- `qa/context/qa-context-first` - 当用户提到"测试上下文"、"了解被测功能"时调用
- `qa/test-case/test-case-design` - 当用户提到"测试用例"、"设计用例"、"测试场景"时调用
- `qa/execution/test-executor` - 当用户提到"执行测试"、"运行测试"、"测试执行"、"测试报告"时调用

### 协同类技能
- `collaboration/handoff/collab-product-to-dev` - 当用户提到"需求交接"、"需求评审"、"产品给开发"时调用
- `collaboration/handoff/collab-dev-to-qa` - 当用户提到"提测"、"测试交接"、"开发完成"时调用
- `collaboration/review/collab-acceptance-review` - 当用户提到"验收"、"UAT"、"验收评审"时调用
- `collaboration/process/collab-retrospective` - 当用户提到"复盘"、"回顾"、"总结"、"retro"时调用
- `collaboration/sync/document-alignment` - 当用户提到"文档对齐"、"文档同步"、"三方对齐"时调用

### 系统类技能
- `system/auto-skill-dispatcher` - 当不确定使用哪个技能时，调用此自动调度器
- `system/document-integrity-check` - 当用户提到"文档检查"、"完整性检查"、"文档审计"时调用
- `system/security/compliance` - 当用户提到"安全审计"、"合规检查"、"GDPR"、"数据加密"、"SOC2"时调用

### 项目类技能
- `project/kickoff` - 当用户提到"启动项目"、"新项目"、"项目初始化"时调用

### DevOps 类技能
- `devops/ci/pipeline` - 当用户提到"CI/CD"、"流水线"、"GitHub Actions"、"Jenkins"时调用
- `devops/deploy/dockerfile` - 当用户提到"Docker"、"容器化"、"dockerfile"时调用
- `devops/deploy/k8s` - 当用户提到"K8s"、"Kubernetes"、"kubectl"时调用
- `devops/deploy/multi-env` - 当用户提到"多环境"、"环境配置"、"dev/staging/prod"时调用
- `devops/monitoring/observability` - 当用户提到"监控"、"告警"、"日志"、"链路追踪"、"Grafana"、"Prometheus"、"Jaeger"时调用
- `devops/data/migration` - 当用户提到"数据库迁移"、"数据变更"、"DDL"、"迁移脚本"、"回滚方案"时调用
- `devops/cost-optimization` - 当用户提到"成本优化"、"云成本"、"FinOps"、"预算管理"、"资源优化"时调用

---

## 调用协议

当用户输入包含上述关键词时，**必须**：

1. **先调用 skill() 工具**加载相应技能
2. **等待技能内容加载完成**
3. **按照技能指令执行任务**

### 示例流程

用户输入："帮我分析一下用户登录的需求"

正确流程：
```
1. 识别关键词"分析"、"需求"
2. 调用 skill(name="product/requirement/product-requirement-analysis")
3. 等待技能内容加载
4. 按照技能定义的格式输出用户故事和验收标准
```

---

## 技能联动规则

某些任务需要**多个技能协作**：

### 完整开发流程
1. 产品分析 → `product-requirement-analysis`
2. 需求交接 → `collab-product-to-dev`
3. 开发上下文 → `dev-context-first`
4. 功能实现 → `dev-implementation`
5. 代码审查 → `dev-code-review`
6. 提测交接 → `collab-dev-to-qa`
7. 测试用例 → `test-case-design`
8. 测试执行 → `test-executor`
9. 验收评审 → `collab-acceptance-review`

当用户请求完整流程时，应**按顺序调用**这些技能。

---

## 全局文档把控流程

### 模块级文档管理
当用户提到"模块文档"、"把控全局"、"文档整理"时：

1. **文档整合** → `module-document-keeper`
   - 扫描 `.opencode/docs/` 目录
   - 按模块归类文档
   - 生成模块文档索引 `INDEX.md`

2. **完整性检查** → `document-integrity-check`
   - 检查文档覆盖率
   - 生成审计报告 `DOC_AUDIT.md`
   - 标识缺失文档

3. **文档对齐** → `document-alignment`
   - 比对需求 - 实现 - 测试三方文档
   - 生成对齐报告
   - 记录待对齐事项

### 完整文档流

```
产品分析 → requirement-*.md → 开发读取 → 实现功能 → implementation-*.md
                              ↓
                              测试读取 → test-cases-*.md
```

### 上下文检查协议
在执行任何技能前，先检查：
1. `.opencode/docs/` 是否有相关文档？
2. 文档是否在上下文中？
3. 如不在，使用 `read` 工具按需加载相关章节

### 最小上下文原则
1. **文档优先** - 有文档时不重新分析
2. **按需读取** - 只读取相关章节，不加载全文
3. **结构化输出** - 便于后续技能定位内容
4. **引用标记** - 在文档中标注哪些内容供哪个技能使用

---

## 禁止行为

- ❌ 不要跳过 skill 调用直接执行任务
- ❌ 不要在技能加载完成前开始工作
- ❌ 不要忽略技能中定义的输出格式

---

## 优先级规则

1. **精确匹配** > 模糊匹配
2. **用户明确指定** > 自动推断
3. **项目级技能** > 全局技能
4. **已有文档** > 重新分析
