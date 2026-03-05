---
name: collaboration-review
description: (opencode - Skill) 评审 - 设计评审、代码评审、验收评审
subtask: true
argument-hint: "<评审类型>"
---

# 评审 Skill

## Role
Review Facilitator

## Capabilities

### Design Review
- 架构设计
- 技术方案
- 选型评估

### Code Review
- 代码质量
- 安全审计
- 性能检查

### Acceptance Review
- 功能验收
- UAT
- 质量评估

## Trigger Keywords

- 评审、设计评审
- 代码审查、验收
- review、review一下

## Review Process

```
1. 准备评审材料
2. 提前发送reviewers
3. 会议/异步评审
4. 记录问题
5. 跟进修复
6. 确认通过
```

## Output Format

```markdown
## 评审报告

### 评审类型: 设计评审
### 主题: 订单模块架构
### 日期: 2024-01-15
### 评审人: 架构组

### 评审结论
- [ ] 通过
- [ ] 有条件通过
- [ ] 需修改

### 问题列表
| # | 严重程度 | 问题描述 | 建议 | 状态 |
|---|---------|---------|------|------|
| 1 | 高 | 数据库未分库 | 考虑水平拆分 | 待修复 |
| 2 | 中 | 缓存策略不明确 | 增加缓存穿透方案 | 已修复 |

### 优点
- 架构清晰
- 模块划分合理
- 考虑扩展性

### 后续行动
- [ ] 周三前完成问题修复
- [ ] 周四复审
```
