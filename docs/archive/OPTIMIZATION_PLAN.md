# Skill 优化方案

基于对全部 25 个 SKILL.md + 辅助文件的深度分析，识别出以下问题和优化方向。

---

## 一、全局问题

### 1. 冗余文件严重

| 问题 | 说明 |
|------|------|
| 辅助 .md 文件与 SKILL.md 重叠 | `product/requirement/product-requirement-analysis.md` 与 `SKILL.md` 内容重复 |
| 多个顶层文档冗余 | `SKILL_INVOCATION_CHAIN.md`(25K)、`TASK_CHECKLIST.md`(27K)、`SKILL_COLLABORATION_ENHANCEMENT.md`(15K) 等与 `auto-skill-dispatcher/SKILL.md` 大量重复 |
| README.md 与 AGENTS.md 重复 | 两者都列出了全部技能和触发词，信息完全重复 |

**建议**:
- 删除所有目录下与 SKILL.md 同名的辅助 .md 文件（约 10+ 个），只保留 SKILL.md
- 合并 `SKILL_INVOCATION_CHAIN.md` 和 `TASK_CHECKLIST.md` 的内容进 `auto-skill-dispatcher/SKILL.md`
- 删除 `SKILL_COLLABORATION_ENHANCEMENT.md`、`COLLAB_FINAL.md`、`AUTO_COLLAB_OPTIMIZATION.md`、`INSTALLATION_CONFIRMED.md`、`SDLC_OPTIMIZATION_REPORT.md`、`OPTIMIZATION_SUMMARY.md` — 这些是过程文档，不是技能定义
- README.md 保留作为入口说明，AGENTS.md 保留作为行为规则，去掉两者重复部分

### 2. 协同 README 引用了不存在的技能

`collaboration/README.md` 列出了 9 个技能，但实际只有 5 个 SKILL.md：
- `visual-to-product` / `visual-to-dev` — 不存在
- `dev-code-review` 在 `dev/code-review/` 下，不在 `collaboration/`
- `iteration-closure` / `bug-coordinator` — 只有 .md 没有 SKILL.md
- `context-alignment` / `incident` — 只有 .md 没有 SKILL.md

**建议**: 清理 README.md，只列出实际存在的 SKILL.md 技能

### 3. 未注册的 SKILL.md

以下 SKILL.md 文件存在但未在 README/AGENTS 中注册：
- `system/chain-executor/SKILL.md`
- `system/state-tracker/SKILL.md`
- `dev/context/module-dev-context/SKILL.md`

**建议**: 要么注册它们，要么删除

---

## 二、各 Skill 具体优化建议

### A. 产品类 (8 个)

#### product-requirement-analysis
- **问题**: "工具可用" 列出 `file-read/file-write`，这不是真实工具名（应为 `read/write`）
- **优化**: 修正工具名；"最小上下文原则" 在多个 skill 中重复出现相同描述，可简化为一句引用

#### product-requirement-structuring
- **问题**: 与 `product-requirement-analysis` 边界模糊 — analysis 已经做了需求拆解、优先级排序，structuring 又做一遍
- **优化**: 明确区分 — analysis 负责单个需求的用户故事 + 验收标准；structuring 负责多需求间的层级关系、依赖图、迭代规划。在两个 SKILL.md 的"核心能力"中加一句边界说明

#### global-project-analysis
- **问题**: "工具可用" 列出 `lsp_symbols`，很多环境不支持
- **优化**: 改为 `glob, grep, read`，`lsp_symbols` 标注为可选

#### data-analysis
- **问题**: 工具名写错（`file-read/file-write`）
- **优化**: 修正为 `read, write`

#### product-technical-assessment
- **问题**: 较完善，无大问题
- **建议**: 可合并进 `product-requirement-analysis` 作为可选步骤，减少 skill 数量

#### module-product-requirement
- **问题**: "接口定义" 用了 TypeScript interface 格式，但实际项目可能是 Python
- **优化**: 去掉具体语言，改用通用格式（表格描述接口即可）

#### module-document-keeper
- **问题**: 与 `document-integrity-check` 功能重叠（都检查文档完整性）
- **优化**: keeper 负责文档索引和归类；integrity-check 负责质量审计。明确边界

