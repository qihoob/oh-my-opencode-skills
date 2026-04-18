#!/usr/bin/env bash
# oh-my-opencode-skills 一键安装脚本
#
# 用法 1（推荐，curl 管道）:
#   curl -fsSL https://raw.githubusercontent.com/qihoob/oh-my-opencode-skills/main/install.sh | bash
#
# 用法 2（指定路径）:
#   SKILL_DIR=~/my-skills curl -fsSL https://raw.githubusercontent.com/qihoob/oh-my-opencode-skills/main/install.sh | bash
#
# 用法 3（本地执行）:
#   ./install.sh [安装路径]
#
# 环境变量:
#   SKILL_DIR  - 安装路径（默认: ~/skill）
#   REPO_URL   - Git 仓库地址（默认: https://github.com/qihoob/oh-my-opencode-skills.git）
#   BRANCH     - 分支（默认: main）

set -euo pipefail

{ # 用 { ... } 包裹，确保管道模式下完整下载后再执行

# ── 配置 ──────────────────────────────────────────────

SKILL_DIR="${SKILL_DIR:-${1:-$HOME/skill}}"
REPO_URL="${REPO_URL:-https://github.com/qihoob/oh-my-opencode-skills.git}"
BRANCH="${BRANCH:-main}"

# 颜色（检测终端支持）
if [ -t 1 ]; then
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    YELLOW='\033[0;33m'
    CYAN='\033[0;36m'
    BOLD='\033[1m'
    RESET='\033[0m'
else
    RED='' GREEN='' YELLOW='' CYAN='' BOLD='' RESET=''
fi

# ── 工具函数 ──────────────────────────────────────────

info()  { printf "${CYAN}==>${RESET} %s\n" "$*"; }
ok()    { printf "${GREEN}  ✓${RESET} %s\n" "$*"; }
warn()  { printf "${YELLOW}  ⚠${RESET} %s\n" "$*"; }
err()   { printf "${RED}  ✗${RESET} %s\n" "$*" >&2; }

# 检测下载工具
detect_downloader() {
    if command -v curl &>/dev/null; then
        echo "curl -fsSL"
    elif command -v wget &>/dev/null; then
        echo "wget -qO-"
    else
        return 1
    fi
}

# 检测 Git
check_git() {
    if ! command -v git &>/dev/null; then
        err "需要 git 但未找到。请先安装 git: https://git-scm.com"
        exit 1
    fi
}

# 展开为绝对路径
expand_path() {
    local p="$1"
    # 处理 ~
    p="${p/#\~/$HOME}"
    # 如果不是绝对路径，基于当前目录转换
    if [ "${p:0:1}" != "/" ]; then
        p="$(cd "$p" 2>/dev/null && pwd)" || p="$PWD/$p"
    fi
    echo "$p"
}

# ── 主流程 ────────────────────────────────────────────

info "oh-my-opencode-skills 安装器"
echo ""

# 1. 前置检查
check_git

DOWNLOADER="$(detect_downloader)" || {
    err "需要 curl 或 wget，但都未找到。请安装其中之一。"
    exit 1
}
ok "下载工具: $DOWNLOADER"

# 2. 展开 SKILL_DIR 为绝对路径
SKILL_DIR="$(expand_path "$SKILL_DIR")"
ok "安装路径: $SKILL_DIR"

# 3. 克隆或更新
if [ -d "$SKILL_DIR/.git" ]; then
    info "检测到已有安装，更新中..."
    (cd "$SKILL_DIR" && git fetch origin "$BRANCH" && git reset --hard "origin/$BRANCH")
    ok "更新完成"
elif [ -d "$SKILL_DIR" ]; then
    # 目录存在但不是 git 仓库
    warn "$SKILL_DIR 已存在但不是 git 仓库，备份后重新克隆"
    mv "$SKILL_DIR" "${SKILL_DIR}.bak.$(date +%s)"
    git clone -b "$BRANCH" "$REPO_URL" "$SKILL_DIR"
    ok "克隆完成"
else
    info "克隆仓库..."
    git clone -b "$BRANCH" "$REPO_URL" "$SKILL_DIR"
    ok "克隆完成"
fi

# 4. 替换项目内 {{SKILL_DIR}} 占位符
info "配置路径..."
sed -i "s|{{SKILL_DIR}}|$SKILL_DIR|g" \
    "$SKILL_DIR/CLAUDE.md" \
    "$SKILL_DIR/AGENTS.md" 2>/dev/null || true
ok "项目内占位符已替换"

# 5. 生成全局 CLAUDE.md
CLAUDE_MD="$HOME/.claude/CLAUDE.md"
mkdir -p "$HOME/.claude"

if grep -q "oh-my-opencode" "$CLAUDE_MD" 2>/dev/null; then
    info "更新全局配置..."
    # 替换已有路径
    sed -i "s|/home/[^/]*/skill|$SKILL_DIR|g" "$CLAUDE_MD"
    sed -i "s|/Users/[^/]*/skill|$SKILL_DIR|g" "$CLAUDE_MD"
    # 更新技能数量（如果有变化）
    sed -i "s|的 [0-9]* 个技能|的 59 个技能|g" "$CLAUDE_MD"
else
    info "写入全局配置到 $CLAUDE_MD ..."
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
ok "全局配置已就绪"

# 6. 完成
echo ""
printf "${GREEN}${BOLD}  ✓ 安装完成!${RESET}\n"
echo ""
echo "    技能库:    $SKILL_DIR"
echo "    全局配置:  $CLAUDE_MD"
echo ""
echo "    现在可以在任何项目中使用技能了。"
echo "    试试对 Claude Code 说: ${CYAN}帮我实现用户登录功能${RESET}"
echo ""

} # end wrapping block
