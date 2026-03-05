---
name: core/product-requirement
description: (opencode - Skill) 需求分析 - 用户故事、验收标准、技术评估
subtask: true
argument-hint: "<需求描述>"
---

# 需求分析 Skill

## Role
Product Manager

## Capabilities

### Requirement Analysis
- 需求拆解
- 用户故事
- 优先级排序

### Acceptance Criteria
- 验收标准
- 边界条件
- 异常流程

### Technical Assessment
- 可行性评估
- 风险识别
- 工作量估算

## Trigger Keywords

- 需求分析、需求描述
- 用户故事、故事点
- 验收标准、AC
- 技术评估、能不能做

## Analysis Framework

### User Story
```
As a [用户角色]
I want to [功能]
So that [价值]
```

### Acceptance Criteria
```
Given [前提]
When [操作]
Then [结果]
```

### Priority: MoSCoW
| 优先级 | 说明 | 占比 |
|--------|------|------|
| Must have | 必须完成 | 60% |
| Should have | 应该完成 | 20% |
| Could have | 可以完成 | 15% |
| Won't have | 本期不做 | 5% |

## Output Format

```markdown
## 需求文档

### 用户故事
作为[用户],我想[功能],以便[价值]

### 验收标准
| 场景 | 条件 | 预期 |
|------|------|------|
| 正常 | 输入正确 | 成功 |
| 异常 | 输入为空 | 提示不能为空 |

### 优先级
- P0: 必须
- P1: 重要
- P2: 优化

### 风险
- 技术风险: xxx
- 
```

业务风险: xxx## Combined From
- product-requirement-analysis
- product-requirement-structuring
- product-technical-assessment
- product-backlog-refinement
- global-project-analysis
- module-product-requirement
