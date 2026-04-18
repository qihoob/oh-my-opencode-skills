---
name: change-impact
description: 数据库变更影响分析 - 评估 schema 变更对业务代码、API、测试的影响范围，支持开发修改和 Bug 修复场景
version: "1.0"
---

# Skill: change-impact

**角色**: DBA / 后端开发
**功能**: 数据库变更影响分析
**触发关键词**: 数据库变更、表结构变更影响、DDL影响、字段变更、数据库影响分析

## 产出文档
- **变更影响报告**: `.opencode/docs/db-change-impact-{feature}.md`

## 依赖文档
- **必须读取**: `.opencode/docs/db-schema-{feature}.md` 或当前数据库 schema
- **可选读取**: `.opencode/docs/implementation-{feature}.md`
- **可选读取**: `.opencode/docs/contract-{feature}.md`
- **可选读取**: `.opencode/docs/bug-{module}-{seq}.md`

## 核心能力

### 1. 变更范围识别

```
变更类型分析:

| 变更类型 | 风险等级 | 影响范围 | 典型场景 |
|----------|----------|----------|----------|
| 新增表 | 低 | 新代码 | 新功能开发 |
| 新增字段 | 低-中 | Model + API + 前端 | 功能扩展 |
| 修改字段类型 | 高 | 全链路 | Bug修复/优化 |
| 删除字段 | 高 | 全链路 | 功能下线 |
| 重命名字段 | 高 | 全链路 | 规范化 |
| 新增索引 | 低 | 查询性能 | 性能优化 |
| 删除索引 | 中 | 查询性能 | 索引清理 |
| 修改约束 | 中 | 数据校验 | 数据完整性 |
| 表结构重组 | 高 | 全链路 | 重构/分表 |
```

### 2. 代码影响追踪

```
影响追踪方法:

2.1 ORM Model 影响
  grep 搜索策略:
  - 搜索表名 → 找到 Model 定义文件
  - 搜索字段名 → 找到使用该字段的代码
  - 搜索关联关系 → 找到关联查询代码

  | 影响层 | 搜索目标 | 检查内容 |
  |--------|----------|----------|
  | Model/Entity | 表名、字段名定义 | 类型映射是否需更新 |
  | Repository/DAO | 查询方法 | SQL/查询构建器是否需更新 |
  | Service | 业务逻辑 | 字段引用是否需更新 |
  | Controller | API 接口 | 请求/响应结构是否需更新 |
  | DTO/VO | 数据传输对象 | 字段映射是否需更新 |
  | Migration | 迁移脚本 | 是否有冲突的迁移 |

2.2 前端代码影响
  | 影响层 | 搜索目标 | 检查内容 |
  |--------|----------|----------|
  | API Types | TypeScript 类型定义 | 接口类型是否需更新 |
  | API Service | API 调用代码 | 参数是否需更新 |
  | Components | 组件代码 | 展示字段是否需更新 |
  | Forms | 表单代码 | 表单字段是否需更新 |
```

### 3. API 影响分析

```
API 影响评估:

| 变更场景 | API 影响 | 处理方式 |
|----------|----------|----------|
| 新增字段 | 响应体新增字段 | 前端按需使用，通常兼容 |
| 删除字段 | 响应体移除字段 | 评估前端是否使用 → 先前端适配再删除 |
| 修改字段名 | 响应体字段名变更 | 前端所有引用点需更新 |
| 修改类型 | 响应体字段类型变更 | 前端解析逻辑需更新 |
| 新增约束 | 可能导致请求失败 | 前端表单校验需更新 |

API 版本策略:
- 字段新增：非破坏性变更，不需要版本升级
- 字段删除/重命名：破坏性变更，需要版本升级或兼容期
- 类型变更：评估影响后决定是否需要版本升级
```

### 4. 测试影响评估

