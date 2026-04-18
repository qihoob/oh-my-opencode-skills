---
name: performance-testing
description: 性能测试 - k6/Lighthouse/Core Web Vitals/SLA验证/压力测试
version: "1.0"
---

# 性能测试 Skill

## 角色

你是性能测试专家，负责为企业级项目设计完整的性能测试方案，包括负载测试、基准测试、前端性能监控。

## 产出文档
- **性能测试报告**: `.opencode/docs/performance-test-report-{feature}.md`

## 性能指标

### 1. 核心指标定义

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                          性能指标速查表                                      │
├─────────────────────────────────────────────────────────────────────────────┤
│                                                                             │
│  指标                    缩写      优秀    良好    差      说明            │
│  ────                    ────      ────    ────    ───     ────            │
│  首字节时间              TTFB      <1.3s   <2.5s   >2.5s   服务端响应       │
│  最大内容绘制            LCP       <2.5s   <4.0s   >4.0s   主要内容加载     │
│  首次输入延迟            FID       <100ms  <300ms  >300ms  交互响应         │
│  累积布局偏移            CLS       <0.1    <0.25   >0.25   页面稳定性       │
│  首次内容绘制            FCP       <1.8s   <3.0s   >3.0s   首次渲染         │
│  交互到绘制              INP       <200ms  <500ms  >500ms  整体交互响应      │
│                                                                             │
│  响应时间(API)                                                       │
│  ──────────────                                                           │
│  GET 请求               -         <200ms  <500ms  >500ms                   │
│  POST 请求              -         <300ms  <1s     >1s                     │
│  列表查询               -         <500ms  <1s     >1s                     │
│                                                                             │
│  吞吐量                                                                     │
│  ────                                                                     │
│  TPS                    -         >1000   >500    <500    每秒事务数       │
│  并发用户               -         >500    >200    <200    峰值并发          │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

### 2. SLA 定义

```yaml
# sla-requirements.yaml
sla:
  availability:
    target: 99.9%
    calculation: "(uptime_minutes / total_minutes) * 100"

  response_time:
    p50: < 200ms    # 50% 请求响应时间
    p90: < 500ms    # 90% 请求响应时间
    p95: < 1000ms   # 95% 请求响应时间
    p99: < 2000ms   # 99% 请求响应时间

  throughput:
    baseline: 100 TPS
    peak: 500 TPS
    burst: 1000 TPS (10秒内)

  error_rate:
    max: 0.1%
    critical_max: 1%

  web_vitals:
    LCP: < 2.5s (p95)
    FID: < 100ms (p95)
    CLS: < 0.1 (p95)
```

## k6 负载测试

### 1. k6 配置

```javascript
// k6-config.js
import http from 'k6/http';
import { check, sleep } from 'k6';
import { Rate, Trend } from 'k6/metrics';

// 自定义指标
const errorRate = new Rate('errors');
const apiDuration = new Trend('api_duration');

export const options = {
  stages: [
    { duration: '2m', target: 100 },  // 预热
    { duration: '5m', target: 500 }, // 逐渐增加到 500 用户
    { duration: '10m', target: 500 }, // 保持 500 用户
    { duration: '2m', target: 1000 }, // 压力测试
    { duration: '5m', target: 0 },    // 逐渐降为 0
  ],

  thresholds: {
    http_req_duration: ['p(95)<1000'], // 95% 请求 < 1s
    http_req_failed: ['rate<0.01'],    // 错误率 < 1%
    errors: ['rate<0.1'],              // 自定义错误率 < 10%
  },

  summaryTrendStats: ['avg', 'min', 'med', 'p(90)', 'p(95)', 'max'],
};
```

### 2. API 性能测试

```javascript
// api-load-test.js
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  vus: 100,
  duration: '10m',

  thresholds: {
    http_req_duration: ['p(95)<500', 'p(99)<1000'],
    http_req_failed: ['rate<0.01'],
  },
};

const BASE_URL = __ENV.BASE_URL || 'http://localhost:3000';

export default function () {
  // 1. 用户登录
  const loginRes = http.post(`${BASE_URL}/api/auth/login`,
    JSON.stringify({ email: 'test@example.com', password: 'password' }),
    { headers: { 'Content-Type': 'application/json' } }
  );

  check(loginRes, {
    'login status 200': (r) => r.status === 200,
    'login has token': (r) => !!r.json('token'),
  }) || errorRate.add(1);

  const token = loginRes.json('token');
  const headers = { 'Authorization': `Bearer ${token}` };

  // 2. 获取用户列表
  const listRes = http.get(`${BASE_URL}/api/users?page=1&size=20`, { headers });
  check(listRes, {
    'list status 200': (r) => r.status === 200,
    'list has data': (r) => Array.isArray(r.json('data')),
  });

  // 3. 获取详情
  const userId = listRes.json('data.0.id');
  if (userId) {
    const detailRes = http.get(`${BASE_URL}/api/users/${userId}`, { headers });
    check(detailRes, {
      'detail status 200': (r) => r.status === 200,
    });
  }

  // 4. 创建订单
  const orderRes = http.post(`${BASE_URL}/api/orders`,
    JSON.stringify({
      items: [{ productId: '123', quantity: 2 }],
      address: '测试地址',
    }),
    { headers: { ...headers, 'Content-Type': 'application/json' } }
  );
  check(orderRes, {
    'order created': (r) => r.status === 201,
  });

  sleep(1);
}
```

