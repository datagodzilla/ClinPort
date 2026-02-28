# Summary Creation Workflow

This workflow guides you through creating high-quality summaries of research papers, articles, and technical documents.

## Workflow Overview

**Purpose**: Transform complex documents into concise, accurate summaries
**Duration**: 30-90 minutes depending on source length and complexity
**Agents Involved**: @research-doc-parser, @research-ai-expert OR @research-clinical-expert, @research-doc-formatter

## Prerequisites

- [ ] Source document accessible (PDF, DOCX, TEXT, etc.)
- [ ] Document domain identified (AI/Clinical/Mixed)
- [ ] Target audience defined
- [ ] Summary type chosen (TL;DR, Executive, Comprehensive)

## Phase 1: Document Parsing

**Responsible**: @research-doc-parser

### Step 1.1: Obtain Source Document
- Verify document format is supported
- Check document readability
- Note document length and complexity

### Step 1.2: Parse Document
- Extract full text content
- Identify document structure (sections, headings)
- Extract metadata (title, authors, date, publication)
- Identify key concepts and terminology
- Note figures, tables, and data

**Output**: Parsed document saved to `PDFs/parsed/[filename]_parsed.md`

### Step 1.3: Domain Classification
- Determine if AI/Technical, Clinical, or Mixed domain
- Note specialized terminology used
- Identify required expertise for analysis

**Decision Point**:
- AI/Technical → Use @research-ai-expert
- Clinical → Use @research-clinical-expert
- Mixed → Use both experts

## Phase 2: Content Analysis

**Responsible**: Domain expert agent(s)

### Step 2.1: Initial Review
- Read parsed document thoroughly
- Identify main thesis or purpose
- Note key sections and structure
- Highlight critical findings
- List important concepts

### Step 2.2: Information Extraction

Extract these elements:
- [ ] Main thesis/research question
- [ ] Methodology (if applicable)
- [ ] Key arguments or findings
- [ ] Supporting evidence (major points only)
- [ ] Conclusions and implications
- [ ] Novel contributions
- [ ] Practical applications
- [ ] Limitations

### Step 2.3: Concept Identification
- List 5-10 most important concepts
- Identify relationships between concepts
- Note technical or clinical terms requiring definition
- Highlight data or statistics worth including

### Step 2.4: Determine Compression Ratio
Based on summary type and source length:
- TL;DR: 5-10% of original
- Executive Summary: 10-15%
- Brief Summary: 15-25%
- Standard Summary: 25-35%
- Comprehensive: 35-50%

**Output**: Analysis notes with extracted information

## Phase 3: Summary Drafting

**Responsible**: Domain expert agent(s)

### Step 3.1: Create TL;DR
Write one paragraph (50-100 words) capturing absolute essence:
- First sentence: What is this about?
- Second sentence: What was found/argued?
- Third sentence: Why does it matter?

### Step 3.2: Draft Main Summary

#### Structure to Follow:
1. **Source Information**
   - Title, authors, publication, date
   - Link/DOI if available

2. **Overview** (2-3 paragraphs)
   - Context and background
   - Purpose of original document
   - Scope of coverage

3. **Key Points** (organized by major topics)
   - Each major section summarized
   - 2-4 sentences per section
   - Key insight highlighted

4. **Main Findings/Arguments**
   - Numbered list of key findings
   - Brief explanation for each
   - Supporting data included

5. **Methodology** (if applicable)
   - Brief description of approach
   - Sample size, study design, or methods
   - Keep to 1 paragraph

6. **Conclusions**
   - Main conclusions from source
   - Implications noted
   - Significance explained

7. **Implications & Applications**
   - Theoretical implications
   - Practical applications
   - Future research directions

8. **Key Takeaways** (5-7 items)
   - Most important lessons
   - Memorable points
   - Actionable insights

### Step 3.3: Verify Accuracy
- [ ] All facts match source
- [ ] No misrepresentation of findings
- [ ] Context preserved
- [ ] Nuance maintained
- [ ] Limitations acknowledged
- [ ] Author's intent preserved

### Step 3.4: Check Compression
- Count words in summary
- Calculate compression ratio
- Verify ratio matches target
- If too long: identify content to cut
- If too short: ensure completeness

**Output**: Draft summary saved to `docs/[topic]/summaries/[filename]_draft.md`

## Phase 4: Quality Review

**Responsible**: Same domain expert agent(s)

### Step 4.1: Accuracy Review
- Verify all facts against source
- Check for any misinterpretation
- Ensure proper attribution
- Confirm data accuracy

### Step 4.2: Completeness Review
- [ ] All major points covered
- [ ] Key findings included
- [ ] Conclusions represented
- [ ] Implications addressed
- [ ] No critical gaps

