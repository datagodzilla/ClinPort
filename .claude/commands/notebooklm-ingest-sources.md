---
argument-hint: "Path to sources manifest file (e.g., sources/notebooklm_sources.md) [--extract-visuals]"
allowed-tools: read, write, bash, task, webfetch, mcp__playwright__browser_navigate, mcp__playwright__browser_snapshot, mcp__playwright__browser_take_screenshot, mcp__playwright__browser_click, mcp__playwright__browser_evaluate, mcp__playwright__browser_wait_for, mcp__playwright__browser_close
description: "Ingest multiple data sources (YouTube, websites, GitHub repos, PDFs, Word docs) into a unified knowledge base with optional visual extraction"
---

# Multi-Source Ingestion Command


## ⚠️ Argument Required

**Input received:** `$ARGUMENTS`

**If no argument is provided**, display this help information and stop:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Multi-Source Ingestion Command
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

DESCRIPTION:
  Ingest multiple data sources (YouTube, websites, GitHub repos, PDFs, Word docs) into a unified knowledge base with optional visual extraction

USAGE:
  /notebooklm-ingest-sources Path to sources manifest file (e.g., sources/notebooklm_sources.md) [--extract-visuals]

REQUIRED ARGUMENTS:
    Path to sources manifest file (e.g., sources/notebooklm_sources.md) [--extract-visuals]

OPTIONAL ARGUMENTS:
    (none)

EXAMPLES:
  /notebooklm-ingest-sources "example-argument"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Run the command with required arguments to proceed.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**If arguments ARE provided**, proceed with the command below.

---
## Purpose
Parse a sources manifest file and ingest all listed data sources (YouTube videos, websites, PDFs, Word documents) into a unified knowledge base for further processing.

## Input Format

### Sources Manifest Structure
The input should be a markdown file listing sources by type (typically `sources/notebooklm_sources.md`):

```markdown
# Knowledge Base Sources

## Project Information
- **Topic**: [Topic name]
- **Output Directory**: output/[topic]/

## YouTube Videos
- https://www.youtube.com/watch?v=VIDEO_ID_1
- https://www.youtube.com/watch?v=VIDEO_ID_2

## Websites
- https://ohdsi.org/documentation
- https://athena.ohdsi.org/about

## GitHub Repositories
- https://github.com/OHDSI/CommonDataModel - OMOP CDM schema definitions
- https://github.com/OHDSI/Achilles - Data characterization tool
- https://github.com/username/repo/blob/main/docs/README.md - Specific file

## PDF Documents
- /path/to/document1.pdf
- /path/to/document2.pdf

## Word Documents
- /path/to/document1.docx
- /path/to/document2.docx

## Other Files
- /path/to/spreadsheet.xlsx
- /path/to/presentation.pptx
```

**Note**: The `sources/sources.md` file is reserved as a reference document. Use `sources/notebooklm_sources.md` as the working file for active ingestion.

## Execution Workflow

### Phase 1: Parse Manifest
1. Read the sources manifest file
2. Extract topic and output directory
3. Categorize sources by type:
   - YouTube URLs
   - Website URLs
   - GitHub repository URLs (repos, files, READMEs)
   - Local PDF files
   - Local Word documents
   - Other supported files

### Phase 2: Ingest YouTube Videos
For each YouTube URL:
```bash
# Using yt-dlp for transcript extraction
yt-dlp --write-auto-sub --sub-lang en --skip-download \
    --output "ingested/youtube/%(title)s" "URL"
```

**Process**:
1. Extract video ID from URL
2. Download transcript (auto-generated or manual)
3. Convert VTT/SRT to markdown
4. Add metadata (title, channel, duration, date)
5. Save to `ingested/youtube/[title]_transcript.md`

**Fallback**: If auto-extraction fails, prompt for manual transcript entry.

### Phase 3: Ingest Websites
For each website URL:
1. Use WebFetch to retrieve content
2. Convert HTML to clean markdown
3. Extract main content (remove navigation, ads)
4. Add source metadata
5. Save to `ingested/web/[domain]_[slug].md`

### Phase 3.1: Ingest GitHub Repositories
For each GitHub URL:

**Repository URLs** (e.g., `https://github.com/OHDSI/CommonDataModel`):
1. Use `gh` CLI to fetch README.md
2. Extract key documentation files (docs/, README.md, CONTRIBUTING.md)
3. Parse code structure for overview
4. Add repository metadata (stars, description, topics)
5. Save to `ingested/github/[owner]_[repo].md`

```bash
# Fetch repository README
gh api repos/OWNER/REPO/readme --jq '.content' | base64 -d > ingested/github/[repo]_readme.md

# Get repository info
gh repo view OWNER/REPO --json name,description,url,stargazerCount,topics
```

**Specific File URLs** (e.g., `https://github.com/owner/repo/blob/main/docs/guide.md`):
1. Extract raw content using GitHub raw URL
2. Convert to markdown if needed
3. Add file metadata (path, last modified)
4. Save to `ingested/github/[repo]_[filename].md`

```bash
# Fetch specific file
gh api repos/OWNER/REPO/contents/PATH --jq '.content' | base64 -d > ingested/github/[repo]_[filename].md
```

**Wiki URLs** (e.g., `https://github.com/owner/repo/wiki`):
1. Clone wiki repository
2. Extract all wiki pages
3. Convert to unified markdown
4. Save to `ingested/github/[repo]_wiki/`

### Phase 3.5: Extract Visual Content (Optional)
If `--extract-visuals` flag is set, use Playwright to extract images and diagrams:

