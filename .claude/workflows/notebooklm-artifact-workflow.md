# NotebookLM-Style Artifact Generation Workflow

## Overview

This workflow describes how to generate multiple knowledge artifacts from source materials, replicating and extending Google NotebookLM functionality within the research-hub profile.

## Supported Artifact Types

| Artifact | Command | Output Format | Tools Used |
|----------|---------|---------------|------------|
| **Audio Podcast** | `/notebooklm-generate-podcast` | MP3 + Script | edge-tts, ElevenLabs |
| **Flashcards** | `/notebooklm-generate-flashcards` | Markdown | Native |
| **Quiz** | `/notebooklm-generate-quiz` | Markdown | Native |
| **Slide Deck** | `/notebooklm-generate-slides` | Marp Markdown | marp-cli |
| **Mind Map** | `/notebooklm-generate-mindmap` | ASCII/Mermaid/Graphviz | Native |
| **Summary Report** | `/notebooklm-generate-report` | Markdown | Native |
| **Blog Post** | `/research-generate-blog-post` | Markdown | Native |

## Complete Workflow

### Phase 0: Source Preparation

#### Create Sources Manifest

Create a `sources/notebooklm_sources.md` file listing all input materials for ingestion:

```markdown
# Research Sources Manifest

## Topic
Introduction to OMOP Common Data Model

## Sources

### YouTube Videos
- https://www.youtube.com/watch?v=VIDEO_ID_1
- https://www.youtube.com/watch?v=VIDEO_ID_2

### Websites
- https://ohdsi.github.io/TheBookOfOhdsi/
- https://ohdsi.github.io/CommonDataModel/

### GitHub Repositories
- https://github.com/OHDSI/CommonDataModel - OMOP CDM schema definitions
- https://github.com/OHDSI/Achilles - Data characterization
- https://github.com/OHDSI/ETL-Synthea/blob/main/README.md - ETL example

### PDF Documents
- PDFs/omop-cdm-v54.pdf
- PDFs/ohdsi-network-studies.pdf

### Word Documents
- docs/project-overview.docx

## Options
- depth: comprehensive
- domain: clinical
- style: tutorial
```

**Note**: Use `sources/notebooklm_sources.md` for active ingestion. Keep `sources/sources.md` as a static reference document.

### Phase 1: Source Ingestion

**Command**: `/notebooklm-ingest-sources sources/notebooklm_sources.md`

**Process**:
1. Parse manifest file
2. For each YouTube video:
   - Extract transcript using yt-dlp
   - Save to `transcripts/youtube/`
3. For each website:
   - Fetch content via WebFetch
   - Convert to markdown
   - Save to `transcripts/web/`
4. For each document:
   - Convert via Markitdown MCP
   - Parse structure
   - Save to `parsed/`

**Output**:
```
output/
├── transcripts/
│   ├── youtube/
│   │   ├── video1_transcript.md
│   │   └── video2_transcript.md
│   └── web/
│       ├── website1.md
│       └── website2.md
├── parsed/
│   ├── document1_parsed.md
│   └── document2_parsed.md
└── combined/
    └── all_sources_combined.md
```

### Phase 2: Content Synthesis

**Command**: (Automatic as part of `/notebooklm-generate-all`)

**Process**:
1. Analyze combined sources
2. Extract key concepts
3. Identify relationships
4. Build knowledge graph
5. Generate structured outline

**Agents Used**:
- `@research-doc-parser` - Structure extraction
- `@research-ai-expert` or `@research-clinical-expert` - Domain analysis
- `@research-clinical-terminologist` - Vocabulary mapping (for OHDSI content)

### Phase 3: Artifact Generation

#### 3A: Generate Podcast

**Command**: `/notebooklm-generate-podcast output/combined/all_sources_combined.md`

**Process**:
1. Generate conversational script
   - Host + Expert dialogue
   - Natural language, engaging tone
   - 10-20 minute target length
2. Optimize for TTS
   - Add pronunciation guides
   - Insert pauses
   - Mark emphasis
3. Generate audio
   - Default: edge-tts (free)
   - Premium: ElevenLabs (requires API key)

**Output**:
```
output/podcasts/
├── scripts/
│   └── topic_podcast_script.md
└── audio/
    └── topic_podcast.mp3
```

#### 3B: Generate Flashcards

**Command**: `/notebooklm-generate-flashcards output/combined/all_sources_combined.md`

**Process**:
1. Extract key concepts
2. Create Q&A pairs
3. Add cloze deletions for definitions
4. Tag by topic and difficulty
5. Format for spaced repetition

**Output**:
```
output/flashcards/
└── topic_flashcards.md
```

**Card Count**: 25-50 cards per topic

#### 3C: Generate Quiz

**Command**: `/notebooklm-generate-quiz output/combined/all_sources_combined.md`

**Process**:
1. Generate question bank
   - Multiple choice (40-50%)
   - True/False with explanation (15-20%)
   - Fill-in-the-blank (15-20%)
   - Matching (10-15%)
   - Short answer (5-10%)
2. Create answer key
3. Add difficulty ratings
4. Include explanations

