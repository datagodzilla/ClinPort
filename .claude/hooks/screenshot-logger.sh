#!/bin/bash
# Screenshot Logger Hook
# Logs all Playwright screenshots taken during UI testing sessions

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOG_DIR="${SCRIPT_DIR}/../testing/reports"
LOG_FILE="${LOG_DIR}/screenshots.log"

# Ensure log directory exists
mkdir -p "$LOG_DIR"

# Get timestamp
TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')

# Log the screenshot action
echo "[$TIMESTAMP] Screenshot captured" >> "$LOG_FILE"

exit 0