**For each website URL**:
1. Navigate using Playwright:
```javascript
mcp__playwright__browser_navigate({ url: websiteUrl })
mcp__playwright__browser_wait_for({ selector: "article, main", state: "visible" })
```

2. Handle dynamic content:
```javascript
// Accept cookies
mcp__playwright__browser_click({ selector: "[class*='cookie'] button[class*='accept']" })

// Scroll for lazy loading
mcp__playwright__browser_evaluate({
  script: "window.scrollTo(0, document.body.scrollHeight)"
})
```

3. Detect diagrams and images:
```javascript
mcp__playwright__browser_evaluate({
  script: `
    Array.from(document.querySelectorAll('article img')).map(img => ({
      src: img.src,
      alt: img.alt,
      isDiagram: /diagram|architecture|flow|chart/i.test(img.src + img.alt)
    }))
  `
})
```

4. Capture screenshots of diagrams:
```javascript
mcp__playwright__browser_take_screenshot({
  selector: "img[alt*='diagram'], .diagram, .mermaid",
  fullPage: false
})
```

5. Save to `ingested/visuals/[domain]/`:
```
ingested/visuals/[domain]/
├── [timestamp]-diagram-1.png
├── [timestamp]-diagram-2.png
└── manifest.yaml
```

6. Close browser:
```javascript
mcp__playwright__browser_close()
```

**For YouTube videos**:
- Extract video thumbnail using yt-dlp
- Save to `ingested/visuals/youtube/[video-id]-thumbnail.jpg`

### Phase 4: Ingest Documents
For PDFs, Word docs, and other files:
1. Use Markitdown MCP server for conversion
2. Convert to markdown format
3. Preserve structure (headings, tables, lists)
4. Add source metadata
5. Save to `ingested/documents/[filename].md`

### Phase 5: Create Knowledge Base Manifest
Generate a unified manifest of all ingested content:

```markdown
# Knowledge Base Manifest

## Topic: [Topic]
## Generated: [Date]

## Ingested Sources

### YouTube Transcripts
| Title | Duration | Path |
|-------|----------|------|
| [Title] | [Duration] | ingested/youtube/... |

### Web Content
| URL | Title | Path |
|-----|-------|------|
| [URL] | [Title] | ingested/web/... |

### Documents
| Filename | Type | Path |
|----------|------|------|
| [Name] | PDF | ingested/documents/... |

## Statistics
- Total Sources: [N]
- YouTube Videos: [N]
- Websites: [N]
- Documents: [N]
- Total Content Size: [X] words

## Next Steps
Run `/notebooklm-generate-all` to create all artifact types from this knowledge base.
```

## Output Structure

```
ingested/
├── youtube/
│   ├── [video-title-1]_transcript.md
│   └── [video-title-2]_transcript.md
├── web/
│   ├── [domain-1]_[slug].md
│   └── [domain-2]_[slug].md
├── github/
│   ├── [owner]_[repo].md             # Repository overview + README
│   ├── [repo]_[filename].md          # Specific files
│   └── [repo]_wiki/                  # Wiki pages (if applicable)
│       └── [page].md
├── documents/
│   ├── [document-1].md
│   └── [document-2].md
├── visuals/                          # If --extract-visuals
│   ├── [domain]/
│   │   ├── [timestamp]-diagram-1.png
│   │   └── manifest.yaml
│   └── youtube/
│       └── [video-id]-thumbnail.jpg
└── manifest.md
```

## Error Handling

### YouTube Errors
- **No transcript**: Prompt for manual entry or skip
- **Private video**: Skip with warning
- **Age-restricted**: Skip with warning
- **Invalid URL**: Report and skip

### Website Errors
- **404/403**: Report and skip
- **Timeout**: Retry once, then skip
- **No content**: Report empty page

### GitHub Errors
- **404/Private repo**: Check authentication, report and skip
- **Rate limit**: Wait and retry, or skip with warning
- **Invalid URL format**: Report malformed URL
- **No README**: Use repo description as fallback

### Document Errors
- **File not found**: Report missing file
- **Unsupported format**: Report and skip
- **Corrupted file**: Report and skip

## Usage Examples

### Basic Usage
```
/notebooklm-ingest-sources sources/notebooklm_sources.md
```

### With Specific Topic
```
/notebooklm-ingest-sources research/2025/December/14/01-topic/sources/notebooklm_sources.md
```

### With Visual Extraction
```
/notebooklm-ingest-sources sources/notebooklm_sources.md --extract-visuals
```

## Integration

### Triggers Next Commands
After ingestion, user can run:
- `/notebooklm-generate-all` - Generate all artifact types
- `/notebooklm-generate-podcast` - Generate podcast from KB
- `/notebooklm-generate-mindmap` - Generate mindmap from KB

### Uses Skills
- `youtube-ingestion` - YouTube transcript extraction
- `playwright-web-extraction` - Visual content extraction (if --extract-visuals)
- `ohdsi-domain-knowledge` - If OHDSI content detected

### Uses Agents
- `@research-web-extractor` - Coordinates Playwright extraction

## Success Criteria

Ingestion is complete when:
- [ ] All sources attempted
- [ ] Successful sources saved to ingested/
- [ ] Failed sources logged with reasons
- [ ] Knowledge base manifest created
- [ ] Summary report displayed to user

## Example Output

```
Source Ingestion Complete

Statistics:
- YouTube Videos: 3/3 successful
- Websites: 5/5 successful
- GitHub Repos: 2/2 successful
- Documents: 2/3 successful (1 not found)

Output Location: ingested/

Knowledge Base Manifest: ingested/manifest.md

Issues:
- missing_doc.pdf: File not found

Ready for artifact generation!
Run /notebooklm-generate-all to create all output types.
```
