---
name: collaboration-bug-track
description: (opencode - Skill) Bug追踪 - Bug管理、回归测试、循环驱动
subtask: true
argument-hint: "<Bug描述>"
---

# Bug追踪 Skill

## Role
Bug Coordinator

## Capabilities

### Bug Management
- Bug记录
- 分配跟进
- 状态流转

### Regression Testing
- 回归验证
- 范围评估
- 测试覆盖

### Cycle Management
- 测试→修复→验证循环
- 轮次跟踪
- 关闭条件

## Trigger Keywords

- Bug追踪、Bug管理
- 回归测试、复测
- Bug修复、循环

## Bug Lifecycle

```
新建 → 确认 → 分配 → 修复 → 回归 → 关闭
         ↓
       拒绝
```

## Severity Levels

| 级别 | 定义 | 响应时间 | 示例 |
|------|------|---------|------|
| P0 | 系统崩溃、数据丢失 | 立即 | 支付失败 |
| P1 | 核心功能不可用 | 4h | 登录异常 |
| P2 | 功能有缺陷 | 24h | 显示异常 |
| P3 | 体验问题 | 72h | 样式问题 |

## Output Format

```markdown
## Bug追踪报告

### 当前状态
- 新建: 3
- 修复中: 2
- 回归: 2
- 关闭: 15

### 本轮Bug
| ID | 级别 | 模块 | 描述 | 状态 |
|----|------|------|------|------|
| 001 | P0 | 登录 | 验证码发送失败 | 修复中 |
| 002 | P1 | 订单 | 创建订单超时 | 回归中 |

### 回归情况
- BUG-015: ✅ 通过
- BUG-016: ❌ 失败 (需重新修复)

### 轮次统计
- 第1轮: 发现8个 → 修复7个
- 第2轮: 发现3个 → 修复2个
- 第3轮: 发现1个 → 修复1个 ✅
```

## Combined From
- bug-coordinator
- collab-test-debug-cycle
