---
name: mindmap-creation
description: "Create visual knowledge structures and mind maps for concepts, processes, workflows, and domain relationships. Generate concept maps, process flows, domain maps, and comparative analyses. Use when user asks for visualization, mind map, diagram, or visual representation."
allowed-tools: read, write, grep, glob, task
---

# Mind Map Creation Skill

## Purpose
Generate visual knowledge structures optimized for learning, comprehension, and knowledge synthesis.

## When to Activate
- User mentions "mind map", "visualize", "diagram", "visual representation"
- Request for "map out", "show relationships", "visualize concepts"
- Complex concepts need visual structure
- Process flows or workflows need clarity
- Comparative analysis visualization needed

**Key Triggers**: mind map, visualize, diagram, visual, map out, show relationships, concept map, flow diagram

## Mind Map Types

1. **Concept Maps** - Central idea with hierarchical branches
2. **Process Flow Diagrams** - Sequential workflows with decision points
3. **Domain Maps** - Territory mapping of knowledge areas
4. **Problem-Solution Maps** - Issues, causes, and solutions
5. **Comparative Maps** - Side-by-side analysis and comparisons

## How to Use This Skill

### For Topic Mind Mapping
1. Identify central concept
2. Determine 3-7 main branches
3. Add hierarchical sub-branches (2-3 levels deep)
4. Show relationships and connections
5. Include learning path or reading order

### For Workflow Mind Mapping
1. Map sequential steps in logical order
2. Show decision points and branches
3. Highlight parallel processes
4. Indicate data flow and transformations
5. Mark critical checkpoints

### For Comparative Mind Mapping
1. Identify items to compare
2. Create parallel structures
3. Highlight similarities and differences
4. Show relationships between compared items
5. Summarize key insights

## Output Format
Markdown-based visual structures with:
- Clear hierarchical organization
- Relationship indicators (→, ↔, etc.)
- Visual symbols (■, ●, ◆, ▲)
- Color coding via emoji when helpful
- Learning paths marked clearly

## Integration
- Receives from: `@research-doc-parser` (heading hierarchy)
- Uses: Parsed workflows from technical/clinical analysis
- Outputs to: docs/[topic]/mindmaps/
- Referenced by: `@research-blog-publisher` and summaries

## See Also
- Agent: @research-mindmap-creator
- Commands:
  - `/research-generate-mindmap` - General research mind maps
  - `/notebooklm-generate-mindmap` - NotebookLM-style mind maps from ingested content
- Templates: templates/ folder for starter templates
- Reference: reference.md for visualization best practices
