---
name: comic-storyboard-generation
description: "Generate educational comic storyboards from concepts. Transform complex ideas into engaging visual narratives with panel-based layouts. Supports placeholder mode (fast) and AI-illustrated mode (creative)."
allowed-tools: read, write, bash
---

# Comic Storyboard Generation Skill

## Purpose

Transform complex concepts into engaging comic-style visual narratives using:
- Structured panel layouts (2, 4, 6, or 8 panels)
- Multiple style presets (educational, narrative, technical, humorous)
- Two generation modes: placeholder (fast SVG/HTML) and illustrated (AI images)
- Narrative beat templates for effective storytelling

## When to Activate

- User wants to explain a concept visually
- Creating engaging educational content
- Building tutorial materials with visual storytelling
- Making complex topics accessible through comics

**Key Triggers**: comic, storyboard, visual story, narrative panels, explain visually, comic strip

## Panel Layouts

### 2-Panel Layout (2x1)
**Use Case**: Before/After, Problem/Solution comparisons

**Beats**:
1. Problem/Challenge
2. Solution/Resolution

### 4-Panel Layout (2x2)
**Use Case**: Standard story arc, process explanations

**Beats**:
1. Introduction
2. Challenge
3. Action
4. Resolution

### 6-Panel Layout (2x3)
**Use Case**: Detailed explanations, complex workflows

**Beats**:
1. Setup
2. Introduction
3. Rising Action
4. Climax
5. Falling Action
6. Resolution

### 8-Panel Layout (4x2)
**Use Case**: In-depth tutorials, multi-step processes

**Beats**:
1. Context
2. Problem
3. Discovery
4. Plan
5. Action 1
6. Action 2
7. Result
8. Lesson

## Style Presets

### Educational
Clear, instructive, friendly tone with bright colors.
- **Visual**: Clean lines, simple shapes, labeled elements
- **Dialogue**: Explanatory, step-by-step, uses analogies
- **Colors**: Blue accent (#3182CE)

### Narrative
Story-driven, character-focused with warm colors.
- **Visual**: Expressive characters, dynamic compositions
- **Dialogue**: Conversational, character-driven
- **Colors**: Red accent (#E53E3E)

### Technical
Process-focused, detailed with blue tones.
- **Visual**: Diagrams, flowcharts, annotations
- **Dialogue**: Precise, uses technical terms
- **Colors**: Blue accent (#4299E1)

### Humorous
Engaging, light-hearted with yellow tones.
- **Visual**: Cartoon style, exaggerated expressions
- **Dialogue**: Witty, uses jokes
- **Colors**: Yellow accent (#ECC94B)

## Generation Modes

### Placeholder Mode (Default)
Fast generation of SVG or HTML layouts with:
- Panel borders and structure
- Visual placeholder areas
- Description and dialogue text
- Styled according to preset

**Output**: `.svg` or `.html` file

### Illustrated Mode
AI-generated illustrations for each panel using:
- Stable Diffusion for panel images
- Integration with infographic-generation skill
- Consistent style across panels

**Output**: Composite image or individual panel images

## Usage

### Command
```bash
/notebooklm-generate-comic "<concept>" "<output-path>" --panels 4 --style educational
```

### Python Script
```bash
.venv/bin/python scripts/generate_comic_storyboard.py \
    "How FHIR API authentication works" \
    artifacts/comics/fhir-auth.svg \
    --panels 4 \
    --style educational \
    --format svg
```

### Python API
```python
from scripts.generate_comic_storyboard import ComicStoryboardGenerator

generator = ComicStoryboardGenerator(mode="placeholder")

result = generator.generate(
    concept="How FHIR API authentication works",
    output_path="artifacts/comics/fhir-auth.svg",
    num_panels=4,
    style="educational",
    title="FHIR Authentication",
    output_format="svg"
)
```

## Output Structure

**Default output location**: `sources/artifacts/comics/`

```
sources/artifacts/comics/
├── [topic]-storyboard.svg         # SVG placeholder version
├── [topic]-storyboard.html        # HTML interactive version
├── [topic]-storyboard.yaml        # Manifest with metadata
├── [topic]-storyboard-illustrated.png  # Optional AI version
└── panels/                        # Individual panel images
    ├── panel-1.png
    ├── panel-2.png
    └── ...
```

## Manifest Format

```yaml
title: "Understanding FHIR Authentication"
concept: "How FHIR API authentication works"
style: educational
style_name: Educational
num_panels: 4
layout: "2x2"
dimensions: [880, 820]
mode: placeholder
output_path: "artifacts/comics/fhir-auth.svg"
output_format: svg
generation_date: "2025-12-15T10:30:00"
panels:
  - number: 1
    title: "Introduction"
    description: "Introduce the concept of FHIR authentication"
    dialogue: '"Let me explain FHIR..."'
    visual_notes: "Show FHIR logo and API concept"
  - number: 2
    title: "Challenge"
    description: "Show the authentication challenge"
    dialogue: '"How do we secure API access?"'
    visual_notes: "Show locked API endpoint"
```

## Effective Concepts

### Good for Comics
- Step-by-step processes
- Before/after transformations
- Problem/solution narratives
- Journey or flow explanations
- Comparisons and contrasts

### Examples by Style

**Educational**:
```
"How an HTTP request travels from browser to server and back"
"The journey of healthcare data from EHR to research database"
```

**Technical**:
```
"ETL pipeline stages from source data to standardized tables"
"OAuth 2.0 authorization flow with all participants"
```

**Narrative**:
```
"A patient's journey through the healthcare system"
"How a bug in production gets discovered and fixed"
```

**Humorous**:
```
"Why developers hate meetings (and how to fix them)"
"The life of a SQL query in a poorly optimized database"
```

## Integration

### Triggers
- `/notebooklm-generate-comic` command
- **DEFAULT in `/notebooklm-generate-all`** (use `--skip-comics` to exclude)
- Called by research analysis workflows

### Uses
- Script: `scripts/generate_comic_storyboard.py`
- Optional: `scripts/generate_infographic.py` for illustrated mode

### Outputs To
- `sources/artifacts/comics/` - Generated storyboards (default location)
- Blog posts as embedded visuals
- Presentations as slide content
- Educational materials

## Best Practices

1. **Keep concepts focused**: One main idea per storyboard
2. **Match panels to complexity**: More panels for detailed topics
3. **Choose appropriate style**: Educational for tutorials, technical for processes
4. **Use clear language**: Dialogue should be concise and natural
5. **Consider the audience**: Technical vs. non-technical readers
6. **Iterate**: Regenerate with refined concepts if needed

## See Also

- Command: /notebooklm-generate-comic
- Command: /notebooklm-generate-all
- Script: scripts/generate_comic_storyboard.py
- Skill: infographic-generation (for AI illustrations)
- Skill: mindmap-creation (for concept visualization)
