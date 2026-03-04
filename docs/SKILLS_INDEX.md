# Skills Index

## Overview

This directory contains the complete skill system for oh-my-opencode, featuring **78 skills** across 10 categories designed for Product, Development, and QA roles with full collaboration support.

---

## Directory Structure

```
skills/
├── docs/                      # Documentation
│   └── SKILLS_USAGE.md       # Usage guide
│   └── SKILLS_INDEX.md       # This file
│
├── collaboration-skills.yaml   # 18 collaboration skills
├── context-skills.yaml        # 4 context management skills
├── dev-skills.yaml           # 14 development skills
├── global-product-skills.yaml # 4 global product skills
├── module-dev-test-skills.yaml # Module dev/test/overall skills
├── module-product-skills.yaml # 5 module product skills
├── module-skills.yaml         # 5 module management skills
├── product-skills.yaml        # 8 product skills
├── qa-skills.yaml            # 11 QA skills
└── skills-registry.yaml      # Central registry with 650+ triggers
```

---

## Skills by Category

### 1. Global Product (4)
| Skill | Description |
|-------|-------------|
| `global-project-analysis` | Project overall analysis and module breakdown |
| `global-module-coordination` | Module coordination and dependency management |
| `global-acceptance` | Overall acceptance and sign-off |
| `global-product-handoff` | Global product handoff to modules |

### 2. Module Product (5)
| Skill | Description |
|-------|-------------|
| `module_product_requirement` | Module-specific requirement output |
| `module_product_handoff` | Module requirements handoff to dev/test |
| `module_product_acceptance` | Module-level acceptance |
| `module_product_sync` | Module product alignment with global |
| `module_product_query` | Query module product information |

### 3. Module Management (5)
| Skill | Description |
|-------|-------------|
| `module-responsibility-analysis` | Analyze module responsibilities |
| `module-context-generator` | Generate responsibility context files |
| `module-responsibility-sync` | Sync responsibilities across modules |
| `module-query` | Query module information |
| `module-progress-track` | Track module progress |

### 4. Context Management (4)
| Skill | Description |
|-------|-------------|
| `context-classification` | Classify requirements/tasks |
| `context-minimum` | Extract minimal core information |
| `context-organization` | Structure and organize context |
| `context-handover` | Cross-role context handoff |

### 5. Product (8)
| Skill | Description |
|-------|-------------|
| `product-requirement-analysis` | Requirement analysis with 可用/易用/好用 |
| `product-function-design` | Function flow and interaction design |
| `product-page-design` | Page layout and component design |
| `product-edge-case` | Boundary and error scenario design |
| `product-backlog-refinement` | Backlog prioritization |
| `product-acceptance-criteria` | Acceptance criteria definition |
| `product-ux-review` | UX review |
| `product-data-analysis` | Data analysis and metrics |

### 6. Development (14)
| Skill | Description |
|-------|-------------|
| `dev-context-first` | Get minimum context before implementation |
| `dev-implementation` | Feature implementation |
| `dev-architecture-design` | Architecture design |
| `dev-code-review` | Code review |
| `dev-debugging` | Debug and troubleshoot |
| `dev-refactoring` | Code refactoring |
| `dev-api-design` | API design |
| `dev-database-design` | Database design |
| `dev-security-review` | Security review |
| `dev-product-communication` | Communicate with product on feasibility |
| `dev-design-confirmation` | Confirm design implementation |
| `dev-product-feedback` | Feedback to product |
| `dev-deployment` | Deployment |
| `dev-ops` | Operations and monitoring |

### 7. QA (11)
| Skill | Description |
|-------|-------------|
| `qa-context-first` | Get minimum context before testing |
| `qa-test-strategy` | Test strategy planning |
| `qa-test-case-design` | Test case design |
| `qa-test-automation` | Automation testing |
| `qa-bug-report` | Bug reporting |
| `qa-test-execution` | Test execution |
| `qa-performance-test` | Performance testing |
| `qa-security-test` | Security testing |
| `qa-product-communication` | Communicate with product on test scope |
| `qa-ux-testing` | UX testing (可用/易用/好用) |
| `qa-product-feedback` | Feedback to product |

