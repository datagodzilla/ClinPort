#!/bin/bash
# Markdown Enhancement Hook - Auto-adds metadata to research documents
# Hook: PostToolUse (matcher: Write)

INPUT=$(cat)

FILE=$(echo "$INPUT" | jq -r '.tool_input.file_path // ""')

# Only process markdown files in docs/ or analysis/
if [[ "$FILE" == *.md ]] && [[ "$FILE" == *docs/* || "$FILE" == *analysis/* ]]; then
    # Check if file has frontmatter
    if ! head -1 "$FILE" | grep -q "^---$"; then
        # Add research metadata frontmatter
        TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
        TEMP_FILE=$(mktemp)

        cat > "$TEMP_FILE" << EOF
---
created: $TIMESTAMP
profile: research-hub
type: research-document
status: draft
---

EOF
        cat "$FILE" >> "$TEMP_FILE"
        mv "$TEMP_FILE" "$FILE"

        echo "Added research metadata to $FILE"
    fi
fi

exit 0
