#!/bin/bash
# Stop Guard Hook - Validates task completion before allowing Claude to stop
# Hook: Stop (prompt-based)
# Returns JSON: {"decision": "approve"} or {"decision": "block", "reason": "..."}

set -euo pipefail

INPUT=$(cat)

# Extract stop reason and transcript summary
STOP_REASON=$(echo "$INPUT" | jq -r '.stop_reason // "unknown"')
TRANSCRIPT=$(echo "$INPUT" | jq -r '.transcript_summary // ""')

LOG_DIR="${CLAUDE_PROJECT_DIR:-.}/.claude/logs"
mkdir -p "$LOG_DIR"

# Log the stop attempt
echo "{\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"event\":\"stop_attempt\",\"reason\":\"$STOP_REASON\"}" >> "$LOG_DIR/session.jsonl"

# For end_turn stops, check if user's request seems complete
if [ "$STOP_REASON" = "end_turn" ]; then
    # Check for common incomplete indicators in recent output
    # This is a lightweight heuristic - the prompt-based hook approach
    # would use Claude to make this decision more intelligently

    # Look for TODO markers or incomplete indicators in recent logs
    RECENT_LOG="$LOG_DIR/tools-$(date +%Y-%m-%d).jsonl"

    if [ -f "$RECENT_LOG" ]; then
        # Count recent operations in last minute
        RECENT_COUNT=$(tail -20 "$RECENT_LOG" 2>/dev/null | wc -l | tr -d ' ')

        # If very few operations, might be incomplete
        if [ "$RECENT_COUNT" -lt 2 ]; then
            # Allow but log warning
            echo "{\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"event\":\"stop_warning\",\"message\":\"Low activity detected\"}" >> "$LOG_DIR/session.jsonl"
        fi
    fi
fi

# Default: approve the stop
# In a more sophisticated setup, this would query Claude via prompt-based hook
echo '{"decision": "approve"}'
exit 0
