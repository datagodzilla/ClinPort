---
name: podcast-generation
description: "Generate audio podcasts from knowledge content using text-to-speech. Supports edge-tts (free) and ElevenLabs (premium) for conversational podcast creation."
allowed-tools: read, write, bash, task
---

# Podcast Generation Skill

## Purpose
Transform research content into engaging audio podcasts with conversational dialogue between a host and expert. Supports free (edge-tts) and premium (ElevenLabs) text-to-speech options.

## When to Activate
- User requests podcast generation from content
- NotebookLM-style audio output needed
- Converting research to audio format
- Creating educational audio content

**Key Triggers**: podcast, audio, tts, text-to-speech, spoken, listen

## Prerequisites

### Free Option: edge-tts
```bash
pip install edge-tts
```

### Premium Option: ElevenLabs
```bash
pip install elevenlabs

# Set API key
export ELEVENLABS_API_KEY="your-api-key"
```

## Podcast Script Structure

### Script Template
```markdown
---
title: "[Topic] - Deep Dive"
duration_target: "15-20 minutes"
style: "conversational, educational"
hosts:
  - name: "Alex"
    role: "Host"
    voice_id: "en-US-GuyNeural"  # edge-tts
    personality: "Curious, engaging, asks clarifying questions"
  - name: "Dr. Taylor"
    role: "Expert"
    voice_id: "en-US-JennyNeural"  # edge-tts
    personality: "Knowledgeable, explains clearly, uses analogies"
---

# Podcast Script: [Topic]

## SEGMENT 1: Introduction (30-60 seconds)

[HOST]: Welcome to Research Insights, the podcast where we break down complex topics into digestible conversations. I'm Alex, and today we're diving into [TOPIC]. Joining me is Dr. Taylor, an expert in [FIELD]. Dr. Taylor, thanks for being here!

[EXPERT]: Thanks for having me, Alex! This is such a fascinating topic, and I'm excited to unpack it for our listeners.

[HOST]: So let's start with the basics. For someone who's never heard of [TOPIC], what exactly are we talking about?

## SEGMENT 2: Core Concepts (4-5 minutes)

[EXPERT]: Great question! Think of [TOPIC] like this... [ANALOGY]

[HOST]: Oh, that's a helpful way to think about it. So when you say [TERM], what does that mean in practice?

[EXPERT]: Right, so [EXPLANATION]. The key thing to understand is [KEY POINT].

[HOST]: And why should our listeners care about this? What's the real-world impact?

[EXPERT]: That's the exciting part! [IMPACT/APPLICATION]

## SEGMENT 3: Deep Dive (6-8 minutes)

[HOST]: Let's dig deeper into [SPECIFIC ASPECT]. I've heard that [COMMON QUESTION/MISCONCEPTION]?

[EXPERT]: Yes, that's a common question! The reality is [CLARIFICATION]. What's really happening is [DETAILED EXPLANATION].

[HOST]: Interesting! And how does this relate to [RELATED CONCEPT]?

[EXPERT]: They're actually closely connected. [CONNECTION EXPLANATION]

## SEGMENT 4: Practical Applications (3-4 minutes)

[HOST]: So if someone wanted to apply this knowledge, what would that look like?

[EXPERT]: There are several practical applications. First, [APPLICATION 1]. Second, [APPLICATION 2]. And increasingly, we're seeing [APPLICATION 3].

[HOST]: Are there any common pitfalls or mistakes people should avoid?

[EXPERT]: Definitely. The biggest one is [PITFALL]. Instead, you should [RECOMMENDATION].

## SEGMENT 5: Future & Closing (2-3 minutes)

[HOST]: Where do you see this field heading? What's on the horizon?

[EXPERT]: We're seeing exciting developments in [FUTURE TREND]. I think in the next few years, we'll see [PREDICTION].

[HOST]: That's fascinating! Before we wrap up, what's the one thing you want our listeners to remember from today?

[EXPERT]: If they take away just one thing, it's this: [KEY TAKEAWAY].

[HOST]: Brilliant! Dr. Taylor, thank you so much for joining us today.

[EXPERT]: My pleasure, Alex. This was fun!

[HOST]: And thank you to our listeners! Don't forget to check out our show notes for links and resources. Until next time, keep learning!

## END
```

