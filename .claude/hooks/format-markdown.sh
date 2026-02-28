#!/bin/bash
# Markdown Formatter Hook - Validates and formats markdown files after write
# Hook: PostToolUse (matcher: Write|Edit)
# For research-hub profile: ensures consistent markdown formatting

set -euo pipefail

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""')

# Only process markdown files
if [[ ! "$FILE_PATH" == *.md ]]; then
    exit 0
fi

# Skip if file doesn't exist (might have been deleted)
if [ ! -f "$FILE_PATH" ]; then
    exit 0
fi

LOG_DIR="${CLAUDE_PROJECT_DIR:-.}/.claude/logs"
mkdir -p "$LOG_DIR"

# Run prettier if available (for markdown formatting)
if command -v prettier &> /dev/null; then
    if prettier --check "$FILE_PATH" &>/dev/null; then
        echo "{\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"event\":\"format\",\"file\":\"$FILE_PATH\",\"status\":\"ok\"}" >> "$LOG_DIR/format.jsonl"
    else
        # Format the file
        prettier --write "$FILE_PATH" &>/dev/null
        echo "{\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"event\":\"format\",\"file\":\"$FILE_PATH\",\"status\":\"formatted\"}" >> "$LOG_DIR/format.jsonl"
    fi
fi

# Run markdownlint if available
if command -v markdownlint &> /dev/null; then
    LINT_OUTPUT=$(markdownlint "$FILE_PATH" 2>&1) || true
    if [ -n "$LINT_OUTPUT" ]; then
        # Log warnings but don't block
        echo "{\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"event\":\"lint\",\"file\":\"$FILE_PATH\",\"warnings\":\"$LINT_OUTPUT\"}" >> "$LOG_DIR/format.jsonl"
        # Surface to Claude via stderr (visible in hook output)
        echo "Markdown lint warnings for $FILE_PATH:" >&2
        echo "$LINT_OUTPUT" >&2
    fi
fi

exit 0