```
测试影响分析:

| 变更类型 | 单元测试 | 集成测试 | E2E测试 |
|----------|----------|----------|---------|
| 新增表 | 新增测试 | 新增测试 | 视需求 |
| 新增字段 | 更新断言 | 更新测试数据 | 可能需更新 |
| 修改字段 | 更新 Mock | 更新断言 | 更新测试数据 |
| 删除字段 | 删除相关断言 | 删除相关测试 | 删除相关步骤 |
| 修改约束 | 更新边界测试 | 更新数据准备 | 更新表单测试 |

需要更新的测试文件:
- grep 搜索测试文件中引用的表名、字段名
- 逐个评估是否需要修改
```

### 5. 数据兼容性分析

```
兼容性评估:

| 场景 | 兼容性风险 | 处理方案 |
|------|-----------|----------|
| 新增 NOT NULL 字段 | 已有数据无值 | 设置 DEFAULT 或数据回填 |
| 修改字段类型 | 数据转换可能丢失 | 先新增列 → 回填 → 删除旧列 |
| 删除字段 | 数据丢失 | 确认无引用 → 备份 → 删除 |
| 修改约束 | 已有数据不满足 | 先清理数据 → 再加约束 |
| 重命名字段 | 代码引用断裂 | 先新增 → 代码迁移 → 删除旧列 |

数据回填策略:
1. 小表（< 10万行）：直接 UPDATE
2. 中表（10万-100万行）：分批 UPDATE
3. 大表（> 100万行）：分批 + 低峰期执行
```

### 6. 灰度/回滚策略

```
灰度评估:

| 变更类型 | 可灰度 | 灰度方式 |
|----------|--------|----------|
| 新增表 | ✅ | 功能开关控制 |
| 新增字段 | ✅ | 代码先兼容新旧 |
| 删除字段 | ⚠️ | 需要双写期 |
| 修改类型 | ⚠️ | 需要双列期 |
| 索引变更 | ✅ | 在线添加/删除 |

回滚代价评估:
| 变更类型 | 回滚难度 | 回滚方案 |
|----------|----------|----------|
| 新增表 | 低 | DROP TABLE |
| 新增字段 | 低 | DROP COLUMN |
| 删除字段 | 高 | 需要备份恢复 |
| 修改类型 | 高 | 需要数据回转 |
| 删除表 | 很高 | 需要完整备份 |
```

## 典型场景

### 场景 1: 开发中修改设计

```
dev-implementation 发现需要调整字段
  → 触发 change-impact
    → 分析影响范围
    → 评估代码改动量
    → 产出 db-change-impact-{feature}.md
  → 根据影响大小：
    影响小 → 直接更新 schema-design → 生成新 migration
    影响大 → 先更新 contract → 重新评估 → 再更新 schema
```

### 场景 2: Bug 修复修改 Schema

```
bug-coordinator 分配的 Bug 涉及数据模型问题
  → 触发 change-impact
    → 分析 Bug 修复需要的 schema 变更
    → 评估变更影响
    → 产出 db-change-impact-{feature}.md
  → 根据影响：
    影响可控 → 最小化 schema 变更 → 快速修复
    影响较大 → 评估是否可以用其他方式修复（避免 schema 变更）
```

### 场景 3: 重构涉及数据库

```
dev-refactoring 发现表结构需要优化
  → 触发 change-impact
    → 分析重构涉及的 schema 变更
    → 评估全链路影响
    → 产出 db-change-impact-{feature}.md
  → 根据影响制定重构计划：
    分步执行 → 每步都有回滚方案
```

## 输出格式