### Step 4.3: Clarity Review
- [ ] Easy to understand
- [ ] Technical terms defined
- [ ] Logical flow
- [ ] Appropriate for audience
- [ ] No ambiguity

### Step 4.4: Conciseness Review
- [ ] No unnecessary content
- [ ] No redundancy
- [ ] Efficient language
- [ ] Appropriate length
- [ ] Each word earns its place

### Step 4.5: Readability Check
- Run readability analysis
- Target Flesch Reading Ease: 60-70
- Check average sentence length: 15-20 words
- Verify paragraph length: 2-4 sentences
- Adjust if needed

**Decision Point**:
- If issues found → Revise draft → Repeat Step 4
- If quality standards met → Proceed to Phase 5

## Phase 5: Formatting and Polish

**Responsible**: @research-doc-formatter

### Step 5.1: Apply Standard Template
- Add YAML front matter
- Include all metadata fields
- Structure with standard sections
- Apply consistent formatting

### Step 5.2: Format Content Elements
- [ ] Headings properly hierarchical
- [ ] Lists formatted consistently
- [ ] Quotes properly marked
- [ ] Code blocks (if any) styled
- [ ] Links functional
- [ ] Tables formatted

### Step 5.3: Add Enhanced Elements
- Reading time estimate
- Compression ratio calculation
- Keywords list
- Related resources links
- Relevant quotes (if valuable)

### Step 5.4: Visual Polish
- Check spacing and white space
- Ensure consistent styling
- Verify markdown syntax
- Check for typos
- Proofread carefully

**Output**: Final summary saved to `docs/[topic]/summaries/[filename]_summary_final.md`

## Phase 6: Verification and Delivery

### Step 6.1: Final Quality Check
Run through complete checklist:
- [ ] Accurate to source
- [ ] All major points covered
- [ ] Clear and understandable
- [ ] Concise and focused
- [ ] Properly formatted
- [ ] Metadata complete
- [ ] Links working
- [ ] No errors

### Step 6.2: Save and Organize
- Save to appropriate topic folder
- Update any indexes or catalogs
- Create cross-references if needed
- Archive source document reference

### Step 6.3: Create Variants (Optional)
If multiple formats needed:
- Create slide deck version
- Create email-friendly version
- Create social media snippet
- Create expanded version

### Step 6.4: Inform User
Provide completion summary with:
- Location of final summary
- Summary statistics (length, ratio, reading time)
- Quality metrics
- Suggestions for related work

## Success Criteria

Summary is successful when:
- [ ] Accurately represents source
- [ ] Covers all essential points
- [ ] Appropriately compressed
- [ ] Easy to read and understand
- [ ] Properly formatted and structured
- [ ] Meets quality standards
- [ ] Serves target audience needs

## Common Issues and Solutions

### Issue: Source too technical for audience
**Solution**: Increase simplification, add more definitions, use analogies

### Issue: Summary too long
**Solution**:
- Remove examples (keep only best)
- Eliminate redundancy
- Focus on key points only
- Use lists instead of prose

### Issue: Losing important nuance
**Solution**:
- Add brief qualifier
- Include key limitation
- Note context in parenthetical
- Don't oversimplify to point of error

### Issue: Unclear how to structure
**Solution**:
- Follow source structure
- Use standard template
- Group related points
- Put most important first

### Issue: Domain expertise insufficient
**Solution**:
- Consult additional experts
- Reference authoritative sources
- Note areas of uncertainty
- Suggest expert review

## Time Estimates

- **Short article (1,000-2,000 words)**: 30-45 minutes
- **Research paper (5,000-8,000 words)**: 60-90 minutes
- **Technical documentation (10,000+ words)**: 90-120 minutes
- **Book chapter (5,000-10,000 words)**: 60-90 minutes

Add time for:
- Unfamiliar domain: +50%
- Complex technical content: +25%
- Clinical content requiring verification: +25%
- Multiple source synthesis: +50-100%

## Tips for Efficiency

1. **First pass**: Quick skim to understand structure
2. **Second pass**: Detailed read with note-taking
3. **Template use**: Start with template, fill in sections
4. **Progressive refinement**: Draft quickly, then refine
5. **Checklists**: Use quality checklists to catch issues
6. **Batch processing**: Do similar summaries together
7. **Reuse patterns**: Build library of phrases and structures

## Related Workflows

- [Mind Map Creation Workflow](mindmap-workflow.md) - For visual summaries
- [Blog Publishing Workflow](blog-publishing-workflow.md) - For public-facing summaries
- [Document Formatting Workflow](document-formatting-workflow.md) - For advanced formatting

## Version History

- **v1.0.0** (2025-11-08): Initial workflow creation
