# oh-my-opencode 集成指南

## 快速开始

### 1. 配置 Skills 源

在项目根目录创建 `.opencode/oh-my-opencode.json`:

```json
{
  "skills": {
    "sources": ["C:\\Users\\Administrator\\skills"]
  }
}
```

### 2. 验证安装

```typescript
// 测试自动调度器
skill(name="system/auto-skill-dispatcher", user_message="帮我分析这个需求")
```

---

## 可用技能 (18 项)

### 产品技能 (3 项)
| Skill | 触发词 | 用途 |
|-------|--------|------|
| `product/requirement/product-requirement-analysis` | 需求分析、用户故事 | 需求分析与用户故事编写 |
| `product/module/module-document-keeper` | 模块文档、文档整理、把控全局 | 模块文档管理 |
| `product/feedback/analysis` | 用户反馈、反馈分析、NPS、A/B 测试 | 用户反馈分析 |

### 开发技能 (3 项)
| Skill | 触发词 | 用途 |
|-------|--------|------|
| `dev/context/dev-context-first` | 给我上下文、先看看代码 | 开发前获取最小上下文 |
| `dev/implementation/dev-implementation` | 实现功能、编写代码、开发 | 功能实现 |
| `dev/code-review` | 代码审查、Code Review、CR、代码检查、代码评审 | 代码审查 |

### 测试技能 (3 项)
| Skill | 触发词 | 用途 |
|-------|--------|------|
| `qa/context/qa-context-first` | 测试上下文、了解被测功能 | 测试前获取最小上下文 |
| `qa/test-case/test-case-design` | 测试用例、设计用例、测试场景 | 测试用例设计 |
| `qa/execution/test-executor` | 执行测试、运行测试、测试报告 | 测试执行 |

### DevOps 技能 (6 项)
| Skill | 触发词 | 用途 |
|-------|--------|------|
| `devops/ci/pipeline` | CI/CD、流水线、GitHub Actions | CI/CD 流水线 |
| `devops/deploy/dockerfile` | Docker、容器化 | Docker 部署 |
| `devops/deploy/k8s` | K8s、Kubernetes | Kubernetes 部署 |
| `devops/deploy/multi-env` | 多环境、环境配置 | 多环境管理 |
| `devops/monitoring/observability` | 监控、告警、日志、链路追踪、Grafana | 监控与可观测性 |
| `devops/data/migration` | 数据库迁移、数据变更、DDL | 数据库迁移 |
| `devops/cost-optimization` | 成本优化、云成本、FinOps | 成本优化 |

### 系统技能 (3 项)
| Skill | 触发词 | 用途 |
|-------|--------|------|
| `system/auto-skill-dispatcher` | 不确定使用哪个技能 | 自动技能调度器 |
| `system/document-integrity-check` | 文档检查、完整性检查、文档审计 | 文档完整性检查 |
| `system/security/compliance` | 安全审计、合规检查、GDPR、数据加密 | 安全合规 |

### 协同技能 (2 项)
| Skill | 触发词 | 用途 |
|-------|--------|------|
| `collaboration/handoff/collab-product-to-dev` | 需求交接、需求评审 | 产品→开发需求交接 |
| `collaboration/sync/document-alignment` | 文档对齐、文档同步 | 文档对齐 |

---

## 使用方式

### 方式一：自动调度（推荐）

```typescript
skill(name="system/auto-skill-dispatcher", user_message="帮我实现用户登录功能")
```

自动调度器会根据关键词自动匹配对应技能。

### 方式二：手动调用

```typescript
task(
  category="product",
  load_skills=["product/requirement/product-requirement-analysis"],
  prompt="分析用户登录需求"
)
```

### 方式三：直接调用 Skill

```typescript
skill(name="dev/code-review", user_message="审查 src/auth/login.ts")
```

---

## 工作流示例

### 完整开发流程

```
1. 需求分析
   skill("system/auto-skill-dispatcher", "分析用户登录需求")
   → 触发：product/requirement/product-requirement-analysis

2. 获取上下文
   skill("system/auto-skill-dispatcher", "先看看现有代码结构")
   → 触发：dev/context/dev-context-first

3. 功能实现
   skill("system/auto-skill-dispatcher", "实现用户登录功能")
   → 触发：dev/implementation/dev-implementation

4. 代码审查
   skill("system/auto-skill-dispatcher", "审查代码质量")
   → 触发：dev/code-review

5. 测试用例
   skill("system/auto-skill-dispatcher", "设计测试用例")
   → 触发：qa/test-case/test-case-design

6. 执行测试
   skill("system/auto-skill-dispatcher", "运行测试")
   → 触发：qa/execution/test-executor

7. 提测
   skill("system/auto-skill-dispatcher", "开发完成，准备提测")
   → 触发：collaboration/handoff/collab-dev-to-qa
```

### DevOps 工作流

```
1. CI/CD 配置
   skill("system/auto-skill-dispatcher", "配置 GitHub Actions 流水线")
   → 触发：devops/ci/pipeline

2. 容器化部署
   skill("system/auto-skill-dispatcher", "创建 Dockerfile")
   → 触发：devops/deploy/dockerfile

3. 监控配置
   skill("system/auto-skill-dispatcher", "配置监控告警")
   → 触发：devops/monitoring/observability

4. 安全扫描
   skill("system/auto-skill-dispatcher", "进行安全审计")
   → 触发：system/security/compliance
```

---

## 高级配置

### 自定义技能组合

```json
{
  "agents": {
    "sisyphus": {
      "skills": [
        "system/auto-skill-dispatcher",
        "dev/code-review",
        "qa/test-case/test-case-design"
      ]
    }
  }
}
```

### 钩子配置

```json
{
  "hooks": {
    "preCommit": ["dev/code-review"],
    "prePush": ["qa/execution/test-executor"],
    "preDeploy": ["devops/monitoring/observability"]
  }
}
```

### 集成配置

```json
{
  "integrations": {
    "github": {
      "enablePRReview": true,
      "enableSecurityScan": true
    },
    "sonarqube": {
      "enabled": true,
      "qualityGate": "default"
    }
  }
}
```

---

## 故障排除

### 技能未加载

1. 检查 `.opencode/oh-my-opencode.json` 配置
2. 确认 `skills.sources` 路径正确
3. 重启 opencode

### 自动调度失败

1. 检查触发词是否匹配
2. 尝试手动调用技能
3. 查看 `system/auto-skill-dispatcher` 的调度规则

### 技能执行错误

1. 检查技能文件完整性
2. 查看技能的前置条件
3. 确认必要的工具/权限已配置

---

## 版本信息

- **Skills 版本**: 1.0.0
- **技能总数**: 18 项
- **最后更新**: 2024-03-10
- **SDLC 覆盖率**: 95%+

---

## 贡献指南

1. Fork 本仓库
2. 创建新技能或增强现有技能
3. 更新 README.md 和调度规则
4. 提交 PR

### 技能文件结构

```markdown
---
name: skill-name
description: 技能描述
subtask: true
argument-hint: "<参数提示>"
---

# 技能名称

## 角色
技能扮演的角色

## 核心能力
1. 能力 1
2. 能力 2

## 输出格式
标准输出模板

## 触发词
关键词 1、关键词 2
```
