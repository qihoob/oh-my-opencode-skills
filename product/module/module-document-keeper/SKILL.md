---
name: module-document-keeper
description: 模块文档管理 - 整合和管理模块级所有文档，确保产品 - 开发 - 测试文档一致性
---

# Skill: module-document-keeper

**角色**: 产品 (Product) / 项目经理
**功能**: 模块文档整合与管理
**触发关键词**: 模块文档、文档整理、文档管理、把控全局、文档汇总

## 产出文档
**路径**: `.opencode/docs/module-{module}/INDEX.md`
**说明**: 模块文档索引，汇总该模块所有相关文档

## 依赖文档
**扫描目录**: `.opencode/docs/`
- `requirement-{feature}.md` - 需求文档
- `implementation-{feature}.md` - 实现文档
- `test-cases-{feature}.md` - 测试用例

## 核心能力

1. **文档收集**
   - 扫描 `.opencode/docs/` 目录
   - 按模块归类所有文档
   - 识别文档关联关系

2. **完整性检查**
   - 检查每个功能是否有需求文档
   - 检查开发是否有实现文档
   - 检查测试是否有用例文档
   - 标识缺失的文档

3. **一致性验证**
   - 需求 ↔ 实现：功能是否按需求实现
   - 实现 ↔ 测试：测试是否覆盖实现
   - 需求 ↔ 测试：验收标准是否有对应用例

4. **文档索引生成**
   - 创建模块文档地图
   - 标注文档状态（完整/缺失/待更新）
   - 提供文档导航

## 输出格式

```markdown
# 模块文档索引：{模块名称}

## 文档概览
| 功能 | 需求文档 | 实现文档 | 测试用例 | 状态 |
|------|----------|----------|----------|------|
| 功能 A | ✅ | ✅ | ✅ | 完整 |
| 功能 B | ✅ | ✅ | ❌ | 缺测试 |
| 功能 C | ✅ | ❌ | ❌ | 缺实现 |

## 文档列表

### 需求文档
- [requirement-feature-a.md](./requirement-feature-a.md) - 功能 A 需求
- [requirement-feature-b.md](./requirement-feature-b.md) - 功能 B 需求

### 实现文档
- [implementation-feature-a.md](./implementation-feature-a.md) - 功能 A 实现

### 测试用例
- [test-cases-feature-a.md](./test-cases-feature-a.md) - 功能 A 测试

## 缺失文档
- ❌ implementation-feature-b.md - 功能 B 尚未实现
- ❌ test-cases-feature-b.md - 功能 B 缺少测试
- ❌ test-cases-feature-c.md - 功能 C 缺少测试

## 文档一致性检查
- ⚠️ 功能 B：需求中有验收标准 AC3，但测试用例未覆盖
- ⚠️ 功能 C：实现文档缺失，无法验证一致性
```

## 最小上下文原则

1. **增量扫描** - 只扫描 `.opencode/docs/` 目录，不分析代码
2. **按需读取** - 只读取文档标题和验收标准章节
3. **缓存索引** - 已有 INDEX.md 时增量更新

## 使用场景

1. **模块完成时** - 整理该模块所有文档
2. **迭代结束时** - 检查本迭代文档完整性
3. **验收前** - 确保文档齐全可供评审
4. **新成员加入** - 提供模块文档地图

## 工具可用
- glob: 扫描文档目录
- read: 读取文档内容
- write: 写入索引文档
- grep: 搜索文档关键词

## 下一步推荐

| 条件 | 推荐技能 |
|------|----------|
| 文档整理完成 | `system/document-integrity-check` |