**Output**:
```
output/quizzes/
├── topic_quiz.md
└── topic_quiz_answers.md
```

**Question Count**: 15-25 questions per quiz

#### 3D: Generate Slides

**Command**: `/notebooklm-generate-slides output/combined/all_sources_combined.md`

**Process**:
1. Create slide outline
2. Generate Marp-compatible markdown
3. Add speaker notes
4. Include diagrams (Mermaid)
5. Export to PDF/HTML (optional)

**Output**:
```
output/slides/
├── marp/
│   └── topic_slides.md
└── exports/
    ├── topic_slides.pdf
    └── topic_slides.html
```

**Slide Count**: 15-25 slides per deck

#### 3E: Generate Mind Map

**Command**: `/notebooklm-generate-mindmap output/combined/all_sources_combined.md`

**Process**:
1. Identify central concept
2. Extract main branches
3. Build hierarchy
4. Generate three formats:
   - ASCII (terminal-friendly)
   - Mermaid (web-friendly)
   - Graphviz (high-resolution)

**Output**:
```
output/mindmaps/
├── topic_mindmap_ascii.md
├── topic_mindmap_mermaid.md
├── topic_mindmap_graphviz.md
└── topic_mindmap.svg
```

### Phase 4: Complete Workflow Command

**Command**: `/notebooklm-generate-all sources/notebooklm_sources.md`

**Process**: Executes all phases automatically:

```
sources.md
    ↓
[Phase 1] Ingest Sources
    ↓
[Phase 2] Synthesize Content
    ↓
[Phase 3A] Generate Podcast
[Phase 3B] Generate Flashcards
[Phase 3C] Generate Quiz
[Phase 3D] Generate Slides
[Phase 3E] Generate Mind Map
    ↓
[Phase 4] Compile Output Package
```

**Output Structure**:
```
output/
├── sources/
│   └── sources_manifest.md
├── transcripts/
│   ├── youtube/
│   └── web/
├── parsed/
├── combined/
│   └── all_sources_combined.md
├── podcasts/
│   ├── scripts/
│   └── audio/
├── flashcards/
├── quizzes/
├── slides/
│   ├── marp/
│   └── exports/
├── mindmaps/
└── README.md (artifact index)
```

## OHDSI-Specific Workflows

### OMOP CDM Learning Package

```bash
# Create comprehensive learning materials for OMOP CDM
/notebooklm-generate-all omop-cdm-sources.md
```

**Sources**:
- Book of OHDSI chapters
- OMOP CDM documentation
- OHDSI tutorial videos
- Network study examples

**Output Includes**:
- Podcast explaining CDM concepts
- Flashcards for CDM tables and vocabularies
- Quiz on CDM fundamentals
- Slide deck for training sessions
- Mind map of CDM structure

### HADES Package Tutorial

```bash
# Generate training materials for specific HADES package
/notebooklm-generate-all hades-cohortmethod-sources.md
```

**Sources**:
- CohortMethod vignettes
- OHDSI Methods Library documentation
- Example study protocols
- R code examples

## Quality Standards

### Podcast Standards
- Natural conversational flow
- Host + Expert format
- 10-20 minute duration
- Clear explanations of technical terms
- Engaging questions and answers

### Flashcard Standards
- One concept per card
- Clear, unambiguous questions
- Concise answers
- Appropriate difficulty tagging
- Spaced repetition optimized

### Quiz Standards
- Varied question types
- Balanced difficulty (30% easy, 50% medium, 20% hard)
- Complete answer key with explanations
- Clear learning objectives

### Slide Standards
- One idea per slide
- Maximum 6 bullet points
- Speaker notes included
- Marp/reveal.js compatible
- Visual hierarchy maintained

## Tool Dependencies

| Tool | Purpose | Required |
|------|---------|----------|
| yt-dlp | YouTube transcripts | Yes (for YouTube sources) |
| edge-tts | Audio generation | Yes (for podcasts) |
| marp-cli | Slide export | Optional (for PDF/HTML) |
| ElevenLabs | Premium TTS | Optional |

## Best Practices

1. **Start with Quality Sources**
   - Curate authoritative materials
   - Include diverse formats
   - Verify source accuracy

2. **Use Appropriate Depth**
   - `overview`: Quick reference (20-30 min artifacts)
   - `comprehensive`: Standard (45-60 min artifacts)
   - `deep-dive`: Exhaustive (60-90 min artifacts)

3. **Iterate and Refine**
   - Review generated artifacts
   - Edit scripts before audio generation
   - Customize flashcards for your learning needs

4. **Leverage OHDSI Expertise**
   - Use `@research-clinical-terminologist` for vocabulary
   - Use `@research-ohdsi-data-engineer` for ETL content
   - Reference OHDSI standards throughout

## See Also

- [Sources Manifest Template](../templates/sources-manifest-template.md)
- [Podcast Script Template](../templates/podcast-script-template.md)
- [Flashcard Template](../templates/flashcard-template.md)
- [Quiz Template](../templates/quiz-template.md)
- [Slide Deck Template](../templates/slide-deck-template.md)
- [OHDSI Standards](../standards/ohdsi-standards.md)
