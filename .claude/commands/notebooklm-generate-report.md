---
argument-hint: "Path to knowledge base or ingested content"
allowed-tools: read, write, bash, task
description: "Generate comprehensive summary report from NotebookLM ingested content"
---

# NotebookLM Generate Report Command


## ⚠️ Argument Required

**Input received:** `$ARGUMENTS`

**If no argument is provided**, display this help information and stop:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NotebookLM Generate Report Command
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

DESCRIPTION:
  Generate comprehensive summary report from NotebookLM ingested content

USAGE:
  /notebooklm-generate-report Path to knowledge base or ingested content

REQUIRED ARGUMENTS:
    Path to knowledge base or ingested content

OPTIONAL ARGUMENTS:
    (none)

EXAMPLES:
  /notebooklm-generate-report ingested/manifest.md
  /notebooklm-generate-report output/omop-cdm/
  /notebooklm-generate-report ingested/ --length detailed

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Run the command with required arguments to proceed.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**If arguments ARE provided**, proceed with the command below.

---
## Purpose
Generate comprehensive summary documentation from NotebookLM-ingested content (YouTube transcripts, web content, documents). Creates a well-structured research report with key findings, insights, and actionable takeaways.

## Input Options

### Option 1: Knowledge Base Manifest
```
/notebooklm-generate-report ingested/manifest.md
```
Summarizes all ingested content from the knowledge base.

### Option 2: Topic Directory
```
/notebooklm-generate-report output/omop-cdm/
```
Summarizes content from a specific topic's output directory.

### Option 3: Specific Content File
```
/notebooklm-generate-report output/ohdsi/knowledge_base/unified_kb.md
```
Summarizes a single knowledge base file.

### Option 4: Ingested Directory
```
/notebooklm-generate-report ingested/
```
Summarizes all content in the ingested directory.

## Execution Workflow

### Phase 1: Content Loading
1. Load source content from specified path
2. Identify all content sources:
   - YouTube transcripts
   - Website content
   - Document content
3. Catalog source metadata

### Phase 2: Content Analysis
1. Identify domain (Clinical/Technical/Mixed)
2. Extract key themes and topics
3. Identify main arguments and findings
4. Note important quotes and statistics
5. Map relationships between concepts

### Phase 3: Summary Generation
Generate comprehensive report with:
- Executive summary (2-3 paragraphs)
- Key findings (bullet points)
- Detailed analysis by topic
- Source attribution
- Practical applications
- Conclusions and takeaways

### Phase 4: Documentation Polish
1. Apply consistent formatting
2. Add proper citations
3. Include source references
4. Generate table of contents

## Output Format

```markdown
---
title: "[Topic] - Research Summary"
type: NotebookLM Summary Report
source_count: [N]
sources:
  youtube: [N]
  websites: [N]
  documents: [N]
generated_date: "YYYY-MM-DD"
domain: "[Clinical/Technical/Mixed]"
word_count: [N]
---

# [Topic] - Research Summary

## Table of Contents
1. [Executive Summary](#executive-summary)
2. [Key Findings](#key-findings)
3. [Detailed Analysis](#detailed-analysis)
4. [Source Overview](#source-overview)
5. [Practical Applications](#practical-applications)
6. [Conclusions](#conclusions)

---

## Executive Summary

[2-3 paragraph high-level overview of the topic, synthesizing insights from all sources. Provides context, main themes, and significance.]

---

## Key Findings

### Finding 1: [Title]
- **Summary**: [1-2 sentence description]
- **Evidence**: [Source reference]
- **Significance**: [Why this matters]

### Finding 2: [Title]
- **Summary**: [1-2 sentence description]
- **Evidence**: [Source reference]
- **Significance**: [Why this matters]

### Finding 3: [Title]
- **Summary**: [1-2 sentence description]
- **Evidence**: [Source reference]
- **Significance**: [Why this matters]

---

## Detailed Analysis

### Topic 1: [Name]

[In-depth analysis of this topic, synthesizing information from multiple sources]

**Key Points:**
- Point 1
- Point 2
- Point 3

**Source References:**
- [Source 1]: [Relevant insight]
- [Source 2]: [Relevant insight]

### Topic 2: [Name]

[In-depth analysis continues...]

---

## Source Overview

### Sources Analyzed

| # | Type | Source | Key Contribution |
|---|------|--------|------------------|
| 1 | YouTube | [Title] | [Main insight] |
| 2 | Website | [URL] | [Main insight] |
| 3 | Document | [File] | [Main insight] |

### Source Quality Assessment
- **Coverage**: [How well sources cover the topic]
- **Consistency**: [Agreement between sources]
- **Gaps**: [Areas needing more information]

---

## Practical Applications

### For Practitioners
1. [Actionable recommendation 1]
2. [Actionable recommendation 2]
3. [Actionable recommendation 3]

### For Researchers
1. [Research direction 1]
2. [Research direction 2]

### For Learners
1. [Learning path recommendation]
2. [Key concepts to master]

---

## Conclusions

### Main Takeaways
1. **[Takeaway 1]**: [Explanation]
2. **[Takeaway 2]**: [Explanation]
3. **[Takeaway 3]**: [Explanation]

### Limitations
- [Limitation 1 of the source material]
- [Limitation 2]

### Next Steps
- [ ] [Recommended action 1]
- [ ] [Recommended action 2]
- [ ] [Recommended action 3]

---

## Appendix

### Glossary
| Term | Definition |
|------|------------|
| [Term 1] | [Definition] |
| [Term 2] | [Definition] |

### Full Source List
1. [Complete source citation 1]
2. [Complete source citation 2]
3. [Complete source citation 3]

---

*Generated by NotebookLM Workflow | Research Hub Profile*
```

