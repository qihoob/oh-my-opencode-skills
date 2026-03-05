---
name: devops-build-config
description: (opencode - Skill) 构建配置 - Vite/Webpack/多环境/代码分割/按需加载/性能优化
subtask: true
argument-hint: "<构建配置> 或 <打包优化>"
---

# 构建配置 Skill

## 角色

你是前端构建专家，负责为企业级项目配置高效的构建系统，支持多环境、代码分割、性能优化。

## Vite 配置

### 1. 基础配置

```typescript
// vite.config.ts
import { defineConfig, loadEnv } from 'vite';
import react from '@vitejs/plugin-react';
import { resolve } from 'path';

export default defineConfig(({ mode }) => {
  const env = loadEnv(mode, process.cwd(), '');
  
  return {
    // 基础路径
    base: env.VITE_BASE_PATH || '/',
    
    // 插件
    plugins: [
      react(),
      // 按需导入
      import('vite-plugin-impor'),
    ],
    
    // 解析配置
    resolve: {
      alias: {
        '@': resolve(__dirname, 'src'),
        '@components': resolve(__dirname, 'src/components'),
        '@hooks': resolve(__dirname, 'src/hooks'),
        '@services': resolve(__dirname, 'src/services'),
        '@utils': resolve(__dirname, 'src/utils'),
      },
      extensions: ['.mjs', '.js', '.mts', '.ts', '.jsx', '.tsx', '.json'],
    },
    
    // CSS 配置
    css: {
      modules: {
        localsConvention: 'camelCase',
        generateScopedName: '[name]__[local]__[hash:base64:5]',
      },
      preprocessorOptions: {
        less: {
          javascriptEnabled: true,
          modifyVars: {
            'primary-color': '#1890ff',
          },
        },
      },
    },
    
    // 构建优化
    build: {
      // 目标浏览器
      target: 'es2015',
      
      // 输出目录
      outDir: 'dist',
      
      // 生成 sourcemap
      sourcemap: env.VITE_SOURCEMAP === 'true',
      
      // 代码分割策略
      rollupOptions: {
        output: {
          // 手动分割入口
          manualChunks: {
            // React 核心
            'react-vendor': [
              'react',
              'react-dom',
              'react-router-dom',
            ],
            // UI 组件库
            'antd-vendor': [
              'antd',
              '@ant-design/icons',
            ],
            // 工具库
            'utils-vendor': [
              'lodash',
              'dayjs',
              'axios',
            ],
          },
          
          // 资源文件命名
          assetFileNames: (assetInfo) => {
            if (/\.css$/.test(assetInfo.name || '')) {
              return 'css/[name]-[hash][extname]';
            }
            return 'assets/[name]-[hash][extname]';
          },
          
          // chunk 命名
          chunkFileNames: 'js/[name]-[hash].js',
          entryFileNames: 'js/[name]-[hash].js',
        },
      },
      
      // 最小化配置
      minify: 'terser',
      terserOptions: {
        compress: {
          drop_console: mode === 'production',
          drop_debugger: mode === 'production',
        },
      },
      
      // 压缩
      compressGzip: true,
      compressBrotli: true,
      
      // chunk 大小警告
      chunkSizeWarningLimit: 500,
      
      // 禁用 gzip 压缩大小警告
      reportCompressedSize: false,
    },
    
    // 开发服务器
    server: {
      port: 3000,
      open: true,
      proxy: {
        '/api': {
          target: env.VITE_API_URL || 'http://localhost:8080',
          changeOrigin: true,
          rewrite: (path) => path.replace(/^\/api/, ''),
        },
      },
    },
    
    // 预览服务器
    preview: {
      port: 4173,
      proxy: {
        '/api': 'http://localhost:8080',
      },
    },
    
    // 依赖优化
    optimizeDeps: {
      include: ['react', 'react-dom', 'react-router-dom', 'antd'],
      exclude: ['react-dom/server'],
    },
    
    // 环境变量
    envPrefix: ['VITE_', 'REACT_APP_'],
  };
});
```

### 2. 多环境配置

```typescript
// .env.development
VITE_APP_TITLE=开发环境
VITE_API_URL=http://localhost:8080
VITE_MOCK=true
VITE_SOURCEMAP=true

// .env.staging
VITE_APP_TITLE=预发布环境
VITE_API_URL=https://staging-api.example.com
VITE_MOCK=false
VITE_SOURCEMAP=false

// .env.production
VITE_APP_TITLE=生产环境
VITE_API_URL=https://api.example.com
VITE_MOCK=false
VITE_SOURCEMAP=false
```