### 3. 场景测试

```javascript
// scenario-test.js
import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  scenarios: {
    // 场景1: 浏览商品 (高并发)
    browse: {
      executor: 'ramping-vus',
      startVUs: 0,
      stages: [
        { duration: '30s', target: 200 },
        { duration: '1m', target: 200 },
        { duration: '30s', target: 0 },
      ],
      exec: 'browseProducts',
    },

    // 场景2: 用户登录 (中等并发)
    login: {
      executor: 'constant-vus',
      vus: 50,
      duration: '2m',
      exec: 'userLogin',
    },

    // 场景3: 创建订单 (低并发)
    createOrder: {
      executor: 'per-vu-iterations',
      vus: 20,
      iterations: 100,
      maxDuration: '5m',
      exec: 'createOrder',
    },
  },
};

export function browseProducts() {
  const res = http.get(`${__ENV.BASE_URL}/api/products`);
  check(res, { 'products loaded': (r) => r.status === 200 });
  sleep(2);
}

export function userLogin() {
  const res = http.post(`${__ENV.BASE_URL}/api/auth/login`,
    JSON.stringify({ email: 'test@example.com', password: 'password' }),
    { headers: { 'Content-Type': 'application/json' } }
  );
  check(res, { 'login success': (r) => r.status === 200 });
  sleep(3);
}

export function createOrder() {
  const res = http.post(`${__ENV.BASE_URL}/api/orders`,
    JSON.stringify({ items: [{ productId: '123', quantity: 1 }] })
  );
  check(res, { 'order created': (r) => r.status === 201 });
  sleep(1);
}
```

## Lighthouse 性能测试

### 1. 配置

```yaml
# lighthouse.config.js
module.exports = {
  extends: 'lighthouse:default',

  settings: {
    onlyCategories: ['performance', 'accessibility', 'best-practices', 'seo'],

    emulatedFormFactor: 'desktop',
    throttlingMethod: 'simulate',

    throttling: {
      rttMs: 40,
      throughputKbps: 10240,
      cpuSlowdownMultiplier: 1,
    },

    formFactor: 'desktop',
    screenEmulation: {
      mobile: false,
      width: 1920,
      height: 1080,
      deviceScaleFactor: 1,
      disabled: false,
    },
  },

  passes: [{
    passName: 'defaultPass',
    recordTrace: true,
    useThrottling: true,
    networkQuietThresholdMs: 5000,
  }],
};
```

### 2. 性能测试脚本

```javascript
// lighthouse-test.js
const { chromium } = require('playwright');
const lighthouse = require('lighthouse');

async function runLighthouse(url, options = {}) {
  const browser = await chromium.launch({ headless: true });
  const page = await browser.newPage();

  const config = {
    extends: 'lighthouse:default',
    settings: {
      onlyCategories: ['performance'],
      emulatedFormFactor: 'desktop',
      throttlingMethod: 'simulate',
    },
    ...options,
  };

  const result = await lighthouse(url, {
    port: new URL(browser.wsEndpoint()).port,
    output: 'json',
    logLevel: 'info',
    ...config,
  });

  const report = result.lhr;

  await browser.close();

  return {
    // 性能得分
    performance: report.categories.performance.score * 100,

    // Core Web Vitals
    webVitals: {
      LCP: report.audits['largest-contentful-paint'].numericValue,
      FID: report.audits['max-potential-fid'].numericValue,
      CLS: report.audits['cumulative-layout-shift'].numericValue,
      FCP: report.audits['first-contentful-paint'].numericValue,
      TTI: report.audits['interactive'].numericValue,
      TBT: report.audits['total-blocking-time'].numericValue,
    },

    // 详细指标
    metrics: {
      firstContentfulPaint: report.audits['first-contentful-paint'].displayValue,
      speedIndex: report.audits['speed-index'].displayValue,
      largestContentfulPaint: report.audits['largest-contentful-paint'].displayValue,
      timeToInteractive: report.audits['interactive'].displayValue,
      totalBlockingTime: report.audits['total-blocking-time'].displayValue,
      cumulativeLayoutShift: report.audits['cumulative-layout-shift'].displayValue,
    },

    // 建议
    recommendations: report.audits['network-requests'].details.items.slice(0, 10),
  };
}

// 使用
(async () => {
  const pages = [
    { url: 'http://localhost:3000', name: '首页' },
    { url: 'http://localhost:3000/dashboard', name: '仪表盘' },
    { url: 'http://localhost:3000/users', name: '用户列表' },
  ];

  for (const page of pages) {
    console.log(`\n测试: ${page.name}`);
    const result = await runLighthouse(page.url);

    console.log(`性能得分: ${result.performance.toFixed(1)}/100`);
    console.log('Core Web Vitals:');
    console.log(`  LCP: ${(result.webVitals.LCP / 1000).toFixed(2)}s`);
    console.log(`  FID: ${result.webVitals.FID.toFixed(0)}ms`);
    console.log(`  CLS: ${result.webVitals.CLS.toFixed(3)}`);
  }
})();
```

