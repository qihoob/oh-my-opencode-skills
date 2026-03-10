---
name: auto-skill-dispatcher
description: 自动技能调度器 - 根据用户输入自动识别任务类型并选择合适的技能
---

# Skill: auto-skill-dispatcher

**角色**: 系统 (System)
**功能**: 自动技能调度器
**触发关键词**: [所有关键词]

## 核心能力

1. **意图识别**
   - 分析用户输入
   - 识别任务类型
   - 选择合适技能

2. **技能匹配**
   - 关键词匹配
   - 语义理解
   - 上下文推断

3. **自动调度**
   - 加载对应技能
   - 传递任务上下文
   - 执行任务

## 调度规则

### 产品技能
| 用户输入 | → | 触发技能 |
|----------|---|----------|
| 需求分析、用户故事 | → | product/requirement/product-requirement-analysis |
| 模块文档、文档整理、把控全局 | → | product/module/module-document-keeper |
| 用户反馈、反馈分析、NPS、A/B 测试 | → | product/feedback/analysis |

### 开发技能
| 用户输入 | → | 触发技能 |
|----------|---|----------|
| 给我上下文、先看看代码 | → | dev/context/dev-context-first |
| 实现功能、编写代码、开发 | → | dev/implementation/dev-implementation |
| 代码审查、Code Review、CR、代码检查、代码评审、代码质量 | → | dev/code-review |

### 测试技能
| 用户输入 | → | 触发技能 |
|----------|---|----------|
| 测试上下文、了解被测功能 | → | qa/context/qa-context-first |
| 测试用例、设计用例、测试场景 | → | qa/test-case/test-case-design |
| 执行测试、运行测试、测试报告 | → | qa/execution/test-executor |

### DevOps 技能
| 用户输入 | → | 触发技能 |
|----------|---|----------|
| CI/CD、流水线、GitHub Actions | → | devops/ci/pipeline |
| Docker、容器化 | → | devops/deploy/dockerfile |
| K8s、Kubernetes | → | devops/deploy/k8s |
| 多环境、环境配置 | → | devops/deploy/multi-env |
| 监控、告警、日志、链路追踪、Grafana、Prometheus | → | devops/monitoring/observability |
| 数据库迁移、数据变更、DDL、迁移脚本 | → | devops/data/migration |
| 成本优化、云成本、FinOps、预算管理 | → | devops/cost-optimization |

### 系统技能
| 用户输入 | → | 触发技能 |
|----------|---|----------|
| 安全审计、合规检查、GDPR、数据加密 | → | system/security/compliance |
| 文档检查、完整性检查、文档审计 | → | system/document-integrity-check |

### 协同技能
| 用户输入 | → | 触发技能 |
|----------|---|----------|
| 需求交接、需求评审、产品给开发 | → | collaboration/handoff/collab-product-to-dev |
| 文档对齐、文档同步、三方对齐 | → | collaboration/sync/document-alignment |
| 验收、UAT | → | collaboration/review/collab-acceptance-review |
| 复盘、总结、retro | → | collaboration/process/collab-retrospective |
| 提测、测试交接、开发完成 | → | collaboration/handoff/collab-dev-to-qa |

### 项目技能
| 用户输入 | → | 触发技能 |
|----------|---|----------|
| 启动项目、新项目、项目初始化 | → | project/kickoff |

## 工具可用
- 所有工具