---
argument-hint: "Topic name or path to knowledge base content"
allowed-tools: read, write, task
description: "Generate study flashcards from research content for spaced repetition learning"
---

# Flashcard Generation Command


## ⚠️ Argument Required

**Input received:** `$ARGUMENTS`

**If no argument is provided**, display this help information and stop:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Flashcard Generation Command
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

DESCRIPTION:
  Generate study flashcards from research content for spaced repetition learning

USAGE:
  /notebooklm-generate-flashcards Topic name or path to knowledge base content

REQUIRED ARGUMENTS:
    Topic name or path to knowledge base content

OPTIONAL ARGUMENTS:
    (none)

EXAMPLES:
  /notebooklm-generate-flashcards "example-argument"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Run the command with required arguments to proceed.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**If arguments ARE provided**, proceed with the command below.

---
## Purpose
Extract key concepts from research content and generate study flashcards for effective learning through spaced repetition.

## Input Options

### Option 1: Topic Name
```
/notebooklm-generate-flashcards "OMOP CDM"
```

### Option 2: Knowledge Base Path
```
/notebooklm-generate-flashcards ingested/manifest.md
```

### Option 3: Specific Document
```
/notebooklm-generate-flashcards docs/research/omop-overview.md
```

## Execution Workflow

### Phase 1: Content Analysis
1. Load source content
2. Identify key concepts:
   - Definitions and terminology
   - Processes and procedures
   - Comparisons and relationships
   - Key facts and statistics
   - Important examples

### Phase 2: Card Generation
For each concept, create flashcard with:
- **Front**: Clear, focused question
- **Back**: Concise, complete answer
- **Tags**: Topic categorization
- **Difficulty**: Beginner/Intermediate/Advanced

### Phase 3: Quality Review
Validate each card:
- Front is unambiguous
- Back is complete but concise
- One concept per card
- Appropriate difficulty level

### Phase 4: Organization
Organize cards by:
- Topic/subtopic
- Difficulty progression
- Learning path sequence

## Output Format

```markdown
---
title: "[Topic] Flashcards"
generated_date: "YYYY-MM-DD"
source: "[Source path]"
card_count: [N]
difficulty_distribution:
  beginner: [N]
  intermediate: [N]
  advanced: [N]
---

# Flashcards: [Topic]

## Overview
- **Total Cards**: [N]
- **Estimated Study Time**: [X] minutes
- **Recommended Review**: Daily for 1 week, then weekly

---

## Card 1: [Topic]
**Front**: What is the OMOP Common Data Model?

**Back**: A standardized data schema that transforms diverse observational healthcare data into a common format. Key features:
- Enables cross-database analysis
- Uses standard vocabulary concepts
- Supports reproducible research

**Tags**: #definition #omop #fundamentals
**Difficulty**: Beginner

---

## Card 2: [Topic]
**Front**: What are the 5 main clinical data domains in OMOP CDM?

**Back**:
1. **Condition** - Diagnoses
2. **Drug** - Medications
3. **Procedure** - Interventions
4. **Measurement** - Lab tests, vitals
5. **Observation** - Other clinical facts

**Tags**: #domains #omop #structure
**Difficulty**: Beginner

---

[Continue with remaining cards...]

---

## Study Guide

### Learning Path
1. Start with Beginner cards (definitions)
2. Progress to Intermediate (concepts)
3. Challenge with Advanced (application)

### Spaced Repetition Schedule
| Review | Interval |
|--------|----------|
| 1st | Same day |
| 2nd | 1 day |
| 3rd | 3 days |
| 4th | 1 week |
| 5th | 2 weeks |

---

## Card Index

### By Tag
- #fundamentals: Cards 1-5
- #vocabulary: Cards 6-10
- #methodology: Cards 11-15

### By Difficulty
- Beginner: Cards 1-8
- Intermediate: Cards 9-15
- Advanced: Cards 16-20
```

## Card Types Generated

### Definition Cards
```
Front: What is [term]?
Back: [Clear definition with key points]
```

### Concept Cards
```
Front: Explain [concept]
Back: [Explanation with examples]
```

### Process Cards
```
Front: What are the steps for [process]?
Back: [Numbered steps]
```

### Comparison Cards
```
Front: How does [X] differ from [Y]?
Back: [Key differences in bullet points]
```

### Application Cards
```
Front: When would you use [technique]?
Back: [Use cases and scenarios]
```

## Card Count Guidelines

| Content Type | Recommended Cards |
|--------------|-------------------|
| Short article | 10-15 |
| Research paper | 20-30 |
| Book chapter | 30-50 |
| Full course module | 50-100 |

## Quality Standards

### Good Flashcard
- Single, focused concept
- Clear, unambiguous question
- Concise but complete answer
- Appropriate difficulty

### Avoid
- Multiple concepts per card
- Vague or ambiguous questions
- Overly long answers
- Trick questions

## Output Location

```
output/flashcards/[topic]/
├── [topic]_flashcards.md      # Full flashcard set
├── [topic]_study_guide.md     # Study recommendations
└── by_difficulty/
    ├── beginner.md
    ├── intermediate.md
    └── advanced.md
```

## Usage Examples

### Generate from Topic
```
/notebooklm-generate-flashcards "OHDSI Study Design"
```

### Generate from Ingested Content
```
/notebooklm-generate-flashcards ingested/manifest.md
```

### Generate with Specific Card Count
```
/notebooklm-generate-flashcards "OMOP CDM" --cards 25
```

## Success Criteria

Flashcard generation complete when:
- [ ] Content analyzed for key concepts
- [ ] Cards generated for all major topics
- [ ] Cards validated for quality
- [ ] Difficulty levels assigned
- [ ] Study guide created
- [ ] Files saved to output location

## Example Output

```
📚 Flashcard Generation Complete

📁 Output: output/flashcards/omop-cdm/omop-cdm_flashcards.md

📊 Statistics:
- Total Cards: 25
- Beginner: 10 cards
- Intermediate: 10 cards
- Advanced: 5 cards

📖 Topics Covered:
- CDM Structure (8 cards)
- Vocabularies (7 cards)
- ETL Process (5 cards)
- Data Quality (5 cards)

⏱️ Estimated Study Time: 30 minutes

🎯 Ready for studying!
Use spaced repetition for best retention.
```
