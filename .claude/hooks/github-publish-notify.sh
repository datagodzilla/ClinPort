#!/bin/bash
# GitHub Publish Notification Hook
# Triggered after successful GitHub Pages publishing
# Logs publishing events and optionally sends notifications

HOOK_NAME="github-publish-notify"
LOG_DIR=".claude/logs"
PUBLISH_LOG="$LOG_DIR/github-publish.jsonl"

# Ensure log directory exists
mkdir -p "$LOG_DIR"

# Get input from stdin (if any)
INPUT=$(cat 2>/dev/null || echo "{}")

# Extract publishing details from environment or input
REPO="${GITHUB_REPO:-unknown}"
POST_TITLE="${POST_TITLE:-unknown}"
POST_URL="${POST_URL:-unknown}"
COMMIT_HASH="${COMMIT_HASH:-unknown}"
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Log the publishing event
log_event() {
    local status="$1"
    local message="$2"

    echo "{\"timestamp\":\"$TIMESTAMP\",\"hook\":\"$HOOK_NAME\",\"status\":\"$status\",\"repo\":\"$REPO\",\"title\":\"$POST_TITLE\",\"url\":\"$POST_URL\",\"commit\":\"$COMMIT_HASH\",\"message\":\"$message\"}" >> "$PUBLISH_LOG"
}

# Check if this is a publishing event
if [[ "$INPUT" == *"github"* ]] || [[ "$INPUT" == *"publish"* ]] || [[ -n "$POST_URL" && "$POST_URL" != "unknown" ]]; then
    log_event "success" "Blog post published to GitHub Pages"

    # Optional: Desktop notification (macOS)
    if command -v osascript &> /dev/null; then
        osascript -e "display notification \"Blog post published successfully\" with title \"GitHub Pages\" subtitle \"$POST_TITLE\""
    fi

    # Optional: Terminal notification
    if command -v terminal-notifier &> /dev/null; then
        terminal-notifier -title "GitHub Pages Published" -message "$POST_TITLE" -open "$POST_URL"
    fi
fi

# Always exit successfully to not block the workflow
exit 0
