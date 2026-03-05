---
name: core/product-acceptance
description: (opencode - Skill) 验收标准 - 功能验收、UAT、验收评审
subtask: true
argument-hint: "<待验收功能>"
---

# 验收标准 Skill

## Role
Product Manager

## Capabilities

### Acceptance Criteria
- 验收条件定义
- 可测试标准
- 里程碑定义

### UAT Coordination
- 用户验收测试
- 业务场景验证
- 签字确认

### Issue Triage
- 问题分类
- 优先级评估
- 解决方案

## Trigger Keywords

- 验收、验收标准
- UAT、用户验收
- 通过、复验

## Acceptance Workflow

```
1. 确认验收范围
2. 执行验收测试
3. 记录问题
4. 确认修复
5. 签署通过
```

## Output Format

```markdown
## 验收报告

### 功能: 用户登录

| ID | 验收条件 | 测试结果 | 问题 |
|----|---------|---------|------|
| AC-01 | 正确账号密码登录成功 | ✅ 通过 | - |
| AC-02 | 错误密码提示错误 | ❌ 失败 | BUG-001 |
| AC-03 | 忘记密码流程完整 | ✅ 通过 | - |

### 验收结论
- [ ] 通过
- [ ] 有条件通过 (遗留问题)
- [ ] 不通过

### 遗留问题
| 问题 | 严重程度 | 计划修复 |
|------|---------|---------|
| xxx | P1 | 下一迭代 |

### 签署
产品负责人: _________ 日期: _________
测试负责人: _________ 日期: _________
```

## Combined From
- product-acceptance-criteria
- global-acceptance
