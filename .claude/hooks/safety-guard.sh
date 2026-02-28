#!/bin/bash
# Safety Guard Hook - Blocks dangerous shell commands and config file modifications
# Hook: PreToolUse (matcher: Bash|Write|Edit)
# Returns JSON: {"decision": "block", "reason": "..."} or exits 0 to allow

set -euo pipefail

INPUT=$(cat)
TOOL=$(echo "$INPUT" | jq -r '.tool_name // ""')
LOG_DIR="${CLAUDE_PROJECT_DIR:-.}/.claude/logs"
mkdir -p "$LOG_DIR"

log_blocked() {
    local reason="$1"
    echo "{\"timestamp\":\"$(date -u +%Y-%m-%dT%H:%M:%SZ)\",\"tool\":\"$TOOL\",\"status\":\"blocked\",\"reason\":\"$reason\"}" >> "$LOG_DIR/security.jsonl"
}

block_with_reason() {
    local reason="$1"
    log_blocked "$reason"
    echo "{\"decision\": \"block\", \"reason\": \"$reason\"}"
    exit 0
}

case "$TOOL" in
    "Bash")
        COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // ""')

        # Block destructive commands
        if echo "$COMMAND" | grep -qE 'rm\s+(-rf?|--recursive).*(/|\*|~)'; then
            block_with_reason "Blocked: Destructive rm command detected"
        fi

        if echo "$COMMAND" | grep -qE 'rm\s+-rf?\s+\.$'; then
            block_with_reason "Blocked: Removing current directory"
        fi

        # Block dangerous git operations
        if echo "$COMMAND" | grep -qE 'git\s+(push\s+--force|reset\s+--hard|clean\s+-fd)'; then
            block_with_reason "Blocked: Dangerous git operation"
        fi

        # Block direct editing of secrets/env files via shell
        if echo "$COMMAND" | grep -qE '(>|>>)\s*\.env|cat\s*>\s*\.env|echo.*>\s*\.env'; then
            block_with_reason "Blocked: Direct modification of .env file"
        fi

        # Block npm/yarn publish without confirmation
        if echo "$COMMAND" | grep -qE '(npm|yarn|pnpm)\s+publish'; then
            block_with_reason "Blocked: Package publish requires manual execution"
        fi

        # Block docker destructive commands
        if echo "$COMMAND" | grep -qE 'docker\s+(system\s+prune|rm\s+-f|rmi\s+-f)'; then
            block_with_reason "Blocked: Destructive Docker command"
        fi

        # Block modifications to .claude directory via shell
        if echo "$COMMAND" | grep -qE '(rm|mv|cp|cat\s*>|echo.*>).*\.claude/(settings|hooks|CLAUDE)'; then
            block_with_reason "Blocked: Cannot modify .claude config via shell"
        fi

        # Block modifications to .git directory
        if echo "$COMMAND" | grep -qE '(rm|mv).*\.git/'; then
            block_with_reason "Blocked: Cannot modify .git directory"
        fi
        ;;

    "Write"|"Edit")
        FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""')

        # Protect Claude configuration files
        if [[ "$FILE_PATH" == *".claude/settings"* ]] || \
           [[ "$FILE_PATH" == *".claude/hooks/"* ]] || \
           [[ "$FILE_PATH" == *"CLAUDE.md" ]] || \
           [[ "$FILE_PATH" == *".claude/claude.md" ]]; then
            block_with_reason "Blocked: Cannot modify Claude configuration files (.claude/settings*, .claude/hooks/*, CLAUDE.md)"
        fi

        # Protect secrets and credentials
        if [[ "$FILE_PATH" == *".env"* ]] || \
           [[ "$FILE_PATH" == *"credentials"* ]] || \
           [[ "$FILE_PATH" == *"secrets"* ]] || \
           [[ "$FILE_PATH" == *".pem" ]] || \
           [[ "$FILE_PATH" == *".key" ]]; then
            block_with_reason "Blocked: Cannot modify secrets or credentials files"
        fi

        # Protect git internals
        if [[ "$FILE_PATH" == *".git/"* ]]; then
            block_with_reason "Blocked: Cannot modify .git directory"
        fi
        ;;
esac

# Allow the operation
exit 0
