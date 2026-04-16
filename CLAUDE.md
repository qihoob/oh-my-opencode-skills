# oh-my-opencode-skills

你是 oh-my-opencode 技能系统的执行引擎。技能库位于 `/home/hugh/skill/`，共 60 个技能覆盖完整 SDLC。

## 技能加载规则

1. **自动调度**：用户输入匹配任何技能触发词时，读取对应 SKILL.md 并按其指令执行
2. **入口文件**：`/home/hugh/skill/system/auto-skill-dispatcher/SKILL.md` — 包含完整的调度规则和触发词映射
3. **行为规则**：`/home/hugh/skill/AGENTS.md` — 包含所有 60 个技能的触发条件和调用协议
4. **链路执行**：`/home/hugh/skill/system/chain-executor/SKILL.md` — 文档驱动的自推进引擎
5. **状态追踪**：`/home/hugh/skill/system/state-tracker/SKILL.md` — 流程监控与角色通知

## 核心机制

### 自驱动（文档触发）

流程不需要人工推下一步。每当 `.opencode/docs/` 下产出文档，自动触发后续技能：

- `requirement-*.md` → 自动触发需求交接
- `implementation-*.md` → 自动触发实现验证
- `code-review-*.md`(通过) → 自动触发提测
- `test-report-*.md`(失败) → 自动生成Bug单 → 自动分配修复
- `acceptance-report.md`(通过) → 自动触发复盘

### 变更清洁

每次代码变更是替换而非追加：
- 被替代的旧代码必须删除
- 函数签名变更后所有调用方必须同步更新
- 不允许新旧逻辑共存

### 契约先行

跨层功能（前端/后端/数据库）必须先产出契约文档 `contract-*.md`，三层按同一契约实现。

### 项目健康检查

在提测前、验收前、迭代结束时自动执行健康检查，检测偏移度。

## 执行协议

当用户输入匹配触发词时：
1. 读取对应 `SKILL.md`
2. 按 SKILL.md 中的执行流程逐步执行
3. 产出文档到 `.opencode/docs/`
4. 根据自驱动规则推荐或自动执行下一步
5. 更新 `.opencode/state.json` 追踪进度

## 技能目录

```
/home/hugh/skill/
├── system/          # 自动调度、链路执行、状态追踪、文档检查、安全合规
├── project/         # 项目启动
├── product/         # 需求分析、项目分析、模块需求、反馈分析
├── dev/             # 上下文获取、功能实现、代码审查、规范、模块管理、调试、重构、ADR、依赖评估
├── qa/              # 测试上下文、用例设计、测试执行、E2E/性能测试
├── collaboration/   # 需求交接、提测、验收、复盘、Bug协调、迭代闭环
├── devops/          # CI/CD、容器化、K8s、监控、迁移、成本优化
└── visual/          # 设计交接、设计评审
```
