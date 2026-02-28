# Playwright Web Extraction Reference

## Quick Reference

### Essential Commands

```javascript
// Navigate to URL
mcp__playwright__browser_navigate({ url: "https://example.com" })

// Wait for element
mcp__playwright__browser_wait_for({ selector: ".content", state: "visible" })

// Take screenshot
mcp__playwright__browser_take_screenshot({ fullPage: true })

// Click element
mcp__playwright__browser_click({ selector: ".button" })

// Execute JavaScript
mcp__playwright__browser_evaluate({ script: "document.title" })

// Get page snapshot
mcp__playwright__browser_snapshot()

// Close browser
mcp__playwright__browser_close()
```

---

## Available Playwright MCP Tools

### Navigation

| Tool | Purpose | Parameters |
|------|---------|------------|
| `browser_navigate` | Go to URL | `url: string` |
| `browser_navigate_back` | Go back | None |
| `browser_tabs` | Manage tabs | Tab operations |
| `browser_close` | Close browser | None |

### Content Capture

| Tool | Purpose | Parameters |
|------|---------|------------|
| `browser_take_screenshot` | Capture image | `selector?`, `fullPage?` |
| `browser_snapshot` | Get accessibility tree | None |
| `browser_evaluate` | Run JavaScript | `script: string` |

### Interaction

| Tool | Purpose | Parameters |
|------|---------|------------|
| `browser_click` | Click element | `selector: string` |
| `browser_type` | Type text | `selector`, `text` |
| `browser_fill_form` | Fill input | `selector`, `value` |
| `browser_press_key` | Keyboard input | `key: string` |
| `browser_hover` | Hover element | `selector: string` |
| `browser_select_option` | Select dropdown | `selector`, `value` |
| `browser_drag` | Drag element | Source, target |
| `browser_file_upload` | Upload file | `selector`, `files` |

### Waiting & State

| Tool | Purpose | Parameters |
|------|---------|------------|
| `browser_wait_for` | Wait for element | `selector`, `state` |
| `browser_handle_dialog` | Handle alerts | Accept/dismiss |
| `browser_console_messages` | Get console logs | None |
| `browser_network_requests` | Monitor network | None |

### Setup

| Tool | Purpose | Parameters |
|------|---------|------------|
| `browser_install` | Install browser | None |
| `browser_resize` | Change viewport | `width`, `height` |

---

## Common Extraction Patterns

### Pattern 1: Extract All Images from Article

```javascript
// Navigate
mcp__playwright__browser_navigate({ url: articleUrl })

// Wait for content
mcp__playwright__browser_wait_for({ selector: "article", state: "visible" })

// Get all image URLs
mcp__playwright__browser_evaluate({
  script: `
    Array.from(document.querySelectorAll('article img')).map(img => ({
      src: img.src,
      alt: img.alt,
      width: img.naturalWidth,
      height: img.naturalHeight
    }))
  `
})

// Screenshot specific diagram
mcp__playwright__browser_take_screenshot({
  selector: ".diagram-container",
  fullPage: false
})
```

### Pattern 2: Extract Code Blocks

```javascript
// Get all code blocks with language
mcp__playwright__browser_evaluate({
  script: `
    Array.from(document.querySelectorAll('pre code, .highlight')).map(el => ({
      code: el.textContent,
      language: el.className.match(/language-(\\w+)/)?.[1] || 'unknown',
      lineCount: el.textContent.split('\\n').length
    }))
  `
})
```

### Pattern 3: Handle Cookie Consent

```javascript
// Common cookie consent selectors
const cookieSelectors = [
  '[id*="cookie"] button[class*="accept"]',
  '.cookie-consent-accept',
  '#onetrust-accept-btn-handler',
  '.cc-accept',
  'button[data-cookiebanner="accept_button"]'
]

// Try each selector
for (const selector of cookieSelectors) {
  try {
    mcp__playwright__browser_click({ selector })
    break
  } catch (e) {
    continue
  }
}
```

### Pattern 4: Capture Full Page with Lazy Loading

```javascript
// Navigate
mcp__playwright__browser_navigate({ url: pageUrl })

// Scroll to load lazy content
mcp__playwright__browser_evaluate({
  script: `
    (async () => {
      const delay = ms => new Promise(r => setTimeout(r, ms));
      for (let i = 0; i < document.body.scrollHeight; i += window.innerHeight) {
        window.scrollTo(0, i);
        await delay(500);
      }
      window.scrollTo(0, 0);
    })()
  `
})

// Wait for images
mcp__playwright__browser_wait_for({
  selector: "img[loading='lazy']",
  state: "visible"
})

// Full page screenshot
mcp__playwright__browser_take_screenshot({ fullPage: true })
```

### Pattern 5: Extract Article Metadata

