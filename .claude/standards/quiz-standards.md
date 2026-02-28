# Quiz Standards

## Overview
Standards for generating educational assessment quizzes that test comprehension and application of research content.

## Quiz Structure

### Overall Format
```
Questions: 10-25 per quiz
Time estimate: 1-2 minutes per question
Difficulty distribution: 30% easy, 50% medium, 20% hard
Question type mix: Varied (see types below)
```

### Question Types

1. **Multiple Choice (40-50% of quiz)**
   - 4-5 answer options
   - One clearly correct answer
   - Plausible distractors
   - Avoid "all of the above" / "none of the above"

2. **True/False with Explanation (15-20%)**
   - Clear, unambiguous statements
   - Require explanation for why
   - Test common misconceptions

3. **Fill-in-the-Blank (15-20%)**
   - Single word or short phrase answers
   - Provide context clues
   - Accept reasonable synonyms

4. **Matching (10-15%)**
   - 5-8 items per set
   - Clear category distinctions
   - No overlapping correct answers

5. **Short Answer (5-10%)**
   - Specific, focused questions
   - Clear grading criteria
   - 1-3 sentence expected response

## Question Writing Guidelines

### Stem Construction
- Clear, concise language
- All necessary information included
- No trick questions or wordplay
- Positive phrasing (avoid "NOT" unless necessary)

### Answer Options
- Grammatically parallel
- Similar length and complexity
- Randomly ordered (correct answer position varies)
- No absolute terms ("always", "never") unless accurate

### OHDSI-Specific Questions

#### Concept Testing
```markdown
**Q:** Which OMOP CDM table would you query to find a patient's diagnosis of Type 2 Diabetes?

a) DRUG_EXPOSURE
b) CONDITION_OCCURRENCE ✓
c) OBSERVATION
d) MEASUREMENT

**Explanation:** CONDITION_OCCURRENCE stores diagnoses and conditions. DRUG_EXPOSURE stores medications, OBSERVATION stores non-standard clinical facts, and MEASUREMENT stores lab results.
```

#### Application Testing
```markdown
**Q:** You need to identify patients who started metformin after being diagnosed with Type 2 Diabetes. Which temporal relationship should you specify in ATLAS?

a) Starts before
b) Starts after ✓
c) Starts during
d) Ends before

**Explanation:** "Starts after" ensures the drug exposure (metformin) begins after the condition (T2DM diagnosis), which is the correct temporal sequence for incident drug use.
```

## Difficulty Levels

### Easy (Beginner)
- Recall-based questions
- Definitions and terminology
- Basic concept identification
- Direct facts from content

### Medium (Intermediate)
- Application of concepts
- Comparison and contrast
- Process understanding
- Multiple concept integration

### Hard (Advanced)
- Analysis and evaluation
- Edge cases and exceptions
- Multi-step reasoning
- Real-world problem solving

## Answer Key Format

```markdown
## Answer Key

### Question 1
**Correct Answer:** B
**Difficulty:** Medium
**Topic:** OMOP CDM Tables
**Explanation:** [Detailed explanation of why B is correct and why other options are incorrect]
**Reference:** OMOP CDM Documentation, Chapter 4

### Question 2
...
```

## Quality Checklist

### Per Question
- [ ] Clear, unambiguous stem
- [ ] One definitively correct answer
- [ ] Plausible distractors (for MC)
- [ ] Tests understanding, not trivia
- [ ] Appropriate difficulty level
- [ ] Explanation provided
- [ ] Topic/tag assigned

### Per Quiz
- [ ] Balanced difficulty distribution
- [ ] Varied question types
- [ ] Logical topic progression
- [ ] No dependent questions (one answer reveals another)
- [ ] Time estimate provided
- [ ] Learning objectives stated
- [ ] Complete answer key

## Anti-Patterns

### Avoid These Question Types
```markdown
# TRICK QUESTION ❌
Q: OMOP CDM does NOT include which table?
(Using negatives confuses more than tests)

# TRIVIAL ❌
Q: What year was OHDSI founded?
(Tests memorization, not understanding)

# OPINION-BASED ❌
Q: What is the best HADES package?
(No objectively correct answer)

# OVERLY COMPLEX ❌
Q: Given a patient with ICD-10 code E11.9 who started on RxNorm 860975
   on day 30 of their observation period which ended on day 365...
(Too many details obscure the actual question)
```

## Metadata Standards

```yaml
quiz:
  title: "OMOP CDM Fundamentals Assessment"
  version: "1.0"
  created: "2024-01-15"
  difficulty: "mixed"
  estimated_time: "25 minutes"
  question_count: 15
  topics:
    - "OMOP CDM Structure"
    - "Clinical Data Tables"
    - "Vocabulary System"
  learning_objectives:
    - "Identify appropriate OMOP tables for clinical data"
    - "Understand vocabulary hierarchy concepts"
    - "Apply temporal logic in cohort definitions"
```
