# Flashcard Standards

## Overview
Standards for creating effective study flashcards optimized for spaced repetition learning.

## Card Design Principles

### Minimum Information Principle
- One concept per card
- Clear, unambiguous questions
- Concise answers (ideally under 20 words)
- Avoid "what is X and Y" compound questions

### Active Recall Focus
- Questions should require retrieval, not recognition
- Avoid yes/no questions where possible
- Use "what", "how", "why", "when" question stems
- Frame as problems to solve when applicable

## Card Types

### Basic (Question → Answer)
```markdown
## Card
**Q:** What is the OMOP CDM?
**A:** A standardized data model for observational healthcare data that enables systematic analysis across disparate databases.
**Tags:** #omop #cdm #fundamentals
```

### Cloze Deletion
```markdown
## Card
**Q:** The {{c1::CONDITION_OCCURRENCE}} table stores diagnoses and the {{c2::DRUG_EXPOSURE}} table stores medications.
**Tags:** #omop #tables #clinical-data
```

### Reverse Card
```markdown
## Card (Reversible)
**Front:** SNOMED-CT
**Back:** Systematized Nomenclature of Medicine - Clinical Terms; the primary vocabulary for conditions in OMOP CDM
**Tags:** #vocabularies #snomed #conditions
```

## OHDSI-Specific Guidelines

### Vocabulary Cards
- Include concept_id examples where helpful
- Reference domain mappings
- Note source vs standard concept distinctions
- Include common code examples (ICD-10, RxNorm)

### CDM Table Cards
- Focus on primary keys and foreign keys
- Include common field names and purposes
- Reference table relationships
- Note required vs optional fields

### HADES Package Cards
- Include package names and primary functions
- Reference common function signatures
- Note dependencies between packages
- Include typical use cases

## Tagging Taxonomy

### Required Tags
- Domain: `#omop`, `#vocabularies`, `#hades`, `#atlas`, `#etl`
- Difficulty: `#beginner`, `#intermediate`, `#advanced`
- Type: `#definition`, `#concept`, `#procedure`, `#code`

### Optional Tags
- Topic: `#cohort-definition`, `#characterization`, `#plp`, `#ple`
- Table: `#person`, `#visit`, `#condition`, `#drug`, `#measurement`
- Vocabulary: `#snomed`, `#rxnorm`, `#loinc`, `#icd10`

## Quality Standards

### Card Quality Checklist
- [ ] Single concept per card
- [ ] Question is unambiguous
- [ ] Answer is concise and complete
- [ ] Appropriate difficulty level
- [ ] Relevant tags applied
- [ ] No reliance on card ordering
- [ ] Can be understood in isolation

### Deck Organization
- Group by topic (20-50 cards per deck)
- Progress from fundamentals to advanced
- Include prerequisite tags for dependencies
- Balance card types within deck

## Anti-Patterns to Avoid

### Bad Card Examples
```markdown
# TOO VAGUE
Q: What is OHDSI?
A: An organization. ❌

# BETTER
Q: What is OHDSI's primary mission?
A: To generate reliable evidence from observational health data through open-source analytics. ✓
```

```markdown
# TOO COMPLEX
Q: List all 16 clinical data tables in OMOP CDM v5.4.
A: [long list] ❌

# BETTER
Q: Name 3 core clinical event tables in OMOP CDM.
A: CONDITION_OCCURRENCE, DRUG_EXPOSURE, PROCEDURE_OCCURRENCE ✓
```

## Export Compatibility

### Anki Format
- Use `::` separator for hierarchical tags
- Include deck name in metadata
- Support media references with `[sound:file.mp3]`

### Markdown Format
- Use consistent heading structure
- Support rendering in any markdown viewer
- Include YAML frontmatter for metadata
