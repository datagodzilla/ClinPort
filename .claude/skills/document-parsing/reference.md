# Document Parsing - Detailed Reference Guide

## Markitdown Integration Guide

### When to Use Markitdown

**ALWAYS Use**:
- DOCX, PPTX, XLSX files → Best conversion to markdown
- Images (JPG, PNG, GIF) → Only way to extract text
- MP3, WAV audio → Only way to transcribe
- ZIP archives → Batch processing multiple files

**Optional Use**:
- PDF files → Use when native parsing fails or PDF is scanned/complex
- HTML files → Use to clean web content and remove formatting artifacts

**Never Needed**:
- Markdown (.md) files → Already in correct format
- Plain text (.txt) files → Already parseable
- CSV files → Direct parsing works fine

### Markitdown Conversion Workflow

```markdown
1. Identify File Extension
   ↓
2. Determine if Markitdown needed
   ↓
3. Call Markitdown MCP tool
   ↓
4. Receive markdown output
   ↓
5. Save to PDFs/[filename].md
   ↓
6. Proceed with standard parsing
```

## Heading Extraction Best Practices

### Why Heading Extraction is Critical

Every downstream skill depends on your heading hierarchy:

| Skill | How It Uses Your Headings |
|-------|---------------------------|
| `ai-technical-analysis` | Maps workflow phases to your headings, cites sections in technical docs |
| `clinical-analysis` | Maps clinical procedures to your headings, creates traceability matrix |
| `mindmap-creation` | Uses your headings as node labels and structure |
| `documentation-generation` | Organizes content by your heading structure, creates cross-reference tables |
| `blog-publishing` | Cites your headings throughout blog post, uses for citations |

**If you miss headings or get hierarchy wrong, all downstream artifacts lose traceability.**

### Extraction Techniques by Format

