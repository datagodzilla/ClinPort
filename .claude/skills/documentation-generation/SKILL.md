---
name: documentation-generation
description: "Generate comprehensive templated documentation from expert analysis including technical workflows, clinical workflows, and research summaries. Uses 3 specialized templates with source traceability, cross-referencing, and structured formatting. Use when creating documentation, workflow guides, or structured reports."
allowed-tools: read, write, grep, glob, task
---

# Documentation Generation Skill

## Purpose
Generate comprehensive, templated documentation from expert analysis with complete source traceability and professional structure. **Source references are included by default.**

## When to Activate
- User wants "documentation", "workflow guide", "technical docs", "comprehensive report"
- Need structured, templated output with cross-references
- Source traceability and citations required
- Professional documentation needed from analysis
- Workflow documentation or implementation guides

**Key Triggers**: documentation, document, workflow guide, technical docs, report, structured output, comprehensive guide

## Default Behaviors

### Source References (Always Included)
All generated documentation **automatically includes**:
1. **Source Index**: Master reference list in `sources/references/source_index.md`
2. **Inline Citations**: `[^1]`, `[^2]` style citations throughout the document
3. **References Section**: Full bibliography at the end of each document
4. **Source Attribution**: Each key claim linked to its source

### Source Reference Format
```markdown
## References

[^1]: **YouTube**: "Video Title" by Channel Name. [Watch](https://youtube.com/...). Accessed: 2025-12-17.
[^2]: **Website**: "Article Title" from domain.com. [Read](https://...). Accessed: 2025-12-17.
[^3]: **PDF**: Document Title. Page X. Located in `sources/pdfs/filename.pdf`.
[^4]: **GitHub**: Repository/File description. [Source](https://github.com/...).
```

### Output Location
All artifacts are stored within the `sources/` folder:
- Parsed content: `sources/ingested/`
- Knowledge base: `sources/knowledge_base/`
- References: `sources/references/`
- All artifacts: `sources/artifacts/`

## Available Templates

1. **Technical Workflow Documentation** (Template 1)
   - For AI/ML and technical content
   - Includes code examples, implementation guides
   - Technical cross-references and best practices

2. **Clinical Workflow Documentation** (Template 2)
   - For healthcare and clinical content
   - Includes care pathways, safety protocols
   - Regulatory compliance and traceability matrix

3. **Research Summary Documentation** (Template 3)
   - For comprehensive research synthesis
   - Includes methodology, findings, applications
   - Source references and practical implications

## How to Use This Skill

### Step 1: Receive Input
Accept analyzed content from:
- `@research-ai-expert` (technical analysis)
- `@research-clinical-expert` (clinical analysis)
- Expert agents (research summaries)
- `@research-doc-parser` (parsed structure)

### Step 2: Select Template
Choose appropriate template based on:
- Content domain (AI/Clinical/Research)
- Output purpose (workflow/guide/summary)
- Audience requirements

### Step 3: Generate Documentation
- Preserve source heading structure
- Create cross-reference tables
- Add section mappings with page numbers
- Include traceability matrix
- Add examples (code/clinical procedures)
- Generate complete citations

### Step 4: Quality Assurance
- Verify all source headings preserved
- Validate cross-references
- Check citation completeness
- Ensure template compliance
- Confirm output location

## Key Features
- Source document structure preservation
- Complete heading hierarchy integration
- Cross-reference table creation
- Section mapping with page numbers
- Traceability matrix generation
- Evidence-based organization
- Template-based consistency

## Integration
- Receives from: Expert agents + doc-parser
- Outputs to: `@research-doc-formatter`
- Ensures: All source headings preserved and referenced
- Works with: All analysis skills for comprehensive documentation

## See Also
- Agent: @research-doc-generator
- Templates: Defined in agent file (.claude/agents/research-doc-generator.md)
- Reference: reference.md for template usage guidelines
