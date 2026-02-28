# Slide Deck Standards

## Overview
Standards for creating presentation slide decks in Marp/reveal.js compatible Markdown format.

## Slide Structure

### Deck Organization
```
1. Title Slide (1)
2. Agenda/Overview (1)
3. Introduction/Context (1-2)
4. Main Content (10-20 slides)
5. Key Takeaways (1)
6. Q&A / Discussion (1)
7. References/Resources (1)
```

### Slide Count Guidelines
- 5-minute talk: 5-8 slides
- 15-minute talk: 12-18 slides
- 30-minute talk: 25-35 slides
- Rule of thumb: 1-2 minutes per slide

## Marp Formatting

### Frontmatter
```yaml
---
marp: true
theme: default
paginate: true
header: 'Presentation Title'
footer: 'Author Name | Date'
style: |
  section {
    font-size: 28px;
  }
  h1 {
    color: #2d3748;
  }
---
```

### Slide Separators
```markdown
---

# New Slide Title

Content here

---

# Another Slide
```

### Speaker Notes
```markdown
---

# Slide Title

Content visible to audience

<!--
Speaker notes here - not shown in presentation
Key points to mention:
- Point 1
- Point 2
-->
```

## Content Guidelines

### Text Per Slide
- Maximum 6 bullet points
- Maximum 6-8 words per bullet
- One main idea per slide
- Use sentence fragments, not paragraphs

### Visual Hierarchy
```markdown
# Main Title (use sparingly)
## Section Header (primary heading per slide)
### Subsection (secondary emphasis)

- Bullet point (main content)
  - Sub-bullet (supporting detail)
```

### Code Blocks
```markdown
## Code Example

​```sql
SELECT person_id, condition_concept_id
FROM condition_occurrence
WHERE condition_concept_id = 201826;
​```
```

### Tables
```markdown
## Comparison

| Feature | OMOP v5.3 | OMOP v5.4 |
|---------|-----------|-----------|
| Episodes | No | Yes |
| Note_NLP | Limited | Enhanced |
```

### Images and Diagrams
```markdown
## Architecture

![width:800px](./images/omop-cdm-diagram.png)

<!-- Use Mermaid for inline diagrams -->
```

## OHDSI Presentation Guidelines

### Standard Sections for OHDSI Talks
1. **Problem Statement** - Clinical question being addressed
2. **Data Sources** - Networks, databases, patient counts
3. **Methods** - Study design, cohort definitions
4. **Results** - Findings with visualizations
5. **Discussion** - Implications, limitations
6. **Next Steps** - Future work, resources

### Required Elements
- OHDSI community attribution
- Data source acknowledgments
- Conflict of interest disclosure
- Network study identifiers (if applicable)

### Visualization Standards
- Use consistent color schemes
- Include legends for all charts
- Show confidence intervals where applicable
- Note sample sizes on all figures

## Reveal.js Compatibility

### Additional Frontmatter for Reveal.js
```yaml
---
title: "Presentation Title"
theme: white
transition: slide
---
```

### Fragment Animations
```markdown
<!-- Reveal.js fragments -->
- Point 1 <!-- .element: class="fragment" -->
- Point 2 <!-- .element: class="fragment" -->
- Point 3 <!-- .element: class="fragment" -->
```

### Vertical Slides
```markdown
---

## Main Topic

---v

### Subtopic 1

---v

### Subtopic 2

---
```

## Quality Checklist

### Per Slide
- [ ] One main idea only
- [ ] Maximum 6 bullet points
- [ ] Minimal text, maximal clarity
- [ ] Consistent formatting
- [ ] Speaker notes included
- [ ] Images have alt text

### Per Deck
- [ ] Logical flow and narrative
- [ ] Consistent visual theme
- [ ] Title and closing slides
- [ ] Appropriate slide count for time
- [ ] All code blocks syntax highlighted
- [ ] References included
- [ ] Marp/Reveal.js syntax valid

## Export Commands

### Marp CLI
```bash
# PDF export
marp --pdf presentation.md -o presentation.pdf

# HTML export
marp presentation.md -o presentation.html

# PowerPoint export
marp --pptx presentation.md -o presentation.pptx
```

### Reveal.js
```bash
# Serve locally
npm start

# Build static HTML
npm run build
```

## Anti-Patterns

### Avoid
- Wall of text slides
- Reading slides verbatim
- Tiny fonts for "fitting more"
- Excessive animations
- Inconsistent formatting
- Missing speaker notes
- No clear takeaways
