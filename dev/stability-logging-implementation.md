---
name: dev-stability-logging-implementation
description: (opencode - Skill) 稳定性日志实现 - 实现系统监控埋点、性能指标采集、告警服务
subtask: true
---

# 稳定性日志实现 Skill

## 角色

你是后端开发工程师，负责实现系统稳定性监控和业务埋点。

## 核心能力

### 1. 监控指标采集

```typescript
// 指标采集服务
class MetricsCollector {
  // 计数器 - 用于请求数、错误数等
  counter(name: string, tags?: Record<string, string>): Counter;
  
  // 计时器 - 用于响应时间等
  timer(name: string, duration: number, tags?: Record<string, string>): void;
  
  // Gauge - 用于当前值如CPU、内存
  gauge(name: string, value: number, tags?: Record<string, string>): void;
  
  // 直方图 - 用于分布统计
  histogram(name: string, value: number, tags?: Record<string, string>): void;
}

// 使用示例
const metrics = new MetricsCollector();

// 记录HTTP请求
metrics.counter('http_requests_total', { 
  method: 'GET', 
  status: '200' 
});
metrics.timer('http_request_duration', duration, { 
  method: 'GET', 
  path: '/api/users' 
});
```

### 2. 链路追踪埋点

```typescript
// 埋点服务
class埋点Service {
  // 页面埋点
  trackPageView(pageName: string, referrer?: string): void {
    this.send({
      eventType: 'pageview',
      pageName,
      referrer,
      eventTime: Date.now()
    });
  }
  
  // 点击埋点
  trackClick(elementId: string, action: string, data?: object): void {
    this.send({
      eventType: 'click',
      elementId,
      action,
      businessData: data,
      eventTime: Date.now()
    });
  }
  
  // 曝光埋点
  trackExposure(elementIds: string[], pageName: string): void {
    elementIds.forEach(id => {
      this.send({
        eventType: 'exposure',
        elementId: id,
        pageName,
        eventTime: Date.now()
      });
    });
  }
  
  // 错误埋点
  trackError(error: Error, context: object): void {
    this.send({
      eventType: 'error',
      errorMessage: error.message,
      stack: error.stack,
      businessData: context,
      eventTime: Date.now()
    });
  }
  
  private send(data: 埋点Data): void {
    // 发送到埋点服务端
    fetch('/api/track', {
      method: 'POST',
      body: JSON.stringify(data)
    });
  }
}
```

### 3. 告警服务

```typescript
// 告警服务
class AlertService {
  // 告警规则
  private rules: AlertRule[] = [];
  
  // 添加告警规则
  addRule(rule: AlertRule): void {
    this.rules.push(rule);
    this.startMonitoring(rule);
  }
  
  // 检查指标并触发告警
  async checkMetrics(metrics: MetricsData): Promise<void> {
    for (const rule of this.rules) {
      if (this.evaluateRule(rule, metrics)) {
        await this.triggerAlert(rule, metrics);
      }
    }
  }
  
  // 触发告警
  private async triggerAlert(rule: AlertRule, metrics: MetricsData): Promise<void> {
    const alert: Alert = {
      level: rule.level,
      title: rule.name,
      message: `${rule.name}: ${metrics.currentValue}`,
      timestamp: Date.now(),
      metrics: metrics,
      rule: rule
    };
    
    // 发送通知
    await this.notify(rule.level, alert);
  }
  
  // 通知渠道
  private async notify(level: AlertLevel, alert: Alert): Promise<void> {
    switch (level) {
      case 'P0':
        await this.sendSMS(alert);  // 电话通知
        await this.sendDingTalk(alert);
        break;
      case 'P1':
        await this.sendDingTalk(alert);
        await this.sendSlack(alert);
        break;
      default:
        await this.sendEmail(alert);
    }
  }
}

// 告警规则定义
interface AlertRule {
  name: string;
  metric: string;
  condition: '>' | '<' | '>=' | '<=' | '==';
  threshold: number;
  duration: number;  // 持续时间(秒)
  level: 'P0' | 'P1' | 'P2' | 'P3';
  channels: ('sms' | 'email' | 'dingtalk' | 'slack')[];
}
```

### 4. 健康检查

```typescript
// 健康检查服务
class HealthCheck {
  async check(): Promise<HealthStatus> {
    const checks = await Promise.all([
      this.checkDatabase(),
      this.checkRedis(),
      this.checkExternalServices()
    ]);
    
    const healthy = checks.every(c => c.healthy);
    
    return {
      status: healthy ? 'healthy' : 'unhealthy',
      timestamp: Date.now(),
      checks: checks
    };
  }
  
  private async checkDatabase(): Promise<CheckResult> {
    try {
      await db.query('SELECT 1');
      return { name: 'database', healthy: true };
    } catch {
      return { name: 'database', healthy: false, error: '连接失败' };
    }
  }
}

// 注册到健康检查端点
router.get('/health', async (ctx) => {
  const status = await healthCheck.check();
  ctx.status = status.status === 'healthy' ? 200 : 503;
  ctx.body = status;
});
```

### 5. 性能指标上报

```typescript
// 前端性能采集
class PerformanceMonitor {
  observe(): void {
    // 页面加载性能
    window.addEventListener('load', () => {
      const perf = window.performance.timing;
      this.report({
        type: 'page_performance',
        data: {
          dns: perf.domainLookupEnd - perf.domainLookupStart,
          tcp: perf.connectEnd - perf.connectStart,
          ttfb: perf.responseStart - perf.requestStart,
          download: perf.responseEnd - perf.responseStart,
          domReady: perf.domContentLoadedEventEnd - perf.navigationStart,
          loadComplete: perf.loadEventEnd - perf.navigationStart
        }
      });
    });
    
    // 资源加载性能
    const observer = new PerformanceObserver((list) => {
      list.getEntries().forEach(entry => {
        this.report({
          type: 'resource',
          data: {
            name: entry.name,
            duration: entry.duration,
            size: entry.transferSize
          }
        });
      });
    });
    observer.observe({ entryTypes: ['resource'] });
  }
}
```

## 输出格式

```typescript
// 稳定性日志完整实现

// 1. metrics.ts - 指标采集服务
// 2. tracing.ts - 链路追踪
// 3.埋点.ts - 业务埋点
// 4. alert.ts - 告警服务
// 5. health.ts - 健康检查
// 6. performance.ts - 前端性能采集
```

## 触发词

监控指标、埋点、告警、APM、性能监控、链路追踪、健康检查、可用率、错误率