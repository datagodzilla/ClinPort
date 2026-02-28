---
argument-hint: "Path to knowledge base content or topic name"
allowed-tools: read, write, bash, task
description: "Generate visual mind maps from NotebookLM ingested content"
---

# NotebookLM Mind Map Generation Command


## ⚠️ Argument Required

**Input received:** `$ARGUMENTS`

**If no argument is provided**, display this help information and stop:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
NotebookLM Mind Map Generation Command
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

DESCRIPTION:
  Generate visual mind maps from NotebookLM ingested content

USAGE:
  /notebooklm-generate-mindmap Path to knowledge base content or topic name

REQUIRED ARGUMENTS:
    Path to knowledge base content or topic name

OPTIONAL ARGUMENTS:
    (none)

EXAMPLES:
  /notebooklm-generate-mindmap "example-argument"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Run the command with required arguments to proceed.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**If arguments ARE provided**, proceed with the command below.

---
## Purpose
Generate comprehensive visual mind maps from NotebookLM-ingested content (YouTube transcripts, web content, documents). Creates ASCII, Mermaid, and Graphviz visualizations for different use cases.

## Input Options

### Option 1: Knowledge Base Path
```
/notebooklm-generate-mindmap ingested/manifest.md
```
Uses the unified knowledge base from source ingestion.

### Option 2: Topic Name
```
/notebooklm-generate-mindmap "OMOP CDM Overview"
```
Looks for content in `output/[topic]/` directory.

### Option 3: Specific Document
```
/notebooklm-generate-mindmap output/ohdsi/knowledge_base/unified_kb.md
```
Generates mindmap from a single knowledge base file.

## Execution Workflow

### Phase 1: Content Analysis
1. Load source content (from KB manifest or topic)
2. Identify key concepts and themes:
   - Core definitions and terminology
   - Main topics and subtopics
   - Processes and workflows
   - Relationships between concepts
   - Key insights and takeaways

### Phase 2: Structure Determination
Analyze content to select appropriate mind map type:
- **Concept Map**: For understanding topic structure
- **Process Map**: For visualizing workflows
- **Domain Map**: For comprehensive field overview
- **Comparative Map**: For comparing approaches

### Phase 3: Mind Map Generation
Create three visualization formats:

**1. ASCII Version**:
- Box-drawing characters (├ └ │ ─ ┌ ┐)
- Terminal/email friendly
- No external dependencies

**2. Mermaid Version**:
- `<div class="mermaid">` tags
- Jekyll/web compatible
- Interactive diagrams

**3. Graphviz Version**:
- Python script with graphviz library
- High-quality SVG output
- Print-ready resolution

### Phase 4: Quality Review
- Verify all key concepts included
- Check relationship accuracy
- Validate visual hierarchy
- Add learning path suggestions

## Output Format

### ASCII Mind Map (`*_ascii.md`)
```markdown
---
title: Mind Map - [Topic] (ASCII)
type: NotebookLM Mind Map
visualization_format: ascii
mermaid: false
source: "[Knowledge base path]"
created: YYYY-MM-DD
---

# [TOPIC] - Mind Map

## Overview
- **Source**: [KB or topic path]
- **Key Concepts**: [N]
- **Relationships**: [N]

## Visual Structure

```
                    ┌─────────────────┐
                    │ CENTRAL CONCEPT │
                    └────────┬────────┘
           ┌─────────────────┼─────────────────┐
           ▼                 ▼                 ▼
    ┌──────────┐      ┌──────────┐      ┌──────────┐
    │ Branch 1 │      │ Branch 2 │      │ Branch 3 │
    └────┬─────┘      └────┬─────┘      └────┬─────┘
```

## Tree Structure

├── Branch 1: [Category]
│   ├── Subconcept 1
│   │   ├── Detail A
│   │   └── Detail B
│   └── Subconcept 2
├── Branch 2: [Category]
│   └── Subconcept 3
└── Branch 3: [Category]
    └── Subconcept 4

## Relationships
- [A] ──requires──► [B]
- [C] ◄──depends──► [D]

## Learning Path
1. Start with [concept]
2. Then explore [concept]
3. Advanced: [concept]

## Key Takeaways
1. [Insight from source content]
2. [Insight from source content]
```

### Mermaid Mind Map (`*_mermaid.md`)
```markdown
---
title: Mind Map - [Topic] (Mermaid)
type: NotebookLM Mind Map
visualization_format: mermaid
mermaid: true
source: "[Knowledge base path]"
created: YYYY-MM-DD
---

# [TOPIC] - Mind Map

## Overview
- **Source**: [KB or topic path]
- **Key Concepts**: [N]

## Mind Map Visualization

<div class="mermaid">
mindmap
    root((Central Concept))
        Branch 1
            Subconcept 1
                Detail A
                Detail B
            Subconcept 2
        Branch 2
            Subconcept 3
        Branch 3
            Subconcept 4
</div>

## Flowchart View

<div class="mermaid">
flowchart TB
    center((Central<br/>Concept))

    subgraph b1["Branch 1"]
        sub1[Subconcept 1]
        sub2[Subconcept 2]
    end

    subgraph b2["Branch 2"]
        sub3[Subconcept 3]
    end

    center --> b1
    center --> b2

    style center fill:#4CAF50,color:#fff
    style b1 fill:#e3f2fd,stroke:#1976d2
    style b2 fill:#e8f5e9,stroke:#388e3c
</div>

## Learning Path
1. Start with [concept]
2. Then explore [concept]
3. Advanced: [concept]
```