### 3. CI 集成

```yaml
# .github/workflows/performance.yml
name: Performance Tests

on:
  push:
    branches: [main]
  pull_request:
    branches: [main]

jobs:
  lighthouse:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Install dependencies
        run: npm ci

      - name: Start dev server
        run: npm run dev &

      - name: Run Lighthouse CI
        uses: treosh/lighthouse-ci-action@v9
        with:
          urls: |
            http://localhost:3000
            http://localhost:3000/dashboard
            http://localhost:3000/users
          budgetPath: ./lighthouse-budget.json
          uploadArtifacts: true
          temporaryPublicStorage: true
```

### 4. 性能预算

```json
// lighthouse-budget.json
{
  "budgets": [
    {
      "resourceSizes": [
        { "resourceType": "total", "budget": 500 },
        { "resourceType": "script", "budget": 200 },
        { "resourceType": "image", "budget": 100 },
        { "resourceType": "font", "budget": 50 },
        { "resourceType": "css", "budget": 50 }
      ],
      "resourceCounts": [
        { "resourceType": "third-party", "budget": 30 },
        { "resourceType": "request", "budget": 100 }
      ]
    },
    {
      "thresholds": {
        "performance": 80,
        "accessibility": 90,
        "best-practices": 90,
        "seo": 90
      }
    }
  ]
}
```

## 输出格式

```markdown
## 性能测试配置

### 📊 核心指标

| 指标 | 说明 | 优秀 | 合格 |
|------|------|------|------|
| LCP | 最大内容绘制 | <2.5s | <4s |
| FID | 首次输入延迟 | <100ms | <300ms |
| CLS | 累积布局偏移 | <0.1 | <0.25 |
| TTFB | 首字节时间 | <1.3s | <2.5s |

### 🧪 测试场景

1. **基准测试** - 单用户正常操作
2. **负载测试** - 逐步增加并发
3. **压力测试** - 超过系统容量
4. **峰值测试** - 突发流量
5. **持久测试** - 长时间运行

### 📈 k6 命令

```bash
# 运行测试
k6 run api-load-test.js

# 云端运行
k6 cloud api-load-test.js

# 本地监控
k6 run --out influxdb=http://localhost:8086/k6 api-load-test.js
```

### 🔍 Lighthouse 命令

```bash
# CLI 运行
lighthouse http://localhost:3000 --output=json --output-path=report.json

# CI 模式
lci run
```

### ✅ 通过标准

- [ ] 性能得分 ≥ 80
- [ ] LCP p95 < 2.5s
- [ ] FID p95 < 100ms
- [ ] CLS p95 < 0.1
- [ ] API 响应 p95 < 1s
- [ ] 错误率 < 0.1%
```

## 依赖文档

- **必须读取**: `.opencode/docs/requirement-{feature}.md`
- **必须读取**: `.opencode/docs/implementation-{feature}.md`

## 配合 Skills

| 配合技能 | 关系 | 说明 |
|----------|------|------|
| `qa/execution/test-executor` | 后续 | 性能测试通过后进入功能测试执行 |
| `dev/context/dev-context-first` | 条件 | 性能不达标时，获取上下文分析瓶颈 |
| `dev/implementation/dev-implementation` | 条件 | 性能不达标时，进行优化实现 |
| `dev/standards/dev-frontend-standards` | 互补 | 前端性能优化规范指导 Lighthouse 优化 |
| `devops/monitoring/observability` | 后续 | 性能基线纳入持续监控 |
| `qa/context/qa-context-first` | 前置 | 获取测试上下文和验收标准 |

## 下一步推荐

| 条件 | 推荐技能 |
|------|----------|
| 性能达标 | `collaboration/review/collab-acceptance-review` |
| 性能不达标 | `dev/implementation/dev-implementation`（性能优化） |
| 需要持续监控 | `devops/monitoring/observability` |

## 触发词
性能测试、负载测试、压力测试、k6、Lighthouse、Web Vitals、SLA、响应时间、吞吐量、并发用户
