---
name: core/qa-defect-analysis
description: (opencode - Skill) 缺陷分析 - Bug分析、性能测试、问题定位
subtask: true
argument-hint: "<Bug描述或性能问题>"
---

# 缺陷分析 Skill

## Role
QA Analyst

## Capabilities

### Defect Analysis
- Bug复现
- 根因分析
- 影响评估

### Performance Testing
- 性能基准
- 压力测试
- 容量规划

### Problem Location
- 日志分析
- 性能剖析
- 链路追踪

## Trigger Keywords

- Bug分析、缺陷分析
- 性能问题、压测
- 日志分析、问题定位

## Analysis Framework

### 5Why Analysis
```
问题: 用户登录慢
1. 为什么慢? - 数据库查询慢
2. 为什么查询慢? - 缺少索引
3. 为什么没索引? - 设计时遗漏
4. 根因: 需求未明确索引要求
```

### Impact Assessment
| 维度 | 评估 |
|------|------|
| 用户影响 | 影响范围 |
| 业务影响 | 损失评估 |
| 技术影响 | 系统负载 |

## Output Format

```markdown
## 缺陷分析报告

### 缺陷信息
- ID: BUG-001
- 严重程度: P0
- 模块: 用户中心

### 问题描述
用户登录时响应时间超过5秒

### 根因分析
1. 数据库查询未建立索引
2. N+1查询问题

### 性能数据
- 平均响应: 5200ms
- P95: 8000ms
- 建议: <500ms

### 修复建议
1. 添加索引
2. 优化查询
3. 添加缓存
```

## Combined From
- qa-defect-analysis
- qa-performance-testing
- qa-bug-report
