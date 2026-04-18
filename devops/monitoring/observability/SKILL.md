---
name: observability
description: 监控与可观测性 - 配置日志、指标、链路追踪，建立系统可观测性体系
---

# Skill: observability

**角色**: DevOps
**功能**: 监控与可观测性配置
**触发关键词**: 监控、告警、日志、链路追踪、Grafana、Prometheus、Jaeger、ELK

## 产出文档
**路径**: `monitoring/` 目录下的配置文件
**说明**: 监控、日志、追踪配置

## 依赖文档
- 系统架构文档
- 服务列表和依赖关系

## 核心能力

1. **指标监控 (Metrics)**
   - Prometheus 配置
   - 业务指标定义
   - 告警规则配置
   - Grafana 仪表盘

2. **日志管理 (Logging)**
   - 日志收集配置
   - 日志格式规范
   - ELK/Loki 配置
   - 日志 retention 策略

3. **链路追踪 (Tracing)**
   - OpenTelemetry 配置
   - Jaeger/Zipkin 配置
   - 采样率配置
   - 服务依赖图谱

## 输出格式

```yaml
# Prometheus 告警规则 (prometheus/alerts.yml)
groups:
- name: application_alerts
  rules:
  - alert: HighErrorRate
    expr: |
      sum(rate(http_requests_total{status=~"5.."}[5m])) 
      / sum(rate(http_requests_total[5m])) > 0.05
    for: 5m
    labels:
      severity: critical
    annotations:
      summary: "高错误率告警"
      description: "错误率 {{ $value | humanizePercentage }} 超过 5%"

  - alert: HighLatency
    expr: |
      histogram_quantile(0.95, 
        sum(rate(http_request_duration_seconds_bucket[5m])) by (le)
      ) > 1
    for: 5m
    labels:
      severity: warning
    annotations:
      summary: "高延迟告警"
      description: "P95 延迟 {{ $value }}s 超过 1s"

  - alert: ServiceDown
    expr: up{job="myapp"} == 0
    for: 1m
    labels:
      severity: critical
    annotations:
      summary: "服务宕机"
      description: "实例 {{ $labels.instance }} 已宕机"
```

```yaml
# Grafana 仪表盘配置 (grafana/dashboard.yml)
apiVersion: 1
dashboards:
- name: Application Overview
  folder: Application
  type: file
  options:
    path: /var/lib/grafana/dashboards/app-overview.json
```

```yaml
# OpenTelemetry 配置 (otel-collector.yml)
receivers:
  otlp:
    protocols:
      grpc:
      http:

processors:
  batch:
  tail_sampling:
    policies:
      - name: sample-errors
        type: status_code
        status_code:
          status_codes: [ERROR]
      - name: probabilistic-sample
        type: probabilistic
        probabilistic:
          sampling_percentage: 10

exporters:
  jaeger:
    endpoint: jaeger:14250
  prometheus:
    endpoint: "0.0.0.0:8889"

service:
  pipelines:
    traces:
      receivers: [otlp]
      processors: [batch, tail_sampling]
      exporters: [jaeger]
    metrics:
      receivers: [otlp]
      processors: [batch]
      exporters: [prometheus]
```

## 黄金指标 (Four Golden Signals)

| 指标 | 说明 | 告警阈值 |
|------|------|----------|
| **延迟 (Latency)** | 请求处理时间 | P95 > 1s |
| **流量 (Traffic)** | QPS/并发数 | 突增/突降 50% |
| **错误 (Errors)** | 错误率 | > 5% |
| **饱和度 (Saturation)** | 资源使用率 | CPU/Mem > 80% |

## 日志格式规范

```json
{
  "timestamp": "2024-01-15T10:30:00Z",
  "level": "ERROR",
  "service": "user-service",
  "trace_id": "abc123",
  "span_id": "def456",
  "message": "Database connection failed",
  "error": "Connection timeout",
  "user_id": "user_789"
}
```

## 工具可用
- write: 写入监控配置
- read: 读取项目配置
