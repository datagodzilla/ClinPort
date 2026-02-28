---
name: document-parsing
description: "Parse documents to extract structure, headings, content, and metadata from PDF, DOCX, PPTX, XLSX, images, audio, HTML, and ZIP files. Use Markitdown for format conversion. Activate when user mentions parse, extract, document structure, or provides files for analysis."
allowed-tools: read, write, grep, glob, task
---

# Document Parsing Skill

## Purpose
Expert document parsing specialist that extracts, analyzes, and structures information from various document formats, with primary focus on preserving complete heading hierarchy for downstream analysis.

## When to Activate This Skill

Claude should activate this skill when the user:
- Mentions "parse", "extract", "analyze document", "get structure"
- Wants to "extract headings", "get sections", "find structure"
- Provides document files for processing
- Needs "document breakdown", "content extraction"
- Wants metadata, tables, or figures extracted
- Mentions any supported file format for analysis

**Key Triggers**: parse, extract, structure, headings, sections, document breakdown, analyze document

## Supported File Formats

### Direct Parsing
- **PDF** - Research papers, reports, technical documentation
- **TEXT/MD** - Plain text, markdown files
- **CSV** - Data tables

### Via Markitdown MCP Integration
- **DOCX/PPTX/XLSX** - Office documents (ALWAYS use Markitdown)
- **JPG/PNG/GIF** - Images with text (OCR via Markitdown)
- **MP3/WAV** - Audio files (transcription via Markitdown)
- **HTML** - Web content (clean conversion via Markitdown)
- **ZIP** - Archives containing multiple files (batch process via Markitdown)

## Core Capabilities

### 1. Document Structure Analysis
- Identify document type (research paper, guideline, spec, etc.)
- Extract hierarchical structure (sections, subsections, headings)
- Recognize key components (abstract, methods, results, conclusions)
- Map relationships between sections

### 2. Heading Extraction (CRITICAL)
**This is the most important responsibility**:
- Extract ALL heading levels (H1, H2, H3, H4, H5, H6)
- Preserve exact text and formatting
- Maintain parent-child hierarchy
- Record page numbers and locations
- Create complete Document Structure Map

**Why Critical**: All downstream agents depend on heading extraction for:
- Referencing source material accurately
- Organizing analyses logically
- Maintaining traceability
- Enabling readers to verify claims

### 3. Content Extraction
- Extract all text content with formatting preservation
- Identify and extract tables, figures, charts
- Capture citations, references, footnotes
- Extract metadata (authors, dates, DOI, version)

### 4. Semantic Understanding
- Identify key concepts and terminology
- Recognize domain-specific language (AI/ML, clinical terms)
- Extract definitions, equations, formulas
- Identify acronyms and expansions

## How to Use This Skill

### Step 1: Pre-Processing & Format Conversion

**Detect File Format**:
```markdown
IF file is DOCX/PPTX/XLSX:
    → ALWAYS use Markitdown to convert to markdown
    → Save to `PDFs/[filename].md`
    → Proceed with markdown parsing

ELSE IF file is JPG/PNG/GIF:
    → ALWAYS use Markitdown for OCR
    → Extract text to `PDFs/[filename].md`
    → Proceed with markdown parsing

ELSE IF file is MP3/WAV:
    → Use Markitdown for transcription
    → Save transcript to `PDFs/[filename].md`
    → Proceed with markdown parsing

ELSE IF file is HTML:
    → Use Markitdown to clean and convert
    → Save to `PDFs/[filename].md`
    → Proceed with markdown parsing

ELSE IF file is ZIP:
    → Use Markitdown to process archive
    → Save combined output to `PDFs/[filename].md`
    → Proceed with markdown parsing

ELSE IF file is PDF AND parsing difficult:
    → Try Markitdown as alternative
    → Save to `PDFs/[filename].md`
    → Proceed with markdown parsing

ELSE:
    → Proceed directly to extraction (already parseable)
```

### Step 2: Extraction Phase

**Extract Complete Content**:
1. Read document thoroughly
2. Identify all headings and their levels
3. Extract full text under each heading
4. Capture tables and figures with descriptions
5. Extract all metadata
6. Identify key terminology

### Step 3: Create Document Structure Map

**Generate Complete Heading Hierarchy**:
```markdown
## Document Structure Map

### Complete Heading Hierarchy

1. [H1] Introduction (Page 1)
   - **Content summary**: [1-2 sentences]

   1.1 [H2] Background (Page 1)
       - **Content summary**: [1-2 sentences]

   1.2 [H2] Research Objectives (Page 2)
       - **Content summary**: [1-2 sentences]

       1.2.1 [H3] Primary Objectives (Page 2)
             - **Content summary**: [1-2 sentences]

[Continue for ALL headings...]

### Heading Statistics
- **Total Headings**: [count]
- **H1 Level**: [count]
- **H2 Level**: [count]
- **H3 Level**: [count]
- **Maximum Nesting Depth**: [number]

### Section Navigation Guide
- **Clinical Sections**: [List]
- **Technical Sections**: [List]
- **Mixed Sections**: [List]
```

### Step 4: Generate Structured Output