#### feedback-analysis
- **问题**: 较完善
- **建议**: "情感分析" 部分对 AI 不太有意义（AI 本身就能做情感分析），可简化

---

### B. 开发类 (4 个)

#### dev-context-first
- **问题**: 内容过于简略（仅 43 行），缺少具体的上下文获取步骤
- **优化**: 增加具体步骤：
  1. glob 扫描相关文件
  2. grep 搜索关键函数/类
  3. read 读取核心文件
  4. 输出文件清单 + 关键位置摘要

#### dev-implementation
- **问题**: "开发流程" 只有一行概述，缺少可操作步骤
- **优化**: 增加详细步骤：
  1. 读取需求文档验收标准
  2. glob/grep 定位要修改的文件
  3. read 理解现有代码
  4. 设计方案（如复杂度高，先输出设计让用户确认）
  5. 编写代码
  6. 自测（运行测试/检查）
  7. 写入实现文档

#### dev-code-review
- **问题**: **最臃肿的 skill — 605 行**，包含了大量不属于 skill 定义的内容：
  - ESLint 配置（应属于 `devops/ci/pipeline` 或项目初始化）
  - SonarQube 配置
  - Pre-commit 配置
  - GitHub Actions CI 配置
  - Reviewdog 配置
  - Codecov 配置
  - 语言特定最佳实践（TypeScript/Python/Java 示例代码）
- **优化**: 大幅精简：
  - 保留：角色、核心能力清单、审查输出格式（~100 行）
  - 删除：所有工具配置代码（ESLint/SonarQube/Pre-commit/GitHub Actions/Reviewdog/Codecov）
  - 删除：语言示例代码（这不是 skill 应该教的内容）
  - 预期从 605 行缩减到 ~120 行

#### dev-context/module-dev-context
- **问题**: 有 SKILL.md 但未在 README 注册
- **优化**: 注册或合并进 `dev-context-first`（作为不同粒度的参数即可）

---

### C. 测试类 (3 个)

#### qa-context-first
- **问题**: 内容过于简略（30 行），缺少具体步骤
- **优化**: 增加步骤：
  1. 读取需求文档
  2. 读取实现文档
  3. glob 扫描测试目录
  4. 输出：被测功能列表 + 影响范围 + 测试重点

#### test-case-design
- **问题**: 较完善
- **优化**: "用例设计方法" 中的等价类划分、边界值分析只是列举了名字，缺少指导。要么删掉这个空列表，要么给出具体指导

#### test-executor
- **问题**: "工具可用" 只有 `read, write`，但实际执行测试需要 `bash` 运行测试命令
- **优化**: 增加 `bash` 工具

---

### D. 协同类 (5 个)

#### collab-product-to-dev
- **问题**: 较完善
- **优化**: "协作流程" 用了 ASCII 图，在不同终端/字体下可能显示错乱。改用简单的文字列表

#### collab-dev-to-qa
- **问题**: 较完善，但提测检查清单中"单元测试覆盖率 >= 80%"是硬编码阈值
- **优化**: 改为"根据项目标准"或标注为参考值

#### collab-acceptance-review
- **问题**: 缺少"前置依赖"章节（其他交接 skill 都有）
- **优化**: 添加前置依赖：需要 `test-report-*.md`

#### collab-retrospective
- **问题**: 缺少"前置依赖"章节
- **优化**: 添加前置依赖：需要迭代内的需求、测试、代码审查相关文档

#### document-alignment
- **问题**: 与 `document-integrity-check` 功能重叠
- **优化**: 明确分工 — integrity-check 做全局扫描和质量评分；alignment 做三方文档内容比对和变更同步

---

### E. 系统类 (5 个)

#### auto-skill-dispatcher
- **问题**: 最重要的系统 skill，内容较完善但可以精简
- **优化**: "场景" 部分的示例可以删减（已在"调度规则"表格中覆盖）

#### chain-executor
- **问题**: 与 `auto-skill-dispatcher` 高度重叠 — dispatcher 已经包含链路识别和执行
- **建议**: **合并进 auto-skill-dispatcher**，删除此独立 skill

