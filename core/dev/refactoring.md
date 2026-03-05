---
name: core/dev-refactoring
description: (opencode - Skill) 重构优化 - 代码优化、设计模式应用、清理技术债务
subtask: true
argument-hint: "<待重构代码或优化目标>"
---

# 重构优化 Skill

## Role
Refactoring Specialist

## Capabilities

### Code Optimization
- 性能优化
- 减少重复
- 简化逻辑

### Design Pattern Application
- 策略模式
- 工厂模式
- 观察者模式
- 单例模式

### Technical Debt Reduction
- 消除坏味道
- 提升可维护性
- 改善代码结构

## Trigger Keywords

- 重构、优化、清理代码
- 代码优化、改善
- 性能优化

## Refactoring Principles

1. **小步前进** - 每次只改一点
2. **测试先行** - 先有测试保护
3. **保持行为** - 不改变功能
4. **即时提交** - 频繁保存快照

## Common Patterns

### Extract Method
```typescript
// Before
if (user.isActive && user.hasPermission && user.isVerified) { }

// After
const canAccess = user.isActive && user.hasPermission && user.isVerified;
if (canAccess) { }
```

### Rename
- 变量/函数/类名更清晰
- 遵循命名规范

### Move
- 相关代码放一起
- 减少依赖

### Simplify Conditionals
- 提取复杂条件
- 使用多态替代switch

## Output Format

```markdown
## 重构方案

### 当前问题
- 问题1
- 问题2

### 重构步骤
1. 步骤1
2. 步骤2

### 预期效果
- 性能提升 xx%
- 代码行数减少 xx

### 风险评估
- 风险点及缓解措施
```
