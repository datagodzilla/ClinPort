---
argument-hint: "Path to sources manifest file (e.g., sources/notebooklm_sources.md)"
allowed-tools: read, write, bash, task, glob, grep
description: "Generate all artifact types from source content - complete NotebookLM-style workflow"
---

# NotebookLM Generate All - Master Orchestrator Command


## ⚠️ Argument Required

**Input received:** `$ARGUMENTS`

**If no argument is provided**, display this help information and stop:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NotebookLM Generate All - Master Orchestrator Command
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

DESCRIPTION:
  Generate all artifact types from source content - complete NotebookLM-style workflow

USAGE:
  /notebooklm-generate-all Path to sources manifest file (e.g., sources/notebooklm_sources.md)

REQUIRED ARGUMENTS:
    Path to sources manifest file (e.g., sources/notebooklm_sources.md)

OPTIONAL ARGUMENTS:
    (none)

EXAMPLES:
  /notebooklm-generate-all "example-argument"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Run the command with required arguments to proceed.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**If arguments ARE provided**, proceed with the command below.

---
## Purpose

This is the **master orchestrator command** that coordinates the entire research analysis pipeline. It delegates work to the `@research-master` agent which in turn coordinates all specialized agents to produce comprehensive, Feynman-technique style artifacts.

## Pre-Execution: Python Environment Setup

**CRITICAL**: Before executing any NotebookLM tasks, verify and use the project's Python virtual environment.

### Step 0: Activate Virtual Environment

```bash
# Verify .venv exists
if [ -d ".venv" ]; then
    echo "✓ Virtual environment found"
else
    echo "✗ Virtual environment not found. Creating..."
    python3 -m venv .venv
    .venv/bin/pip install -r requirements.txt
fi

# Use .venv Python for all subsequent commands
PYTHON=".venv/bin/python"
PIP=".venv/bin/pip"

# Verify key packages
$PYTHON -c "import edge_tts, pandas, torch; print('✓ All packages available')"
```

### Required Packages (pre-installed in .venv)
| Package | Purpose |
|---------|---------|
| `edge-tts` | Free text-to-speech for podcast generation |
| `pydub` | Audio processing and combining |
| `yt-dlp` | YouTube transcript extraction |
| `torch` | Deep learning (transformers) |
| `transformers` | NLP models |
| `pandas` | Data processing |
| `plotly` | Interactive visualizations |
| `streamlit` | Dashboards |

### Python Commands Pattern
Always use `.venv/bin/python` instead of `python3`:
```bash
# Correct - uses project venv
.venv/bin/python script.py
.venv/bin/pip install package

# Incorrect - may use system Python
python3 script.py
pip install package
```

## How It Works

```
┌─────────────────────────────────────────────────────────────────────────────┐
│              /notebooklm-generate-all (MASTER ORCHESTRATOR)                  │
│                                                                              │
│   Input: sources/notebooklm_sources.md (manifest with YouTube, URLs, GitHub, PDFs, etc.) │
│   Output: 8+ artifact types ready for blog publishing                        │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                         @research-master                                     │
│                    (Master Orchestrator Agent)                               │
│                                                                              │
│   Coordinates all specialized agents in the optimal sequence                 │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
        ┌───────────────────────────┼───────────────────────────┐
        │                           │                           │
        ▼                           ▼                           ▼
┌───────────────┐         ┌───────────────┐         ┌───────────────┐
│ PLANNING      │         │ PARSING       │         │ DOMAIN        │
│               │         │               │         │ ANALYSIS      │
│ @research-    │         │ @research-    │         │               │
│ project-      │         │ doc-parser    │         │ @research-    │
│ planner       │         │               │         │ clinical-     │
│               │         │               │         │ expert        │
└───────────────┘         └───────────────┘         │               │
                                                    │ @research-    │
                                                    │ ai-expert     │
                                                    │               │
                                                    │ @research-    │
                                                    │ clinical-     │
                                                    │ terminologist │
                                                    └───────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                       ARTIFACT GENERATION (Parallel)                         │
│                                                                              │
│  ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐ ┌─────────┐   │
│  │Podcast  │ │Flashcard│ │  Quiz   │ │ Slides  │ │ Mindmap │ │ Report  │   │
│  │+ Audio  │ │  Cards  │ │Questions│ │  Deck   │ │  + SVG  │ │Document │   │
│  └─────────┘ └─────────┘ └─────────┘ └─────────┘ └─────────┘ └─────────┘   │
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
┌─────────────────────────────────────────────────────────────────────────────┐
│                      DOCUMENTATION PIPELINE                                  │
│                                                                              │
│  @research-doc-generator → @research-doc-formatter → @research-blog-publisher│
└─────────────────────────────────────────────────────────────────────────────┘
                                    │
                                    ▼
                            artifacts/ + blog-post/
```

