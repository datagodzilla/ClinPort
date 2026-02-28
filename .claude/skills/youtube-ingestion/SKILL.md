---
name: youtube-ingestion
description: "Extract transcripts from YouTube videos for knowledge base ingestion. Uses yt-dlp for automatic transcript extraction with manual fallback support."
allowed-tools: read, write, bash, task
---

# YouTube Ingestion Skill

## Purpose
Extract and process YouTube video transcripts for integration into the research knowledge base. Supports automatic transcript extraction via yt-dlp with manual fallback when auto-extraction fails.

## When to Activate
- User provides YouTube video URLs for analysis
- Multi-source ingestion includes YouTube links
- Research content requires video transcript processing
- Building knowledge base from video sources

**Key Triggers**: youtube, video, transcript, yt-dlp, video URL

## Prerequisites

### Python Environment Setup

**CRITICAL**: Always use the `.venv` virtual environment for yt-dlp operations.

```bash
# Verify yt-dlp is available in .venv
.venv/bin/python -c "import yt_dlp; print(f'yt-dlp version: {yt_dlp.version.__version__}')"

# If missing, install:
.venv/bin/pip install yt-dlp
```

### Command Pattern
**Always use `.venv/bin/yt-dlp`** instead of bare `yt-dlp`:
```bash
# Correct
.venv/bin/yt-dlp --version
.venv/bin/python -c "import yt_dlp; ..."

# Incorrect
yt-dlp --version
python3 -c "import yt_dlp; ..."
```

## Transcript Extraction Methods

### Method 1: Automatic Extraction (Primary)
```bash
# Extract auto-generated subtitles
yt-dlp --write-auto-sub --sub-lang en --skip-download \
    --output "ingested/youtube/%(title)s" \
    "https://www.youtube.com/watch?v=VIDEO_ID"

# Extract manual subtitles (if available)
yt-dlp --write-sub --sub-lang en --skip-download \
    --output "ingested/youtube/%(title)s" \
    "https://www.youtube.com/watch?v=VIDEO_ID"
```

### Method 2: Python Script
```python
import yt_dlp
from pathlib import Path

def extract_transcript(video_url: str, output_dir: str = "ingested/youtube") -> str:
    """
    Extract transcript from YouTube video.

    Args:
        video_url: YouTube video URL
        output_dir: Directory to save transcript

    Returns:
        Path to saved transcript file
    """
    Path(output_dir).mkdir(parents=True, exist_ok=True)

    ydl_opts = {
        'writeautomaticsub': True,
        'writesubtitles': True,
        'subtitleslangs': ['en'],
        'skip_download': True,
        'outtmpl': f'{output_dir}/%(title)s',
        'quiet': True
    }

    with yt_dlp.YoutubeDL(ydl_opts) as ydl:
        info = ydl.extract_info(video_url, download=True)
        title = info.get('title', 'video')

        # Find the subtitle file
        for ext in ['.en.vtt', '.en.srt', '.vtt', '.srt']:
            subtitle_path = Path(f"{output_dir}/{title}{ext}")
            if subtitle_path.exists():
                return str(subtitle_path)

    raise FileNotFoundError("No transcript found for video")

def vtt_to_markdown(vtt_path: str) -> str:
    """Convert VTT subtitle file to clean markdown text."""
    import re

    with open(vtt_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Remove VTT header and timestamps
    lines = content.split('\n')
    text_lines = []
    skip_next = False

    for line in lines:
        line = line.strip()

        # Skip WEBVTT header
        if line.startswith('WEBVTT') or line.startswith('Kind:') or line.startswith('Language:'):
            continue

        # Skip timestamp lines
        if re.match(r'\d{2}:\d{2}:\d{2}\.\d{3}', line):
            continue

        # Skip empty lines and numeric cue identifiers
        if not line or line.isdigit():
            continue

        # Remove inline timestamps and tags
        line = re.sub(r'<[^>]+>', '', line)
        line = re.sub(r'\d{2}:\d{2}:\d{2}\.\d{3}', '', line)

        if line:
            text_lines.append(line)

    # Join and deduplicate consecutive identical lines
    result = []
    prev_line = None
    for line in text_lines:
        if line != prev_line:
            result.append(line)
            prev_line = line

    return ' '.join(result)
```

### Method 3: Manual Fallback
When automatic extraction fails:

1. **Check if video has captions**:
   - Open video in YouTube
   - Look for CC button
   - Check if auto-generated or manual captions exist

2. **Manual transcript entry**:
   ```markdown
   ---
   source_type: youtube
   source_url: [VIDEO_URL]
   video_title: [TITLE]
   channel: [CHANNEL_NAME]
   duration: [DURATION]
   upload_date: [DATE]
   extraction_method: manual
   ---

   # [Video Title]

   [Paste transcript text here]
   ```

3. **Alternative sources**:
   - YouTube Studio transcript (video owner)
   - Third-party transcript services
   - Audio transcription via Whisper

## Output Format