## Output Structure

```
output/[topic]/reports/
├── [topic]_summary.md              # Main summary report
├── [topic]_executive_summary.md    # Executive summary only
├── [topic]_key_findings.md         # Key findings extracted
└── [topic]_source_analysis.md      # Detailed source analysis
```

## Integration with NotebookLM Workflow

### Part of Full Pipeline
This command generates the "Document Report" artifact in `/notebooklm-generate-all`:
```
/notebooklm-generate-all sources.md
→ Phase 3: Parallel Artifact Generation
  → /notebooklm-generate-report (this command) → Report
```

### Standalone Usage
```bash
# From ingested content
/notebooklm-generate-report ingested/manifest.md

# From topic directory
/notebooklm-generate-report output/ohdsi/

# Quick summary
/notebooklm-generate-report output/omop-cdm/knowledge_base/unified_kb.md --brief
```

## Summary Types

| Type | Length | Use Case |
|------|--------|----------|
| Brief | 500-1000 words | Quick overview |
| Standard | 2000-3000 words | Comprehensive summary |
| Detailed | 5000+ words | In-depth research report |

## Configuration Options

### Length Control
```
/notebooklm-generate-report content.md --length brief
/notebooklm-generate-report content.md --length detailed
```

### Focus Area
```
/notebooklm-generate-report content.md --focus clinical
/notebooklm-generate-report content.md --focus technical
```

### Output Format
```
/notebooklm-generate-report content.md --format academic
/notebooklm-generate-report content.md --format executive
```

## Usage Examples

### Generate from Knowledge Base
```
/notebooklm-generate-report ingested/manifest.md
```

### Generate Brief Summary
```
/notebooklm-generate-report output/omop-cdm/ --length brief
```

### Generate with Clinical Focus
```
/notebooklm-generate-report ingested/ --focus clinical
```

## Success Criteria

Summary generation complete when:
- [ ] All source content loaded
- [ ] Content analyzed and themes identified
- [ ] Executive summary written
- [ ] Key findings extracted
- [ ] Detailed analysis completed
- [ ] Source attributions included
- [ ] Practical applications listed
- [ ] Conclusions and takeaways provided
- [ ] Files saved to output location

## Example Output

```
📄 Report Generation Complete

📁 Output: output/omop-cdm/reports/omop-cdm_summary.md

📊 Statistics:
- Sources Analyzed: 5
  - YouTube: 2 videos
  - Websites: 2 pages
  - Documents: 1 PDF
- Word Count: 2,847
- Key Findings: 8
- Topics Covered: 5

📑 Sections Generated:
1. Executive Summary (324 words)
2. Key Findings (8 items)
3. Detailed Analysis (5 topics)
4. Source Overview (5 sources)
5. Practical Applications (9 items)
6. Conclusions (3 takeaways)

⏱️ Generation Time: 45 seconds

✅ Summary report ready!

Quick Access:
• Read summary: open output/omop-cdm/reports/omop-cdm_summary.md
• View executive summary: head -50 output/omop-cdm/reports/omop-cdm_summary.md
```

## Uses Skills
- `clinical-analysis` - Clinical content analysis
- `ai-technical-analysis` - Technical content analysis
- `documentation-generation` - Report generation

## Related Commands
- `/notebooklm-ingest-sources` - Ingest sources first
- `/notebooklm-generate-all` - Full artifact pipeline
- `/notebooklm-generate-flashcards` - Study cards from summary
- `/notebooklm-generate-quiz` - Quiz from summary content