## Agent Coordination

### Phase 1: Planning & Parsing
| Agent | Role |
|-------|------|
| `@research-project-planner` | Creates execution plan, identifies key topics, delegates tasks |
| `@research-doc-parser` | Parses all input sources (YouTube, URLs, PDFs, Office docs) |

### Phase 2: Domain Analysis
| Agent | Role |
|-------|------|
| `@research-clinical-expert` | Clinical workflows, medical terminology, healthcare systems, OHDSI/RWE research |
| `@research-ai-expert` | AI/ML concepts, algorithms, architectures, technical workflows |
| `@research-clinical-terminologist` | OMOP CDM vocabularies, SNOMED-CT, LOINC, ICD-10, RxNorm mapping |
| `@research-ohdsi-data-engineer` | ETL pipelines, OMOP CDM transformations, data quality |
| `@research-python-developer` | Python code examples, ETL scripts, data processing |

### Phase 3: Artifact Generation

**All artifacts are generated by DEFAULT.** Use `--skip-*` flags to exclude specific types.

| Artifact | Skills Used | Output Location |
|----------|-------------|-----------------|
| Podcast Script | `podcast-generation` - Generate conversational script | `sources/artifacts/podcasts/` |
| **Podcast Audio** | **REQUIRED**: Run `scripts/generate_podcast_audio.py` to create MP3 | `sources/artifacts/podcasts/` |
| Flashcards | `flashcard-generation` | `sources/artifacts/flashcards/` |
| Quiz | `quiz-generation` | `sources/artifacts/quizzes/` |
| Slides | `slide-generation` (Marp) | `sources/artifacts/slides/` |
| Mindmaps | `mindmap-creation` (ASCII, Mermaid, Graphviz) | `sources/artifacts/mindmaps/` |
| Report | `documentation-generation` (includes source references) | `analysis/` |
| **Infographics** | `infographic-generation` - AI-generated visuals **(DEFAULT)** | `sources/artifacts/infographics/` |
| **Comics** | `comic-storyboard-generation` - Visual narratives **(DEFAULT)** | `sources/artifacts/comics/` |
| **Video Frames** | `youtube-ingestion` - Key moment captures **(DEFAULT for YouTube sources)** | `sources/artifacts/video-frames/` |

### Phase 3.5: Source References Generation (DEFAULT)

**ALWAYS** generate source references for documentation:

```bash
# Auto-generated in sources/references/
sources/references/
├── source_index.md           # Master index with all citations
├── youtube_[video-id].md     # YouTube source reference
├── web_[domain].md           # Website source reference
├── pdf_[filename].md         # PDF source reference
└── github_[repo].md          # GitHub source reference
```

Each reference file includes:
- Full citation (APA/IEEE format)
- Key quotes and excerpts
- Relevant timestamps/pages
- Cross-references to artifacts that use this source

#### Phase 3.1: Podcast Audio Generation (REQUIRED)

After generating the podcast script, **ALWAYS** run the audio generation:

