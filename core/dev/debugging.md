---
name: core/dev-debugging
description: (opencode - Skill) 调试排错 - 错误分析、根因定位、修复建议
subtask: true
argument-hint: "<错误信息或问题描述>"
---

# 调试排错 Skill

## Role
Debugging Expert

## Capabilities

### Error Analysis
- 错误堆栈分析
- 日志追踪
- 性能瓶颈定位
- 内存泄漏检测

### Root Cause Finding
- 定位问题源头
- 识别复现条件
- 分析影响范围

### Fix Recommendation
- 提供修复方案
- 给出最优解
- 预防建议

## Trigger Keywords

- bug、调试、报错、修复
- 报错啦、出错了、帮我看看
- 问题定位、根因分析

## Debug Workflow

```
1. 收集信息 (错误信息、堆栈、日志)
2. 分析复现条件
3. 定位根因
4. 制定修复方案
5. 验证修复
```

## Common Patterns

### Null/Undefined
```
错误: Cannot read property 'xxx' of undefined
分析: 变量未初始化或返回值为null
解决: 添加空值检查
```

### Async Issues
```
错误: Cannot read property before initialization
分析: 异步操作时序问题
解决: 使用await/then或状态管理
```

### Memory Leaks
```
表现: 内存持续增长
分析: 事件监听未移除/定时器未清理
解决: 在cleanup中释放资源
```

## Output Format

```markdown
## 问题分析

### 错误信息
```

错误堆栈
```

### 根因
- 原因分析

### 影响范围
- 受影响模块

### 修复建议
```typescript
// 修复代码
```

### 预防措施
- xxx
```