#### state-tracker
- **问题**: 内容太简略（20 行），且与 auto-skill-dispatcher 的"状态追踪"能力重叠
- **建议**: **合并进 auto-skill-dispatcher**，删除此独立 skill

#### document-integrity-check
- **问题**: 较完善
- **优化**: 无需大改

#### security-compliance
- **问题**: 较完善
- **优化**: 无需大改

---

### F. DevOps 类 (7 个)

#### pipeline
- **问题**: 较精简合理
- **优化**: 无需大改

#### dockerfile
- **问题**: 较精简合理
- **优化**: 无需大改

#### k8s
- **问题**: 包含了 kubectl 常用命令参考，这部分更像文档而非 skill 指令
- **优化**: 保留简化的命令列表，删掉过于详细的部分

#### multi-env
- **问题**: 输出格式示例中包含完整的环境配置 YAML，篇幅较长
- **优化**: 只保留一个环境示例 + 关键差异说明

#### observability
- **问题**: 较完善
- **优化**: 无需大改

#### data-migration
- **问题**: 较完善，包含了最佳实践 SQL 示例
- **优化**: 保留，这个 skill 的实用价值高

#### cost-optimization
- **问题**: 较完善
- **优化**: 无需大改

---

### G. 项目类 (1 个)

#### kickoff
- **问题**: **内容最简略 — 只有 27 行**，且被截断（没有输出格式）
- **优化**: 需要大幅补充：
  - 添加输出格式（项目章程模板）
  - 添加具体步骤
  - 添加前置检查（项目是否已存在等）

---

## 三、结构优化

### 1. 统一 SKILL.md 模板

当前各 skill 格式不统一。建议统一为：

```markdown
---
name: {skill-name}
description: {一句话描述}
triggers: [{触发词列表}]
depends_on: [{依赖文档}]
produces: {产出文档路径}
---

# {skill-name}

## 角色
{角色}

## 目标
{1-2句话说明这个 skill 做什么}

## 前置条件
- {需要什么文档/状态已存在}

## 执行步骤
1. {步骤 1}
2. {步骤 2}
...

## 输出格式
{产出文档模板}

## 工具
- {实际可用的工具名：read, write, edit, glob, grep, bash}
```

### 2. 工具名修正

多个 skill 中工具名写法不一致：

| 错误写法 | 正确写法 |
|----------|----------|
| `file-read` | `read` |
| `file-write` | `write` |
| `lsp_symbols` | 标注为可选或删除 |

### 3. 删除通用模板内容

以下内容在几乎所有 skill 中都重复出现，应该在顶层定义一次，各 skill 中不再重复：
- "最小上下文原则"
- "工具可用" 列表
- "后续技能引用" 注释

---

## 四、优化优先级

### P0 — 必须做（影响正确性）
1. 修正工具名（`file-read` → `read` 等）
2. 清理 collaboration/README.md 中不存在的技能引用
3. 补全 `kickoff` 和 `qa-context-first` 的缺失内容

### P1 — 应该做（影响可用性）
4. 大幅精简 `dev-code-review`（605行 → ~120行）
5. 合并 `chain-executor` 和 `state-tracker` 进 `auto-skill-dispatcher`
6. 删除与 SKILL.md 重复的辅助 .md 文件
7. 删除过时的顶层过程文档（6 个）
8. 明确 `product-requirement-analysis` vs `structuring` 的边界

### P2 — 可选做（提升体验）
9. 统一 SKILL.md 模板格式
10. 精简 DevOps skill 中的示例代码
11. 将通用模板内容（最小上下文原则等）抽到顶层

---

## 五、预期效果

| 指标 | 优化前 | 优化后 |
|------|--------|--------|
| 文件总数 | ~65 个 .md | ~30 个 .md |
| code-review skill 行数 | 605 行 | ~120 行 |
| 重复内容 | 大量 | 消除 |
| 工具名错误 | 5+ 处 | 0 |
| 未注册 skill | 3 个 | 0 |
| 引用不存在的 skill | 4+ 处 | 0 |