```bash
# Generate podcast audio from script (note: artifacts now in sources/)
.venv/bin/python scripts/generate_podcast_audio.py \
    "[research_folder]/sources/artifacts/podcasts/[topic]_script.md" \
    "[research_folder]/sources/artifacts/podcasts/[topic]_podcast.mp3" \
    --topic "[Topic Name]"
```

**Example**:
```bash
.venv/bin/python scripts/generate_podcast_audio.py \
    "research/2025/December/12/01-ohdsi/sources/artifacts/podcasts/ohdsi_podcast_script.md" \
    "research/2025/December/12/01-ohdsi/sources/artifacts/podcasts/ohdsi_podcast.mp3" \
    --topic "OHDSI Introduction"
```

**Output**: `[topic]_podcast.mp3` + `[topic]_podcast.json` (metadata)

### Phase 4: Documentation & Publishing
| Agent | Role |
|-------|------|
| `@research-doc-generator` | Creates comprehensive documentation |
| `@research-doc-formatter` | Applies consistent formatting |
| `@research-blog-publisher` | SEO optimization, publication readiness |

### Phase 5: Blog Post Generation (REQUIRED)
| Step | Action |
|------|--------|
| 5.1 | **Derive SEO-optimized slug** from topic/title (see Filename Convention below) |
| 5.2 | Create integrated blog post with embedded Mermaid diagrams from `artifacts/mindmaps/` |
| 5.3 | Generate THREE document versions with SEO filenames (see below) |
| 5.4 | Embed artifact references (podcast, flashcards, quiz, slides) in Learning Resources section |
| 5.5 | Apply Karpathy narrative style with Feynman technique explanations |
| 5.6 | Include YAML frontmatter for Jekyll publishing |

#### Blog Post Filename Convention (SEO-Optimized)

**CRITICAL**: Blog post files MUST use SEO-optimized slugs, NOT generic names like `final_mermaid.md`.

**Derive the slug from**:
1. **Title** in blog post frontmatter (preferred)
2. **Topic** field in `sources/sources.md`
3. **Folder name** (e.g., `01-ohdsi-introduction` → `ohdsi-introduction`)

**Slug Rules**:
- Lowercase
- Hyphens between words (no spaces or underscores)
- Remove special characters
- Max 50 characters
- Include key search terms

**Three Document Versions**:
| Version | Filename | Example |
|---------|----------|---------|
| Mermaid (primary) | `[seo-slug].md` | `ohdsi-introduction-real-world-data.md` |
| ASCII | `[seo-slug]_ascii.md` | `ohdsi-introduction-real-world-data_ascii.md` |
| Graphviz | `[seo-slug]_graphviz.md` | `ohdsi-introduction-real-world-data_graphviz.md` |

**Example Derivation**:
```
Title: "OHDSI Introduction: From Real-World Data to Reliable Evidence"
↓
Slug: ohdsi-introduction-real-world-data-reliable-evidence
↓
Files:
  - blog-post/ohdsi-introduction-real-world-data-reliable-evidence.md
  - blog-post/ohdsi-introduction-real-world-data-reliable-evidence_ascii.md
  - blog-post/ohdsi-introduction-real-world-data-reliable-evidence_graphviz.md
```

**CRITICAL**: Blog post generation is NOT optional. Every `/notebooklm-generate-all` execution MUST produce:
- `blog-post/[seo-slug].md` (Mermaid version - primary, recommended for Jekyll)
- `blog-post/[seo-slug]_ascii.md` (ASCII version - terminal/email friendly)
- `blog-post/[seo-slug]_graphviz.md` (Graphviz version - print/presentations)

With:
- Embedded Mermaid diagrams inline with content
- Learning Resources section with artifact links
- Proper Jekyll frontmatter
- SEO-optimized title and description

## Feynman Technique Integration

All generated artifacts follow the **Feynman Technique** principles:

