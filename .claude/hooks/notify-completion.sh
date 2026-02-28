#!/bin/bash
# Desktop Notification Hook - Alerts when Claude needs attention
# Hook: Notification (matcher: permission_prompt|idle_prompt|task_complete)

set -euo pipefail

INPUT=$(cat)

NOTIFICATION_TYPE=$(echo "$INPUT" | jq -r '.type // "unknown"')
TITLE=$(echo "$INPUT" | jq -r '.title // "Claude Code - Research Hub"')
MESSAGE=$(echo "$INPUT" | jq -r '.message // "Notification"')

# Log notification
LOG_DIR="${CLAUDE_PROJECT_DIR:-.}/.claude/logs"
mkdir -p "$LOG_DIR"
echo "{\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"event\":\"notification\",\"type\":\"$NOTIFICATION_TYPE\",\"title\":\"$TITLE\"}" >> "$LOG_DIR/session.jsonl"

# Customize notification based on type
case "$NOTIFICATION_TYPE" in
    "permission_prompt")
        TITLE="🔐 Claude Needs Permission"
        SOUND="Basso"
        ;;
    "idle_prompt")
        TITLE="⏳ Claude is Waiting"
        SOUND="Purr"
        ;;
    "task_complete")
        TITLE="✅ Task Complete"
        SOUND="Glass"
        ;;
    *)
        SOUND="Glass"
        ;;
esac

# macOS notification with appropriate sound
if command -v osascript &> /dev/null; then
    osascript -e "display notification \"$MESSAGE\" with title \"$TITLE\" sound name \"$SOUND\""
fi

# Terminal notification (works in tmux/screen)
if [ -n "${TMUX:-}" ]; then
    tmux display-message "Claude: $MESSAGE" 2>/dev/null || true
fi

# Linux notification fallback
if command -v notify-send &> /dev/null; then
    notify-send "$TITLE" "$MESSAGE" --urgency=normal
fi

exit 0
