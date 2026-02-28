---
name: playwright-web-extraction
description: "Extract rich visual content (images, diagrams, code snippets) from websites using Playwright MCP for browser automation. Use when capturing screenshots, extracting diagrams, or learning blog styles from web sources."
allowed-tools: read, write, grep, glob, bash, mcp__playwright__browser_navigate, mcp__playwright__browser_snapshot, mcp__playwright__browser_take_screenshot, mcp__playwright__browser_click, mcp__playwright__browser_evaluate, mcp__playwright__browser_wait_for, mcp__playwright__browser_close
---

# Playwright Web Extraction Skill

## Purpose
Enable automated extraction of rich visual content from websites including screenshots, architecture diagrams, workflow diagrams, code snippets, and images using Playwright browser automation.

## When to Activate This Skill

**Key Triggers**:
- "extract images from", "capture diagrams", "screenshot website"
- "learn from blog", "analyze blog style", "get visuals from"
- "extract code from website", "capture architecture diagram"
- "scrape images", "download diagrams"

**Contextual Triggers**:
- User provides a URL and asks for visual content
- During blog ingestion when images/diagrams are present
- When learning writing styles from reference blogs
- Creating documentation that needs web-sourced visuals

## Core Capabilities

### 1. Visual Content Extraction

**Screenshots**:
- Full page screenshots
- Element-specific screenshots (diagrams, code blocks)
- Viewport-specific captures
- Before/after comparisons

**Diagram Extraction**:
- Architecture diagrams
- Flowcharts and process flows
- Sequence diagrams
- Infographics and data visualizations

**Code Snippet Capture**:
- Syntax-highlighted code blocks
- Interactive code examples
- Console output captures

### 2. Interactive Web Navigation

**Dynamic Content Handling**:
- Wait for lazy-loaded content
- Expand collapsed sections
- Handle infinite scroll
- Navigate paginated content

**Dialog Management**:
- Accept/dismiss cookie consent
- Handle authentication modals
- Close popup overlays

**SPA Navigation**:
- Client-side routing
- Dynamic element detection
- State-based content loading

### 3. Content Analysis

**Element Detection**:
- Identify image types (diagram, photo, icon)
- Detect code blocks and language
- Find structured data (tables, lists)
- Locate key content areas

**Metadata Extraction**:
- Alt text and captions
- Author and publication info
- Date and timestamps
- Article structure

### 4. Source Attribution

**Automatic Attribution**:
- Source URL capture
- Timestamp generation
- Author extraction
- License detection (when available)

**Citation Format**:
```markdown
![Diagram Description](path/to/image.png)
*Source: [Article Title](https://source-url.com) - Author Name, Date*
```

## How to Use This Skill

### Step 1: Navigate to Target URL

```javascript
// Using Playwright MCP
mcp__playwright__browser_navigate({ url: "https://example.com/article" })
```

Wait for page load:
```javascript
mcp__playwright__browser_wait_for({ selector: "article", state: "visible" })
```

### Step 2: Handle Dynamic Content

Handle cookie consent:
```javascript
mcp__playwright__browser_click({ selector: ".cookie-accept-button" })
```

Wait for lazy content:
```javascript
mcp__playwright__browser_wait_for({ selector: ".diagram-container img", state: "visible" })
```

### Step 3: Identify Extractable Elements

Get page snapshot for element detection:
```javascript
mcp__playwright__browser_snapshot()
```

Evaluate for specific elements:
```javascript
mcp__playwright__browser_evaluate({
  script: "document.querySelectorAll('img[src*=\"diagram\"], .mermaid, pre code').length"
})
```

### Step 4: Extract Content

**Full Page Screenshot**:
```javascript
mcp__playwright__browser_take_screenshot({ fullPage: true })
```

**Element Screenshot**:
```javascript
mcp__playwright__browser_take_screenshot({
  selector: ".architecture-diagram",
  fullPage: false
})
```