1. **Simple Explanations First**: Start with intuitive explanations before technical details
2. **Analogies & Metaphors**: Use familiar concepts to explain unfamiliar ones
3. **Progressive Complexity**: Build from simple to complex
4. **Practical Examples**: Tie every concept to real-world use cases
5. **Visual Thinking**: Architecture diagrams and visualizations before text
6. **Gap Identification**: Highlight areas needing deeper understanding

## Input Format

### Sources Manifest (sources/notebooklm_sources.md)

```markdown
# Knowledge Base Sources

## Project Information
| Field | Value |
|-------|-------|
| **Topic** | Your Topic Name |
| **Domain** | clinical / technical / mixed |

## YouTube Videos
- https://www.youtube.com/watch?v=VIDEO_ID

## Websites
- https://example.com/article

## GitHub Repositories
- https://github.com/OHDSI/CommonDataModel - OMOP CDM definitions
- https://github.com/owner/repo/blob/main/docs/guide.md - Specific file

## PDF Documents
- sources/pdfs/document.pdf

## Research Notes
- Key concepts to cover
- Practical use cases
- Questions to answer
```

**Note**: Use `sources/notebooklm_sources.md` as the working ingestion file. The `sources/sources.md` file is reserved as a reference document.

## Output Structure

**IMPORTANT**: All generated artifacts are stored within the `sources/` folder to keep everything self-contained and portable.

```
research/YYYY/MonthName/DD/NN-topic/
├── sources/
│   ├── sources.md                    # Reference document (static)
│   ├── notebooklm_sources.md         # Working ingestion manifest
│   ├── references/                   # Source references (auto-generated)
│   │   ├── source_index.md           # Index of all sources with citations
│   │   └── [source]_reference.md     # Individual source references
│   ├── ingested/                     # Parsed content (moved from root)
│   │   └── [source]_parsed.md
│   ├── knowledge_base/               # Synthesized knowledge (moved from root)
│   │   └── unified_kb.md
│   └── artifacts/                    # All generated artifacts
│       ├── podcasts/
│       │   ├── [topic]_script.md     # Conversational script
│       │   └── [topic]_podcast.mp3   # Generated audio
│       ├── flashcards/
│       │   └── [topic]_flashcards.md
│       ├── quizzes/
│       │   └── [topic]_quiz.md
│       ├── slides/
│       │   └── [topic]_slides.md     # Marp format
│       ├── mindmaps/
│       │   ├── [topic]_ascii.md
│       │   ├── [topic]_mermaid.md
│       │   └── [topic]_mindmap.svg
│       ├── infographics/             # AI-generated visuals (DEFAULT)
│       │   ├── [topic]_overview.png
│       │   └── [topic]_overview.yaml
│       ├── comics/                   # Visual narratives (DEFAULT)
│       │   ├── [topic]_storyboard.svg
│       │   ├── [topic]_storyboard.html
│       │   └── [topic]_storyboard.yaml
│       └── video-frames/             # YouTube key moments (DEFAULT)
│           └── [video-id]/
│               ├── frame-001-Xm00s.png
│               └── manifest.yaml
├── analysis/
│   ├── clinical_workflow.md          # Clinical analysis
│   ├── technical_workflow.md         # Technical analysis
│   └── comprehensive_report.md       # Full report (includes source references)
├── visualizations/
│   └── architecture_diagrams/
├── blog-post/
│   ├── draft.md
│   ├── [seo-slug].md                 # Mermaid version (primary, recommended)
│   ├── [seo-slug]_ascii.md           # ASCII version
│   ├── [seo-slug]_graphviz.md        # Graphviz SVG version
│   └── visualizations/
│       ├── [topic]_diagrams.py       # Graphviz generator script
│       └── generated/                # SVG output files
└── manifest.md                       # Generation manifest
```

## Execution Instructions

### Step 1: Invoke Research Master Agent

Use the Task tool to spawn the `@research-master` agent with the sources manifest:

