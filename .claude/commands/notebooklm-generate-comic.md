---
argument-hint: "<concept-description> <output-path> [--panels 2|4|6|8] [--style educational|narrative|technical|humorous]"
allowed-tools: read, write, bash
description: "Generate educational comic storyboards from concept descriptions with panel-based visual narratives"
---

# Comic Storyboard Generation Command

## Argument Required

**Input received:** `$ARGUMENTS`

**If no argument is provided**, display this help information and stop:

```
Comic Storyboard Generation Command

DESCRIPTION:
  Generate educational comic storyboards from concept descriptions.
  Creates visual narratives with structured panel layouts.
  Supports placeholder mode (fast SVG/HTML) and illustrated mode (AI images).

USAGE:
  /notebooklm-generate-comic "<concept>" "<output-path>" [options]

REQUIRED ARGUMENTS:
  <concept>       Concept description for the storyboard
  <output-path>   Path to save the storyboard file

OPTIONS:
  --panels        Number of panels: 2, 4, 6, or 8 (default: 4)
  --style         Style preset: educational, narrative, technical, humorous
                  (default: educational)
  --title         Custom title for the storyboard
  --format        Output format: svg or html (default: svg)
  --mode          Generation mode: placeholder or illustrated (default: placeholder)
  --list-styles   Show available style presets

PANEL LAYOUTS:
  2-panel  - Before/After, Problem/Solution
  4-panel  - Intro, Challenge, Action, Resolution
  6-panel  - Full narrative arc with details
  8-panel  - In-depth tutorial, multi-step process

STYLES:
  educational  - Clear, instructive, friendly (tutorials)
  narrative    - Story-driven, character-focused (journeys)
  technical    - Process-focused, detailed (workflows)
  humorous     - Engaging, light-hearted (entertainment)

EXAMPLES:
  /notebooklm-generate-comic "How FHIR API authentication works" output/fhir-auth.svg
  /notebooklm-generate-comic "Patient journey through clinical trials" output/trial.html --panels 6 --style narrative
  /notebooklm-generate-comic "ETL pipeline stages" output/etl.svg --panels 4 --style technical

Run the command with arguments to proceed.
```

**If arguments ARE provided**, proceed with the command below.

---

## Purpose

Generate visual comic storyboards that transform complex concepts into engaging narratives using:
1. Structured panel layouts (2, 4, 6, or 8 panels)
2. Narrative beat templates for effective storytelling
3. Multiple style presets for different content types
4. SVG/HTML placeholder layouts or AI-illustrated versions

## Execution Workflow

### Phase 1: Parse Arguments

```
Parse input:
- concept: The concept to explain visually
- output_path: Path to save storyboard file
- panels: Number of panels (default: 4)
- style: Style preset (default: educational)
- title: Optional custom title
- format: Output format (default: svg)
- mode: Generation mode (default: placeholder)
```

### Phase 2: Run Generation Script

Execute the comic storyboard generator:

```bash
.venv/bin/python scripts/generate_comic_storyboard.py \
    "<concept>" \
    "<output_path>" \
    --panels <panels> \
    --style <style> \
    [--title "<title>"] \
    --format <format> \
    --mode <mode>
```

### Phase 3: Display Results

```
Comic Storyboard Generation Complete

Concept: [concept description]
Style: [style name]
Panels: [count]
Layout: [layout]

Output: [output_path]
Manifest: [manifest_path]

Narrative Beats:
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Panel 1: Introduction
  "Let me explain [concept]..."

Panel 2: Challenge
  "How does [problem]?"

Panel 3: Action
  "Here's how it works..."

Panel 4: Resolution
  "And that's how [solution]!"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## Output Structure

**Default output location**: `sources/artifacts/comics/`

```
sources/artifacts/comics/
├── [topic]-storyboard.svg         # SVG placeholder version
├── [topic]-storyboard.html        # HTML interactive version
├── [topic]-storyboard.yaml        # Manifest with metadata
└── [topic]-storyboard-illustrated.png  # Optional AI version
```

## Panel Layout Guide

| Panels | Layout | Best For |
|--------|--------|----------|
| 2 | 2x1 | Before/after, problem/solution |
| 4 | 2x2 | Standard explanations, processes |
| 6 | 2x3 | Detailed workflows, complex topics |
| 8 | 4x2 | In-depth tutorials, multi-step |

## Style Selection Guide

| Content Type | Recommended Style |
|--------------|-------------------|
| Tutorials | educational |
| Process flows | technical |
| Patient journeys | narrative |
| Complex topics made fun | humorous |

## Integration

### Triggers
- Manual command execution
- **DEFAULT in `/notebooklm-generate-all`** (use `--skip-comics` to exclude)
- Called by research analysis workflows

### Uses
- Script: `scripts/generate_comic_storyboard.py`
- Skill: `comic-storyboard-generation`

### Outputs To
- `sources/artifacts/comics/` - Generated storyboards (default location)
- Blog posts as embedded visuals
- Educational materials

## Success Criteria

- [ ] Concept description parsed
- [ ] Narrative beats generated
- [ ] Panel layout created
- [ ] Style applied correctly
- [ ] Output file saved (SVG or HTML)
- [ ] Manifest created
- [ ] Summary displayed
