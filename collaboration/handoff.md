---
name: collaboration-handoff
description: (opencode - Skill) 角色交接 - 产品→开发→测试 角色过渡
subtask: true
argument-hint: "<交接场景>"
---

# 角色交接 Skill

## Role
Collaboration Manager

## Capabilities

### Product → Dev
- 需求澄清
- 技术确认
- 验收标准对齐

### Dev → QA
- 实现说明
- 测试范围
- 测试数据

### QA → Product
- 测试结果
- 问题反馈
- 验收确认

## Trigger Keywords

- 提测、交给测试
- 开发完成、转交
- 需求评审、可以开发了

## Handoff Checklist

### Product → Dev
- [ ] 需求文档完整
- [ ] 验收标准清晰
- [ ] 边界条件明确
- [ ] 技术可行性确认

### Dev → QA
- [ ] 代码合并完成
- [ ] 接口文档更新
- [ ] 测试数据准备
- [ ] 自测通过

### QA → Product
- [ ] 测试用例通过
- [ ] 缺陷修复确认
- [ ] 验收条件满足
- [ ] 签署通过

## Output Format

```markdown
## 交接报告

### 交接类型: Dev → QA

### 交接内容
- 功能: 用户登录
- 分支: feature/login
- commit: abc123

### 测试范围
| 模块 | 测试类型 | 优先级 |
|------|---------|--------|
| 登录 | 功能 | P0 |
| 登出 | 功能 | P0 |
| token | 接口 | P1 |

### 测试数据
- 测试账号: test@example.com / 123456
- Mock服务: 已部署

### 已知问题
| ID | 描述 | 状态 |
|----|------|------|
| BUG-001 | 验证码过期时间短 | 遗留 |

### 签署
开发: _________ 日期: _________
测试: _________ 日期: _________
```

## Combined From
- collab-product-to-dev
- collab-dev-to-qa
- collab-qa-to-product
