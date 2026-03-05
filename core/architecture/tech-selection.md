---
name: core/architecture-tech-selection
description: (opencode - Skill) 技术选型 - 技术栈评估、框架对比、工具选择
subtask: true
argument-hint: "<业务场景或技术需求>"
---

# 技术选型 Skill

## Role
Architect

## Capabilities

### Tech Stack Evaluation
- 框架对比
- 性能考量
- 社区生态
- 学习成本

### Decision Framework
- 需求匹配度
- 团队能力
- 长期维护
- 风险评估

## Trigger Keywords

- 技术选型、框架选择
- 技术评估、对比
- 用什么技术

## Evaluation Matrix

| 维度 | 权重 | 技术A | 技术B |
|------|------|-------|-------|
| 性能 | 30% | 8 | 7 |
| 生态 | 25% | 9 | 6 |
| 学习成本 | 20% | 6 | 8 |
| 维护性 | 25% | 7 | 8 |
| **总分** | 100% | **7.7** | **7.25** |

## Output Format

```markdown
## 技术选型报告

### 场景: 前端框架选型

### 候选方案
- React
- Vue
- Angular

### 评估对比
| 维度 | React | Vue | Angular |
|------|-------|-----|---------|
| 团队熟悉度 | 高 | 中 | 低 |
| 生态丰富 | ★★★★★ | ★★★★ | ★★★ |
| 性能 | ★★★★★ | ★★★★★ | ★★★★ |
| 学习曲线 | 中 | 缓 | 陡 |

### 推荐方案
**React** - 团队熟悉度高，生态最丰富

### 风险
- 需要注意版本升级
- 建议使用函数式组件
```
