---
name: dev-frontend-standards
description: (opencode - Skill) 前端开发规范 - 响应式布局/状态管理/加载错误状态/性能优化/无障碍访问
subtask: true
argument-hint: "<前端规范> 或 <响应式开发>"
---

# 前端开发规范 Skill

## 角色

你是企业级前端开发专家，负责输出符合企业级体验的前端代码，包括响应式布局、状态管理、性能优化、无障碍访问等。

## 响应式布局

### 1. 核心分辨率适配

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                            核心分辨率适配                                    │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  分辨率          屏幕类型              布局策略                              │
│  ──────          ─────────              ───────                              │
│  1920px+        大屏/工作站          宽布局，内容区 1200-1440px             │
│  1440px-1919px  办公标准屏            标准布局，内容区 1200px               │
│  1366px-1439px  办公小屏              紧凑布局，内容区 1100px               │
│  1024px-1365px  笔记本                自适应，内容区 100%                    │
│  768px-1023px   平板横屏             两列/单列切换                          │
│  480px-767px    平板竖屏/大手机       单列，触控优化                        │
│  <480px         手机                  极简布局，底部导航                    │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 2. Ant Design 栅格系统

```tsx
import { Row, Col } from 'antd';

// 标准栅格配置
<Row gutter={[16, 16]}>
  {/* 大屏 3 列 */}
  <Col xxl={6} xl={8} lg={8} md={12} sm={24} xs={24}>
    <Card>内容</Card>
  </Col>
</Row>

// 响应式断点
// xxl: ≥1600px (27寸+)
// xl:  ≥1200px (大屏笔记本)
// lg:  ≥992px  (笔记本)
// md:  ≥768px  (平板横屏)
// sm:  ≥576px  (平板竖屏)
// xs:  <576px   (手机)
```

### 3. CSS 媒体查询

```scss
// 变量定义
:root {
  --breakpoint-xs: 576px;
  --breakpoint-sm: 768px;
  --breakpoint-md: 992px;
  --breakpoint-lg: 1200px;
  --breakpoint-xl: 1600px;
  
  --container-width: 1200px;
  --sidebar-width: 240px;
  --header-height: 64px;
}

// 响应式断点
@mixin mobile {
  @media (max-width: #{$breakpoint-sm - 1px}) {
    @content;
  }
}

@mixin tablet {
  @media (min-width: $breakpoint-sm) and (max-width: #{$breakpoint-md - 1px}) {
    @content;
  }
}

@mixin desktop {
  @media (min-width: $breakpoint-md) {
    @content;
  }
}

// 使用示例
.container {
  width: 100%;
  max-width: var(--container-width);
  margin: 0 auto;
  padding: 0 16px;
  
  @include mobile {
    padding: 0 12px;
  }
}
```

### 4. 移动端适配最佳实践

```tsx
// 使用 rem 进行移动端适配
// 根字体大小计算: 屏幕宽度 / 10
const setRootFontSize = () => {
  const width = window.innerWidth;
  document.documentElement.style.fontSize = `${width / 10}px`;
};

// viewport meta 标签
// <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, minimum-scale=1, user-scalable=no">

// 移动端点击延迟处理
// 1. 设置 touch-action
button {
  touch-action: manipulation;
}

// 2. 使用 FastClick (如需要兼容旧浏览器)
import FastClick from 'fastclick';
FastClick.attach(document.body);
```

## 状态管理

### 1. 加载/错误/空状态

```tsx
// 统一的加载状态组件
const LoadingState: React.FC<{ tip?: string }> = ({ tip }) => (
  <div className="loading-container">
    <Spin size="large" tip={tip || '加载中...'} />
  </div>
);

// 统一的错误状态组件
const ErrorState: React.FC<{ 
  message?: string; 
  onRetry?: () => void 
}> = ({ message = '加载失败', onRetry }) => (
  <div className="error-container">
    <Result
      status="error"
      title="加载失败"
      subTitle={message}
      extra={<Button onClick={onRetry}>重试</Button>}
    />
  </div>
);

// 统一的空状态组件
const EmptyState: React.FC<{
  description?: string;
  action?: React.ReactNode;
}> = ({ description = '暂无数据', action }) => (
  <div className="empty-container">
    <Empty description={description} />
    {action && <div className="empty-action">{action}</div>}
  </div>
);

// 使用示例
const UserList: React.FC = () => {
  const { data, loading, error } = useUserList();
  
  if (loading) return <LoadingState tip="加载用户列表..." />;
  if (error) return <ErrorState message={error.message} onRetry={refetch} />;
  if (!data?.length) return <EmptyState action={<Button>新建用户</Button>} />;
  
  return <UserListView data={data} />;
};
```

