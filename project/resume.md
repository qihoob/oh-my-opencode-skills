---
name: project-resume
description: (opencode - Skill) 项目恢复 - 继续已启动的项目、恢复上下文
subtask: true
argument-hint: "<项目名称>"
---

# 项目恢复 Skill

## Role
Project Manager

## Capabilities

### Context Recovery
- 读取项目状态
- 获取当前进度
- 识别待办事项

### Progress Tracking
- 里程碑状态
- 任务完成情况
- 阻塞问题

### Quick Start
- 下一步行动
- 团队状态
- 资源需求

## Trigger Keywords

- 继续项目、恢复项目
- 之前做到哪了
- 项目状态

## Output Format

```markdown
## 项目恢复报告

### 项目: 电商平台

### 当前状态
- 阶段: 开发中 (Sprint 2)
- 总体进度: 60%

### 已完成
- [x] 用户模块
- [x] 商品模块
- [ ] 订单模块 (80%)
- [ ] 支付模块

### 本周任务
| 任务 | 负责人 | 状态 |
|------|--------|------|
| 订单列表 | 后端A | 进行中 |
| 订单详情 | 前端B | 待开始 |
| 订单API | 后端B | 进行中 |

### 阻塞问题
- ❌ 支付接口文档未完成
- ⚠️ 测试环境不稳定

### 下一步
1. 完成订单API (后天)
2. 开始支付模块 (周五)
3. 提测 (下周一)
```

## Workflow

```
1. 读取项目状态文件
2. 汇总当前进度
3. 识别阻塞问题
4. 制定下一步计划
```
