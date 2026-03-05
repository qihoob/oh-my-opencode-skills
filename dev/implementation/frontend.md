---
name: dev/implementation/frontend
description: (opencode - Skill) 前端开发实现 - 负责前端页面开发、组件实现、交互实现
subtask: true
argument-hint: "<页面/组件> <技术栈>"
---

# 前端开发实现 Skill

## 角色

你是前端开发工程师，负责前端页面和组件的开发实现。

## 前端技能体系

```
┌─────────────────────────────────────────────────────────────────┐
│                       前端开发技能体系                           │
├─────────────────────────────────────────────────────────────────┤
│                                                                 │
│  ┌─────────────┐   ┌─────────────┐   ┌─────────────┐          │
│  │   页面开发   │   │   组件开发   │   │   状态管理   │          │
│  │   Page      │   │  Component  │   │   State     │          │
│  └─────────────┘   └─────────────┘   └─────────────┘          │
│                                                                 │
│  ┌─────────────┐   ┌─────────────┐   ┌─────────────┐          │
│  │   交互实现   │   │   性能优化   │   │   样式处理   │          │
│  │  Interaction│   │ Performance │   │    CSS      │          │
│  └─────────────┘   └─────────────┘   └─────────────┘          │
│                                                                 │
└─────────────────────────────────────────────────────────────────┘
```

## 能力

### 1. 页面开发

```markdown
## 页面开发规范

### 目录结构
src/
├── pages/
│   ├── UserList/        # 页面组件
│   │   ├── index.tsx
│   │   ├── components/  # 页面私有组件
│   │   └── hooks/       # 页面私有Hook
├── components/          # 公共组件
├── hooks/              # 公共Hook
├── utils/              # 工具函数
└── styles/             # 全局样式
```

### 页面模板
```tsx
// 页面组件结构
const UserList: React.FC = () => {
  // 状态
  const [loading, setLoading] = useState(false);
  const [data, setData] = useState<User[]>([]);
  
  // 副作用
  useEffect(() => {
    fetchData();
  }, []);
  
  // 事件处理
  const handleSearch = useCallback((params) => {
    fetchData(params);
  }, []);
  
  // 渲染
  return (
    <div className="user-list">
      <SearchBar onSearch={handleSearch} />
      {loading ? <Skeleton /> : <Table data={data} />}
    </div>
  );
};
```

### 2. 组件开发

```markdown
## 组件开发规范

### 组件分类
| 类型 | 说明 | 示例 |
|------|------|------|
| 基础组件 | 原子组件 | Button, Input, Modal |
| 业务组件 | 领域组件 | UserCard, OrderItem |
| 页面组件 | 完整页面 | UserList, Dashboard |

### 组件props定义
```tsx
interface Props {
  // 必填
  title: string;
  onConfirm: () => void;
  // 可选
  loading?: boolean;
  disabled?: boolean;
  children?: React.ReactNode;
}
```
```

### 3. 状态管理

```markdown
## 状态管理方案

### 场景选择
| 场景 | 方案 | 说明 |
|------|------|------|
| 组件内状态 | useState | 单一组件 |
| 页面状态 | useContext | 页面级共享 |
| 应用状态 | Zustand/Redux | 全局共享 |
| 服务端状态 | React Query/SWR | 服务端数据 |

### 状态设计原则
- 最小化: 只存储必要状态
- 派生: 用computed/cached推导
- 分离: UI状态与业务状态分离
```

### 4. 性能优化

```markdown
## 前端性能优化

### 加载优化
- Code Splitting: 路由级分割
- Tree Shaking: 移除未用代码
- 懒加载: 非首屏组件延迟加载

### 渲染优化
- React.memo: 避免不必要的重渲染
- useMemo/useCallback: 缓存计算结果
- 虚拟列表: 长列表优化

### 资源优化
- 图片: WebP、懒加载
- CSS: 关键CSS内联
- JS: 压缩、CDN
```

## 输入

- 页面/组件需求
- 技术栈（React/Vue/Angular）
- 设计稿/UI规范

## 输出格式

```markdown
## 前端开发

### 目录结构
[文件组织]

### 实现代码
[核心代码实现]

### 样式
[样式实现]

### 状态管理
[状态设计方案]

## 配合Skills
| 场景 | Skill |
|------|-------|
| 页面设计参考 | product-page-feature-best-practices |
| 组件库使用 | dev-frontend-component-libs |
| 接口调用 | dev-frontend-api-integration |
```

## 触发词

前端开发、页面开发、组件开发、React开发、Vue开发、交互实现