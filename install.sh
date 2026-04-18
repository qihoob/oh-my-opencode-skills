#!/usr/bin/env bash
set -euo pipefail

# oh-my-opencode-skills 安装脚本
# 用法: ./install.sh [安装路径]
# 默认路径: ~/skill

SKILL_DIR="${1:-$HOME/skill}"

# 如果脚本不在目标目录，说明是从别处运行的
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# 如果已经 clone 好了，SCRIPT_DIR 就是项目目录
# 如果还没 clone，先 clone
if [ "$SCRIPT_DIR" != "$SKILL_DIR" ]; then
    if [ ! -d "$SKILL_DIR" ]; then
        echo "==> Cloning to $SKILL_DIR ..."
        git clone https://github.com/qihoob/oh-my-opencode-skills.git "$SKILL_DIR"
    fi
    SOURCE_DIR="$SKILL_DIR"
else
    SOURCE_DIR="$SCRIPT_DIR"
fi

# 展开为绝对路径
SKILL_DIR="$(cd "$SKILL_DIR" && pwd)"
SOURCE_DIR="$(cd "$SOURCE_DIR" && pwd)"

echo "==> 技能库路径: $SKILL_DIR"

# 1. 替换项目内占位符
echo "==> 替换项目内 {{SKILL_DIR}} 占位符 ..."
sed -i "s|{{SKILL_DIR}}|$SKILL_DIR|g" "$SOURCE_DIR/CLAUDE.md" "$SOURCE_DIR/AGENTS.md"

# 2. 生成全局 CLAUDE.md 配置
CLAUDE_MD="$HOME/.claude/CLAUDE.md"
mkdir -p "$HOME/.claude"

# 检查是否已经配置过
if grep -q "oh-my-opencode" "$CLAUDE_MD" 2>/dev/null; then
    echo "==> 检测到已有配置，更新路径 ..."
    sed -i "s|/home/[^/]*/skill|$SKILL_DIR|g" "$CLAUDE_MD"
else
    echo "==> 写入全局配置到 $CLAUDE_MD ..."
    cat >> "$CLAUDE_MD" << HEREDOC

# 全局技能系统

你的技能库位于 \`$SKILL_DIR/\`，在任何项目中都可以使用。

## 技能加载方式：Read 文件，不要调用 Skill 工具
oh-my-opencode 的 59 个技能存储为 SKILL.md 文件，不是 Claude Code 原生注册的 skill。
- 正确：用 Read 工具读取 SKILL.md 文件，然后按其指令执行
- 错误：调用 Skill("product-requirement-analysis")

## 快速入口

当用户输入涉及以下场景时，先读取对应的 SKILL.md 再执行：

| 用户说 | 读取 |
|--------|------|
| 需求分析、用户故事 | $SKILL_DIR/product/requirement/product-requirement-analysis/SKILL.md |
| 给我上下文、先看看代码 | $SKILL_DIR/dev/context/dev-context-first/SKILL.md |
| 实现功能、写代码 | $SKILL_DIR/dev/implementation/dev-implementation/SKILL.md |
| 代码审查、CR | $SKILL_DIR/dev/code-review/SKILL.md |
| 测试用例 | $SKILL_DIR/qa/test-case/test-case-design/SKILL.md |
| 执行测试 | $SKILL_DIR/qa/execution/test-executor/SKILL.md |
| 半路测试、没有需求文档 | $SKILL_DIR/qa/context/qa-context-from-code/SKILL.md |
| 提测 | $SKILL_DIR/collaboration/handoff/collab-dev-to-qa/SKILL.md |
| 验收 | $SKILL_DIR/collaboration/review/collab-acceptance-review/SKILL.md |
| Bug协调 | $SKILL_DIR/collaboration/process/bug-coordinator/SKILL.md |
| 复盘 | $SKILL_DIR/collaboration/process/collab-retrospective/SKILL.md |
| 线上故障、P0 | $SKILL_DIR/collaboration/sync/incident/SKILL.md |
| 项目分析 | $SKILL_DIR/product/analysis/global-project-analysis/SKILL.md |
| 调试、debug | $SKILL_DIR/dev/debugging/SKILL.md |
| 重构、refactor | $SKILL_DIR/dev/refactoring/SKILL.md |
| ADR、架构决策 | $SKILL_DIR/dev/adr/SKILL.md |
| 评估依赖 | $SKILL_DIR/dev/dependency-eval/SKILL.md |
| 保存上下文、恢复上下文 | $SKILL_DIR/dev/context-restore/SKILL.md |

## 完整触发词映射

详见 $SKILL_DIR/AGENTS.md

## 自驱动流程

详见 $SKILL_DIR/system/chain-executor/SKILL.md

核心规则：文档产出 = 下一步自动触发。无需人工推流程。
HEREDOC
fi

echo ""
echo "==> 安装完成!"
echo "    技能库: $SKILL_DIR"
echo "    全局配置: $CLAUDE_MD"
echo ""
echo "    现在可以在任何项目中使用技能了。"
echo "    试试对 Claude Code 说: '帮我实现用户登录功能'"
