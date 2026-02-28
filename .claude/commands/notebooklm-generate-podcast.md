---
argument-hint: "Topic name or path to knowledge base content"
allowed-tools: read, write, bash, task
description: "Generate an audio podcast with conversational dialogue from research content"
---

# Podcast Generation Command


## ⚠️ Argument Required

**Input received:** `$ARGUMENTS`

**If no argument is provided**, display this help information and stop:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Podcast Generation Command
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

DESCRIPTION:
  Generate an audio podcast with conversational dialogue from research content

USAGE:
  /notebooklm-generate-podcast Topic name or path to knowledge base content

REQUIRED ARGUMENTS:
    Topic name or path to knowledge base content

OPTIONAL ARGUMENTS:
    (none)

EXAMPLES:
  /notebooklm-generate-podcast "example-argument"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Run the command with required arguments to proceed.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**If arguments ARE provided**, proceed with the command below.

---
## Purpose
Generate a conversational audio podcast from research content, featuring a host and expert discussing the topic in an engaging, educational format.

## Pre-Execution: Python Environment Setup

**CRITICAL**: Podcast generation requires the `.venv` virtual environment with `edge-tts` and `pydub`.

### Step 0: Verify Environment

```bash
# Verify .venv and required packages
.venv/bin/python -c "
import edge_tts
import pydub
print('✓ Podcast dependencies available')
print(f'  edge-tts: {edge_tts.__version__}')
"
```

If packages are missing:
```bash
.venv/bin/pip install edge-tts pydub
```

### Python Execution Pattern
**Always use `.venv/bin/python`** for all podcast generation scripts:
```bash
# Audio generation
.venv/bin/python -c "import edge_tts; ..."

# Edge-tts CLI
.venv/bin/edge-tts --text "Hello" --write-media output.mp3
```

## Input Options

### Option 1: Topic Name
```
/notebooklm-generate-podcast "OMOP CDM Overview"
```
Uses content from `docs/[topic]/` or `ingested/` directories.

### Option 2: Knowledge Base Path
```
/notebooklm-generate-podcast ingested/manifest.md
```
Uses the unified knowledge base from source ingestion.

### Option 3: Specific Document
```
/notebooklm-generate-podcast docs/research/summary.md
```
Generates podcast from a single document.

## Execution Workflow

### Phase 1: Content Analysis
1. Load source content (from topic, KB, or document)
2. Identify key concepts and themes
3. Extract main points for discussion
4. Determine target duration (15-20 minutes default)

### Phase 2: Script Generation
Generate conversational script with two personas:

**Host (Alex)**: Curious, engaging, asks clarifying questions
**Expert (Dr. Taylor)**: Knowledgeable, explains clearly, uses analogies

Script structure:
1. **Introduction** (30-60 seconds) - Welcome, topic introduction
2. **Core Concepts** (4-5 minutes) - Foundational explanation
3. **Deep Dive** (6-8 minutes) - Detailed exploration
4. **Practical Applications** (3-4 minutes) - Real-world uses
5. **Future & Closing** (2-3 minutes) - Takeaways and wrap-up

### Phase 3: Script Review
Output script for user review before audio generation:
- Save to `output/podcasts/[topic]/[topic]_script.md`
- Display summary and estimated duration
- Ask for approval to proceed with audio

### Phase 4: Audio Generation

**CRITICAL**: After script generation, ALWAYS run the audio generation script.

**Generate Audio from Script**:
```bash
# Generate the podcast audio using the generate_podcast_audio.py script
.venv/bin/python scripts/generate_podcast_audio.py \
    "[script_path]" \
    "[output_mp3_path]" \
    --topic "[topic_name]"
```

**Example**:
```bash
.venv/bin/python scripts/generate_podcast_audio.py \
    "research/2025/December/12/01-topic/artifacts/podcasts/topic_script.md" \
    "research/2025/December/12/01-topic/artifacts/podcasts/topic_podcast.mp3" \
    --topic "Topic Name"
```

**What the script does**:
1. Parses the script for [SPEAKER]: or **Speaker**: format
2. Assigns voices (Alex/Host = male, Sam/Expert = female)
3. Generates audio for each segment using edge-tts
4. Combines segments with 500ms pauses
5. Exports final MP3 (192kbps)
6. Creates metadata JSON file

