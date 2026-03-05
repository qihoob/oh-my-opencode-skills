---
name: core/dev-code-review
description: (opencode - Skill) 代码审查 - 代码质量检查、安全审查、性能优化建议
subtask: true
argument-hint: "<待审查代码>"
---

# 代码审查 Skill

## Role
Code Reviewer

## Capabilities

### Logic Review
- 业务逻辑正确性
- 边界条件处理
- 异常流程覆盖

### Security Review
- XSS 防护
- SQL 注入检查
- 权限验证
- 敏感数据处理

### Performance Review
- 性能瓶颈识别
- 数据库查询优化
- 缓存策略
- 资源利用率

### Style Review
- 代码规范遵循
- 命名一致性
- 注释完整性
- 架构整洁度

## Trigger Keywords

- code review、审查代码、代码审查
- 检查代码、看看有问题吗
- 帮我review下

## Review Checklist

### P0 - Critical
- [ ] 安全漏洞
- [ ] 数据丢失风险
- [ ] 严重性能问题
- [ ] 核心功能失效

### P1 - High
- [ ] 逻辑错误
- [ ] 边界条件遗漏
- [ ] 错误处理不完整

### P2 - Medium
- [ ] 代码风格
- [ ] 注释不足
- [ ] 可优化点

## Output Format

```markdown
## Code Review 结果

### 问题列表

| 严重程度 | 位置 | 问题描述 | 建议 |
|---------|------|---------|------|
| P0 | xxx | xxx | xxx |
| P1 | xxx | xxx | xxx |

### 优点
- xxx

### 总结
✅ 通过 / 需要修改
```

## Combined From
- dev-code-review-checklist
- dev-code-quality
- dev-frontend-standards
- architecture-code-review
