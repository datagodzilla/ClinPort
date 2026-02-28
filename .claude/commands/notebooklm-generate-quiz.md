---
argument-hint: "Topic name or path to knowledge base content"
allowed-tools: read, write, task
description: "Generate assessment quiz from research content with diverse question types"
---

# Quiz Generation Command


## ⚠️ Argument Required

**Input received:** `$ARGUMENTS`

**If no argument is provided**, display this help information and stop:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Quiz Generation Command
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

DESCRIPTION:
  Generate assessment quiz from research content with diverse question types

USAGE:
  /notebooklm-generate-quiz Topic name or path to knowledge base content

REQUIRED ARGUMENTS:
    Topic name or path to knowledge base content

OPTIONAL ARGUMENTS:
    (none)

EXAMPLES:
  /notebooklm-generate-quiz "example-argument"

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Run the command with required arguments to proceed.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**If arguments ARE provided**, proceed with the command below.

---
## Purpose
Create comprehensive assessment quizzes from research content to test understanding and reinforce learning with diverse question types.

## Input Options

### Option 1: Topic Name
```
/notebooklm-generate-quiz "OMOP CDM"
```

### Option 2: Knowledge Base Path
```
/notebooklm-generate-quiz ingested/manifest.md
```

### Option 3: Specific Document
```
/notebooklm-generate-quiz docs/research/cohort-design.md
```

## Execution Workflow

### Phase 1: Content Analysis
1. Load source content
2. Identify testable concepts:
   - Key definitions
   - Important facts
   - Processes and procedures
   - Relationships and comparisons
   - Application scenarios

### Phase 2: Question Generation
Create diverse question types:
- Multiple choice (40%)
- True/False (20%)
- Fill in the blank (15%)
- Short answer (15%)
- Scenario-based (10%)

### Phase 3: Answer Key & Explanations
For each question:
- Correct answer
- Detailed explanation
- Why incorrect options are wrong
- Related concepts

### Phase 4: Quiz Assembly
Organize quiz with:
- Clear instructions
- Progressive difficulty
- Section groupings
- Scoring rubric

## Output Format

```markdown
---
title: "[Topic] Assessment Quiz"
generated_date: "YYYY-MM-DD"
source: "[Source path]"
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
- Each question shows difficulty level (⭐ = Beginner, ⭐⭐ = Intermediate, ⭐⭐⭐ = Advanced)
- Review explanations after completing
- Target score: 80% or higher

---

## Section 1: Fundamentals

### Question 1 (Multiple Choice) ⭐
**What is the primary purpose of the OMOP Common Data Model?**

A) To store patient names securely
B) To standardize healthcare data for systematic analysis
C) To replace electronic health records
D) To generate billing codes automatically

---

### Question 2 (True/False) ⭐
**ATLAS is an open-source tool for defining cohorts in the OHDSI ecosystem.**

- [ ] True
- [ ] False

---

### Question 3 (Fill in the Blank) ⭐⭐
**The vocabulary mapping process converts source codes to _______ concept IDs.**

---

## Section 2: Concepts

### Question 4 (Short Answer) ⭐⭐
**Explain the difference between "source" and "standard" concepts in OMOP CDM.**

[Your answer here]

---

### Question 5 (Matching) ⭐⭐
**Match each OMOP CDM table with its primary purpose:**

| Table | Purpose |
|-------|---------|
| 1. PERSON | A. Diagnoses and conditions |
| 2. CONDITION_OCCURRENCE | B. Medications |
| 3. DRUG_EXPOSURE | C. Lab tests |
| 4. MEASUREMENT | D. Demographics |

---

## Section 3: Application

### Question 6 (Scenario) ⭐⭐⭐
**Scenario**: You are designing an OHDSI study to compare cardiovascular safety of two diabetes medications.

**Question**: What key elements should be included in your cohort definition to minimize confounding bias?

[Your answer here]

---

## Answer Key

### Section 1

**Q1**: B - To standardize healthcare data for systematic analysis
> **Explanation**: The OMOP CDM provides a standardized schema enabling systematic analysis across disparate databases by transforming diverse source data into a common format.

**Q2**: True
> **Explanation**: ATLAS is the primary web-based tool in OHDSI for designing cohort definitions, characterizations, and study packages.

**Q3**: standard
> **Explanation**: Vocabulary mapping transforms source-specific codes to OMOP standard concept IDs for cross-database analysis.

### Section 2

**Q4 Scoring Rubric** (3 points):
- Source concepts preserve original codes (1 pt)
- Standard concepts are unified OMOP representation (1 pt)
- Mapping connects them for analysis (1 pt)

**Q5**: 1-D, 2-A, 3-B, 4-C

### Section 3

**Q6 Expected Elements** (5 points):
- New user design (1 pt)
- Active comparator (1 pt)
- Washout period (1 pt)
- Baseline covariate period (1 pt)
- Outcome window specification (1 pt)

---

## Scoring

| Section | Points |
|---------|--------|
| Fundamentals | 3 |
| Concepts | 6 |
| Application | 5 |
| **Total** | **14** |

**Passing**: 11+ points (80%)

---

## Performance Analysis

### Score Interpretation
| Score | Level | Recommendation |
|-------|-------|----------------|
| 90-100% | Expert | Ready for advanced topics |
| 80-89% | Proficient | Review missed concepts |
| 70-79% | Developing | Additional study needed |
| <70% | Foundational | Review core materials |

### Topic Feedback
- Q1-2 wrong: Review OMOP fundamentals
- Q3-4 wrong: Study vocabulary concepts
- Q5 wrong: Practice table relationships
- Q6 wrong: Review study design principles
```

