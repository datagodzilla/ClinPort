---
name: quiz-generation
description: "Generate assessment quizzes from knowledge content. Creates diverse question types with explanations for self-assessment and learning validation."
allowed-tools: read, write, task
---

# Quiz Generation Skill

## Purpose
Create comprehensive assessment quizzes from research content to test understanding and reinforce learning. Supports multiple question types with detailed explanations.

## When to Activate
- User requests quiz generation
- Assessment material needed
- Knowledge testing required
- Educational content validation

**Key Triggers**: quiz, test, assessment, questions, exam, evaluate knowledge

## Question Types

### 1. Multiple Choice
```markdown
## Question 1 (Multiple Choice)
**What is the primary purpose of the OMOP Common Data Model?**

A) To store patient names securely
B) To standardize healthcare data for systematic analysis
C) To replace electronic health records
D) To generate billing codes automatically

**Correct Answer**: B

**Explanation**: The OMOP CDM provides a standardized schema that enables systematic analysis of disparate observational databases by transforming diverse source data into a common format with consistent vocabulary representations.

**Difficulty**: Beginner
**Tags**: #omop #fundamentals
```

### 2. True/False
```markdown
## Question 2 (True/False)
**ATLAS is an open-source tool for defining cohorts in the OHDSI ecosystem.**

- [ ] True
- [ ] False

**Correct Answer**: True

**Explanation**: ATLAS is the primary web-based tool in the OHDSI ecosystem for designing cohort definitions, characterizations, and study packages. It provides a graphical interface for building complex cohort logic.

**Difficulty**: Beginner
**Tags**: #atlas #tools
```

### 3. Fill in the Blank
```markdown
## Question 3 (Fill in the Blank)
**The vocabulary mapping process converts source codes to _______ concept IDs.**

**Correct Answer**: standard

**Explanation**: Vocabulary mapping transforms source-specific codes (like ICD-10) to OMOP standard concept IDs (like SNOMED) to enable cross-database analysis using a unified terminology.

**Difficulty**: Intermediate
**Tags**: #vocabulary #mapping
```

### 4. Short Answer
```markdown
## Question 4 (Short Answer)
**Explain the difference between "source" and "standard" concepts in OMOP CDM.**

**Expected Answer Points**:
- Source concepts preserve original codes from data source
- Standard concepts are OMOP's unified representation
- Mapping connects source to standard for analysis
- Both are stored but standard is used for queries

**Sample Complete Answer**: Source concepts retain the original vocabulary codes from the source system (e.g., ICD-10-CM diagnosis codes), while standard concepts are the OMOP-defined unified representation (e.g., SNOMED-CT concepts). The vocabulary tables contain mappings between source and standard concepts. Both are stored in the CDM—source concepts in *_source_concept_id fields for traceability, and standard concepts in *_concept_id fields for analysis.

**Difficulty**: Intermediate
**Tags**: #vocabulary #concepts
```

### 5. Matching
```markdown
## Question 5 (Matching)
**Match each OMOP CDM table with its primary purpose:**

| Table | Purpose |
|-------|---------|
| 1. PERSON | A. Diagnoses and conditions |
| 2. CONDITION_OCCURRENCE | B. Medications and prescriptions |
| 3. DRUG_EXPOSURE | C. Lab tests and vital signs |
| 4. MEASUREMENT | D. Patient demographics |

**Correct Matches**:
- 1-D: PERSON contains patient demographics
- 2-A: CONDITION_OCCURRENCE stores diagnoses
- 3-B: DRUG_EXPOSURE records medications
- 4-C: MEASUREMENT captures lab results and vitals

**Difficulty**: Beginner
**Tags**: #omop #tables
```

### 6. Scenario-Based
```markdown
## Question 6 (Scenario)
**Scenario**: You are designing an OHDSI study to compare the cardiovascular safety of two diabetes medications. You need to define your target and comparator cohorts.

**Question**: What key elements should be included in your cohort definition to minimize confounding bias?

**Expected Answer Elements**:
1. **New user design**: First-time use of study drug only
2. **Active comparator**: Compare drug vs drug, not drug vs no treatment
3. **Washout period**: 365 days without prior use of study drugs
4. **Exclusion criteria**: Prior cardiovascular events (for incident event analysis)
5. **Baseline period**: Sufficient time for covariate assessment (365 days)
6. **Observation period requirement**: Adequate data before and after index

**Difficulty**: Advanced
**Tags**: #study-design #cohort #methodology
```

## Quiz Template

