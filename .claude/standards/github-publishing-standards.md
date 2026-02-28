# GitHub Pages Publishing Standards

## Purpose
Define standards for publishing blog posts to GitHub Pages to ensure consistency, quality, and successful deployment.

## Scope
These standards apply to all blog posts published via the `@research-github-publisher` agent and `/research-github-publisher` command.

---

## 1. Content Standards

### 1.1 Attribution Rules

**NEVER include in published content**:
- "Generated with Claude Code"
- "Co-Authored-By: Claude"
- "🤖" or any AI/robot emojis
- "AI-generated" or similar disclaimers
- References to agents or automation tools

**NEVER include in commit messages**:
- Co-Authored-By tags
- "Generated with" text
- AI attribution of any kind
- Bot/robot references

### 1.2 Content Quality

**Required**:
- Proper heading hierarchy (H1 → H2 → H3)
- Valid markdown syntax
- Working links (internal and external)
- Proper code block formatting
- Clear, readable prose

**Prohibited**:
- Broken links
- Placeholder text
- Development comments
- Internal system paths
- Sensitive information

### 1.3 Sensitive Information

**Never publish**:
- API keys or secrets
- Personal identifiable information (PII)
- Internal IP addresses or paths
- Credentials or tokens
- Private repository references

---

## 2. Jekyll Frontmatter Standards

### 2.1 Required Fields

```yaml
---
layout: post
title: '[Title]'
date: YYYY-MM-DD HH:MM:SS
---
```

### 2.2 Recommended Fields

```yaml
---
layout: post
comments: true
title: '[SEO-friendly title, 50-60 chars]'
excerpt: '[Description, 150-160 chars]'
date: YYYY-MM-DD HH:MM:SS
mathjax: false
---
```

### 2.3 Optional Fields

```yaml
categories: [category1, category2]
tags: [tag1, tag2, tag3]
author: [Author Name]
image: /assets/images/post-image.jpg
```

### 2.4 Field Specifications

| Field | Max Length | Format | Required |
|-------|------------|--------|----------|
| title | 60 chars | String in quotes | Yes |
| excerpt | 160 chars | String in quotes | Recommended |
| date | - | YYYY-MM-DD HH:MM:SS | Yes |
| layout | - | post | Yes |
| comments | - | true/false | Recommended |
| categories | - | Array | Optional |
| tags | - | Array | Optional |

---

## 3. Filename Standards

### 3.1 Format
```
YYYY-MM-DD-title-slug.md
```

### 3.2 Rules

| Rule | Specification |
|------|---------------|
| Date | YYYY-MM-DD format (publication date) |
| Separator | Single hyphen between date and slug |
| Slug | Lowercase, hyphen-separated |
| Characters | Alphanumeric and hyphens only |
| Length | Max 50 chars for slug portion |
| Extension | .md |

### 3.3 Examples

Good:
```
2025-11-30-Understanding-FHIR-APIs.md
2025-12-01-Clinical-Decision-Support-Guide.md
2025-12-05-HL7-Message-Anatomy.md
```

Bad:
```
blog_post.md                    # No date
2025-11-30-My Really Long Title That Goes On Forever.md  # Too long
2025/11/30-title.md            # Wrong date separator
Post About APIs.md              # Spaces, no date
```

---

## 4. Commit Message Standards

### 4.1 Format

```
Add blog post: [Short Title]

[Brief description of content - 1-2 sentences]

Topics covered:
- Topic 1
- Topic 2
- Topic 3
```

### 4.2 Title Line Rules

| Rule | Specification |
|------|---------------|
| Prefix | "Add blog post:" |
| Length | Max 72 characters total |
| Case | Title case for post name |
| Punctuation | No period at end |

### 4.3 Body Rules

- Blank line after title
- Brief description (1-2 sentences)
- List of topics (3-5 items)
- No AI attribution

### 4.4 Examples

Good:
```
Add blog post: Understanding Healthcare Interoperability

Comprehensive guide to FHIR, HL7, LOINC, and SNOMED CT standards
for clinical data exchange.

Topics covered:
- HL7 v2.x message structure
- FHIR resource mapping
- LOINC code integration
```

Bad:
```
Added new post

🤖 Generated with Claude Code

Co-Authored-By: Claude <noreply@anthropic.com>
```

---

## 5. Git Operations Standards

### 5.1 Branch Rules

| Operation | Standard |
|-----------|----------|
| Default push | main or master (detect from repo) |
| Force push | NEVER to main/master |
| Branch naming | feature/post-title (if needed) |

### 5.2 Authentication

- Use `gh` CLI for all git operations
- Never store credentials in files
- Use `gh auth setup-git` for credential helper

### 5.3 Safety Rules

- Never force push to protected branches
- Always verify repository before push
- Create PR if direct push fails
- Never modify .git directory

---

## 6. Repository Structure Standards

### 6.1 Required Structure

```
repository/
├── _config.yml     # Jekyll configuration
├── _posts/         # Blog posts directory
└── index.html/md   # Site index
```

### 6.2 Recommended Structure

```
repository/
├── _config.yml
├── _posts/
│   └── YYYY-MM-DD-title.md
├── _layouts/
├── _includes/
├── assets/
│   └── images/
│       └── posts/
└── index.html
```

### 6.3 Post Location

Always place posts in `_posts/` directory at repository root.

---

## 7. Deployment Verification Standards

### 7.1 Build Verification

After push, verify:
- [ ] GitHub Actions build triggered
- [ ] Build completed successfully
- [ ] No Jekyll errors in logs

### 7.2 URL Verification

Check published URL:
- [ ] URL is accessible (HTTP 200)
- [ ] Content renders correctly
- [ ] Images load properly
- [ ] Links work

### 7.3 Timing

- Wait 1-2 minutes after push
- Retry verification if initial check fails
- Report failure after 5 minutes

---

## 8. Error Handling Standards

### 8.1 Authentication Errors

```
Error: Authentication failed
Action: Guide user to run `gh auth login`
Recovery: Re-authenticate and retry
```

### 8.2 Push Errors

```
Error: Push rejected
Action: Check branch protection
Recovery: Create PR instead of direct push
```

### 8.3 Build Errors

```
Error: Jekyll build failed
Action: Check build logs
Recovery: Fix errors and push again
```

### 8.4 General Recovery

1. Diagnose specific error
2. Provide clear explanation
3. Offer recovery options
4. Guide through solution

---

## 9. Quality Checklist

### Pre-Publish
- [ ] Content reviewed and complete
- [ ] AI attribution removed
- [ ] Markdown syntax valid
- [ ] Links verified
- [ ] No sensitive information

### Frontmatter
- [ ] layout: post
- [ ] title: valid and SEO-friendly
- [ ] date: correct format
- [ ] excerpt: 150-160 chars

### Filename
- [ ] Date prefix correct
- [ ] Slug is lowercase
- [ ] Hyphens as separators
- [ ] .md extension

### Commit
- [ ] Professional message
- [ ] No AI attribution
- [ ] Topics listed
- [ ] Under 72 char title

### Post-Publish
- [ ] Build successful
- [ ] URL accessible
- [ ] Content renders
- [ ] User notified

---

## 10. Compliance

All publishing operations MUST:
1. Follow these standards
2. Remove AI attribution
3. Use professional commit messages
4. Verify deployment success
5. Report results to user

Non-compliance will result in failed publishing operations.
