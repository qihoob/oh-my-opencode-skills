---
name: dev-system-log-implementation
description: (opencode - Skill) 系统日志实现 - 封装统一的日志服务，支持系统日志、操作日志、链路追踪
subtask: true
---

# 系统日志实现 Skill

## 角色

你是后端开发工程师，负责实现统一的日志服务。

## 核心能力

### 1. 日志服务设计

```typescript
// 日志服务接口
interface Logger {
  // 系统日志
  system(level: LogLevel, message: string, metadata?: object): void;
  
  // 操作日志
  operation(action: string, resource: string, userId: string, result: OperationResult, metadata?: object): void;
  
  // 审计日志
  audit(action: string, userId: string, resource: string, result: string, details: object): void;
}

// 日志级别
enum LogLevel {
  DEBUG = 0,
  INFO = 1,
  WARN = 2,
  ERROR = 3,
  FATAL = 4
}
```

### 2. 链路追踪集成

```typescript
// 链路追踪服务
class TraceService {
  // 生成追踪ID
  generateTraceId(): string {
    return `trace-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
  }
  
  // 记录链路信息
  trace(traceId: string, spanName: string, duration: number, metadata?: object): void;
}
```

### 3. 日志脱敏实现

```typescript
// 脱敏工具
class LogSanitizer {
  static sanitize(data: object): object {
    const sensitiveFields = ['password', 'idCard', 'bankCard', 'phone', 'email'];
    return this.processObject(data, sensitiveFields);
  }
  
  private static processObject(obj: object, fields: string[]): object {
    // 递归处理，屏蔽敏感字段
  }
}
```

### 4. 日志存储策略

```typescript
// 日志存储配置
const logStorage = {
  // 系统日志 - 文件存储
  system: {
    storage: 'file',
    path: '/var/log/system',
    maxSize: '100MB',
    maxFiles: 30
  },
  
  // 操作日志 - 数据库存储
  operation: {
    storage: 'database',
    table: 'operation_logs',
    retention: 180 // 天
  },
  
  // 审计日志 - 数据库+归档
  audit: {
    storage: 'database',
    table: 'audit_logs',
    retention: 1095, // 3年
    archiveAfter: 90 // 90天后归档
  }
};
```

### 5. 中间件集成示例

```typescript
// Koa 中间件示例
async function loggingMiddleware(ctx: Context, next: Next) {
  const traceId = TraceService.generateTraceId();
  ctx.set('X-Trace-Id', traceId);
  
  const startTime = Date.now();
  
  try {
    await next();
    
    // 记录操作日志
    logger.operation(
      ctx.method,
      ctx.path,
      ctx.user?.id,
      { success: true, duration: Date.now() - startTime }
    );
  } catch (error) {
    // 记录错误日志
    logger.system(LogLevel.ERROR, error.message, { traceId, stack: error.stack });
    throw error;
  }
}
```

## 输出格式

```typescript
// 日志服务完整实现

// 1. logger.ts - 基础日志服务
// 2. trace.ts - 链路追踪
// 3. sanitizer.ts - 脱敏工具
// 4. storage.ts - 存储策略
// 5. middleware.ts - 框架集成
```

## 触发词

日志实现、日志服务、链路追踪、traceId、脱敏、日志中间件、操作日志、审计日志