**Extract Code Blocks**:
```javascript
mcp__playwright__browser_evaluate({
  script: "Array.from(document.querySelectorAll('pre code')).map(el => ({ code: el.textContent, lang: el.className }))"
})
```

### Step 5: Generate Attribution

Extract metadata:
```javascript
mcp__playwright__browser_evaluate({
  script: `({
    title: document.title,
    author: document.querySelector('[rel=\"author\"]')?.textContent,
    date: document.querySelector('time')?.getAttribute('datetime'),
    url: window.location.href
  })`
})
```

### Step 6: Save Artifacts

Save to appropriate directories:
```
shared/sources/artifacts/
├── images/[source-domain]/[timestamp]-[description].png
├── diagrams/[source-domain]/[timestamp]-[description].png
└── code-snippets/[source-domain]/[timestamp]-[description].md
```

Include attribution file:
```markdown
# Artifact Attribution

- **Source**: [URL]
- **Captured**: [Timestamp]
- **Author**: [If available]
- **License**: [If detected]
- **Context**: [How this artifact relates to content]
```

## Output Formats

### Screenshot Output
```
{
  "type": "screenshot",
  "path": "artifacts/diagrams/productcompass/2025-12-13-workflow-diagram.png",
  "source": {
    "url": "https://www.productcompass.pm/article",
    "title": "Product Development Workflow",
    "captured": "2025-12-13T10:30:00Z"
  },
  "metadata": {
    "width": 1200,
    "height": 800,
    "format": "png"
  }
}
```

### Code Extraction Output
```markdown
## Code Snippet: Database Connection

**Source**: [Building Data Pipelines](https://moderndata101.substack.com/p/pipelines)
**Language**: Python
**Captured**: 2025-12-13

\`\`\`python
import pandas as pd
from sqlalchemy import create_engine

engine = create_engine('postgresql://...')
df = pd.read_sql('SELECT * FROM users', engine)
\`\`\`
```

## Integration with Other Skills

### Works With
- **document-parsing**: HTML to markdown conversion
- **blog-publishing**: Visual content for blog posts
- **youtube-ingestion**: Video thumbnail extraction
- **research-orchestration**: Complete research pipeline

### Provides To
- `@research-blog-publisher`: Extracted visuals for posts
- `@research-doc-generator`: Diagrams for documentation
- `@research-mindmap-creator`: Reference diagrams

### Receives From
- `/notebooklm-ingest-sources`: URLs to process
- `/research-learn-blog-style`: Blogs to analyze
- `@research-master`: Extraction requests

## Quality Checklist

Before completing extraction:
- [ ] Page fully loaded (dynamic content visible)
- [ ] Cookie/consent dialogs handled
- [ ] Screenshots are clear and complete
- [ ] Code snippets have syntax highlighting preserved
- [ ] Attribution metadata captured
- [ ] Files saved to correct locations
- [ ] Manifest updated with new artifacts

## Error Handling

| Error | Recovery Action |
|-------|-----------------|
| Page timeout | Retry with longer wait, or skip |
| Element not found | Use broader selector, capture full page |
| Screenshot failed | Try different viewport size |
| Code extraction empty | Check for iframe embedding |
| Cookie dialog blocks | Try multiple common selectors |

## Limitations

- Cannot extract from password-protected pages without credentials
- Some sites block automated browsers (rate limiting)
- Dynamic canvas/WebGL content may not capture correctly
- PDF embedded in pages require separate handling
- Very large pages may timeout

## Best Practices

1. **Respect Rate Limits**: Wait between requests to same domain
2. **Handle Failures Gracefully**: Skip problematic elements, continue with others
3. **Optimize Screenshots**: Capture only needed regions when possible
4. **Document Sources**: Always include attribution
5. **Check Licensing**: Note when content has usage restrictions
6. **Clean Up**: Close browser sessions when done

## Example Usage

```
User: Extract the architecture diagram from https://example.com/system-design