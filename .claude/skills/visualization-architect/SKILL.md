---
name: visualization-architect
description: "Intelligent diagram and visualization generator that analyzes user prompts to automatically design architecture diagrams, flowcharts, mind maps, pipelines, and interactive React components. Use when user asks to: (1) Visualize any system/process/concept, (2) Create diagrams from descriptions or ASCII art, (3) Build architecture/flow/mind map diagrams, (4) Generate interactive visual components. Automatically determines optimal layout, structure, and styling based on content analysis."
---

# Visualization Architect Skill

Analyzes user prompts to intelligently design and generate professional visualizations. Automatically determines structure, layout, and styling based on content.

## Workflow

### Step 1: Analyze Input
Extract from user prompt:
- **Entities**: Nouns, systems, components, concepts
- **Relationships**: Hierarchies, flows, dependencies, groupings
- **Domain**: Technical, business, clinical, educational, etc.
- **Purpose**: Documentation, presentation, training, dashboard

### Step 2: Classify Visualization Type
| Pattern Detected | Visualization Type |
|-----------------|-------------------|
| Central concept + categories | Architecture Diagram |
| Sequential steps, A→B→C | Flowchart / Pipeline |
| Branching concepts, brainstorm | Mind Map |
| Decision points, if/then | Decision Tree |
| Comparison, pros/cons | Comparison Chart |
| Timeline, phases | Timeline Diagram |
| Layers, stacks | Stack Diagram |
| Interactive needs | React Component |

### Step 3: Design Structure
Determine dynamically:
- Number of main nodes (2-7 optimal)
- Hierarchy depth (1-3 levels)
- Layout direction (TB, LR, radial)
- Grouping strategy

### Step 4: Apply Domain Styling
See `references/domain-styles.md` for domain-specific color palettes and icons.

### Step 5: Generate Output
Select format based on use case:
- **SVG**: Static, print, presentations
- **HTML/Mermaid**: Web, interactive, shareable
- **React JSX**: Apps, dashboards, Streamlit

## Content Analysis Framework

### Entity Extraction
```
Input: "Show our ETL pipeline from EHR sources through OMOP CDM to analytics"

Entities:
- EHR sources (input)
- ETL pipeline (process)
- OMOP CDM (storage)
- Analytics (output)

Structure: Linear pipeline (LR flow)
```

### Relationship Detection
| Signal Words | Relationship Type |
|-------------|------------------|
| "consists of", "includes", "contains" | Parent-Child |
| "flows to", "connects to", "feeds" | Sequential |
| "depends on", "requires" | Dependency |
| "vs", "compared to", "or" | Comparison |
| "if", "when", "decision" | Conditional |
| "types of", "categories" | Classification |

### Hierarchy Inference
```
Level 0: Central/Main concept (1 node)
Level 1: Major categories (2-7 nodes)
Level 2: Sub-items within categories (2-5 per category)
Level 3: Details (only if explicitly needed)
```

## Dynamic Layout Rules

### Column/Branch Count
- 2-3 items → Use all horizontally
- 4-5 items → Standard 5-column or radial
- 6-7 items → Consider 2 rows or condensed
- 8+ items → Group into meta-categories first

### Direction Selection
| Content Type | Direction |
|-------------|-----------|
| Hierarchy, org chart | TB (Top-Bottom) |
| Process, pipeline, timeline | LR (Left-Right) |
| Concept exploration | Radial (Mind Map) |
| System architecture | TB with grouped columns |

### Sizing
| Complexity | SVG ViewBox | Max Columns |
|-----------|-------------|-------------|
| Simple (≤3 categories) | 800 x 500 | 3 |
| Standard (4-5 categories) | 1200 x 620 | 5 |
| Complex (6-7 categories) | 1400 x 700 | 6 |
| Mind Map | 1000 x 1000 | Radial |

## Output Generation

