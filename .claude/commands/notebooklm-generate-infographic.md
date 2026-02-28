---
argument-hint: "<concept-description> <output-path> [--style technical|clinical|tutorial|conceptual] [--title text]"
allowed-tools: read, write, bash
description: "Generate AI-powered infographics from concept descriptions using Stable Diffusion XL"
---

# Infographic Generation Command

## Argument Required

**Input received:** `$ARGUMENTS`

**If no argument is provided**, display this help information and stop:

```
AI Infographic Generation Command

DESCRIPTION:
  Generate professional infographics from concept descriptions using
  local Stable Diffusion XL models (Apple Silicon MPS or NVIDIA CUDA).
  Falls back to HuggingFace Inference API if no GPU available.

USAGE:
  /notebooklm-generate-infographic "<concept>" "<output-path>" [options]

REQUIRED ARGUMENTS:
  <concept>       Description of the concept to visualize
  <output-path>   Path to save the generated PNG image

OPTIONS:
  --style         Style preset: technical, clinical, tutorial, conceptual
                  (default: technical)
  --title         Title text to overlay on the infographic
  --labels        Labels to overlay at the bottom (space-separated)
  --steps         Inference steps, more = higher quality (default: 30)
  --guidance      Guidance scale, higher = closer to prompt (default: 7.5)
  --device        Force device: cuda, mps, or cpu
  --no-api-fallback  Disable HuggingFace API fallback
  --list-styles   Show available style presets

STYLES:
  technical   - Clean lines, icons, blue palette (systems, architecture)
  clinical    - Healthcare imagery, green/teal (medical concepts)
  tutorial    - Step-by-step, warm colors (educational guides)
  conceptual  - Abstract, gradients, purple (high-level ideas)

EXAMPLES:
  /notebooklm-generate-infographic "FHIR API architecture with resources and endpoints" output/fhir.png --style technical
  /notebooklm-generate-infographic "Patient journey through clinical trials" output/trial.png --style clinical --title "Clinical Trial Journey"
  /notebooklm-generate-infographic --list-styles

Run the command with arguments to proceed.
```

**If arguments ARE provided**, proceed with the command below.

---

## Purpose

Generate professional AI-powered infographics from concept descriptions using:
1. Local Stable Diffusion XL on Apple Silicon (MPS) or NVIDIA GPU (CUDA)
2. HuggingFace Inference API as fallback for CPU-only machines
3. Multiple style presets optimized for different content types
4. Text overlay capability for titles and labels

## Prerequisites

### GPU Support (Recommended)
- **Apple Silicon**: MPS (Metal Performance Shaders) - M1/M2/M3
- **NVIDIA GPU**: CUDA with cuDNN

### Python Dependencies
```bash
.venv/bin/pip install diffusers transformers accelerate torch Pillow huggingface_hub pyyaml
```

### For API Fallback
Set HuggingFace token:
```bash
export HF_TOKEN="your_huggingface_token"
```

## Style Presets

| Style | Use Case | Visual Characteristics |
|-------|----------|------------------------|
| **technical** | System architecture, APIs | Clean lines, icons, blue palette |
| **clinical** | Healthcare, medical | Medical imagery, green/teal palette |
| **tutorial** | Step-by-step guides | Numbered steps, arrows, warm colors |
| **conceptual** | Abstract ideas | Gradients, flowing shapes, purple |

## Execution Workflow

### Phase 1: Parse Arguments

```
Parse input:
- concept: The concept description
- output_path: Path to save PNG
- style: Style preset (default: technical)
- title: Optional title overlay
- labels: Optional label overlays
- steps: Inference steps (default: 30)
- guidance: Guidance scale (default: 7.5)
- device: Force specific device
- no_api_fallback: Disable API fallback
```

### Phase 2: Check Prerequisites

Verify torch and GPU availability:
```bash
.venv/bin/python -c "import torch; print(f'CUDA: {torch.cuda.is_available()}, MPS: {torch.backends.mps.is_available()}')"
```

### Phase 3: Run Generation Script

Execute the infographic generator:

```bash
.venv/bin/python scripts/generate_infographic.py \
    "<concept>" \
    "<output_path>" \
    --style <style> \
    [--title "<title>"] \
    [--labels "<label1>" "<label2>"] \
    [--steps <steps>] \
    [--guidance <guidance>] \
    [--device <device>]
```

### Phase 4: Display Results

```
AI Infographic Generation Complete

Concept: [concept description]
Style: [style name]
Device: [mps/cuda/cpu]

Output: [output_path]
Manifest: [output_path.yaml]

Image Size: 1024x1024
Inference Steps: 30
Guidance Scale: 7.5
```

## Output Structure

**Default output location**: `sources/artifacts/infographics/`

```
sources/artifacts/infographics/
├── [topic]-overview.png
├── [topic]-overview.yaml    # Manifest
├── [topic]-architecture.png
└── [topic]-architecture.yaml
```

## Manifest Format

```yaml
concept: "FHIR API architecture showing resources, endpoints, and data flow"
style: technical
style_name: Technical
title: "FHIR Architecture"
labels: ["Resources", "Endpoints", "Data Flow"]
output_path: "artifacts/infographics/fhir-architecture.png"
model: "stabilityai/stable-diffusion-xl-base-1.0"
device: mps
image_size: [1024, 1024]
num_inference_steps: 30
guidance_scale: 7.5
generation_date: "2025-12-15T10:30:00"
colors:
  primary: "#0066CC"
  secondary: "#4A90D9"
  accent: "#00A3E0"
  background: "#F5F8FA"
  text: "#1A365D"
```

## Generation Tips

### Effective Concept Descriptions

**Good descriptions include:**
- Main subject/topic
- Key components or elements
- Relationships or flow
- Specific visual elements wanted

**Examples:**
```
Technical:
"OMOP CDM data flow showing source data, ETL process, and standardized tables with vocabulary mapping"

Clinical:
"Patient care pathway from diagnosis through treatment options including medication, surgery, and therapy branches"

Tutorial:
"Step-by-step guide showing how to query FHIR API with authentication, request, response, and error handling"

Conceptual:
"Relationship between electronic health records, clinical decision support, and patient outcomes"
```

### Style Selection Guide

| Content Type | Recommended Style |
|--------------|-------------------|
| API architecture | technical |
| Database schemas | technical |
| Medical workflows | clinical |
| Patient journeys | clinical |
| How-to guides | tutorial |
| Learning materials | tutorial |
| High-level concepts | conceptual |
| Vision/strategy | conceptual |

## Error Handling

| Error | Cause | Solution |
|-------|-------|----------|
| No GPU available | CPU only | Uses API fallback |
| Model download fail | Network/space | Check connection, free space |
| Out of memory | Large model | Reduce steps, use API |
| API auth fail | No HF token | Set HF_TOKEN env var |
| Generation fail | Bad prompt | Simplify concept description |

## Integration

### Triggers
- Manual command execution
- **DEFAULT in `/notebooklm-generate-all`** (use `--skip-infographics` to exclude)
- Called by research analysis workflows

### Uses
- Script: `scripts/generate_infographic.py`
- Model: Stable Diffusion XL
- Fallback: HuggingFace Inference API

### Outputs To
- `sources/artifacts/infographics/` - Generated images (default location)
- `@research-blog-publisher` - Blog post visuals
- `@research-doc-generator` - Documentation diagrams

## Success Criteria

- [ ] Concept description parsed
- [ ] Style preset applied
- [ ] GPU/API backend selected
- [ ] Image generated successfully
- [ ] Text overlays applied (if requested)
- [ ] Image saved to output path
- [ ] Manifest created
- [ ] Summary displayed