### Graphviz Script (`*_mindmap.py`)
```python
#!/usr/bin/env python3
"""Generate [Topic] mind map visualization from NotebookLM content."""

from graphviz import Digraph
import os

OUTPUT_DIR = os.path.dirname(os.path.abspath(__file__))

def create_mindmap():
    dot = Digraph('mindmap', comment='[Topic] Mind Map')
    dot.attr(rankdir='TB', bgcolor='white', nodesep='0.5', ranksep='0.75')
    dot.attr('node', fontname='Arial', fontsize='10')

    # Central node
    dot.node('center', 'Central\\nConcept',
             shape='ellipse', style='filled', fillcolor='#4CAF50',
             fontcolor='white', fontsize='14', width='2', height='1')

    # Branches
    dot.node('b1', 'Branch 1', fillcolor='#e3f2fd', style='filled,rounded')
    dot.edge('center', 'b1', color='#1976d2')

    # Render
    output_path = os.path.join(OUTPUT_DIR, 'generated', '[topic]_mindmap')
    os.makedirs(os.path.dirname(output_path), exist_ok=True)
    dot.render(output_path, format='svg', cleanup=True)
    dot.render(output_path, format='png', cleanup=True)
    print(f"Mind map generated: {output_path}.svg")

if __name__ == "__main__":
    create_mindmap()
```

## Output Structure

```
output/[topic]/mindmaps/
├── [topic]_mindmap_ascii.md      # Complete ASCII version
├── [topic]_mindmap_mermaid.md    # Complete Mermaid version
├── [topic]_mindmap_graphviz.md   # SVG reference version
├── [topic]_mindmap.py            # Graphviz generator script
└── generated/
    ├── [topic]_mindmap.svg       # High-quality SVG
    └── [topic]_mindmap.png       # PNG export
```

## Integration with NotebookLM Workflow

### Part of Full Pipeline
This command is called by `/notebooklm-generate-all`:
```
/notebooklm-generate-all sources.md
→ Phase 3: Parallel Artifact Generation
  → /notebooklm-generate-mindmap (this command)
```

### Standalone Usage
```bash
# From ingested content
/notebooklm-generate-mindmap ingested/manifest.md

# From topic directory
/notebooklm-generate-mindmap output/ohdsi/

# From specific KB file
/notebooklm-generate-mindmap output/omop-cdm/knowledge_base/unified_kb.md
```

## Mind Map Types

| Type | When to Use | Structure |
|------|-------------|-----------|
| Concept Map | Understanding relationships | Central concept + radiating branches |
| Process Map | Visualizing workflows | Sequential steps with branches |
| Domain Map | Field overview | Hierarchical categories |
| Comparative Map | Comparing options | Side-by-side branches |

## Usage Examples

### Generate from Knowledge Base
```
/notebooklm-generate-mindmap ingested/manifest.md
```

### Generate from Topic
```
/notebooklm-generate-mindmap "OHDSI Cohort Definitions"
```

### Generate with Specific Type
```
/notebooklm-generate-mindmap output/omop-cdm/ --type process
```

## Success Criteria

Mind map generation complete when:
- [ ] Source content analyzed
- [ ] Key concepts identified
- [ ] Appropriate map type selected
- [ ] THREE visualization formats created:
  - [ ] ASCII version (`*_mindmap_ascii.md`)
  - [ ] Mermaid version (`*_mindmap_mermaid.md`)
  - [ ] Graphviz version (`*_mindmap_graphviz.md`)
- [ ] Python generator script created
- [ ] SVG image generated
- [ ] Learning path included
- [ ] Files saved to output location

## Example Output

```
🗺️ Mind Map Generation Complete

📁 Output: output/omop-cdm/mindmaps/

📊 Generated Files:
┌──────────────────────────────────────────────────────────┐
│ Format    │ File                           │ Best For    │
├───────────┼────────────────────────────────┼─────────────┤
│ ASCII     │ omop-cdm_mindmap_ascii.md      │ Terminal    │
│ Mermaid   │ omop-cdm_mindmap_mermaid.md    │ Web/Jekyll  │
│ Graphviz  │ omop-cdm_mindmap_graphviz.md   │ Print       │
│ SVG       │ generated/omop-cdm_mindmap.svg │ High-res    │
└───────────┴────────────────────────────────┴─────────────┘

📈 Statistics:
- Central Concept: OMOP Common Data Model
- Main Branches: 5
- Sub-concepts: 23
- Relationships: 18

🎯 Map Type: Concept Map

✅ Ready for use!

Quick Access:
• View ASCII: cat output/omop-cdm/mindmaps/omop-cdm_mindmap_ascii.md
• View SVG: open output/omop-cdm/mindmaps/generated/omop-cdm_mindmap.svg
• Regenerate SVG: python output/omop-cdm/mindmaps/omop-cdm_mindmap.py
```

## Uses Skills
- `mindmap-creation` - Visual knowledge mapping

## Related Commands
- `/notebooklm-ingest-sources` - Ingest sources first
- `/notebooklm-generate-all` - Full artifact pipeline
- `/notebooklm-generate-flashcards` - Study cards from same content
