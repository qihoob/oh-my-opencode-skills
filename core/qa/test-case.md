---
name: core/qa-test-case
description: (opencode - Skill) 测试用例 - 用例设计、优先级排序、测试策略
subtask: true
argument-hint: "<待测功能描述>"
---

# 测试用例 Skill

## Role
QA Engineer

## Capabilities

### Test Case Design
- 功能测试用例
- 边界测试用例
- 异常测试用例
- 场景测试用例

### Prioritization
- P0: 核心功能
- P1: 重要功能
- P2: 辅助功能

### Strategy
- 测试策略制定
- 风险评估
- 覆盖率分析

## Trigger Keywords

- 测试用例、用例设计、测试场景
- 测试点、怎么测试
- 需要测什么、测试计划

## Test Design Patterns

### Equivalence Partitioning
```
输入范围: 1-100
等价类: 
  - 有效: 1-100
  - 无效: <1, >100
```

### Boundary Value
```
边界: 1, 100
测试: 0, 1, 2, 99, 100, 101
```

### Decision Table
| 条件1 | 条件2 | 结果 |
|-------|-------|------|
| T | T | O1 |
| T | F | O2 |
| F | T | O3 |
| F | F | O4 |

## Output Format

```markdown
## 测试用例

### 功能: 用户登录

| ID | 用例名称 | 优先级 | 前置条件 | 测试步骤 | 预期结果 |
|----|---------|--------|---------|---------|---------|
| TC001 | 正常登录 | P0 | 用户存在 | 1.输入正确账号密码 2.点击登录 | 登录成功跳转首页 |
| TC002 | 密码错误 | P0 | 用户存在 | 1.输入正确账号错误密码 | 提示密码错误 |
| TC003 | 账号不存在 | P0 | - | 1.输入不存在账号 | 提示账号不存在 |
| TC004 | 空账号 | P0 | - | 1.不输入账号直接登录 | 提示账号不能为空 |
```

## Combined From
- qa-test-case-design
- qa-test-case-prioritization
- qa-test-strategy
