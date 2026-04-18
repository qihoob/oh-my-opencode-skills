---
name: product-requirement-structuring
description: 需求整理与结构化 - 将分散的需求信息整理为结构化文档，建立需求层级和关联关系
---

# Skill: product-requirement-structuring

**角色**: 产品 (Product)
**功能**: 需求整理与结构化
**触发关键词**: 需求整理、结构化需求、需求归类、需求层级

## 产出文档
**路径**: `.opencode/docs/requirement-structure-{feature}.md`
**说明**: 需求结构化文档，包含需求层级、优先级、依赖关系

## 依赖文档
- `.opencode/docs/requirement-*.md`（已有需求分析文档）

## 核心能力

1. **需求分层**
   - Epic (史诗级需求)
   - Feature (功能级需求)
   - User Story (用户故事)
   - Task (具体任务)

2. **需求关联**
   - 识别需求间依赖关系
   - 建立需求优先级排序
   - 标记冲突或重复需求

3. **结构化输出**
   - 需求矩阵
   - 优先级排序 (MoSCoW/RICE)
   - 依赖关系图

## 输入要求

用户需提供：
- 多个分散的需求描述
- 或：已有的需求分析文档列表

## 输出格式

```markdown
# 需求结构：{项目名称}

## 需求层级

### Epic: {史诗名称}
- **目标**: {业务目标}
- **范围**: {覆盖范围}

#### Feature: {功能名称}
- **优先级**: Must Have / Should Have / Could Have
- **依赖**: [相关功能]
- **用户故事**:
  - As a... I want to... So that...

##### Tasks
- [ ] Task 1
- [ ] Task 2

## 需求矩阵

| ID | 需求描述 | 优先级 | 状态 | 依赖 |
|----|----------|--------|------|------|
| R001 | ... | Must Have | 待开发 | - |
| R002 | ... | Should Have | 待开发 | R001 |

## 迭代规划建议

- Sprint 1: [R001, R003]
- Sprint 2: [R002, R004]
```

## 最小上下文原则

1. **只读取相关需求文档** - 不加载无关文件
2. **保持文档引用** - 标注每个需求的来源文档
3. **结构化便于检索** - 使用表格和层级结构

## 工具可用
- read: 读取现有需求文档
- write: 写入结构化需求文档
- grep: 搜索需求相关内容

## 下一步推荐

| 条件 | 推荐技能 |
|------|----------|
| 结构化完成，需要评审 | `product/requirement/product-collaborative-requirement-optimization` |
| 结构化完成，准备开发 | `product/requirement/product-requirement-analysis` — 补充用户故事和验收标准 |
