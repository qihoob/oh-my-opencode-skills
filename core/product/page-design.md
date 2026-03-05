---
name: core/product-page-design
description: (opencode - Skill) 页面设计 - 组件设计、交互设计、边界设计
subtask: true
argument-hint: "<页面功能描述>"
---

# 页面设计 Skill

## Role
Product Designer

## Capabilities

### Component Design
- 组件拆分
- 状态定义
- 属性设计

### Interaction Design
- 操作流程
- 反馈机制
- 动画效果

### Edge Case Design
- 空状态
- 加载状态
- 错误状态
- 边界处理

## Trigger Keywords

- 页面设计、组件设计
- 交互设计、空状态
- 边界情况、异常处理

## Design Framework

### Component Hierarchy
```
Page
├── Header
├── Content
│   ├── List
│   │   ├── Item
│   │   └── Item
│   └── Detail
└── Footer
```

### State Design
| 状态 | 说明 |
|------|------|
| default | 默认状态 |
| loading | 加载中 |
| empty | 空数据 |
| error | 错误 |
| success | 成功 |
| disabled | 禁用 |

### Edge Cases
- 网络异常
- 数据为空
- 权限不足
- 超时处理

## Output Format

```markdown
## 页面设计

### 页面: 商品列表页

### 组件拆分
```
components/
├── ProductList/
│   ├── ProductItem.tsx
│   ├── ProductFilter.tsx
│   └── ProductEmpty.tsx
```

### 状态定义
```typescript
interface State {
  loading: boolean;
  list: Product[];
  filter: Filter;
  error: string | null;
}
```

### 交互流程
1. 进入页面 → 显示骨架屏
2. 请求接口 → loading状态
3. 返回数据 → 渲染列表
4. 无数据 → 显示空状态
5. 请求失败 → 显示错误状态

### 边界设计
| 场景 | 处理 |
|------|------|
| 首次加载 | 骨架屏 |
| 加载中 | 骨架屏/loading |
| 空数据 | 空状态插图 |
| 网络错 | 重新加载按钮 |
| 下拉刷新 | 刷新动画 |
```

## Combined From
- product-page-feature-best-practices
- product-edge-case