### SVG Architecture
Use for: System overviews, documentation, presentations
```
Structure:
1. Title + subtitle (top)
2. Central node (below title)
3. Connection lines (from central)
4. Category columns (side by side)
5. Items within each category
6. Footer (bottom)
```
Pattern reference: `references/svg-generation.md`

### Mermaid Flowchart
Use for: Processes, pipelines, web embedding
```
Structure:
1. Define flow direction (TB/LR)
2. Central/start node
3. Subgraphs for categories
4. Nodes within subgraphs
5. Connection arrows
6. Style classes
```
Pattern reference: `references/mermaid-generation.md`

### React Component
Use for: Interactive dashboards, Streamlit, hover effects
```
Structure:
1. Data array from extracted entities
2. State for interactivity
3. Header component
4. Central node component
5. Grid of category cards
6. Item cards within categories
```
Pattern reference: `references/react-generation.md`

## Design System

### Universal Color Palette
Assign colors based on semantic meaning:

| Semantic Role | Primary | Background | Text |
|--------------|---------|------------|------|
| Core/Central | #6366f1 | #e0e7ff | #3730a3 |
| Data/Input | #059669 | #d1fae5 | #065f46 |
| Process/Transform | #0891b2 | #cffafe | #155e75 |
| Tools/Actions | #d97706 | #fef3c7 | #92400e |
| Output/Results | #7c3aed | #ede9fe | #5b21b6 |
| Rules/Standards | #dc2626 | #fee2e2 | #991b1b |
| Neutral/Info | #475569 | #f1f5f9 | #1e293b |

### Auto-Color Assignment
```
1st category → Green (data/input)
2nd category → Cyan (concepts/process)
3rd category → Amber (tools/actions)
4th category → Purple (network/output)
5th category → Red (standards/rules)
Additional → Cycle or use neutral
```

### Icon Selection
Map category types to icons:
```
Data/Tables: 📊 📋 🗃️
Concepts/Knowledge: 📚 🧠 💡
Tools/Software: 🔧 ⚙️ 🛠️
Network/Cloud: 🌐 ☁️ 🔗
Standards/Rules: 🔄 📏 ✅
People/Org: 👥 🏢 👤
Time/Process: ⏱️ 📅 🔄
Security: 🔒 🛡️ 🔐
Analytics: 📈 📉 🎯
Clinical/Health: 🏥 💊 🩺
```

## Example Analysis

### Input
```
"Create a diagram showing our clinical NLP pipeline:
- Data sources: EHR notes, Lab reports, Radiology
- Preprocessing: Tokenization, De-identification, Normalization
- NLP Models: BioBERT NER, Negation Detection, Relation Extraction
- Output: OMOP CDM tables, Power BI dashboards"
```

### Analysis
```
Entities: 4 main categories with 3 items each
Relationship: Sequential pipeline (left-to-right flow)
Domain: Clinical/Healthcare
Purpose: Technical documentation

Visualization: Pipeline flowchart (LR) or Architecture (TB)
Layout: 4 columns
Colors: Green→Cyan→Amber→Purple (input→process→model→output)
Icons: 🗃️ ⚙️ 🧠 📊
```

### Output Decision
- If user wants overview → SVG Architecture (TB)
- If user wants process flow → Mermaid Flowchart (LR)
- If user wants interactive → React Component

## File Output

Save to `/mnt/user-data/outputs/` with descriptive names:
```
{topic}_{viztype}.{ext}

Examples:
clinical_nlp_pipeline_architecture.svg
etl_workflow_flowchart.html
data_governance_mindmap.svg
fhir_resources_diagram.jsx
```

Always use `present_files` tool after generation.

## Reference Files

- `references/domain-styles.md` - Domain-specific styling (clinical, tech, business)
- `references/svg-generation.md` - SVG code patterns and snippets
- `references/mermaid-generation.md` - Mermaid syntax and styling
- `references/react-generation.md` - React/Tailwind component patterns
