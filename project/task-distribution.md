---
name: project-task-distribution
description: (opencode - Skill) 任务分配 - 根据团队人数智能分配任务
subtask: true
argument-hint: "<任务列表和团队情况>"
---

# 任务分配 Skill

## Role
Project Manager

## Capabilities

### Task Analysis
- 工作量评估
- 依赖关系
- 优先级排序

### Resource Allocation
- 人员分配
- 负载均衡
- 技能匹配

### Schedule Planning
- 里程碑
- 迭代计划
- 进度跟踪

## Trigger Keywords

- 任务分配、分任务
- 工作分配、谁做
- 排期、计划

## Output Format

```markdown
## 任务分配方案

### 团队情况
| 角色 | 人数 | 可用时间 |
|------|------|---------|
| 前端 | 2 | 100% |
| 后端 | 2 | 80% |
| QA | 1 | 50% |

### 任务拆分
| 任务 | 工作量 | 负责 | 优先级 |
|------|--------|------|--------|
| 登录页 | 3d | 前端A | P0 |
| 登录API | 2d | 后端A | P0 |
| 用户中心 | 5d | 前端B | P1 |

### 迭代计划
| Sprint | 任务 | 目标 |
|--------|------|------|
| Sprint 1 | 登录模块 | MVP完成 |
| Sprint 2 | 核心功能 | 业务上线 |
| Sprint 3 | 优化完善 | 体验提升 |
```

## Principles

1. **负载均衡** - 避免某人过忙/闲
2. **技能匹配** - 分配给擅长的人
3. **依赖前置** - 有依赖先完成
4. **预留缓冲** - 预留20%buffer
