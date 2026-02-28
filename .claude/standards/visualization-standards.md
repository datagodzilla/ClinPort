# Visualization Standards

This document defines the three visualization formats used across Research Hub outputs: ASCII, Mermaid, and Graphviz.

## Overview

All mind maps, workflows, and diagrams should be generated in three formats:

| Format | Use Case | Output Location | Suffix |
|--------|----------|-----------------|--------|
| ASCII | Quick reference, terminal display | `*_ascii.md` | `.md` |
| Mermaid | Web/Jekyll rendering | `*_mermaid.md` | `.md` |
| Graphviz | High-quality images | `*_graphviz.py` | `.svg`, `.png` |

## 1. ASCII Visualization Format

### Purpose
- Quick terminal viewing
- Copy-paste friendly
- No rendering dependencies
- Universal compatibility

### Characters to Use

```
Hierarchy:
├── Branch with more siblings
└── Last branch in group
│   Vertical connection
    Indentation (4 spaces)

Arrows:
→ Direction/flow (right)
← Direction/flow (left)
↑ Direction/flow (up)
↓ Direction/flow (down)
↔ Bidirectional

Boxes:
┌───────────┐
│   Box     │
└───────────┘

Connectors:
───  Horizontal line
│    Vertical line
┼    Cross
┬    T down
┴    T up
├    T right
┤    T left
```

### ASCII Mind Map Template

```markdown
# [Title] - ASCII Visualization

```
                        ┌─────────────────┐
                        │ CENTRAL CONCEPT │
                        └────────┬────────┘
               ┌─────────────────┼─────────────────┐
               ▼                 ▼                 ▼
        ┌──────────┐      ┌──────────┐      ┌──────────┐
        │ Branch 1 │      │ Branch 2 │      │ Branch 3 │
        └────┬─────┘      └────┬─────┘      └────┬─────┘
             │                 │                 │
     ┌───────┼───────┐         │         ┌───────┼───────┐
     ▼       ▼       ▼         ▼         ▼       ▼       ▼
   Sub 1   Sub 2   Sub 3     Sub 4     Sub 5   Sub 6   Sub 7
```

### Relationships
- [A] ──requires──► [B]
- [C] ◄──depends──► [D]
- [E] ──leads to──► [F]
```

### ASCII Workflow Template

```markdown
# [Workflow Title] - ASCII Visualization

```
START
  │
  ▼
┌─────────────────┐
│   Step 1        │
│   Description   │
└────────┬────────┘
         │
         ▼
    ┌────────┐
   <  Decision >──── No ────►┌──────────┐
    └────┬───┘               │ Alt Path │
         │                   └────┬─────┘
        Yes                       │
         │                        │
         ▼                        ▼
┌─────────────────┐     ┌─────────────────┐
│   Step 2        │     │   Step 2B       │
└────────┬────────┘     └────────┬────────┘
         │                       │
         └───────────┬───────────┘
                     ▼
              ┌──────────┐
              │   END    │
              └──────────┘
```
```

---

## 2. Mermaid Visualization Format

### Purpose
- Jekyll/web rendering
- Interactive diagrams
- Easy editing in markdown
- Version control friendly

### Enable in Jekyll

Blog posts using Mermaid must include frontmatter:
```yaml
---
mermaid: true
---
```

### Mermaid Mind Map Template

```markdown
# [Title] - Mermaid Visualization

<div class="mermaid">
mindmap
    root((Central Concept))
        Branch 1
            Sub 1.1
            Sub 1.2
            Sub 1.3
        Branch 2
            Sub 2.1
            Sub 2.2
        Branch 3
            Sub 3.1
            Sub 3.2
</div>
```

### Mermaid Flowchart Template

```markdown
# [Title] - Mermaid Visualization

<div class="mermaid">
flowchart TB
    subgraph Layer1["Layer Name"]
        A[Node A] --> B[Node B]
        A --> C[Node C]
    end

    subgraph Layer2["Another Layer"]
        D[Node D] --> E[Node E]
    end

    B --> D
    C --> D

    style A fill:#e3f2fd,stroke:#1976d2
    style D fill:#e8f5e9,stroke:#388e3c
</div>
```

### Mermaid Sequence Diagram Template

```markdown
# [Title] - Mermaid Visualization

<div class="mermaid">
sequenceDiagram
    autonumber
    participant A as System A
    participant B as System B
    participant C as System C

    A->>B: Request
    B->>C: Forward
    C-->>B: Response
    B-->>A: Result
</div>
```

### Mermaid Color Palette

```
Blue (EHR/Primary):    fill:#e3f2fd,stroke:#1976d2
Green (LIS/Success):   fill:#e8f5e9,stroke:#388e3c
Orange (Integration):  fill:#fff3e0,stroke:#f57c00
Purple (Terminology):  fill:#f3e5f5,stroke:#7b1fa2
Red (Alerts/CDS):      fill:#ffcdd2,stroke:#c62828
Gray (Neutral):        fill:#f5f5f5,stroke:#616161
```

---

## 3. Graphviz Visualization Format

### Purpose
- High-quality static images
- Print-ready output
- Complex layouts
- Precise positioning

### Graphviz Python Template

