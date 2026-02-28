---
argument-hint: "Path to sources manifest file (e.g., sources/sources.md)"
allowed-tools: read, write, bash, task, glob, grep, webfetch
description: "Generate podcast script AND audio file from ingested sources - complete podcast workflow"
---

# NotebookLM Generate Podcast Audio Command


## ⚠️ Argument Required

**Input received:** `$ARGUMENTS`

**If no argument is provided**, display this help information and stop:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NotebookLM Generate Podcast Audio Command
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

DESCRIPTION:
  Generate podcast script AND audio file from ingested sources - complete podcast workflow

USAGE:
  /notebooklm-generate-podcast-audio Path to sources manifest file (e.g., sources/sources.md)

REQUIRED ARGUMENTS:
    Path to sources manifest file (e.g., sources/sources.md)

OPTIONAL ARGUMENTS:
    (none)

EXAMPLES:
  /notebooklm-generate-podcast-audio "example-argument"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Run the command with required arguments to proceed.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**If arguments ARE provided**, proceed with the command below.

---
## Purpose

This is a **standalone podcast generation command** that creates both the podcast script AND audio file from source materials. Unlike the full `/notebooklm-generate-all` pipeline, this command focuses exclusively on podcast generation.

## What This Command Does

```
sources/sources.md → Ingest Sources → Generate Script → Generate Audio → Final Podcast
```

1. **Ingests** all sources from the manifest (YouTube, URLs, PDFs, docs)
2. **Analyzes** content using domain experts
3. **Generates** conversational podcast script
4. **Creates** MP3 audio using edge-tts
5. **Outputs** script + audio + metadata

## Pre-Execution: Environment Verification

```bash
# Verify .venv and required packages
.venv/bin/python -c "
import edge_tts
import pydub
print('✓ Podcast dependencies available')
"
```

## Input Format

### Sources Manifest (sources.md)

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

## PDF Documents
- sources/pdfs/document.pdf

## Research Notes
- Key concepts to cover
- Questions to answer
```

## Execution Workflow

### Phase 1: Source Ingestion

1. Parse the sources manifest file
2. Extract content from each source type:
   - **YouTube**: Use yt-dlp to extract transcripts
   - **Websites**: Fetch and convert to markdown
   - **PDFs/Docs**: Parse using document parser
3. Create unified knowledge base content

### Phase 2: Content Analysis

Spawn domain expert agents to analyze content:

| Content Type | Agent |
|--------------|-------|
| Clinical/Healthcare | `@research-clinical-expert` |
| AI/Technical | `@research-ai-expert` |
| Mixed | Both agents |

Analysis focuses on:
- Key concepts and themes
- Main insights and findings
- Practical applications
- Discussion-worthy topics

### Phase 3: Script Generation

Generate conversational podcast script with two personas:

**Host (Alex)**: Curious, engaging, asks clarifying questions
**Expert (Sam)**: Knowledgeable, explains clearly, uses Feynman technique

Script structure:
1. **Introduction** (30-60 seconds) - Welcome, topic hook
2. **Core Concepts** (4-5 minutes) - Foundational explanations
3. **Deep Dive** (6-8 minutes) - Detailed exploration
4. **Practical Applications** (3-4 minutes) - Real-world uses
5. **Takeaways & Closing** (2-3 minutes) - Summary and wrap-up

Script format:
```markdown
---
title: "[Topic] - Research Insights"
duration_target: "15-20 minutes"
---

# Podcast Script: [Topic]

## SEGMENT 1: Introduction

[HOST]: Welcome to Research Insights! I'm Alex, and today...

[EXPERT]: Thanks, Alex! I'm excited to discuss...

## SEGMENT 2: Core Concepts

[HOST]: So, what exactly is [TOPIC]?

[EXPERT]: Great question! At its heart...
```

### Phase 4: Audio Generation

**CRITICAL**: Always generate audio after script creation.

```bash
# Generate podcast audio
.venv/bin/python scripts/generate_podcast_audio.py \
    "[research_folder]/artifacts/podcasts/[topic]_script.md" \
    "[research_folder]/artifacts/podcasts/[topic]_podcast.mp3" \
    --topic "[Topic Name]"