#### PDF Documents
- Identify headings by: font size, weight, formatting, position
- Look for numbered sections (1., 1.1, 1.1.1)
- Check table of contents for heading structure
- Note page numbers for each heading
- Watch for: multi-column layouts, headers/footers (don't confuse with headings)

#### Word Documents (DOCX - via Markitdown)
- Markitdown preserves built-in heading styles
- Look for # ## ### in converted markdown
- Hierarchy is usually well-preserved
- Page numbers may not be available (note this limitation)

#### Presentations (PPTX - via Markitdown)
- Slide titles become H1 or H2 headings
- Bullet points may become lower-level headings
- Hierarchy may be flat (many H1s)
- No traditional page numbers (use slide numbers instead)

#### Images (via Markitdown OCR)
- OCR extracts text - identify larger/bold text as headings
- Infer hierarchy from font size and positioning
- Note approximate location on image
- Quality depends on OCR accuracy

#### Markdown/Text
- Look for # ## ### markdown headers
- Look for underlined headings (=== or ---)
- Recognize numbered hierarchies
- Usually most reliable format

### Document Structure Map Template

```markdown
## Document Structure Map

### Complete Heading Hierarchy

[Use actual numbers from document, not renumbered]

1. [H1] Introduction (Page 1)
   - **Content summary**: Brief overview of what this section covers

   1.1 [H2] Background and Motivation (Page 1-2)
       - **Content summary**: Why this research was conducted

       1.1.1 [H3] Previous Work (Page 2)
             - **Content summary**: Related research and gaps

   1.2 [H2] Research Objectives (Page 3)
       - **Content summary**: Specific goals of this study

2. [H1] Methods (Page 4)
   - **Content summary**: Research methodology overview

   2.1 [H2] Study Design (Page 4-5)
       - **Content summary**: How the study was structured

   2.2 [H2] Data Collection (Page 5-6)
       - **Content summary**: Methods for gathering data

       2.2.1 [H3] Participants (Page 6)
             - **Content summary**: Who was included

       2.2.2 [H3] Instruments (Page 6-7)
             - **Content summary**: Tools and measures used

[Continue for ALL headings in document]

### Heading Statistics
- **Total Headings**: 45
- **H1 Level**: 6
- **H2 Level**: 18
- **H3 Level**: 21
- **H4 Level**: 0
- **H5 Level**: 0
- **H6 Level**: 0
- **Maximum Nesting Depth**: 3

### Section Navigation Guide
- **Clinical Sections**:
  * "2. Methods > 2.1 Study Design"
  * "3. Results > 3.2 Clinical Outcomes"
  * "4. Discussion > 4.1 Clinical Implications"

- **Technical Sections**:
  * "2. Methods > 2.3 Data Analysis"
  * "3. Results > 3.1 Statistical Findings"

- **Mixed Sections**:
  * "1. Introduction"
  * "4. Discussion"
  * "5. Conclusions"
```

## Content Extraction Guidelines

### Tables
```markdown
**Table 1**: [Caption/Title] (Page X)

| Column 1 | Column 2 | Column 3 |
|----------|----------|----------|
| Data     | Data     | Data     |

**Key Insights**: [What this table shows]
```

### Figures
```markdown
**Figure 1**: [Caption] (Page X)

**Description**: [What the figure depicts]

**Key Insights**: [What we learn from this]
```

### Equations
```markdown
**Equation 1**: (Page X)

[Mathematical notation or description]

**Where**:
- Variable 1 = Definition
- Variable 2 = Definition

**Significance**: [What this equation represents]
```

### Code Blocks
```markdown
**Code Example 1**: [Title] (Page X)

\`\`\`language
[Actual code]
\`\`\`

**Purpose**: [What this code does]
**Key Concepts**: [Programming concepts demonstrated]
```

## Metadata Extraction

### Essential Metadata
```markdown
## Document Metadata
- **Original Filename**: paper.pdf
- **Title**: [Extract from document]
- **Authors**: [List all authors]
- **Publication Date**: [YYYY-MM-DD if available]
- **DOI/ISBN**: [If available]
- **Version**: [If specified]
- **Document Type**: Research Paper / Technical Report / Clinical Guideline / etc.
- **Pages/Length**: 15 pages
- **Date Parsed**: 2025-11-19
- **Parser Version**: 1.0
- **Conversion Method**: Direct PDF Parsing / Markitdown Conversion / etc.
```

### Optional Metadata (if available)
- Journal/Conference name
- Volume/Issue numbers
- Keywords
- Abstract
- Citation count
- License information

## Domain Detection

Classify document domain for routing to appropriate expert skills:

### AI/Technical Indicators
- Keywords: algorithm, model, training, neural network, transformer, CNN, RNN
- Technical diagrams and architectures
- Code examples
- Mathematical formulations
- Performance metrics (accuracy, precision, recall)
- Implementation details

### Clinical Indicators
- Keywords: patient, treatment, diagnosis, clinical, medical, healthcare
- Clinical workflows and pathways
- Medical terminology (ICD, SNOMED, LOINC)
- Patient outcomes
- Regulatory considerations
- Safety protocols

### Mixed Domain
- Contains both technical and clinical content
- Healthcare AI/ML applications
- Medical imaging algorithms
- Clinical decision support systems
- EHR system implementations

## Quality Control Checklist

### Before Saving Parsed Output

**Structure Verification**:
- [ ] All headings extracted from source
- [ ] Hierarchy matches original document
- [ ] Page numbers accurate
- [ ] No headings duplicated or missing

**Content Verification**:
- [ ] All sections have content
- [ ] Tables captured with structure
- [ ] Figures described
- [ ] References complete
- [ ] Special formatting noted

**Metadata Verification**:
- [ ] Document type identified
- [ ] Authors captured
- [ ] Date information included
- [ ] Conversion method noted

**Output Verification**:
- [ ] Saved to correct location (PDFs/parsed/)
- [ ] Filename follows convention ([original]_parsed.md)
- [ ] Markdown formatting valid
- [ ] Structure map complete
- [ ] Terminology list included

## Common Issues and Solutions

### Issue: Scanned PDF with No Selectable Text
**Solution**:
1. Use Markitdown for OCR conversion
2. Note in parsing report: "Source was scanned PDF, used Markitdown OCR"
3. Review OCR output for accuracy
4. Flag any obvious OCR errors in parsing notes

### Issue: Complex Multi-Column Layout
**Solution**:
1. Extract column by column
2. Reconstruct logical reading order
3. Note layout complexity in parsing notes
4. Consider Markitdown conversion if native parsing struggles

### Issue: Embedded Images with Important Text
**Solution**:
1. Extract images separately
2. Use Markitdown OCR on images
3. Integrate image text into appropriate sections
4. Note image locations in content summaries

### Issue: Tables Spanning Multiple Pages
**Solution**:
1. Combine table parts
2. Note page range in table caption
3. Preserve complete table structure
4. Indicate "continued from previous page" if needed

### Issue: Mixed Languages
**Solution**:
1. Extract all languages as-is
2. Note language changes in content summaries
3. Provide English translation in notes if possible
4. Flag for user review if translation needed

### Issue: Corrupted or Damaged File
**Solution**:
1. Attempt Markitdown conversion as fallback
2. Try opening in different readers
3. Extract whatever is salvageable
4. Clearly note corruption in parsing report
5. Request clean copy from user

## Performance Tips

### For Large Documents (>50 pages)
- Process in chunks if needed
- Abbreviate content summaries to 1 sentence
- Focus on heading hierarchy quality
- Note processing time in parsing report

### For Multiple Documents
- Parse each separately
- Create master index of all parsed docs
- Cross-reference related content
- Note relationships between documents

### For Quick Parsing
- Prioritize heading extraction
- Abbreviated content summaries acceptable
- Skip detailed terminology extraction if time-constrained
- Always include structure map (non-negotiable)

## Integration Testing

Verify your parsed output works for downstream skills:

1. **Test with ai-technical-analysis**:
   - Can it map workflow phases to your headings?
   - Are page numbers accessible for citations?

2. **Test with clinical-analysis**:
   - Can it create traceability matrix from your structure?
   - Are clinical sections clearly identified?

3. **Test with mindmap-creation**:
   - Can it use your heading hierarchy for nodes?
   - Is nesting depth reasonable for visualization?

4. **Test with documentation-generation**:
   - Can it create cross-reference tables?
   - Is section mapping clear and complete?

If any downstream skill struggles with your output, revisit your heading extraction and structure map.
