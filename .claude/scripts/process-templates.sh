#!/bin/bash

# Template Processing Script for research-hub profile
# Replaces placeholders in template files with actual values

set -e

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

# Function to replace placeholders in a file
process_template() {
    local template_file="$1"
    local output_file="$2"
    local temp_file="${output_file}.tmp"

    # Copy template to temp file
    cp "$template_file" "$temp_file"

    # Escape special characters for sed (escape forward slashes)
    PROJECT_NAME_ESCAPED=$(echo "$PROJECT_NAME" | sed 's/\//\\\//g')
    PROJECT_NAME_LOWER_ESCAPED=$(echo "$PROJECT_NAME_LOWER" | sed 's/\//\\\//g')
    PROJECT_TYPE_ESCAPED=$(echo "$PROJECT_TYPE" | sed 's/\//\\\//g')
    PROJECT_DESCRIPTION_ESCAPED=$(echo "${PROJECT_DESCRIPTION:-Deep thinking and research project}" | sed 's/\//\\\//g')

    # Replace all placeholders
    sed -i.bak \
        -e "s/{{PROJECT_NAME}}/$PROJECT_NAME_ESCAPED/g" \
        -e "s/{{PROJECT_NAME_LOWER}}/$PROJECT_NAME_LOWER_ESCAPED/g" \
        -e "s/{{PROJECT_TYPE}}/$PROJECT_TYPE_ESCAPED/g" \
        -e "s/{{PROJECT_PATH}}/$PROJECT_PATH_ESCAPED/g" \
        -e "s/{{PROJECT_DESCRIPTION}}/$PROJECT_DESCRIPTION_ESCAPED/g" \
        -e "s/{{CREATION_DATE}}/$CREATION_DATE/g" \
        -e "s/{{TARGET_DATE}}/$TARGET_DATE/g" \
        -e "s/{{ENV_NAME}}/${ENV_NAME:-research-hub}/g" \
        -e "s/{{PORT}}/${PORT:-8000}/g" \
        "$temp_file"

    # Handle conditional sections for research-hub profile
    # Deep-think is research-focused, so we enable research/analysis sections
    if [ "$IS_PYTHON" = "true" ]; then
        sed -i.bak -e '/{{#if_python}}/d' -e '/{{\/if_python}}/d' "$temp_file"
    else
        sed -i.bak '/{{#if_python}}/,/{{\/if_python}}/d' "$temp_file"
    fi

    if [ "$IS_NODE" = "true" ]; then
        sed -i.bak -e '/{{#if_node}}/d' -e '/{{\/if_node}}/d' "$temp_file"
    else
        sed -i.bak '/{{#if_node}}/,/{{\/if_node}}/d' "$temp_file"
    fi

    if [ "$IS_ML" = "true" ]; then
        sed -i.bak -e '/{{#if_ml}}/d' -e '/{{\/if_ml}}/d' "$temp_file"
    else
        sed -i.bak '/{{#if_ml}}/,/{{\/if_ml}}/d' "$temp_file"
    fi

    if [ "$IS_WEB" = "true" ]; then
        sed -i.bak -e '/{{#if_web}}/d' -e '/{{\/if_web}}/d' "$temp_file"
    else
        sed -i.bak '/{{#if_web}}/,/{{\/if_web}}/d' "$temp_file"
    fi

    if [ "$IS_API" = "true" ]; then
        sed -i.bak -e '/{{#if_api}}/d' -e '/{{\/if_api}}/d' "$temp_file"
    else
        sed -i.bak '/{{#if_api}}/,/{{\/if_api}}/d' "$temp_file"
    fi

    # Move temp file to output
    mv "$temp_file" "$output_file"
    rm -f "${temp_file}.bak"

    echo -e "${GREEN}✅ Processed: $output_file${NC}"
}

# Export function for use by other scripts
export -f process_template

# If run directly
if [ "${BASH_SOURCE[0]}" == "${0}" ]; then
    echo -e "${BLUE}Template Processing Utility - research-hub profile${NC}"
    echo "This script is meant to be sourced by create-project.sh"
    echo ""
    echo "Usage: source scripts/process-templates.sh"
fi