```javascript
mcp__playwright__browser_evaluate({
  script: `
    ({
      title: document.querySelector('h1, [class*="title"]')?.textContent?.trim(),
      author: document.querySelector('[rel="author"], .author, [class*="author"]')?.textContent?.trim(),
      date: document.querySelector('time, [class*="date"], [class*="published"]')?.getAttribute('datetime') ||
            document.querySelector('time, [class*="date"]')?.textContent?.trim(),
      description: document.querySelector('meta[name="description"]')?.content,
      url: window.location.href,
      domain: window.location.hostname
    })
  `
})
```

### Pattern 6: Analyze Blog Style Structure

```javascript
mcp__playwright__browser_evaluate({
  script: `
    ({
      headings: Array.from(document.querySelectorAll('h1,h2,h3,h4')).map(h => ({
        level: h.tagName,
        text: h.textContent.trim()
      })),
      images: document.querySelectorAll('article img, .post img').length,
      codeBlocks: document.querySelectorAll('pre code, .highlight').length,
      paragraphs: document.querySelectorAll('article p, .post p').length,
      lists: document.querySelectorAll('ul, ol').length,
      tables: document.querySelectorAll('table').length,
      avgParagraphLength: Array.from(document.querySelectorAll('article p'))
        .reduce((sum, p) => sum + p.textContent.split(' ').length, 0) /
        Math.max(1, document.querySelectorAll('article p').length)
    })
  `
})
```

---

## Selector Strategies

### Finding Diagrams

```javascript
// Common diagram selectors
const diagramSelectors = [
  'img[src*="diagram"]',
  'img[src*="architecture"]',
  'img[src*="flowchart"]',
  'img[alt*="diagram"]',
  '.mermaid',
  '.diagram',
  'svg[class*="diagram"]',
  '[class*="architecture"]',
  'figure img'
]
```

### Finding Code Blocks

```javascript
// Common code block selectors
const codeSelectors = [
  'pre code',
  '.highlight pre',
  '.code-block',
  '[class*="prism"]',
  '[class*="hljs"]',
  '.CodeMirror-code',
  '.monaco-editor'
]
```

### Finding Main Content

```javascript
// Common content area selectors
const contentSelectors = [
  'article',
  '[role="main"]',
  '.post-content',
  '.article-content',
  '.entry-content',
  'main',
  '#content'
]
```

---

## Output Directory Structure

```
shared/sources/artifacts/
├── images/
│   └── [domain]/
│       └── [YYYY-MM-DD]-[slug].png
├── diagrams/
│   └── [domain]/
│       └── [YYYY-MM-DD]-[slug].png
├── code-snippets/
│   └── [domain]/
│       └── [YYYY-MM-DD]-[slug].md
└── metadata/
    └── [domain]/
        └── [YYYY-MM-DD]-[slug].json
```

## Attribution Template

```markdown
---
source_url: https://example.com/article
source_title: Article Title
source_author: Author Name
captured_date: 2025-12-13T10:30:00Z
artifact_type: diagram
license: Unknown
---

# [Artifact Description]

![Image](./image.png)

**Source**: [Article Title](https://example.com/article) by Author Name
**Captured**: December 13, 2025
```

---

## Error Recovery

### Timeout Handling

```javascript
// Set longer timeout for slow pages
// Use try/catch pattern

try {
  mcp__playwright__browser_wait_for({
    selector: ".content",
    state: "visible",
    timeout: 30000  // 30 seconds
  })
} catch (e) {
  // Fallback to snapshot without waiting
  mcp__playwright__browser_snapshot()
}
```

### Element Not Found

```javascript
// Try multiple selectors
const selectors = ['#diagram', '.diagram', 'img[alt*="diagram"]']
let found = false

for (const selector of selectors) {
  const result = mcp__playwright__browser_evaluate({
    script: `document.querySelector('${selector}') !== null`
  })
  if (result) {
    found = true
    break
  }
}

if (!found) {
  // Capture full page as fallback
  mcp__playwright__browser_take_screenshot({ fullPage: true })
}
```

---

## Integration Points

### With notebooklm-ingest-sources

```markdown
When ingesting websites:
1. Use WebFetch for text content
2. Use Playwright for visual content extraction
3. Combine into unified knowledge base
```

### With research-blog-publisher

```markdown
When creating blog posts:
1. Reference extracted diagrams from artifacts/
2. Include attribution from metadata/
3. Apply learned style patterns
```

### With research-learn-blog-style

```markdown
When analyzing blog style:
1. Navigate to blog URL
2. Extract structure patterns
3. Capture example visuals
4. Save to style-guides/
```

---

## See Also

- Agent: `@research-web-extractor`
- Command: `/research-extract-web-content`
- Command: `/research-learn-blog-style`
- Workflow: `web-extraction-workflow.md`
- Sources: `shared/sources/sources.md`
