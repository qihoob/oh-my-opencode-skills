---
name: collaboration-retrospective
description: (opencode - Skill) 迭代复盘 - 回顾总结、改进计划、闭环跟踪
subtask: true
argument-hint: "<迭代信息>"
---

# 迭代复盘 Skill

## Role
Agile Coach

## Capabilities

### Retrospective
- 亮点收集
- 改进点
- 感谢

### Action Planning
- 改进措施
- 责任人
- 完成时间

### Closure
- 目标对齐
- 资源规划
- 下轮启动

## Trigger Keywords

- 复盘、回顾
- retro、迭代总结
- 改进、闭环

## Retro Format

### Classic (Start/Stop/Continue)
```
Start: 开始做
Stop:  停止做  
Continue: 继续做
```

### 4Ls (Liked/Learned/Lacked/Longed for)
```
Liked: 喜欢的
Learned: 学到的
Lacked: 欠缺的
Longed for: 期待的
```

## Output Format

```markdown
## 迭代复盘报告

### 迭代: Sprint 15 (1月1日 - 1月14日)

### 交付情况
| 指标 | 目标 | 实际 |
|------|------|------|
| 需求数 | 10 | 8 |
| 完成率 | 100% | 80% |
| Bug数 | - | 12 |

### 亮点 ✨
- 支付模块按时交付
- 代码质量提升
- 团队协作顺畅

### 改进点 📌
- 需求评审不够充分 → 增加设计评审环节
- 接口联调时间过长 → 提前输出Mock
- 测试环境不稳定 → 优化环境

### 感谢 🙏
- 小王: 主动帮助其他人
- 小李: 解决了技术难题

### 下轮改进计划
| 改进项 | 行动 | 负责人 | 时间 |
|--------|------|--------|------|
| 增加设计评审 | 每次需求增加设计Review | 小张 | 立即 |
| 提前Mock | 需求完成后2天内 | 小王 | 立即 |
| 环境优化 | 每周固定环境维护 | 运维 | 周三 |

### 闭环跟踪
- [x] Sprint 14 改进项已完成
- [ ] Sprint 15 改进项进行中
```

## Combined From
- collab-retrospective
- iteration_closure