## Audio Generation

### Option 1: edge-tts (Free)
```python
import edge_tts
import asyncio
from pathlib import Path
from pydub import AudioSegment
import re

# Voice options for edge-tts
VOICES = {
    'host_male': 'en-US-GuyNeural',
    'host_female': 'en-US-JennyNeural',
    'expert_male': 'en-US-ChristopherNeural',
    'expert_female': 'en-US-AriaNeural',
    'narrator': 'en-US-DavisNeural'
}

async def text_to_speech(text: str, voice: str, output_path: str):
    """Convert text to speech using edge-tts."""
    communicate = edge_tts.Communicate(text, voice)
    await communicate.save(output_path)

def parse_script(script_path: str) -> list:
    """Parse podcast script into segments."""
    with open(script_path, 'r') as f:
        content = f.read()

    segments = []
    pattern = r'\[(HOST|EXPERT)\]:\s*(.+?)(?=\n\[|$)'
    matches = re.findall(pattern, content, re.DOTALL)

    for speaker, text in matches:
        segments.append({
            'speaker': speaker,
            'text': text.strip(),
            'voice': VOICES['host_male'] if speaker == 'HOST' else VOICES['expert_female']
        })

    return segments

async def generate_podcast(script_path: str, output_path: str):
    """Generate complete podcast from script."""
    segments = parse_script(script_path)
    audio_segments = []
    temp_dir = Path("temp_audio")
    temp_dir.mkdir(exist_ok=True)

    for i, segment in enumerate(segments):
        temp_file = temp_dir / f"segment_{i:03d}.mp3"

        await text_to_speech(
            segment['text'],
            segment['voice'],
            str(temp_file)
        )

        audio = AudioSegment.from_mp3(str(temp_file))
        audio_segments.append(audio)

        # Add pause between speakers
        audio_segments.append(AudioSegment.silent(duration=500))

    # Combine all segments
    final_audio = sum(audio_segments)

    # Export
    final_audio.export(output_path, format="mp3", bitrate="192k")

    # Cleanup
    for f in temp_dir.glob("*.mp3"):
        f.unlink()
    temp_dir.rmdir()

    return output_path

# Usage
if __name__ == "__main__":
    asyncio.run(generate_podcast(
        "output/podcasts/topic_script.md",
        "output/podcasts/topic_podcast.mp3"
    ))
```

### Option 2: ElevenLabs (Premium)
```python
from elevenlabs import generate, save, set_api_key, voices
from pathlib import Path
import os

set_api_key(os.getenv("ELEVENLABS_API_KEY"))

# ElevenLabs voice IDs
ELEVENLABS_VOICES = {
    'host': 'pNInz6obpgDQGcFmaJgB',  # Adam
    'expert': 'EXAVITQu4vr4xnSDxMaL',  # Sarah
}

def generate_segment(text: str, voice_id: str, output_path: str):
    """Generate audio for a single segment."""
    audio = generate(
        text=text,
        voice=voice_id,
        model="eleven_monolingual_v1"
    )
    save(audio, output_path)

def generate_podcast_elevenlabs(script_path: str, output_path: str):
    """Generate podcast using ElevenLabs."""
    segments = parse_script(script_path)
    audio_files = []
    temp_dir = Path("temp_audio")
    temp_dir.mkdir(exist_ok=True)

    for i, segment in enumerate(segments):
        temp_file = temp_dir / f"segment_{i:03d}.mp3"
        voice_id = (ELEVENLABS_VOICES['host']
                   if segment['speaker'] == 'HOST'
                   else ELEVENLABS_VOICES['expert'])

        generate_segment(segment['text'], voice_id, str(temp_file))
        audio_files.append(temp_file)

    # Combine using pydub
    combined = AudioSegment.empty()
    for f in audio_files:
        audio = AudioSegment.from_mp3(str(f))
        combined += audio
        combined += AudioSegment.silent(duration=500)

    combined.export(output_path, format="mp3", bitrate="320k")

    # Cleanup
    for f in audio_files:
        f.unlink()
    temp_dir.rmdir()
```

