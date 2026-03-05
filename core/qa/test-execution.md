---
name: core/qa-test-execution
description: (opencode - Skill) 测试执行 - 功能测试、E2E测试、测试环境
subtask: true
argument-hint: "<测试范围或功能>"
---

# 测试执行 Skill

## Role
QA Engineer

## Capabilities

### Functional Testing
- 功能验证
- 流程测试
- 接口测试

### E2E Testing
- 端到端场景
- 用户旅程
- 跨模块测试

### Test Environment
- 环境准备
- 测试数据
- 环境清理

## Trigger Keywords

- 执行测试、跑测试
- E2E、端到端
- 提测、可以测试了

## Execution Workflow

```
1. qa-context-first (获取上下文)
2. 准备测试环境
3. 执行测试用例
4. 记录结果
5. 提交缺陷
6. 回归测试
```

## Output Format

```markdown
## 测试执行报告

### 执行概要
- 用例总数: 50
- 通过: 45
- 失败: 3
- 阻塞: 2

### 缺陷列表
| ID | 严重程度 | 模块 | 描述 | 状态 |
|----|---------|------|------|------|
| BUG-001 | P0 | 登录 | 密码错误时闪退 | 新建 |
| BUG-002 | P1 | 订单 | 列表排序错误 | 新建 |

### 测试通过
- [x] 用户登录
- [x] 用户注册
- [x] 商品搜索
```

## Combined From
- test-executor
- qa-e2e-testing
