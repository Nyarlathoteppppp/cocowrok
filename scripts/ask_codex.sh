#!/bin/bash
# ask_codex — 将 Codex 请求写入 cowork 队列（终端入口）
# 用法:
#   ask_codex "你想问的问题"
#
# 原理:
#   1. 将问题写入 cowork/scratch/codex-queue.md
#   2. 等待 Claude 或外部调度器拾取队列并通过 MCP 发送
#   3. 结果可写入 cowork/scratch/codex-response.md
#
# 注意: 实际消息发送和轮询由 Claude 的 MCP 工具完成，
#       此脚本仅作为异步触发的终端入口。

set -euo pipefail

COWORK="${ABG_COWORK_DIR:-/Users/ywbw/cowork}"
QUEUE="$COWORK/scratch/codex-queue.md"
RESPONSE="$COWORK/scratch/codex-response.md"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

if [ $# -eq 0 ] && [ -t 0 ]; then
  echo "用法: ask_codex <消息内容>"
  echo ""
  echo "示例:"
  echo "  ask_codex \"请 review 这个方案\""
  echo "  echo \"方案内容\" | ask_codex"
  echo ""
  echo "环境变量:"
  echo "  ABG_COWORK_DIR  覆盖协作目录 (默认: $COWORK)"
  exit 1
fi

if [ $# -gt 0 ]; then
  MESSAGE="$*"
else
  MESSAGE="$(cat)"
fi

mkdir -p "$COWORK/scratch"
touch "$QUEUE" "$RESPONSE"

TMP_FILE="$(mktemp "${TMPDIR:-/tmp}/ask-codex.XXXXXX")"
trap 'rm -f "$TMP_FILE"' EXIT

# 写入队列
cat > "$TMP_FILE" <<EOF

---
timestamp: $TIMESTAMP
status: pending
---

## 问题

$MESSAGE

---

**等待 Claude 处理中...**
EOF
cat "$TMP_FILE" >> "$QUEUE"

echo "✅ 已加入队列: $MESSAGE"
echo "   等待 Claude 或外部调度器拾取处理。"
echo "   或直接对 Claude 说: 看看 codex 队列"
