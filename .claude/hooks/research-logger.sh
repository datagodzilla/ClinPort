#!/bin/bash
# Research Logger Hook - Logs all research activities for the research-hub profile
# Hook: PostToolUse (matcher: Read|WebFetch|WebSearch)

LOG_DIR="${CLAUDE_PROJECT_DIR:-.}/.claude/research-logs"
mkdir -p "$LOG_DIR"

LOG_FILE="$LOG_DIR/research-$(date +%Y-%m-%d).log"

# Read JSON from stdin
INPUT=$(cat)

TOOL=$(echo "$INPUT" | jq -r '.tool_name // "unknown"')
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

case "$TOOL" in
    "Read")
        FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // "unknown"')
        echo "[$TIMESTAMP] READ: $FILE" >> "$LOG_FILE"
        ;;
    "WebFetch")
        URL=$(echo "$INPUT" | jq -r '.tool_input.url // "unknown"')
        echo "[$TIMESTAMP] FETCH: $URL" >> "$LOG_FILE"
        ;;
    "WebSearch")
        QUERY=$(echo "$INPUT" | jq -r '.tool_input.query // "unknown"')
        echo "[$TIMESTAMP] SEARCH: $QUERY" >> "$LOG_FILE"
        ;;
    *)
        echo "[$TIMESTAMP] $TOOL: (activity logged)" >> "$LOG_FILE"
        ;;
esac

exit 0