## Script Generation from Content

### Content to Script Conversion
```python
def generate_podcast_script(
    content: str,
    topic: str,
    target_duration: int = 15  # minutes
) -> str:
    """
    Generate a podcast script from source content.

    Uses the content to create a conversational dialogue
    between host and expert.
    """
    script = f"""---
title: "{topic} - Research Insights"
duration_target: "{target_duration} minutes"
generation_date: "{datetime.now().isoformat()}"
source_content: "knowledge_base"
---

# Podcast Script: {topic}

## SEGMENT 1: Introduction (45 seconds)

[HOST]: Welcome back to Research Insights! I'm your host, and today we're exploring {topic}. This is a fascinating area that's really transforming how we think about [DOMAIN]. I'm joined by our resident expert to break it all down. Welcome!

[EXPERT]: Thanks! I'm really excited to discuss this. {topic} is one of those topics that sounds complex but becomes incredibly intuitive once you understand the core principles.

[HOST]: Perfect! Let's start from the beginning. What exactly is {topic}?

## SEGMENT 2: Core Explanation (5 minutes)

[EXPERT]: At its heart, {topic} is about...

[Continue generating based on content...]
"""

    # Use LLM to expand script based on content
    # This would involve calling the research agents to structure the content

    return script
```

## Output Structure

### Generated Files
```
output/podcasts/[topic]/
├── [topic]_script.md           # Full podcast script
├── [topic]_script_timed.md     # Script with timestamps
├── [topic]_podcast.mp3         # Final audio file
├── [topic]_podcast_hq.mp3      # High quality version (ElevenLabs)
├── segments/                    # Individual segments
│   ├── 001_intro.mp3
│   ├── 002_core_concepts.mp3
│   └── ...
└── metadata.json               # Podcast metadata
```

### Metadata Format
```json
{
  "title": "Topic - Research Insights",
  "duration_seconds": 912,
  "duration_formatted": "15:12",
  "generation_date": "2024-01-15T10:30:00Z",
  "tts_provider": "edge-tts",
  "voices": {
    "host": "en-US-GuyNeural",
    "expert": "en-US-JennyNeural"
  },
  "source_content": "docs/topic/knowledge_base.md",
  "segments": [
    {"name": "Introduction", "start": 0, "end": 45},
    {"name": "Core Concepts", "start": 45, "end": 345}
  ]
}
```

## Voice Selection Guide

### edge-tts Voices (Free)
| Voice ID | Gender | Style | Best For |
|----------|--------|-------|----------|
| en-US-GuyNeural | Male | Conversational | Host |
| en-US-ChristopherNeural | Male | Professional | Expert |
| en-US-JennyNeural | Female | Friendly | Host/Expert |
| en-US-AriaNeural | Female | Expressive | Narrator |
| en-US-DavisNeural | Male | Authoritative | Narrator |

### ElevenLabs Voices (Premium)
| Voice | Style | Best For |
|-------|-------|----------|
| Adam | Natural, warm | Host |
| Sarah | Clear, professional | Expert |
| Antoni | Engaging | Narrator |
| Domi | Conversational | Guest |

## Best Practices

1. **Script Quality**: Well-written scripts produce better audio
2. **Pacing**: Include natural pauses and transitions
3. **Pronunciation**: Spell out technical terms phonetically if needed
4. **Length**: 15-20 minutes is optimal for engagement
5. **Testing**: Preview with short segments before full generation

## Integration

### Command Usage
```
/notebooklm-generate-podcast [topic_or_path]
```

### Workflow Integration
Part of the `/notebooklm-generate-all` workflow that creates all artifact types from ingested sources.

## See Also
- Command: /notebooklm-generate-podcast
- Skill: youtube-ingestion (for source content)
- Workflow: notebooklm-complete-workflow.md
