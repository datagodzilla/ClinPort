# GitHub Pages Post Template

## Purpose
Template for formatting blog posts for GitHub Pages/Jekyll publication.

## Usage
Apply this template when formatting content for GitHub Pages publishing via `@research-github-publisher`.

---

## Template Structure

```markdown
---
layout: post
comments: true
title: '[TITLE: SEO-friendly, 50-60 characters]'
excerpt: '[EXCERPT: Compelling description, 150-160 characters]'
date: [DATE: YYYY-MM-DD HH:MM:SS]
mathjax: false
---

[HOOK: Attention-grabbing opening paragraph that immediately engages the reader and establishes relevance. Should create curiosity or promise value.]

---

## [SECTION 1: Primary Topic]

[Content with clear explanations, examples, and practical information]

### [Subsection if needed]

[Detailed content]

**Key Point**: [Important takeaway highlighted]

## [SECTION 2: Supporting Topic]

[Content that builds on Section 1]

| [Table Header 1] | [Table Header 2] | [Table Header 3] |
|------------------|------------------|------------------|
| [Data] | [Data] | [Data] |

## [SECTION 3: Practical Application]

[How readers can apply this information]

```code
// Code example if applicable
example code here
```

## Key Takeaways

1. [Main lesson 1]
2. [Main lesson 2]
3. [Main lesson 3]

## Conclusion

[Summary paragraph that reinforces main points and provides closure]

[Call to action or next steps for readers]

---

## Further Reading

- [Related article or resource 1]
- [Related article or resource 2]

---

*[Optional: Author note or invitation to comment]*
```

---

## Field Specifications

### Frontmatter Fields

| Field | Type | Max Length | Required | Notes |
|-------|------|------------|----------|-------|
| layout | string | - | Yes | Always "post" |
| comments | boolean | - | No | Enable Disqus comments |
| title | string | 60 chars | Yes | SEO-friendly, in quotes |
| excerpt | string | 160 chars | Recommended | For previews/meta description |
| date | datetime | - | Yes | YYYY-MM-DD HH:MM:SS |
| mathjax | boolean | - | No | Enable math rendering |
| categories | array | - | No | Topic categories |
| tags | array | - | No | Keywords for discovery |

### Content Sections

| Section | Purpose | Length |
|---------|---------|--------|
| Hook | Grab attention | 2-3 sentences |
| Main Sections | Core content | 200-400 words each |
| Key Takeaways | Summary points | 3-5 bullets |
| Conclusion | Wrap up | 1-2 paragraphs |
| Further Reading | Resources | 2-4 links |

---

## Filename Convention

```
YYYY-MM-DD-Title-Slug.md
```

**Examples**:
- `2025-11-30-Understanding-Healthcare-Interoperability.md`
- `2025-12-01-FHIR-API-Guide-for-Developers.md`
- `2025-12-05-Clinical-Decision-Support-Systems.md`

**Rules**:
- Date: Current date or scheduled publish date
- Slug: Title converted to URL-friendly format
- Case: Title case or lowercase (consistent with repo)
- Separators: Hyphens only
- Max Length: 50 characters for slug portion

---

## Formatting Guidelines

### Headings
- H1: Page title (in frontmatter, not content)
- H2: Major sections
- H3: Subsections
- H4: Rare, for detailed breakdowns

### Code Blocks
```markdown
```language
code here
```
```

Supported languages: python, javascript, json, bash, yaml, sql, etc.

### Tables
```markdown
| Header 1 | Header 2 |
|----------|----------|
| Data 1   | Data 2   |
```

### Links
```markdown
[Link text](https://url.com)
```

### Images
```markdown
![Alt text](/assets/images/posts/image.png)
```

### Emphasis
- **Bold**: `**text**`
- *Italic*: `*text*`
- `Code`: `` `code` ``

### Lists
```markdown
- Bullet item
- Another item

1. Numbered item
2. Another item
```

---

## Content Checklist

Before applying template:
- [ ] Content is complete and reviewed
- [ ] No AI/agent attribution present
- [ ] All links are valid URLs
- [ ] Images have proper paths
- [ ] Code examples are tested
- [ ] Sensitive info removed

After applying template:
- [ ] Frontmatter is valid YAML
- [ ] Title is 50-60 characters
- [ ] Excerpt is 150-160 characters
- [ ] Date format is correct
- [ ] Headings follow hierarchy
- [ ] Content flows logically

---

## Example: Completed Template

```markdown
---
layout: post
comments: true
title: 'Understanding Healthcare Interoperability Standards'
excerpt: 'A practical guide to FHIR, HL7, LOINC, and SNOMED CT for seamless clinical data exchange between systems.'
date: 2025-11-30 12:00:00
mathjax: false
---

Healthcare systems don't just need to talk—they need to understand each other. This guide explores the standards that make semantic interoperability possible.

---

## The Interoperability Challenge

Modern healthcare generates massive amounts of data across disparate systems...

### Why Standards Matter

Without standardization, a glucose test result from Hospital A might be unrecognizable at Hospital B...

**Key Point**: Interoperability isn't just about data transfer—it's about preserving meaning.

## The Standards Stack

| Standard | Purpose |
|----------|---------|
| HL7 v2.x | Messaging backbone |
| FHIR | Modern API framework |
| LOINC | Test identification |
| SNOMED CT | Clinical semantics |

## Practical Implementation

Here's how to implement a basic FHIR Observation:

```json
{
  "resourceType": "Observation",
  "code": {
    "coding": [{
      "system": "http://loinc.org",
      "code": "2345-7"
    }]
  }
}
```

## Key Takeaways

1. Use LOINC for universal test identification
2. FHIR provides modern API-driven architecture
3. SNOMED CT adds clinical meaning

## Conclusion

Implementing these standards enables systems to reason about data, not just transfer it.

---

## Further Reading

- [HL7 International](https://www.hl7.org)
- [FHIR R4 Specification](https://www.hl7.org/fhir/)

---

*Questions about healthcare interoperability? Drop a comment below.*
```

---

## Notes

- This template is designed for Jekyll/GitHub Pages
- Adjust based on specific repository conventions
- Always verify against existing posts in target repo
- Remove this documentation section before publishing
