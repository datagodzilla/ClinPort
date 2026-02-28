#!/bin/bash
# Tool Logger Hook - JSON logging for all tool calls
# Hook: PreToolUse/PostToolUse (all tools)
# Logs structured JSON to .claude/logs/tools-YYYY-MM-DD.jsonl

set -euo pipefail

LOG_DIR="${CLAUDE_PROJECT_DIR:-.}/.claude/logs"
mkdir -p "$LOG_DIR"

LOG_FILE="$LOG_DIR/tools-$(date +%Y-%m-%d).jsonl"

INPUT=$(cat)

# Extract common fields
TOOL=$(echo "$INPUT" | jq -r '.tool_name // "unknown"')
SESSION=$(echo "$INPUT" | jq -r '.session_id // "unknown"')
TIMESTAMP=$(date -u +%Y-%m-%dT%H:%M:%SZ)

# Determine if this is pre or post based on presence of tool_output
HAS_OUTPUT=$(echo "$INPUT" | jq -r 'if .tool_output then "post" else "pre" end')

# Build log entry based on tool type
case "$TOOL" in
    "Read")
        FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""')
        DETAIL="{\"file\":\"$FILE_PATH\"}"
        ;;
    "Write"|"Edit")
        FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""')
        DETAIL="{\"file\":\"$FILE_PATH\"}"
        ;;
    "Bash")
        # Truncate command for logging
        COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // ""' | head -c 200)
        DETAIL=$(echo "{}" | jq --arg cmd "$COMMAND" '. + {command: $cmd}')
        ;;
    "WebFetch")
        URL=$(echo "$INPUT" | jq -r '.tool_input.url // ""')
        DETAIL="{\"url\":\"$URL\"}"
        ;;
    "WebSearch")
        QUERY=$(echo "$INPUT" | jq -r '.tool_input.query // ""')
        DETAIL=$(echo "{}" | jq --arg q "$QUERY" '. + {query: $q}')
        ;;
    "Grep"|"Glob")
        PATTERN=$(echo "$INPUT" | jq -r '.tool_input.pattern // ""')
        DETAIL=$(echo "{}" | jq --arg p "$PATTERN" '. + {pattern: $p}')
        ;;
    "Task")
        AGENT=$(echo "$INPUT" | jq -r '.tool_input.subagent_type // ""')
        DETAIL="{\"agent\":\"$AGENT\"}"
        ;;
    *)
        DETAIL="{}"
        ;;
esac

# Determine status for post-tool use
if [ "$HAS_OUTPUT" = "post" ]; then
    # Check if there was an error in the output
    HAS_ERROR=$(echo "$INPUT" | jq -r 'if .tool_output.error then "error" else "success" end')
    STATUS="$HAS_ERROR"
else
    STATUS="initiated"
fi

# Create JSON log entry
LOG_ENTRY=$(jq -n \
    --arg ts "$TIMESTAMP" \
    --arg tool "$TOOL" \
    --arg phase "$HAS_OUTPUT" \
    --arg status "$STATUS" \
    --arg session "$SESSION" \
    --argjson detail "$DETAIL" \
    '{timestamp: $ts, tool: $tool, phase: $phase, status: $status, session: $session, detail: $detail}')

echo "$LOG_ENTRY" >> "$LOG_FILE"

exit 0
