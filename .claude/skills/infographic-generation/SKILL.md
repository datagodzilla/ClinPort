---
name: infographic-generation
description: "Generate AI-powered infographics from concept descriptions using local Stable Diffusion XL models. Supports multiple style presets optimized for technical, clinical, tutorial, and conceptual content."
allowed-tools: read, write, bash
---

# Infographic Generation Skill

## Purpose

Generate professional, AI-powered infographics from concept descriptions using:
- Local Stable Diffusion XL on Apple Silicon (MPS) or NVIDIA GPU (CUDA)
- HuggingFace Inference API as fallback for CPU-only machines
- Multiple style presets for different content domains
- Text overlay capability for titles and labels

## When to Activate

- User requests visual representation of a concept
- Blog posts need explanatory diagrams
- Documentation requires architectural visualizations
- Creating educational materials with visual aids

**Key Triggers**: infographic, generate visual, create diagram, AI illustration, visualize concept

## Prerequisites

### Python Dependencies
```bash
.venv/bin/pip install diffusers transformers accelerate torch Pillow huggingface_hub pyyaml
```

### Hardware Requirements
- **Apple Silicon**: M1/M2/M3 with MPS support
- **NVIDIA GPU**: CUDA-capable with cuDNN
- **CPU Fallback**: HuggingFace Inference API (requires HF_TOKEN)

### API Token (for fallback)
```bash
export HF_TOKEN="your_huggingface_token"
```

## Style Presets

### Technical
Clean lines, icons, diagrams, blue palette for system architecture and technical content.

**Best for**: API architecture, database schemas, system diagrams, data flows

**Colors**:
- Primary: #0066CC (Blue)
- Secondary: #4A90D9
- Accent: #00A3E0
- Background: #F5F8FA
- Text: #1A365D

### Clinical
Healthcare imagery, green/teal palette for medical and clinical content.

**Best for**: Patient journeys, clinical workflows, medical processes, healthcare systems

**Colors**:
- Primary: #059669 (Green)
- Secondary: #10B981
- Accent: #0891B2
- Background: #F0FDF4
- Text: #064E3B

### Tutorial
Step-by-step, numbered elements, warm colors for educational content.

**Best for**: How-to guides, learning materials, instructional content, tutorials

**Colors**:
- Primary: #D97706 (Orange)
- Secondary: #F59E0B
- Accent: #FBBF24
- Background: #FFFBEB
- Text: #92400E

### Conceptual
Abstract, gradient backgrounds for high-level concepts and strategic content.

**Best for**: Vision statements, abstract ideas, relationships, strategic concepts

**Colors**:
- Primary: #7C3AED (Purple)
- Secondary: #8B5CF6
- Accent: #A78BFA
- Background: #F5F3FF
- Text: #4C1D95

## Usage

### Command
```bash
/notebooklm-generate-infographic "<concept>" "<output-path>" --style <style> [--title "<title>"]
```

### Python Script
```bash
.venv/bin/python scripts/generate_infographic.py \
    "FHIR API architecture with resources and endpoints" \
    artifacts/infographics/fhir-architecture.png \
    --style technical \
    --title "FHIR Architecture" \
    --labels "Resources" "Endpoints" "Data Flow"
```

### Python API
```python
from scripts.generate_infographic import InfographicGenerator

generator = InfographicGenerator()

result = generator.generate(
    concept="OMOP CDM data flow showing ETL process",
    style="technical",
    output_path="artifacts/infographics/omop-flow.png",
    title="OMOP Data Flow"
)
```

## Output Structure

**Default output location**: `sources/artifacts/infographics/`

```
sources/artifacts/infographics/
├── [topic]-overview.png
├── [topic]-overview.yaml     # Manifest with metadata
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

## Effective Concept Descriptions

### Structure
A good concept description includes:
1. **Subject**: What is being visualized
2. **Components**: Key elements to include
3. **Relationships**: How elements connect
4. **Style hints**: Specific visual elements wanted

### Examples

**Technical**:
```
"OMOP CDM data flow showing source data (EHR, claims),
ETL transformation process, and standardized output tables
with vocabulary mapping connections"
```

**Clinical**:
```
"Patient care pathway from initial diagnosis through
treatment decision tree including medication, surgery,
and therapy branches with outcome indicators"
```

**Tutorial**:
```
"Step-by-step guide showing FHIR API authentication flow:
1. Client credentials, 2. Token request, 3. API call,
4. Response handling, with error states"
```

**Conceptual**:
```
"Relationship between electronic health records,
clinical decision support systems, and patient outcomes
showing bidirectional data flow and feedback loops"
```

## Generation Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `num_inference_steps` | 30 | More steps = higher quality (20-50) |
| `guidance_scale` | 7.5 | How closely to follow prompt (5-15) |
| `width` | 1024 | Output image width |
| `height` | 1024 | Output image height |

### Quality Presets

**Draft (fast)**: steps=20, guidance=5
**Standard**: steps=30, guidance=7.5
**High Quality**: steps=50, guidance=10

## Error Handling

| Error | Cause | Solution |
|-------|-------|----------|
| No GPU available | CPU only machine | Uses HuggingFace API fallback |
| Model download fail | Network or disk space | Check connection, free 10GB+ |
| Out of memory | Model too large | Reduce steps, use API |
| API auth fail | Missing HF_TOKEN | Set environment variable |
| Generation timeout | Complex prompt | Simplify concept description |

## Integration

### Triggers
- `/notebooklm-generate-infographic` command
- **DEFAULT in `/notebooklm-generate-all`** (use `--skip-infographics` to exclude)
- Called by `@research-blog-publisher` for visuals
- Part of research analysis workflows

### Outputs To
- `sources/artifacts/infographics/` - Generated images (default location)
- Blog posts as embedded visuals
- Documentation as explanatory diagrams
- Presentations as slide graphics

## Best Practices

1. **Start simple**: Begin with clear, focused concepts
2. **Choose appropriate style**: Match style to content domain
3. **Use text overlays**: Add titles for context
4. **Iterate**: Regenerate with refined descriptions
5. **Combine with code diagrams**: Use for concepts, Mermaid for specifics
6. **Check GPU availability**: Use API fallback for CPU machines

## See Also

- Command: /notebooklm-generate-infographic
- Command: /notebooklm-generate-all
- Script: scripts/generate_infographic.py
- Skill: mindmap-creation (for structured diagrams)
- Skill: visualization-architect (for code-based diagrams)