```

Voice assignments (automatic):
| Speaker | Voice |
|---------|-------|
| ALEX, HOST | en-US-GuyNeural (male) |
| SAM, EXPERT | en-US-JennyNeural (female) |
| DR. TAYLOR | en-US-AriaNeural (female) |

### Phase 5: Output Verification

Verify all outputs exist:
- `[topic]_script.md` - Podcast script
- `[topic]_podcast.mp3` - Audio file
- `[topic]_podcast.json` - Metadata

## Output Structure

```
research/YYYY/MonthName/DD/NN-topic/
└── artifacts/
    └── podcasts/
        ├── [topic]_script.md        # Full podcast script
        ├── [topic]_podcast.mp3      # Generated audio (15-20 min)
        └── [topic]_podcast.json     # Metadata (duration, size, etc.)
```

## Execution Instructions

### Step 1: Parse Sources Manifest

Read the sources.md file and identify:
- Topic name from Project Information table
- All source URLs and file paths
- Domain type (clinical/technical/mixed)

### Step 2: Ingest Sources

For each source type:

**YouTube Videos**:
```bash
# Extract transcript
yt-dlp --write-auto-sub --skip-download --sub-lang en \
    -o "ingested/youtube_%(id)s" "URL"
```

**Websites**:
Use WebFetch tool to retrieve and convert content.

**PDF/Documents**:
Use document-parsing skill to extract text.

### Step 3: Analyze Content

Spawn appropriate expert agent:
```
Task: @research-ai-expert (or @research-clinical-expert)
Prompt: Analyze the following content and identify:
1. Key concepts and themes (5-7 main topics)
2. Important insights and findings
3. Practical applications
4. Engaging discussion points for a podcast

Content:
[ingested content here]
```

### Step 4: Generate Script

Use the podcast-generation skill to create the script:
```
Skill: podcast-generation

Generate a 15-20 minute conversational podcast script with:
- Host: Alex (curious, engaging)
- Expert: Sam (knowledgeable, uses analogies)

Topic: [Topic from manifest]
Key Points: [From analysis]
Target Duration: 15-20 minutes

Apply Feynman Technique:
- Start with simple explanations
- Use analogies and metaphors
- Build from simple to complex
- Tie to practical examples
```

### Step 5: Generate Audio

```bash
.venv/bin/python scripts/generate_podcast_audio.py \
    "[script_path]" \
    "[output_mp3_path]" \
    --topic "[Topic Name]"
```

### Step 6: Verify and Report

Check outputs and display summary:
```
🎙️ Podcast Generation Complete!

📝 Script: artifacts/podcasts/[topic]_script.md
🎵 Audio: artifacts/podcasts/[topic]_podcast.mp3

⏱️ Duration: 18:42
📦 File Size: 14.5 MB
🔊 TTS Provider: edge-tts

✅ Ready for blog embedding!
```

## Usage Examples

### Basic Usage
```bash
/notebooklm-generate-podcast-audio sources/sources.md
```

### From Existing Research Folder
```bash
/notebooklm-generate-podcast-audio research/2025/December/12/01-topic/sources/sources.md
```

### Regenerate Audio Only (if script exists)
```bash
# Use the generate_podcast_audio.py script directly
.venv/bin/python scripts/generate_podcast_audio.py \
    artifacts/podcasts/topic_script.md \
    artifacts/podcasts/topic_podcast.mp3 \
    --topic "Topic Name"
```

## Error Handling

| Error | Recovery |
|-------|----------|
| YouTube transcript unavailable | Try manual transcript, or skip with note |
| Website fetch fails | Retry once, then use available sources |
| Script generation fails | Use simpler template, reduce scope |
| Audio generation fails | Save script, retry audio separately |
| Insufficient content | Request minimum 500 words of source material |

## Success Criteria

Podcast generation complete when:
- [ ] All accessible sources ingested
- [ ] Content analyzed by domain expert
- [ ] Script generated (15-20 minute target)
- [ ] Audio file created (MP3 format)
- [ ] Metadata JSON saved
- [ ] Output files in correct location

## Integration with Blog Publishing

After generating the podcast, embed in blog posts using:

```markdown
## Listen to This Article

<div class="podcast-player">
<audio controls preload="metadata">
  <source src="{{ page.podcast_url }}" type="audio/mpeg">
</audio>
<p><a href="{{ page.podcast_url }}" download>Download MP3</a></p>
</div>
```

Add to blog frontmatter:
```yaml
podcast_url: /assets/audio/[topic]_podcast.mp3
podcast_duration: "18:42"
```

## See Also

- `/notebooklm-generate-all` - Full artifact generation pipeline
- `/notebooklm-generate-podcast` - Legacy script-only command
- `scripts/generate_podcast_audio.py` - Audio generation script
- Skill: `podcast-generation` - Script creation
