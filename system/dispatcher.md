---
name: system-dispatcher
description: (opencode - Skill) 自动调度 - 根据用户意图自动选择合适技能
subtask: true
argument-hint: "<用户请求>"
---

# 自动调度 Skill

## Role
Skill Dispatcher

## Capabilities

### Intent Recognition
- 理解用户意图
- 提取关键信息
- 场景判断

### Skill Matching
- 匹配最佳技能
- 参数提取
- 执行协调

### Multi-skill Orchestration
- 技能链编排
- 顺序安排
- 结果聚合

## Trigger Keywords

- 任何开发相关请求
- 一键完成、多步骤

## Dispatch Logic

```
用户输入 → 意图识别 → 技能匹配 → 执行 → 结果
```

## Intent Patterns

| 模式 | 示例 | 触发技能 |
|------|------|---------|
| 开发 | 帮我实现xxx | core/dev-implementation |
| 测试 | 帮我测试xxx | core/qa-test-case |
| 审查 | 看看代码有问题吗 | core/dev-code-review |
| 需求 | 帮我分析需求 | core/product-requirement |
| 部署 | 部署上线 | core/dev-deployment |
| 调试 | 出错了 | core/dev-debugging |
| 评审 | 需求评审 | collaboration-review |
| 交接 | 开发完成 | collaboration-handoff |

## Output Format

```markdown
## 自动调度结果

### 识别意图: 功能开发

### 技能链
1. core/product-requirement - 需求分析
2. core/dev-implementation - 功能实现
3. core/dev-code-review - 代码审查
4. core/qa-test-execution - 测试执行

### 执行计划
- 首先分析需求
- 然后实现代码
- 接着代码审查
- 最后测试验证

### 开始执行? [确认/取消]
```