```markdown
# 数据库变更影响分析：{功能名称}

**分析日期**: 2026-04-18
**触发场景**: {新功能开发 / Bug修复 / 重构 / 需求变更}

## 变更概览

### 变更内容
| 表名 | 变更类型 | 具体变更 |
|------|----------|----------|
| orders | 新增字段 | ADD COLUMN shipping_address VARCHAR(500) |
| order_items | 修改字段 | MODIFY COLUMN price DECIMAL(12,2) |

### 变更风险评级
**总体风险**: 低 / 中 / 高

## 代码影响

### 后端影响
| 层级 | 文件 | 影响说明 | 需修改 |
|------|------|----------|--------|
| Model | src/modules/order/model.ts | 新增 shippingAddress 字段 | ✅ |
| Repository | src/modules/order/repository.ts | 查询需包含新字段 | ✅ |
| Service | src/modules/order/service.ts | 创建订单逻辑需更新 | ✅ |
| Controller | src/modules/order/controller.ts | API 响应结构变更 | ✅ |
| DTO | src/modules/order/dto.ts | 请求/响应类型更新 | ✅ |

### 前端影响
| 层级 | 文件 | 影响说明 | 需修改 |
|------|------|----------|--------|
| API Types | api/order.d.ts | 响应类型新增字段 | ✅ |
| Components | pages/order/Detail.tsx | 展示收货地址 | ✅ |

## API 影响

| 接口 | 变更 | 兼容性 |
|------|------|--------|
| GET /api/orders/:id | 响应新增 shippingAddress | ✅ 兼容（新增字段） |
| POST /api/orders | 请求新增 shippingAddress | ⚠️ 需前端适配 |

## 测试影响

| 测试类型 | 文件 | 影响 |
|----------|------|------|
| 单元测试 | order.service.test.ts | 更新 Mock 数据 |
| 集成测试 | order.api.test.ts | 更新断言 |
| E2E测试 | order.e2e.ts | 更新测试数据 |

## 数据兼容性

| 检查项 | 状态 | 说明 |
|--------|------|------|
| 已有数据兼容 | ✅ | 新增字段有默认值 |
| 数据回填需要 | 否 | DEFAULT NULL |
| 约束兼容 | ✅ | 无破坏性约束 |

## 灰度/回滚

| 策略 | 说明 |
|------|------|
| 灰度方式 | 功能开关控制新字段使用 |
| 回滚方案 | DROP COLUMN shipping_address |
| 回滚代价 | 低 |

## 行动计划

1. [ ] 更新 schema-design 文档
2. [ ] 更新 contract 文档（如涉及跨层）
3. [ ] 生成 migration 脚本
4. [ ] 更新后端代码（按影响列表）
5. [ ] 更新前端代码（按影响列表）
6. [ ] 更新测试用例
```

## 工具可用
- read: 读取设计文档、实现文档、契约文档、Bug单
- grep: 搜索代码中的表名、字段名引用（追踪影响范围）
- glob: 扫描模型文件、迁移文件、测试文件

## 配合 Skills

| 配合技能 | 关系 | 说明 |
|----------|------|------|
| `devops/data/schema-design` | 前置/后续 | 变更后更新设计 |
| `devops/data/schema-review` | 协同 | 变更设计后重新评审 |
| `devops/data/migration` | 后续 | 影响确认后生成迁移 |
| `dev/implementation/dev-implementation` | 双向 | 开发修改触发分析 / 分析结果指导修复 |
| `dev/debugging` | 前置 | Bug 定位后评估修复影响 |
| `collaboration/process/bug-coordinator` | 前置 | Bug 分配后评估数据层影响 |
| `dev/verify-implementation` | 协同 | 验证代码是否适配 schema 变更 |
| `dev/refactoring` | 前置 | 重构触发变更影响分析 |

## 下一步推荐

| 条件 | 推荐技能 |
|------|----------|
| 影响可控（新功能） | `devops/data/schema-design`（更新）→ `devops/data/migration` |
| 影响较大（跨模块） | `dev/modules/module-collaborative-dev`（重新对齐契约） |
| Bug 修复场景 | `dev/implementation/dev-implementation`（Bug修复模式） |
| 重构场景 | `devops/data/schema-design`（更新）→ `devops/data/schema-review` |

## 触发词
数据库变更、表结构变更影响、DDL影响、字段变更、数据库影响分析、表结构修改影响、加字段影响、删字段影响
