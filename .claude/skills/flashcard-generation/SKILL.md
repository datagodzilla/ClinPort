---
name: flashcard-generation
description: "Generate study flashcards from knowledge content. Creates front/back pairs with tags for spaced repetition learning."
allowed-tools: read, write, task
---

# Flashcard Generation Skill

## Purpose
Extract key concepts from research content and generate flashcards for effective learning through spaced repetition. Output in markdown format for easy review and study.

## When to Activate
- User requests flashcards from content
- Study material generation needed
- Knowledge retention artifacts requested
- Educational content creation

**Key Triggers**: flashcard, study, memorize, quiz yourself, spaced repetition, learning cards

## Flashcard Design Principles

### Effective Flashcard Characteristics
1. **Atomic**: One concept per card
2. **Clear**: Unambiguous question and answer
3. **Concise**: Brief enough to review quickly
4. **Connected**: Tags link related concepts
5. **Complete**: Answer is self-contained

### Question Types
| Type | Front | Back | Best For |
|------|-------|------|----------|
| Definition | "What is [term]?" | Definition | Vocabulary |
| Concept | "Explain [concept]" | Explanation | Understanding |
| Comparison | "How does X differ from Y?" | Key differences | Relationships |
| Application | "When would you use [technique]?" | Use cases | Practical knowledge |
| Process | "What are the steps for [process]?" | Numbered steps | Procedures |
| Example | "Give an example of [concept]" | Concrete example | Reinforcement |

## Output Format

### Flashcard Markdown Template
```markdown
---
title: "[Topic] Flashcards"
generated_date: "YYYY-MM-DD"
source: "[Source document or topic]"
card_count: [N]
difficulty: [Beginner|Intermediate|Advanced]
domain: [clinical|technical|mixed]
tags: [tag1, tag2, tag3]
---

# Flashcards: [Topic]

## Overview
- **Total Cards**: [N]
- **Difficulty**: [Level]
- **Estimated Study Time**: [X] minutes
- **Recommended Review**: Daily for 1 week, then weekly

---

## Card 1: [Brief Topic]
**Front**: What is the OMOP Common Data Model?

**Back**: A standardized data schema that transforms diverse observational healthcare data into a common format. Key features:
- Enables analysis across different data sources
- Uses standard vocabulary concepts
- Supports reproducible research

**Tags**: #definition #omop #fundamentals
**Difficulty**: Beginner

---

## Card 2: [Brief Topic]
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

## Card 3: [Brief Topic]
**Front**: What is the difference between "standard" and "source" concepts in OMOP?

**Back**:
- **Source concepts**: Original codes from data source (e.g., ICD-10)
- **Standard concepts**: OMOP's unified representation (e.g., SNOMED)
- Mapping connects source → standard for cross-database analysis
- Both are stored; standard used for queries

**Tags**: #vocabulary #concepts #mapping
**Difficulty**: Intermediate

---

## Card 4: [Brief Topic]
**Front**: When would you use a new-user study design?

**Back**: Use new-user design when:
- Comparing treatment effects between drugs
- Need to avoid prevalent user bias
- Want to capture early treatment effects
- Important for safety signal detection

Example: Comparing cardiovascular outcomes between SGLT2i and GLP-1RA in T2DM

**Tags**: #study-design #methodology #comparative-effectiveness
**Difficulty**: Advanced

---

[Continue with remaining cards...]

---

## Study Tips

### Spaced Repetition Schedule
| Review | Interval |
|--------|----------|
| 1st | Same day |
| 2nd | 1 day later |
| 3rd | 3 days later |
| 4th | 1 week later |
| 5th | 2 weeks later |
| 6th+ | Monthly |

### Self-Assessment Guide
- ⭐ Easy: < 5 seconds to answer → Increase interval
- ⚡ Medium: 5-15 seconds → Keep interval
- ❌ Hard: > 15 seconds or wrong → Reset interval

---

## Card Index by Tag

### #fundamentals
- Card 1: OMOP CDM Definition
- Card 2: Clinical Data Domains

### #vocabulary
- Card 3: Standard vs Source Concepts

### #methodology
- Card 4: New-User Study Design

---

## Source References
- [Source 1]: Cards 1-5
- [Source 2]: Cards 6-10
```

## Generation Process

### Step 1: Content Analysis
```python
def analyze_content_for_flashcards(content: str) -> dict:
    """Identify flashcard-worthy content."""
    analysis = {
        'definitions': [],      # Terms to define
        'concepts': [],         # Ideas to explain
        'processes': [],        # Steps to memorize
        'comparisons': [],      # Things to contrast
        'facts': [],           # Key facts to remember
        'examples': []         # Illustrative examples
    }

    # Extract each type from content
    # ...

    return analysis
```

### Step 2: Card Generation
```python
def generate_flashcard(
    concept: str,
    card_type: str,
    source_text: str,
    difficulty: str
) -> dict:
    """Generate a single flashcard."""
    card = {
        'front': '',
        'back': '',
        'tags': [],
        'difficulty': difficulty,
        'source': source_text[:100]
    }

    if card_type == 'definition':
        card['front'] = f"What is {concept}?"
        card['back'] = extract_definition(source_text, concept)

    elif card_type == 'process':
        card['front'] = f"What are the steps for {concept}?"
        card['back'] = extract_steps(source_text, concept)

    # ... other types

    return card
```

### Step 3: Quality Checks
```python
def validate_flashcard(card: dict) -> bool:
    """Ensure flashcard meets quality standards."""
    checks = [
        len(card['front']) > 10,           # Front not too short
        len(card['front']) < 200,          # Front not too long
        len(card['back']) > 20,            # Back has content
        len(card['back']) < 500,           # Back not overwhelming
        len(card['tags']) >= 1,            # Has at least one tag
        card['difficulty'] in ['Beginner', 'Intermediate', 'Advanced']
    ]
    return all(checks)
```

## Card Count Guidelines

| Content Length | Recommended Cards | Focus |
|----------------|-------------------|-------|
| Short article | 10-15 cards | Key definitions, main concepts |
| Research paper | 20-30 cards | Methods, findings, implications |
| Book chapter | 30-50 cards | Full coverage with depth |
| Course module | 50-100 cards | Comprehensive learning |

## Tag Taxonomy

### Domain Tags
- #clinical, #technical, #regulatory, #methodology

### Concept Tags
- #definition, #process, #comparison, #example

### Topic Tags
- #omop, #cohort, #vocabulary, #etl, #analysis

### Difficulty Tags
- #beginner, #intermediate, #advanced

## Integration

### With Other Artifacts
- **Mindmaps**: Link cards to mindmap nodes
- **Quizzes**: Generate quiz questions from cards
- **Reports**: Cards summarize key report findings

### Command Usage
```
/notebooklm-generate-flashcards [topic_or_path]
```

## Best Practices

1. **Start Simple**: Begin with definitions, build to complex concepts
2. **Use Examples**: Concrete examples aid retention
3. **Link Cards**: Use tags to show relationships
4. **Progressive Difficulty**: Organize from basic to advanced
5. **Update Regularly**: Add new cards as knowledge grows

## See Also
- Command: /notebooklm-generate-flashcards
- Skill: quiz-generation (for assessment)
- Workflow: notebooklm-complete-workflow.md