```markdown
---
title: "[Topic] Assessment Quiz"
generated_date: "YYYY-MM-DD"
source: "[Source document or topic]"
total_questions: [N]
passing_score: 80%
time_limit: "[X] minutes"
difficulty_distribution:
  beginner: [N]%
  intermediate: [N]%
  advanced: [N]%
---

# Quiz: [Topic]

## Instructions
- Answer all questions to the best of your ability
- Each question shows difficulty level
- Review explanations after completing
- Target score: 80% or higher

## Section 1: Fundamentals ([N] questions)

### Question 1 (Multiple Choice) ⭐
[Question content...]

### Question 2 (True/False) ⭐
[Question content...]

## Section 2: Concepts ([N] questions)

### Question 3 (Fill in the Blank) ⭐⭐
[Question content...]

### Question 4 (Short Answer) ⭐⭐
[Question content...]

## Section 3: Application ([N] questions)

### Question 5 (Scenario) ⭐⭐⭐
[Question content...]

---

## Answer Key

| Q# | Answer | Points |
|----|--------|--------|
| 1 | B | 1 |
| 2 | True | 1 |
| 3 | standard | 1 |
| 4 | See rubric | 3 |
| 5 | See rubric | 5 |

**Total Points**: [N]
**Passing**: [N] points (80%)

---

## Scoring Rubric

### Short Answer Scoring
| Points | Criteria |
|--------|----------|
| Full | All key points addressed accurately |
| Partial | Most key points, minor omissions |
| Minimal | Some correct elements, significant gaps |
| 0 | Incorrect or no response |

---

## Performance Analysis

After completing the quiz, use this guide:

### Score Interpretation
| Score | Level | Recommendation |
|-------|-------|----------------|
| 90-100% | Expert | Ready for advanced topics |
| 80-89% | Proficient | Review missed concepts |
| 70-79% | Developing | Additional study recommended |
| <70% | Foundational | Review core materials |

### Topic-Based Feedback
- If Q1-2 wrong: Review OMOP fundamentals
- If Q3-4 wrong: Study vocabulary concepts
- If Q5 wrong: Practice study design scenarios

---

## Study Resources
Based on quiz performance, review:
- [Resource 1 for Topic A]
- [Resource 2 for Topic B]
```

## Generation Process

### Step 1: Content Analysis
```python
def analyze_for_quiz(content: str) -> dict:
    """Identify quiz-worthy content areas."""
    return {
        'key_definitions': [],    # Definition questions
        'factual_content': [],    # T/F and fill-in-blank
        'conceptual_content': [], # Short answer
        'applied_scenarios': [],  # Scenario questions
        'comparisons': []         # Matching questions
    }
```

### Step 2: Question Distribution
```python
def plan_quiz_structure(
    content_analysis: dict,
    target_questions: int = 15
) -> dict:
    """Plan question distribution."""
    return {
        'multiple_choice': int(target_questions * 0.4),
        'true_false': int(target_questions * 0.2),
        'fill_blank': int(target_questions * 0.15),
        'short_answer': int(target_questions * 0.15),
        'scenario': int(target_questions * 0.1)
    }
```

### Step 3: Distractor Generation
```python
def generate_distractors(
    correct_answer: str,
    context: str,
    count: int = 3
) -> list:
    """Generate plausible but incorrect options."""
    # Distractors should be:
    # - Similar length to correct answer
    # - Related to the topic
    # - Plausible but clearly wrong when explained
    # - Not "trick" options
    pass
```

## Question Count Guidelines

| Quiz Type | Questions | Time | Purpose |
|-----------|-----------|------|---------|
| Quick Check | 5-10 | 5-10 min | Concept verification |
| Standard | 15-20 | 15-20 min | Module assessment |
| Comprehensive | 30-50 | 30-45 min | Full topic evaluation |
| Certification | 50-100 | 60-90 min | Competency validation |

## Difficulty Calibration

### Beginner (⭐)
- Direct recall of definitions
- Simple factual questions
- Recognition of key terms

### Intermediate (⭐⭐)
- Application of concepts
- Comparison and contrast
- Process understanding

### Advanced (⭐⭐⭐)
- Synthesis of multiple concepts
- Real-world scenario analysis
- Problem-solving and design

## Best Practices

1. **Balance Types**: Mix question formats for comprehensive assessment
2. **Clear Wording**: Avoid ambiguous language
3. **Relevant Distractors**: Make wrong answers plausible
4. **Explain All**: Provide explanations for every answer
5. **Progressive Difficulty**: Order from easy to hard
6. **Cover Breadth**: Touch all major topics from source

## Integration

### With Other Artifacts
- **Flashcards**: Quiz tests flashcard knowledge
- **Reports**: Quiz questions from report key points
- **Mindmaps**: Questions cover mindmap branches

### Command Usage
```
/notebooklm-generate-quiz [topic_or_path]
```

## See Also
- Command: /notebooklm-generate-quiz
- Skill: flashcard-generation
- Workflow: notebooklm-complete-workflow.md