```typescript
// env.d.ts
/// <reference types="vite/client" />

interface ImportMetaEnv {
  readonly VITE_APP_TITLE: string;
  readonly VITE_API_URL: string;
  readonly VITE_MOCK: string;
  readonly VITE_SOURCEMAP: string;
}

interface ImportMeta {
  readonly env: ImportMetaEnv;
}
```

## Webpack 配置

### 1. 基础配置

```javascript
// webpack.config.js
const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin');
const MiniCssExtractPlugin = require('mini-css-extract-plugin');
const TerserPlugin = require('terser-webpack-plugin');
const CssMinimizerPlugin = require('css-minimizer-webpack-plugin');
const { InjectManifest } = require('workbox-webpack-plugin');

module.exports = (env, argv) => {
  const isProduction = argv.mode === 'production';
  const isStaging = process.env.STAGE === 'true';
  
  return {
    // 入口
    entry: {
      main: './src/index.tsx',
      admin: './src/admin.tsx',
    },
    
    // 输出
    output: {
      path: path.resolve(__dirname, 'dist'),
      filename: isProduction ? 'js/[name].[contenthash:8].js' : 'js/[name].js',
      chunkFilename: isProduction ? 'js/[name].[contenthash:8].chunk.js' : 'js/[name].chunk.js',
      assetModuleFilename: 'assets/[name].[hash:8][ext]',
      publicPath: '/',
      clean: true,
    },
    
    // 解析
    resolve: {
      extensions: ['.ts', '.tsx', '.js', '.jsx', '.json'],
      alias: {
        '@': path.resolve(__dirname, 'src'),
        '@components': path.resolve(__dirname, 'src/components'),
      },
    },
    
    // 模块规则
    module: {
      rules: [
        // TypeScript
        {
          test: /\.tsx?$/,
          use: 'ts-loader',
          exclude: /node_modules/,
        },
        
        // CSS
        {
          test: /\.css$/,
          use: [
            isProduction ? MiniCssExtractPlugin.loader : 'style-loader',
            'css-loader',
            'postcss-loader',
          ],
        },
        
        // 图片
        {
          test: /\.(png|jpe?g|gif|svg|webp)$/i,
          type: 'asset',
          parser: {
            dataUrlCondition: {
              maxSize: 8 * 1024,
            },
          },
          generator: {
            filename: 'images/[name].[hash:8][ext]',
          },
        },
        
        // 字体
        {
          test: /\.(woff|woff2|eot|ttf|otf)$/i,
          type: 'asset/resource',
          generator: {
            filename: 'fonts/[name].[hash:8][ext]',
          },
        },
      ],
    },
    
    // 插件
    plugins: [
      new HtmlWebpackPlugin({
        template: './public/index.html',
        filename: 'index.html',
        chunks: ['main'],
        minify: isProduction ? {
          removeComments: true,
          collapseWhitespace: true,
          removeAttributeQuotes: true,
        } : false,
      }),
      
      ...(isProduction ? [
        new MiniCssExtractPlugin({
          filename: 'css/[name].[contenthash:8].css',
          chunkFilename: 'css/[name].[contenthash:8].chunk.css',
        }),
        
        // PWA
        new InjectManifest({
          swSrc: './src/service-worker.ts',
          swDest: 'sw.js',
        }),
      ] : []),
    ],
    
    // 优化
    optimization: {
      minimize: isProduction,
      minimizer: [
        new TerserPlugin({
          terserOptions: {
            compress: {
              drop_console: isProduction,
              drop_debugger: isProduction,
            },
          },
        }),
        new CssMinimizerPlugin(),
      ],
      
      // 代码分割
      splitChunks: {
        chunks: 'all',
        maxInitialRequests: 25,
        maxAsyncRequests: 25,
        minSize: 20000,
        
        cacheGroups: {
          react: {
            test: /[\\/]node_modules[\\/](react|react-dom|react-router|react-router-dom)[\\/]/,
            name: 'vendor-react',
            chunks: 'all',
            priority: 40,
          },
          antd: {
            test: /[\\/]node_modules[\\/](antd|@ant-design)[\\/]/,
            name: 'vendor-antd',
            chunks: 'all',
            priority: 30,
          },
          commons: {
            test: /[\\/]node_modules[\\/]/,
            name: 'vendor-commons',
            chunks: 'all',
            priority: 20,
          },
          default: {
            minChunks: 2,
            priority: -20,
            reuseExistingChunk: true,
          },
        },
      },
      
      // runtime 分离
      runtimeChunk: 'single',
    },
    
    // 开发工具
    devtool: isProduction ? 'source-map' : 'eval-source-map',
    
    // 开发服务器
    devServer: {
      port: 3000,
      hot: true,
      historyApiFallback: true,
      proxy: [
        {
          context: ['/api'],
          target: 'http://localhost:8080',
          changeOrigin: true,
        },
      ],
    },
    
    // 性能
    performance: {
      hints: isProduction ? 'warning' : false,
      maxEntrypointSize: 512000,
      maxAssetSize: 512000,
    },
  };
};
```