## Question Types

### Multiple Choice
- 4 options (A-D)
- One correct answer
- Plausible distractors
- Clear, unambiguous

### True/False
- Factual statements
- Not trick questions
- Clear binary choice

### Fill in the Blank
- Key terms only
- Single word/phrase
- Context provided

### Short Answer
- 2-4 sentence response
- Scoring rubric provided
- Key points expected

### Scenario-Based
- Real-world situation
- Multiple elements to address
- Tests application

### Matching
- 4-6 items
- Clear relationships
- No overlap

## Question Count Guidelines

| Quiz Type | Questions | Time |
|-----------|-----------|------|
| Quick Check | 5-10 | 5-10 min |
| Standard | 15-20 | 15-20 min |
| Comprehensive | 30-50 | 30-45 min |

## Output Location

```
output/quizzes/[topic]/
├── [topic]_quiz.md            # Full quiz
├── [topic]_answer_key.md      # Answers only
├── [topic]_explanations.md    # Detailed explanations
└── [topic]_study_guide.md     # Weak area recommendations
```

## Usage Examples

### Generate from Topic
```
/notebooklm-generate-quiz "OHDSI Methodology"
```

### Generate with Question Count
```
/notebooklm-generate-quiz "OMOP CDM" --questions 20
```

### Generate Comprehensive Quiz
```
/notebooklm-generate-quiz "Full OHDSI Course" --type comprehensive
```

## Success Criteria

Quiz generation complete when:
- [ ] All question types represented
- [ ] Difficulty balanced appropriately
- [ ] Answer key with explanations created
- [ ] Scoring rubric defined
- [ ] Study recommendations included
- [ ] Files saved to output location

## Example Output

```
📝 Quiz Generation Complete

📁 Output: output/quizzes/omop-cdm/omop-cdm_quiz.md

📊 Statistics:
- Total Questions: 15
- Multiple Choice: 6
- True/False: 3
- Fill in Blank: 2
- Short Answer: 2
- Scenario: 2

⏱️ Estimated Time: 20 minutes
🎯 Passing Score: 80%

📚 Topics Covered:
- CDM Structure (5 questions)
- Vocabularies (4 questions)
- Study Design (3 questions)
- Data Quality (3 questions)

✅ Ready for assessment!
```
