# Deep-Think Profile Hooks

Standard hooks configuration for the research-hub research and analysis profile.

## Hook Scripts

| Script | Event | Matcher | Purpose |
|--------|-------|---------|---------|
| `safety-guard.sh` | PreToolUse | `Bash\|Write\|Edit` | Blocks dangerous commands and config modifications |
| `tool-logger.sh` | Pre/PostToolUse | `*` | JSON logging of all tool calls |
| `research-logger.sh` | PostToolUse | `Read\|WebFetch\|WebSearch` | Human-readable research activity log |
| `enhance-markdown.sh` | PostToolUse | `Write` | Adds frontmatter metadata to research docs |
| `format-markdown.sh` | PostToolUse | `Write\|Edit` | Runs prettier/markdownlint on markdown files |
| `notify-completion.sh` | Notification | `permission_prompt\|idle_prompt` | Desktop/terminal notifications |
| `stop-guard.sh` | Stop | - | Validates task completion before stopping |
| `session-summary.sh` | SessionEnd | - | Creates session summary with research log |

## Safety Guardrails

The `safety-guard.sh` hook blocks:

- **Destructive commands**: `rm -rf`, `git push --force`, `git reset --hard`
- **Config modifications**: `.claude/settings*`, `.claude/hooks/*`, `CLAUDE.md`
- **Secrets access**: `.env*`, `*.key`, `*.pem`, credentials files
- **Git internals**: Direct `.git/` directory modifications
- **Package publishing**: `npm/yarn/pnpm publish` (requires manual execution)

## Logging

Logs are stored in `.claude/logs/`:

```
logs/
├── tools-YYYY-MM-DD.jsonl    # All tool calls (JSON)
├── security.jsonl            # Blocked operations
├── session.jsonl             # Session events
└── format.jsonl              # Formatting results
```

Research logs are in `.claude/research-logs/`:
```
research-logs/
└── research-YYYY-MM-DD.log   # Human-readable research log
```

## Notifications

Notifications are sent for:
- `permission_prompt` - Claude needs user permission (urgent sound)
- `idle_prompt` - Claude is waiting for input (gentle sound)
- `task_complete` - Task finished (standard sound)

Supports:
- macOS: Native notifications via `osascript`
- Linux: `notify-send`
- Terminal: `tmux display-message`

## Customization

### Disable a Hook

Edit `.claude/settings.json` and remove or comment out the hook entry.

### Adjust Timeouts

Modify the `timeout` value (in milliseconds) in `settings.json`:
```json
{
  "type": "command",
  "command": "bash .claude/hooks/safety-guard.sh",
  "timeout": 5000
}
```

### Add Custom Blocked Patterns

Edit `safety-guard.sh` and add patterns to the case statements:
```bash
if echo "$COMMAND" | grep -qE 'your-pattern'; then
    block_with_reason "Blocked: Your reason"
fi
```

## Dependencies

Optional tools that enhance hook functionality:
- `jq` - JSON parsing (required)
- `prettier` - Markdown formatting
- `markdownlint` - Markdown linting

---
**Configuration files** - Modify with caution. Re-test after changes.
