---
name: document-formatting
description: "Apply professional formatting and ensure consistent structure across all documentation outputs. Provides template application, markdown formatting, metadata management, and quality assurance. Use when polishing, formatting, finalizing, or cleaning up markdown documents."
allowed-tools: read, write, grep, glob
---

# Document Formatting Skill

## Purpose
Ensure professional formatting and consistent structure across all research-hub documentation outputs with quality assurance and standards compliance.

## When to Activate
- User mentions "format", "polish", "finalize", "clean up"
- Document needs final formatting touch
- Markdown formatting inconsistencies
- Metadata validation required
- Quality assurance needed before delivery
- Standards compliance check

**Key Triggers**: format, polish, finalize, clean up, fix formatting, make it professional, final touches

## Core Capabilities

### 1. Template Application
- Apply appropriate documentation templates
- Ensure template compliance
- Validate required sections present
- Check section ordering and hierarchy

### 2. Markdown Formatting
- Fix markdown syntax errors
- Standardize heading styles
- Format code blocks properly
- Clean up table formatting
- Ensure link validity
- Fix list formatting

### 3. Metadata Management
- Validate YAML frontmatter
- Complete missing metadata fields
- Standardize metadata format
- Add version information
- Include timestamps

### 4. Quality Assurance
- Check for completeness
- Validate cross-references
- Ensure citation accuracy
- Verify file organization
- Confirm naming conventions

## How to Use This Skill

### Step 1: Receive Input
Accept documentation from:
- `@research-doc-generator` (generated docs)
- Any agent producing markdown output
- User-provided documents needing polish

### Step 2: Apply Formatting
1. Validate markdown syntax
2. Fix formatting inconsistencies
3. Standardize heading hierarchy
4. Format code and tables properly
5. Clean up whitespace and line breaks

### Step 3: Enhance Metadata
1. Add/complete YAML frontmatter
2. Include all required fields
3. Standardize date formats
4. Add version information
5. Include author/generator attribution

### Step 4: Quality Check
1. Verify all sections present
2. Check cross-reference validity
3. Ensure consistent terminology
4. Validate file structure
5. Confirm output location

### Step 5: Final Save
Save formatted document with:
- Proper filename (_final suffix if applicable)
- Correct location in docs/ structure
- Complete metadata
- Clean formatting

## Formatting Standards

### Heading Hierarchy
- Use proper ATX-style headers (# ## ###)
- Maintain consistent nesting
- No skipped levels
- Clear, descriptive titles

### Code Blocks
- Always specify language
- Use proper indentation
- Include explanatory comments
- Add context before/after blocks

### Tables
- Proper alignment
- Header row clearly marked
- Consistent column widths
- Caption/title when needed

### Lists
- Consistent bullet/number style
- Proper indentation for nesting
- Parallel structure in items
- Complete sentences or fragments (consistent)

### Links and References
- Valid URLs
- Descriptive link text
- Internal links properly formatted
- Citations properly structured

## Integration
- Receives from: `@research-doc-generator` and other agents
- Final output step in documentation pipeline
- Ensures: Professional, consistent, standards-compliant documents
- Outputs to: Final documentation locations

## See Also
- Agent: @research-doc-formatter
- Standards: .claude/standards/ for documentation standards
- Reference: reference.md for formatting guidelines