**Voice Assignments** (automatic):
| Speaker | Voice |
|---------|-------|
| ALEX, HOST | en-US-GuyNeural (male) |
| SAM, EXPERT | en-US-JennyNeural (female) |
| DR. TAYLOR | en-US-AriaNeural (female) |
| NARRATOR | en-US-DavisNeural (male) |

### Phase 5: Post-Processing
The audio generation script automatically:
1. Normalizes audio levels
2. Creates metadata.json with duration, file size, etc.
3. Cleans up temporary files

## Output Structure

```
output/podcasts/[topic]/
├── [topic]_script.md              # Full podcast script
├── [topic]_script_timed.md        # Script with timestamps
├── [topic]_podcast.mp3            # Final audio (edge-tts)
├── [topic]_podcast_premium.mp3    # Premium audio (ElevenLabs)
├── segments/                       # Individual segments
│   ├── 01_introduction.mp3
│   ├── 02_core_concepts.mp3
│   └── ...
└── metadata.json                  # Podcast metadata
```

## Script Template

```markdown
---
title: "[Topic] - Research Insights"
duration_target: "15-20 minutes"
hosts:
  - name: "Alex"
    role: "Host"
    voice: "en-US-GuyNeural"
  - name: "Dr. Taylor"
    role: "Expert"
    voice: "en-US-JennyNeural"
---

# Podcast Script: [Topic]

## SEGMENT 1: Introduction (45 seconds)

[HOST]: Welcome to Research Insights! I'm Alex, and today we're exploring [TOPIC]. This is a fascinating area that's really transforming how we think about [DOMAIN]. I'm joined by Dr. Taylor, an expert in [FIELD]. Welcome!

[EXPERT]: Thanks, Alex! I'm excited to discuss this. [TOPIC] is one of those subjects that sounds complex but becomes incredibly intuitive once you understand the fundamentals.

[HOST]: Perfect! Let's start from the beginning...

## SEGMENT 2: Core Concepts (5 minutes)

[HOST]: So, what exactly is [TOPIC]?

[EXPERT]: Great question! At its heart, [TOPIC] is about...

[Continue with remaining segments...]
```

## Voice Options

### edge-tts (Free)
| Voice ID | Gender | Style |
|----------|--------|-------|
| en-US-GuyNeural | Male | Conversational |
| en-US-JennyNeural | Female | Friendly |
| en-US-ChristopherNeural | Male | Professional |
| en-US-AriaNeural | Female | Expressive |

### ElevenLabs (Premium)
Requires `ELEVENLABS_API_KEY` environment variable.
Higher quality, more natural-sounding voices.

## Configuration Options

### Duration Control
- Short (5-10 min): Quick overview
- Standard (15-20 min): Full discussion
- Extended (30-45 min): Comprehensive deep dive

### Style Options
- Educational: Focus on teaching concepts
- Conversational: Casual discussion
- Interview: Q&A format

## Error Handling

### Script Generation
- Insufficient content: Request more source material
- Content too long: Summarize and focus on key points

### Audio Generation
- edge-tts failure: Retry or fall back to text-only
- ElevenLabs quota: Fall back to edge-tts
- Audio processing error: Save segments individually

## Usage Examples

### Generate from Topic
```
/notebooklm-generate-podcast "OHDSI Cohort Definitions"
```

### Generate from Knowledge Base
```
/notebooklm-generate-podcast ingested/manifest.md
```

### Generate with Premium Audio
```
/notebooklm-generate-podcast "OMOP CDM" --premium
```

## Success Criteria

Podcast generation complete when:
- [ ] Script generated with all segments
- [ ] Script approved by user (or auto-approved)
- [ ] Audio generated for all segments
- [ ] Segments combined into final podcast
- [ ] Metadata file created
- [ ] Output files saved to correct location

## Example Output

```
🎙️ Podcast Generation Complete

📝 Script: output/podcasts/omop-cdm/omop-cdm_script.md
🎵 Audio: output/podcasts/omop-cdm/omop-cdm_podcast.mp3

⏱️ Duration: 18:42
🔊 TTS Provider: edge-tts

📊 Segments:
1. Introduction (0:45)
2. Core Concepts (5:12)
3. Deep Dive (7:28)
4. Applications (3:15)
5. Closing (2:02)

✅ Ready for playback!
```