### 2. 骨架屏

```tsx
// 列表骨架屏
const ListSkeleton: React.FC = () => (
  <div className="skeleton-list">
    {[1, 2, 3, 4, 5].map(i => (
      <div key={i} className="skeleton-item">
        <Skeleton.Avatar active size="large" />
        <div className="skeleton-content">
          <Skeleton.Input active style={{ width: '60%' }} />
          <Skeleton.Input active style={{ width: '40%' }} />
        </div>
      </div>
    ))}
  </div>
);

// 卡片骨架屏
const CardSkeleton: React.FC = () => (
  <Card>
    <Skeleton active>
      <Card.Meta
        avatar={<Skeleton.Avatar active />}
        title={<Skeleton.Input active style={{ width: 200 }} />}
        description={<Skeleton.Input active />}
      />
    </Skeleton>
  </Card>
);
```

### 3. Error Boundary

```tsx
class ErrorBoundary extends React.Component<
  { children: React.ReactNode; fallback?: React.ReactNode },
  { hasError: boolean; error?: Error }
> {
  state = { hasError: false, error: undefined };

  static getDerivedStateFromError(error: Error) {
    return { hasError: true, error };
  }

  componentDidCatch(error: Error, info: React.ErrorInfo) {
    console.error('ErrorBoundary caught:', error, info);
    // 上报错误到监控系统
    reportError(error, info);
  }

  render() {
    if (this.state.hasError) {
      return this.props.fallback || (
        <Result
          status="error"
          title="页面出错"
          subTitle="抱歉，页面发生了错误，请刷新重试"
          extra={<Button onClick={() => window.location.reload()}>刷新页面</Button>}
        />
      );
    }
    return this.props.children;
  }
}

// 使用
<ErrorBoundary>
  <UserProfilePage />
</ErrorBoundary>
```

## 性能优化

### 1. 代码分割与懒加载

```tsx
import { lazy, Suspense } from 'react';
import { Spin } from 'antd';

// 路由级代码分割
const DashboardPage = lazy(() => import('./pages/DashboardPage'));
const UserManagePage = lazy(() => import('./pages/UserManagePage'));
const OrderListPage = lazy(() => import('./pages/OrderListPage'));

// 组件级懒加载
const HeavyChart = lazy(() => import('./components/HeavyChart'));

// Suspense 包装
const App: React.FC = () => (
  <Router>
    <Suspense fallback={<LoadingState tip="页面加载中..." />}>
      <Routes>
        <Route path="/dashboard" element={<DashboardPage />} />
        <Route path="/users" element={<UserManagePage />} />
      </Routes>
    </Suspense>
  </Router>
);

// 预加载
const prefetchDashboard = () => {
  import('./pages/DashboardPage');
};

// 鼠标悬停预加载
<Link 
  to="/dashboard" 
  onMouseEnter={prefetchDashboard}
>
  跳转
</Link>
```

### 2. 虚拟列表

```tsx
import { useVirtualList } from 'react-virtualized-list';

// 大列表渲染优化
const VirtualList: React.FC<{ data: Item[] }> = ({ data }) => {
  const { list, containerProps } = useVirtualList({
    items: data,
    itemHeight: 72,
    overscan: 5,
  });

  return (
    <div {...containerProps} style={{ height: '400px', overflow: 'auto' }}>
      {list.map(({ item, index, style }) => (
        <div key={item.id} style={style}>
          <List.Item>{item.name}</List.Item>
        </div>
      ))}
    </div>
  );
};

// 使用 react-window
import { FixedSizeList as List } from 'react-window';

const VirtualRow = ({ index, style, data }: ListRowProps) => (
  <div style={style}>{data[index].name}</div>
);

<FixedSizeList
  height={400}
  itemCount={10000}
  itemSize={50}
  itemData={items}
>
  {VirtualRow}
</FixedSizeList>
```

### 3. 图片优化

```tsx
import { Image } from 'antd';

// 响应式图片
<Image
  src="/image-1920.jpg"
  srcSet="
    /image-480.jpg 480w,
    /image-768.jpg 768w,
    /image-1024.jpg 1024w,
    /image-1920.jpg 1920w
  "
  sizes="(max-width: 768px) 100vw, (max-width: 1200px) 50vw, 33vw"
  alt="描述"
/>

// WebP + 渐进式加载
<img 
  src="image.jpg" 
  srcSet="image.webp"
  loading="lazy" 
  decoding="async"
  alt="描述"
/>

// 占位符
const ImageWithPlaceholder: React.FC<{ src: string; alt: string }> = ({ src, alt }) => {
  const [loaded, setLoaded] = useState(false);
  
  return (
    <div className="image-wrapper">
      {!loaded && <div className="placeholder" />}
      <img
        src={src}
        alt={alt}
        onLoad={() => setLoaded(true)}
        className={loaded ? 'loaded' : 'loading'}
      />
    </div>
  );
};
```