### Ingested Transcript Structure
```markdown
---
source_type: youtube
source_url: https://www.youtube.com/watch?v=VIDEO_ID
video_id: VIDEO_ID
video_title: [Title]
channel: [Channel Name]
duration: [HH:MM:SS]
upload_date: [YYYY-MM-DD]
extraction_date: [YYYY-MM-DD]
extraction_method: auto|manual
language: en
---

# [Video Title]

## Video Information
- **Channel**: [Channel Name]
- **Duration**: [Duration]
- **Published**: [Date]
- **URL**: [Link]

## Transcript

[Full transcript text organized into paragraphs]

## Key Timestamps
- [00:00] Introduction
- [05:30] Main topic begins
- [15:00] Key point discussed
- [25:00] Conclusion

## Summary
[Brief 2-3 sentence summary of video content]
```

### File Naming Convention
```
ingested/youtube/[sanitized-video-title]_transcript.md
```

Example:
```
ingested/youtube/ohdsi-tutorial-cohort-definitions_transcript.md
```

## Integration with Multi-Source Ingestion

### Sources Manifest Entry
```markdown
## YouTube Videos
- https://www.youtube.com/watch?v=abc123
- https://www.youtube.com/watch?v=def456
```

### Processing Pipeline
```
1. Parse YouTube URLs from manifest
2. For each URL:
   a. Extract video ID from URL
   b. Attempt auto transcript extraction (yt-dlp)
   c. If fails, check for manual subtitles
   d. If fails, prompt for manual entry
   e. Convert to markdown format
   f. Save to ingested/youtube/
3. Add to unified knowledge base
```

## Error Handling

### Common Issues and Solutions

| Issue | Cause | Solution |
|-------|-------|----------|
| No subtitles available | Video has no captions | Use manual fallback or audio transcription |
| Age-restricted video | Requires authentication | Use cookies or manual extraction |
| Private video | Access restricted | Request access or skip |
| Geo-blocked | Regional restriction | Use VPN or skip |
| Rate limiting | Too many requests | Add delays between requests |

### Error Response Template
```markdown
## YouTube Ingestion Failed

**Video**: [URL]
**Error**: [Error type]
**Reason**: [Explanation]

### Manual Fallback Required
Please provide the transcript manually:
1. Open video in YouTube
2. Click CC button
3. Open transcript (... menu → Open transcript)
4. Copy transcript text
5. Paste in the template below:

---
[Manual entry template]
---
```

## Best Practices

1. **Batch Processing**: Process multiple videos in sequence with delays
2. **Caching**: Cache extracted transcripts to avoid re-downloading
3. **Verification**: Verify transcript quality before adding to KB
4. **Metadata**: Always include video metadata for traceability
5. **Language**: Specify language for non-English videos

## Usage Example

```python
# Full ingestion workflow
from pathlib import Path

def ingest_youtube_videos(video_urls: list, output_dir: str = "ingested/youtube"):
    """Ingest multiple YouTube videos."""
    results = []

    for url in video_urls:
        try:
            # Extract transcript
            vtt_path = extract_transcript(url, output_dir)

            # Convert to markdown
            transcript_text = vtt_to_markdown(vtt_path)

            # Get video info
            info = get_video_info(url)

            # Create markdown document
            md_content = create_transcript_markdown(info, transcript_text)

            # Save
            md_path = Path(output_dir) / f"{sanitize_filename(info['title'])}_transcript.md"
            md_path.write_text(md_content)

            results.append({
                'url': url,
                'status': 'success',
                'path': str(md_path)
            })

        except Exception as e:
            results.append({
                'url': url,
                'status': 'failed',
                'error': str(e)
            })

    return results
```

## Video Frame Extraction

In addition to transcript extraction, this skill supports extracting key frames from videos at auto-detected important moments.

### Frame Extraction Command
```bash
/research-extract-video-frames "https://www.youtube.com/watch?v=VIDEO_ID"
```

### Frame Extraction Script
```bash
.venv/bin/python scripts/extract_video_frames.py \
    "https://www.youtube.com/watch?v=VIDEO_ID" \
    --output-dir ingested/video-frames/ \
    --max-frames 15 \
    --min-gap 30
```

### Key Moment Detection
The script analyzes transcripts to find:
- **Concept introductions**: "let me explain", "this is called"
- **Demo starts**: "let me show you", "here's an example"
- **Diagram references**: "as you can see", "this diagram shows"
- **Section transitions**: "moving on", "next topic"

### Frame Output Structure
```
ingested/video-frames/[video-id]/
├── frame-001-0m30s-concept-intro.png
├── frame-002-2m15s-diagram-architecture.png
├── frame-003-5m00s-demo-example.png
├── [video-id].en.vtt           # Downloaded transcript
└── manifest.yaml               # Extraction metadata
```

### Frame Manifest Format
```yaml
video:
  id: "VIDEO_ID"
  title: "Video Title"
  channel: "Channel Name"
  duration_seconds: 1234

extraction:
  date: "2025-12-15"
  total_frames: 12

frames:
  - filename: "frame-001-0m30s-concept-intro.png"
    timestamp_seconds: 30
    moment_type: "concept"
    description: "Speaker introduces the main concept"

summary:
  by_moment_type:
    concept: 4
    demo: 3
    diagram: 3
    transition: 2
```

### Integration with Ingestion
Use the `--extract-frames` flag with source ingestion:
```bash
/notebooklm-ingest-sources sources/manifest.md --extract-frames
```

## See Also
- Command: /notebooklm-ingest-sources
- Command: /research-extract-video-frames
- Workflow: notebooklm-complete-workflow.md
- Skill: podcast-generation (for audio output)
- Script: scripts/extract_video_frames.py