```
Task: @research-master
Prompt: Execute complete NotebookLM-style generation pipeline for [sources.md path]

Instructions:
1. Parse the sources manifest to identify all input sources
2. Create execution plan using @research-project-planner
3. Ingest all sources (YouTube transcripts, web content, PDFs, documents)
4. Analyze content with domain experts (@research-clinical-expert, @research-ai-expert)
5. Generate all artifacts using appropriate skills
6. Create comprehensive documentation
7. Generate publication-ready blog post
8. Validate all outputs and create manifest

Apply Feynman Technique throughout all generated content.
Focus on practical use cases and architecture visualizations.
```

### Step 2: Monitor Progress

The research-master agent will:
1. Report progress at each phase
2. Handle errors gracefully (continue with remaining tasks)
3. Generate a completion manifest
4. Provide quick access links to all artifacts

### Step 3: Review & Publish

After generation:
1. Review the Mermaid version: `blog-post/[seo-slug].md`
2. Make any manual edits
3. Queue for publishing: `/research-queue-for-publish blog-post/[seo-slug].md`
4. Publish: `/daily-publish`

**Note**: The SEO-optimized filename makes your post discoverable. Example:
- `ohdsi-introduction-real-world-data.md` → URL: `/ohdsi-introduction-real-world-data/`

## Quality Standards

### Content Quality
- [ ] Feynman-style explanations (simple before complex)
- [ ] Practical use cases for every concept
- [ ] Architecture diagrams for system relationships
- [ ] Source attribution for all claims
- [ ] Clinical safety notes (if applicable)

### Artifact Quality
- [ ] Podcast: Conversational, engaging, 15-20 minutes
- [ ] Flashcards: 25-50 cards, progressive difficulty
- [ ] Quiz: 15-25 questions, diverse types
- [ ] Slides: 15-25 slides, visual-first
- [ ] Mindmaps: 3 formats (ASCII, Mermaid, SVG)
- [ ] Report: Comprehensive, well-structured

### Technical Quality
- [ ] All files created and non-empty
- [ ] Correct file formats
- [ ] No broken references
- [ ] Consistent naming conventions

## Error Handling

| Error | Recovery |
|-------|----------|
| YouTube transcript unavailable | Skip with warning, note in manifest |
| Website fetch fails | Retry once, then skip with warning |
| PDF parsing fails | Try alternative parser, then skip |
| Audio generation fails | Save script only, note in manifest |
| SVG generation fails | Keep Mermaid/ASCII versions |

## Usage Examples

### Basic Usage (All Artifacts Generated by Default)
```bash
# Generates ALL artifacts including infographics, comics, video frames, and source references
/notebooklm-generate-all sources/notebooklm_sources.md
```

### From Existing Knowledge Base
```bash
/notebooklm-generate-all sources/knowledge_base/unified_kb.md
```

### Skip Specific Artifacts
```bash
# Skip podcast generation
/notebooklm-generate-all sources/notebooklm_sources.md --skip-podcast

# Skip visual artifacts (faster generation)
/notebooklm-generate-all sources/notebooklm_sources.md --skip-infographics
/notebooklm-generate-all sources/notebooklm_sources.md --skip-comics
/notebooklm-generate-all sources/notebooklm_sources.md --skip-video-frames

# Skip all visual artifacts at once
/notebooklm-generate-all sources/notebooklm_sources.md --skip-visuals

# Generate only specific artifacts
/notebooklm-generate-all sources/notebooklm_sources.md --only flashcards,quiz,mindmaps
```

### Premium Options
```bash
# Use premium ElevenLabs voices for podcast
/notebooklm-generate-all sources/notebooklm_sources.md --premium-audio

# Use illustrated mode for comics (AI-generated panels)
/notebooklm-generate-all sources/notebooklm_sources.md --illustrated-comics
```

### Default Behavior Summary
By default, `/notebooklm-generate-all` generates:
- ✅ Podcast (script + audio)
- ✅ Flashcards
- ✅ Quiz
- ✅ Slides
- ✅ Mindmaps (3 formats)
- ✅ Report with source references
- ✅ Infographics (AI-generated)
- ✅ Comics (placeholder mode)
- ✅ Video frames (from YouTube sources)
- ✅ Source references index