## 代码分割策略

### 1. 路由级分割

```typescript
// router.tsx
import { lazy, Suspense } from 'react';
import { Spin } from 'antd';

// 使用 lazy 实现路由级代码分割
export const routes = [
  {
    path: '/',
    element: <HomePage />,
  },
  {
    path: '/dashboard',
    // 动态导入
    element: lazy(() => import('./pages/DashboardPage')),
  },
  {
    path: '/users',
    element: lazy(() => import('./pages/UserPage')),
  },
  {
    path: '/orders',
    element: lazy(() => import('./pages/OrderPage')),
  },
  {
    path: '/settings',
    element: lazy(() => import('./pages/SettingsPage')),
  },
];
```

### 2. 组件级分割

```typescript
// 条件加载大型组件
const HeavyChart = lazy(() => import('./components/HeavyChart'));
const MarkdownEditor = lazy(() => import('./components/MarkdownEditor'));
const DataVisualization = lazy(() => import('./components/DataVisualization'));

// 使用 Suspense 包装
const LazyComponent = () => (
  <Suspense fallback={<ChartSkeleton />}>
    <HeavyChart data={data} />
  </Suspense>
);

// 预加载
const prefetch = () => import('./components/HeavyChart');
```

### 3. 动态 import

```typescript
// 动态加载模块
const loadLibrary = async () => {
  const { formatDate } = await import('./utils/date');
  return formatDate(new Date());
};

// 按需加载
const handleClick = async () => {
  const { showModal } = await import('./components/Modal');
  showModal();
};
```

## 性能优化

### 1. 包体积分析

```javascript
// bundle-analysis.js
const { BundleAnalyzerPlugin } = require('webpack-bundle-analyzer');

module.exports = {
  plugins: [
    new BundleAnalyzerPlugin({
      analyzerMode: 'static',
      reportFilename: 'bundle-report.html',
      openAnalyzer: true,
      generateStatsFile: true,
      statsFilename: 'bundle-stats.json',
    }),
  ],
};
```

```bash
# 分析命令
npm run build -- --env analyze
```

### 2. 依赖优化

```json
// package.json 优化建议
{
  "scripts": {
    "dep:analyze": "npx depcheck",
    "dep:unneeded": "npx depcheck --unused",
    "size:limit": "npx bundlesize",
    "bundle:analyze": "npm run build && npx webpack-bundle-analyzer dist/stats.json"
  },
  "bundlesize": [
    {
      "path": "dist/js/main.*.js",
      "maxSize": "200 kB"
    }
  ]
}
```

### 3. Tree Shaking

```javascript
// 确保使用 ES 模块
// webpack.config.js
module.exports = {
  optimization: {
    usedExports: true,
    sideEffects: true,
  },
};

// package.json 标记副作用
{
  "sideEffects": [
    "**/*.css",
    "**/*.scss",
    "./src/polyfill.js"
  ]
}
```

## 输出格式

```markdown
## 构建配置

### 📦 构建工具
- Vite (推荐) - 开发体验好，构建快
- Webpack - 生态丰富，灵活

### 🎯 代码分割策略

| 类型 | 实现 | 收益 |
|------|------|------|
| 路由分割 | lazy(() => import()) | 首屏加载 |
| 组件分割 | 条件加载大型组件 | 内存占用 |
| vendor | splitChunks | 缓存复用 |

### 📊 性能目标

| 指标 | 目标 |
|------|------|
| 首屏 JS | < 200KB |
| 总 JS | < 500KB |
| 首屏 CSS | < 50KB |
| HTTP 请求 | < 20 |

### 🔧 常用命令

```bash
# 开发
npm run dev

# 构建
npm run build

# 分析
npm run build -- --env analyze

# 预览
npm run preview

# 生产分析
npm run build && npx webpack-bundle-analyzer dist/stats.json
```

### ✅ 构建检查清单

- [ ] 代码分割正确配置
- [ ] 公共依赖提取
- [ ] Tree Shaking 生效
- [ ] 资源压缩 (gzip/brotli)
- [ ] Source Map 配置正确
- [ ] 缓存策略配置
- [ ] 环境变量正确注入
```

## 触发词

构建配置、Vite、Webpack、代码分割、按需加载、性能优化、多环境、打包优化、tree shaking、bundle分析