Create comprehensive parsed output with:
- Document metadata block
- Document summary
- Key information section
- **Document Structure Map** (CRITICAL - see above)
- Extracted content organized by sections
- References and citations
- Extracted terminology
- Parsing notes

### Step 5: Save Output

Save to: `PDFs/parsed/[filename]_parsed.md`

## Output Format

```markdown
# DOCUMENT PARSING REPORT

## Document Metadata
- **Original Filename**: [filename]
- **Document Type**: [type]
- **Pages/Length**: [count]
- **Date Parsed**: [YYYY-MM-DD]
- **Parser Version**: 1.0
- **Conversion Method**: [Markitdown/Direct/None]

## Document Summary
[Brief 2-3 sentence overview]

## Key Information
- **Primary Topic**: [topic]
- **Domain**: [AI/Clinical/Mixed]
- **Target Audience**: [audience]
- **Document Purpose**: [purpose]

## Document Structure Map
[CRITICAL SECTION - Complete heading hierarchy as shown in Step 3]

## Extracted Content

### Section 1: [Title]
[Full text content]

**Key Concepts**: [list]
**Important Terms**: [list]
**Figures/Tables**: [descriptions]

[Continue for all sections...]

## References & Citations
[All references]

## Extracted Terminology
[Alphabetical list of key terms]

## Extraction Notes
[Parsing challenges, recommendations]
```

## Integration with Other Skills

**Downstream Consumers** (skills that use your output):
- `ai-technical-analysis` - Uses your heading hierarchy for technical workflows
- `clinical-analysis` - Uses your heading hierarchy for clinical workflows
- `mindmap-creation` - Uses your headings as node labels
- `documentation-generation` - Uses your structure for organizing documentation
- `blog-publishing` - Uses your headings for citations

**Your heading extraction is the foundation for all downstream analysis.**

## Quality Assurance Checklist

Before finalizing output:
- [ ] All visible headings extracted (checked against source)
- [ ] Hierarchy preserved correctly (parent-child intact)
- [ ] Page numbers accurate for all headings
- [ ] Exact text captured (no paraphrasing)
- [ ] Content summaries provided for each heading
- [ ] No headings skipped or missed
- [ ] Heading statistics calculated correctly
- [ ] Structure map formatted clearly
- [ ] Section navigation guide completed
- [ ] Document metadata complete
- [ ] Parsing notes include conversion method used

## Special Handling Cases

### No Clear Headings
If document lacks formal headings:
- Create logical section divisions based on content
- Note in extraction notes: "No formal headings - structure inferred"
- Use topic sentences or paragraph breaks as markers
- Clearly indicate these are inferred, not original

### Inconsistent Hierarchy
If heading levels skip or are inconsistent:
- Preserve as found in original (document reality over ideal)
- Note inconsistency in extraction notes
- Suggest normalized structure for generated outputs
- Maintain original numbering/labeling system

### Very Long Documents (>50 pages)
For extensive documents:
- Extract all headings (don't skip for length)
- Consider grouping by major sections (Parts, Chapters)
- May abbreviate content summaries to 1 sentence
- Note document length in parsing notes

### Complex Formatting
For unusual structures:
- Note formatting in extraction notes
- Preserve original numbering schemes (Roman numerals, letters, etc.)
- Document special formatting in content summaries
- Maintain any color-coding in text descriptions

## Best Practices

1. **Accuracy First**: Preserve original content exactly as written
2. **Complete Extraction**: Don't skip sections or headings
3. **Context Preservation**: Maintain relationships between sections
4. **Clear Markers**: Use consistent section markers
5. **Metadata Rich**: Include all available metadata
6. **Error Handling**: Note any parsing issues clearly
7. **Terminology Capture**: Extract all domain-specific terms
8. **Reference Tracking**: Maintain citation integrity

## Limitations

- Parsing quality depends on source document structure
- Scanned/image-based PDFs may require Markitdown OCR
- Some complex layouts may need manual cleanup
- Conversion quality varies by file format
- Very large files (>100 pages) may take longer

## Example Usage

**User**: "Parse this research paper and extract all the sections"

**Claude** (activates this skill):
1. Checks file format → PDF
2. Reads PDF directly (or converts via Markitdown if needed)
3. Extracts complete heading hierarchy (H1-H6)
4. Creates Document Structure Map
5. Extracts all content, tables, figures
6. Generates comprehensive parsing report
7. Saves to `PDFs/parsed/[filename]_parsed.md`
8. Returns summary of extracted structure

**User**: "I have this PowerPoint presentation, can you extract the content?"

**Claude** (activates this skill):
1. Detects PPTX format
2. Uses Markitdown to convert to markdown
3. Saves converted output to `PDFs/presentation.md`
4. Parses markdown content
5. Extracts heading structure and content
6. Generates parsing report with conversion notes
7. Saves to `PDFs/parsed/presentation_parsed.md`

## See Also

- **Agent**: `@research-doc-parser`
- **Reference**: See `reference.md` for detailed parsing workflows
- **MCP Server**: Markitdown for file format conversion
- **Outputs Used By**: All downstream analysis skills