## Success Criteria

Generation complete when:
- [ ] All sources ingested (or noted as skipped)
- [ ] Source references generated in `sources/references/`
- [ ] Knowledge base synthesized in `sources/knowledge_base/`
- [ ] All 10 artifact types generated (unless explicitly skipped):
  - [ ] Podcast (script + audio) in `sources/artifacts/podcasts/`
  - [ ] Flashcards in `sources/artifacts/flashcards/`
  - [ ] Quiz in `sources/artifacts/quizzes/`
  - [ ] Slides in `sources/artifacts/slides/`
  - [ ] Mindmaps (3 formats) in `sources/artifacts/mindmaps/`
  - [ ] **Infographics** in `sources/artifacts/infographics/`
  - [ ] **Comics** in `sources/artifacts/comics/`
  - [ ] **Video Frames** in `sources/artifacts/video-frames/` (from YouTube sources)
  - [ ] Report in `analysis/`
  - [ ] Blog post with embedded source references
- [ ] Blog post created with all artifact references and citations
- [ ] Manifest generated with links to all outputs
- [ ] Quality validation passed

## Output Example

```
 NotebookLM Generation Complete!

 Topic: OMOP CDM Data Quality
 Output: research/2025/December/12/01-omop-data-quality/
 SEO Slug: omop-cdm-data-quality-comprehensive-guide

 Generated Artifacts (all stored in sources/):
┌──────────────┬────────────────────────────────────────────────────────┬──────────┐
│ Type         │ File                                                   │ Status   │
├──────────────┼────────────────────────────────────────────────────────┼──────────┤
│  References │ sources/references/source_index.md                      │    ✅    │
│  Podcast    │ sources/artifacts/podcasts/omop-dq_podcast.mp3 (18:42) │    ✅    │
│  Mindmap    │ sources/artifacts/mindmaps/omop-dq_mindmap.svg         │    ✅    │
│  Report     │ analysis/omop-dq_report.md (4,200 words)               │    ✅    │
│  Flashcard  │ sources/artifacts/flashcards/omop-dq_flashcards.md     │    ✅    │
│  Quiz       │ sources/artifacts/quizzes/omop-dq_quiz.md (20 Q)       │    ✅    │
│  Slides     │ sources/artifacts/slides/omop-dq_slides.md (22 slides) │    ✅    │
│  Infographic│ sources/artifacts/infographics/omop-dq_overview.png    │    ✅    │
│  Comic      │ sources/artifacts/comics/omop-dq_storyboard.svg        │    ✅    │
│  Frames     │ sources/artifacts/video-frames/abc123/ (12 frames)     │    ✅    │
├──────────────┼────────────────────────────────────────────────────────┼──────────┤
│  Blog       │ blog-post/omop-cdm-data-quality-comprehensive-guide.md │    ✅    │
│  Blog ASCII │ blog-post/omop-cdm-...-guide_ascii.md                  │    ✅    │
│  Blog SVG   │ blog-post/omop-cdm-...-guide_graphviz.md               │    ✅    │
└──────────────┴────────────────────────────────────────────────────────┴──────────┘

 Total Time: 8m 15s

 Quick Access:
• Blog Post: blog-post/omop-cdm-data-quality-comprehensive-guide.md
• Podcast: sources/artifacts/podcasts/omop-dq_podcast.mp3
• Flashcards: sources/artifacts/flashcards/omop-dq_flashcards.md
• Quiz: sources/artifacts/quizzes/omop-dq_quiz.md
• Source References: sources/references/source_index.md

 Next Steps:
1. Review blog-post/omop-cdm-data-quality-comprehensive-guide.md
2. Run: /research-queue-for-publish blog-post/omop-cdm-data-quality-comprehensive-guide.md
3. Run: /daily-publish
```