### 8. Module Dev (4)
| Skill | Description |
|-------|-------------|
| `module_dev_context` | Get module dev context |
| `module_dev_implementation` | Module feature implementation |
| `module_dev_sync` | Module dev alignment |
| `module_dev_acceptance` | Module acceptance support |

### 9. Module Test (5)
| Skill | Description |
|-------|-------------|
| `module_test_context` | Get module test context |
| `module_test_design` | Module test case design |
| `module_test_execution` | Module test execution |
| `module_test_sync` | Module test alignment |
| `module_test_acceptance` | Module acceptance testing |

### 10. Project Overall (4)
| Skill | Description |
|-------|-------------|
| `project_overall_dev` | Project-wide development control |
| `project_overall_test` | Project-wide test control |
| `project_integration_test` | Integration testing |
| `project_regression_test` | Regression testing |

### 11. Collaboration (18)
| Skill | Description |
|-------|-------------|
| `collab_global_to_module` | Global → Module coordination |
| `collab_module_to_global` | Module → Global reporting |
| `collab_module_to_module` | Module-to-module alignment |
| `collab_module_to_dev_qa` | Module → Dev/QA handoff |
| `collab_context-alignment` | Cross-role context alignment |
| `collab-product-alignment` | Project initiation requirement alignment |
| `collab-requirement-details` | Requirement details alignment |
| `collab-product-to-dev` | Product → Development handoff |
| `collab-dev-to-qa` | Development → QA handoff |
| `collab-qa-to-product` | QA → Product handoff |
| `collab-requirement-handoff` | Requirement handoff |
| `collab-dev-qa-sync` | Dev/QA sync |
| `collab-acceptance-review` | Acceptance review |
| `collab-incident-response` | Incident response |
| `collab-retrospective` | Iteration retrospective |
| `project_feedback_to_module` | Project → Module feedback |
| `acceptance_feedback_to_module` | Acceptance → Module feedback |
| `iteration_closure` | Iteration closure → next round |

---

## Key Principles

### 1. Minimum Context Principle
Before any dev or QA task, always use:
- `dev-context-first` / `qa-context-first` - Get minimum context first
- `context-classification` - Classify the task
- `context-minimum` - Extract core info

### 2. Usability Focus (可用/易用/好用)
- **可用 (Usable)**: Core functionality meets user needs
- **易用 (Easy to Use)**: Simple operations, low learning curve  
- **好用 (Pleasant)**: Exceeds expectations, delightful experience

### 3. Multi-Module Responsibility
- Each module has: Module Product, Module Dev, Module Test
- Global Product coordinates modules
- Project Overall ensures integration

### 4. Feedback Loops
1. **Project → Module**: `project_feedback_to_module`
2. **Acceptance → Module**: `acceptance_feedback_to_module`
3. **Retro → Next Round**: `iteration_closure`

---

## Usage

### Via task() with load_skills
```typescript
// Development task
task(
  category="unspecified-high",
  load_skills=["dev-context-first", "dev-implementation"],
  prompt="Implement user login feature..."
)

// QA task
task(
  category="unspecified-high", 
  load_skills=["qa-context-first", "qa-test-case-design"],
  prompt="Design test cases for payment flow..."
)

// Collaboration
task(
  category="unspecified-high",
  load_skills=["collab-product-alignment"],
  prompt="Align project requirements..."
)
```

### Via Trigger Words
Skills are auto-matched by 650+ trigger keywords. Examples:
- "开发前" → `dev-context-first`
- "测试用例" → `qa-test-case-design`
- "需求分析" → `product-requirement-analysis`
- "验收" → `collab-acceptance-review`

---

## Statistics

| Category | Count |
|----------|-------|
| Global Product | 4 |
| Module Product | 5 |
| Module Management | 5 |
| Context | 4 |
| Product | 8 |
| Development | 14 |
| QA | 11 |
| Module Dev | 4 |
| Module Test | 5 |
| Project Overall | 4 |
| Collaboration | 18 |
| **Total** | **78** |

**Trigger Words**: 650+
**Files**: 10 YAML + 2 MD