```python
#!/usr/bin/env python3
"""
Generate [diagram name] visualization.

Requirements:
    pip install graphviz
    brew install graphviz  # macOS

Output:
    Creates PNG and SVG files
"""

from graphviz import Digraph
import os
import re

OUTPUT_DIR = os.path.dirname(os.path.abspath(__file__))


def fix_svg_viewbox(svg_path):
    """Fix SVG viewBox offset for full visibility."""
    with open(svg_path, 'r') as f:
        content = f.read()

    width_match = re.search(r'width="([\d.]+)pt"', content)
    height_match = re.search(r'height="([\d.]+)pt"', content)

    if not (width_match and height_match):
        return

    viewbox_match = re.search(
        r'viewBox="(-?[\d.]+)\s+(-?[\d.]+)\s+([\d.]+)\s+([\d.]+)"', content
    )
    if viewbox_match:
        vb_x, vb_y, vb_width, vb_height = map(float, viewbox_match.groups())
        if vb_x != 0 or vb_y != 0:
            new_vb_width = vb_width + vb_x
            new_vb_height = vb_height + vb_y
            new_viewbox = f'viewBox="0 0 {new_vb_width:.2f} {new_vb_height:.2f}"'
            content = re.sub(r'viewBox="-?[\d.\s]+"', new_viewbox, content)

            def fix_translate(match):
                tx, ty = map(float, match.groups())
                new_tx = tx + vb_x
                new_ty = ty + vb_y
                return f'translate({new_tx:.2f} {new_ty:.2f})'

            content = re.sub(
                r'translate\(([-\d.]+)\s+([-\d.]+)\)', fix_translate, content
            )

    with open(svg_path, 'w') as f:
        f.write(content)


def create_diagram():
    """Create the main diagram."""
    dot = Digraph('diagram_name', comment='Diagram Description')
    dot.attr(rankdir='TB', bgcolor='white')
    dot.attr('node', shape='box', style='rounded,filled',
             fontname='Arial', fontsize='12')
    dot.attr('edge', fontname='Arial', fontsize='10')

    # Add nodes
    dot.node('center', 'Central\\nConcept',
             fillcolor='#4CAF50', fontcolor='white')
    dot.node('branch1', 'Branch 1', fillcolor='#e3f2fd')
    dot.node('branch2', 'Branch 2', fillcolor='#e8f5e9')

    # Add edges
    dot.edge('center', 'branch1', label='relates to')
    dot.edge('center', 'branch2', label='connects')

    # Render
    output_path = os.path.join(OUTPUT_DIR, 'diagram_name')
    dot.render(output_path, format='png', cleanup=True)
    dot.render(output_path, format='svg', cleanup=True)
    fix_svg_viewbox(f"{output_path}.svg")
    print(f"Created: {output_path}.png and .svg")


if __name__ == "__main__":
    create_diagram()
```

### Graphviz Color Palette (Hex)

```python
# Material Design Colors
COLORS = {
    'blue_light': '#e3f2fd',
    'blue_dark': '#1976d2',
    'green_light': '#e8f5e9',
    'green_dark': '#388e3c',
    'orange_light': '#fff3e0',
    'orange_dark': '#f57c00',
    'purple_light': '#f3e5f5',
    'purple_dark': '#7b1fa2',
    'red_light': '#ffcdd2',
    'red_dark': '#c62828',
    'gray_light': '#f5f5f5',
    'gray_dark': '#616161',
}
```

---

## Output File Structure

When generating visualizations, create the following structure:

```
docs/[topic]/mindmaps/
├── [name]_ascii.md           # ASCII version
├── [name]_mermaid.md         # Mermaid version
├── [name]_graphviz.py        # Graphviz generator
└── generated/
    ├── [name].svg            # Generated SVG
    └── [name].png            # Generated PNG

docs/[topic]/workflows/
├── [name]_ascii.md
├── [name]_mermaid.md
├── [name]_graphviz.py
└── generated/
    ├── [name].svg
    └── [name].png
```

---

## Format Selection Guide

| Scenario | Recommended Format |
|----------|-------------------|
| Quick review/terminal | ASCII |
| Jekyll blog post | Mermaid |
| Documentation site | Mermaid |
| Print publication | Graphviz (PNG/SVG) |
| Presentation slides | Graphviz (SVG) |
| Email/messaging | ASCII |
| Complex relationships | Graphviz |
| Simple hierarchy | Mermaid |

---

## Quality Checklist

### ASCII
- [ ] Uses consistent box characters
- [ ] Proper alignment
- [ ] Readable at 80-column width
- [ ] Clear flow direction

### Mermaid
- [ ] Valid Mermaid syntax
- [ ] Proper node IDs (no spaces)
- [ ] Color styling applied
- [ ] Renders correctly in preview

### Graphviz
- [ ] SVG viewBox fixed
- [ ] Both PNG and SVG generated
- [ ] Clean color scheme
- [ ] Professional layout

---

## Integration Notes

### Blog Posts
- Include Mermaid version inline with `<div class="mermaid">`
- Reference Graphviz images: `![Diagram](assets/images/diagram.svg)`
- Add ASCII in collapsible section for accessibility

### GitHub Pages
- Set `mermaid: true` in frontmatter
- Copy Graphviz outputs to `assets/images/`
- Test rendering before publishing

### Documentation
- Prefer Mermaid for editability
- Use Graphviz for complex diagrams
- Include ASCII as fallback

---

## Examples

See `/Users/Wolverine/00_PROJECTS/ACTION-PLAN/FHIR_HL7_LOINC_SNOMEDCT/docs/diagrams/` for reference implementations:
- `generate_diagrams.py` - Graphviz generator
- `mermaid-diagrams.md` - Mermaid examples
- Individual `.mmd` files - Mermaid source
