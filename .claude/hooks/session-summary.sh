#!/bin/bash
# Session Summary Hook - Creates a summary of research activities at session end
# Hook: SessionEnd

SUMMARY_DIR="${CLAUDE_PROJECT_DIR:-.}/.claude/session-summaries"
mkdir -p "$SUMMARY_DIR"

INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"')
TRANSCRIPT=$(echo "$INPUT" | jq -r '.transcript_path // ""')

SUMMARY_FILE="$SUMMARY_DIR/session-$(date +%Y%m%d-%H%M%S).md"

# Create session summary
cat > "$SUMMARY_FILE" << EOF
# Research Session Summary

**Session ID**: $SESSION_ID
**Date**: $(date '+%Y-%m-%d %H:%M:%S')
****Profile**: research-hub

## Session Details

- Transcript: $TRANSCRIPT
- Working Directory: ${CLAUDE_PROJECT_DIR:-$(pwd)}

## Research Log

EOF

# Append today's research log if exists
LOG_FILE="${CLAUDE_PROJECT_DIR:-.}/.claude/research-logs/research-$(date +%Y-%m-%d).log"
if [ -f "$LOG_FILE" ]; then
    echo '```' >> "$SUMMARY_FILE"
    tail -50 "$LOG_FILE" >> "$SUMMARY_FILE"
    echo '```' >> "$SUMMARY_FILE"
else
    echo "_No research activities logged this session._" >> "$SUMMARY_FILE"
fi

echo "Session summary saved to $SUMMARY_FILE"
exit 0