## 无障碍访问

### 1. ARIA 属性

```tsx
// 按钮
<button aria-label="关闭" aria-describedby="modal-desc">
  <IconClose />
</button>

// 模态框
<div 
  role="dialog"
  aria-modal="true"
  aria-labelledby="modal-title"
  aria-describedby="modal-desc"
>
  <h2 id="modal-title">确认删除</h2>
  <p id="modal-desc">确定要删除这个项目吗？</p>
</div>

// 折叠面板
<button 
  aria-expanded={isExpanded}
  aria-controls="section-content"
>
  展开更多
</button>
<div id="section-content" hidden={!isExpanded}>
  {/* 内容 */}
</div>

// 表单
<label htmlFor="email">邮箱</label>
<input 
  id="email" 
  type="email" 
  aria-required="true"
  aria-invalid={!!error}
  aria-describedby="email-error"
/>
{error && <span id="email-error" role="alert">{error}</span>}
```

### 2. 键盘导航

```tsx
// 焦点管理
const FocusContainer: React.FC = () => {
  const containerRef = useRef<HTMLDivElement>(null);

  // 焦点回到容器
  const returnFocus = () => {
    const previousFocus = document.activeElement;
    containerRef.current?.focus();
    return previousFocus;
  };

  // ESC 关闭
  useEffect(() => {
    const handleKeyDown = (e: KeyboardEvent) => {
      if (e.key === 'Escape') {
        onClose();
      }
    };
    document.addEventListener('keydown', handleKeyDown);
    return () => document.removeEventListener('keydown', handleKeyDown);
  }, []);

  return <div ref={containerRef} tabIndex={-1}>{/* 内容 */}</div>;
};

// 快捷键
useHotkeys('ctrl+k', () => openSearch());
useHotkeys('ctrl+/', () => showHelp());
```

### 3. 屏幕阅读器支持

```tsx
// 动态内容更新
import { use-live-region } from 'ariakit';

// 状态变化通知
const LiveRegion: React.FC = () => {
  const [messages, setMessages] = useState<string[]>([]);

  const addMessage = (msg: string) => {
    setMessages(prev => [...prev, msg]);
    // 3秒后移除
    setTimeout(() => {
      setMessages(prev => prev.filter(m => m !== msg));
    }, 3000);
  };

  return (
    <div role="status" aria-live="polite" aria-atomic="true">
      {messages.map((msg, i) => (
        <p key={i}>{msg}</p>
      ))}
    </div>
  );
};
```

## 输出格式

```markdown
## 前端开发规范

### 📱 响应式布局

#### 断点配置
| 断点 | 宽度 | 列数 |
|------|------|------|
| xs | <576px | 1列 |
| sm | ≥576px | 2列 |
| md | ≥768px | 2-3列 |
| lg | ≥992px | 3-4列 |
| xl | ≥1200px | 4-6列 |
| xxl | ≥1600px | 6-8列 |

### ⚡ 性能优化

#### 懒加载配置
```tsx
const Page = lazy(() => import('./Page'));
```

#### 虚拟列表
- 数据量 > 1000 使用虚拟列表
- react-window / react-virtualized

### ♿ 无障碍

- [ ] 所有图片有 alt 属性
- [ ] 表单有 label 关联
- [ ] 焦点可见
- [ ] 键盘可导航
- [ ] ARIA 正确使用

### 🎨 状态管理

- [ ] loading 状态 - 骨架屏/Spinner
- [ ] error 状态 - 错误提示+重试
- [ ] empty 状态 - 空状态提示
- [ ] success 状态 - 成功反馈
```

## 配合 Skills

| 配合技能 | 关系 | 说明 |
|----------|------|------|
| `dev/implementation/frontend` | 前置 | 前端开发实现时参考本规范 |
| `dev/standards/dev-code-quality` | 互补 | 代码质量规范，本技能聚焦前端专项 |
| `visual/design-handoff` | 前置 | 设计稿交接后，按本规范实现前端 |
| `qa/advanced/performance-testing` | 后续 | 性能测试验证本规范的优化建议 |
| `product/module/product-page-feature-best-practices` | 前置 | 页面功能最佳实践指导前端规范选型 |

## 触发词

前端规范、响应式、响应式布局、状态管理、加载状态、错误处理、性能优化、无障碍、a11y、keyboard 导航、虚拟列表、代码分割、懒加载