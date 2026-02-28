---
argument-hint: "<topic> [--specialty oncology|cardiology|informatics|research-ethics|...] [--scenario-type ethics|workflow|diagnostic|treatment|...] [--complexity basic|intermediate|complex] [--learning-objectives \"obj1, obj2\"]"
allowed-tools: read, write, grep, glob, task, bash
description: Generate comprehensive clinical case studies in CITI Program style with interactive Q&A, clinical workflows, mind maps, and teaching materials for clinical informatics education
---

# Research Hub: Generate Clinical Case Study

## Argument Required

**Input received:** `$ARGUMENTS`

**If no argument is provided**, display this help information and stop:

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Clinical Case Study Generator
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

DESCRIPTION:
  Generate comprehensive clinical case studies in CITI Program style.
  Creates realistic patient/research narratives, interactive Q&A with
  regulatory analysis, clinical workflows, mind maps, and teaching
  materials aligned with clinical informatics competencies.

  Voice: One of the world's best physicians explaining to a clinical
  informatics student, using the Socratic method and case-based teaching.

USAGE:
  /notebooklm-generate-case-study <topic> [options]

REQUIRED ARGUMENTS:
  topic                 Clinical topic or concept name (quoted if spaces)

OPTIONS:
  --specialty <specialty>
      Clinical specialty context. Options:
      • oncology          - Cancer diagnosis, treatment, survivorship
      • cardiology        - Cardiovascular conditions and interventions
      • informatics       - Health IT, EHR, data interoperability
      • emergency         - Acute care, triage, time-critical decisions
      • primary-care      - Preventive care, chronic disease management
      • research-ethics   - IRB, consent, research participant protection
      • pediatrics        - Child-specific care considerations
      • geriatrics        - Age-related care complexities
      • psychiatry        - Mental health, behavioral considerations
      • surgery           - Perioperative care pathways
      • ohdsi             - OMOP CDM, cohort studies, RWE research
      • general           - Cross-specialty (default)

  --scenario-type <type>
      Type of case study scenario. Options:
      • ethics            - Ethical dilemmas, consent, privacy, research ethics
      • workflow          - Clinical process, care coordination, handoffs
      • diagnostic        - Differential diagnosis, clinical reasoning
      • treatment         - Treatment selection, monitoring, outcomes
      • informatics       - EHR design, data quality, interoperability
      • research          - Study design, cohort definition, RWE generation
      • mixed             - Combination of multiple types (default)

  --complexity <level>
      Case complexity level. Options:
      • basic             - Single issue, straightforward decisions
                           150-250 word vignette, 3-4 Q&A tabs
      • intermediate      - Multiple factors, some ambiguity (default)
                           250-400 word vignette, 5-6 Q&A tabs
      • complex           - Multiple stakeholders, ethical gray areas
                           400-600 word vignette, 7-10 Q&A tabs

  --learning-objectives <objectives>
      Comma-separated list of specific learning objectives to address.
      If not provided, will auto-generate based on topic and scenario.

  --output <path>
      Output folder (default: artifacts/case-studies/{topic-slug}/)

EXAMPLES:
  # Basic research ethics case (like CITI Program examples)
  /notebooklm-generate-case-study "Secondary use of biospecimens" \
    --specialty research-ethics --scenario-type ethics --complexity basic

  # Intermediate consent case
  /notebooklm-generate-case-study "Informed consent for biobank research" \
    --specialty research-ethics --scenario-type ethics

  # Complex oncology treatment case
  /notebooklm-generate-case-study "Precision oncology treatment selection" \
    --specialty oncology --scenario-type treatment --complexity complex

  # Informatics workflow case with custom objectives
  /notebooklm-generate-case-study "EHR alert fatigue management" \
    --specialty informatics --scenario-type workflow \
    --learning-objectives "Identify CDS alert triggers, Evaluate alert effectiveness"

  # OHDSI research case
  /notebooklm-generate-case-study "Cohort definition for comparative effectiveness" \
    --specialty ohdsi --scenario-type research --complexity intermediate

OUTPUT:
  Generates both Interactive HTML (CITI-style tabs) and Static Markdown:

  artifacts/case-studies/{topic-slug}/
  ├── README.md                          # Quick start guide
  ├── {topic}_complete_case_study.md     # Master Markdown document
  ├── {topic}_interactive.html           # Interactive HTML (CITI-style)
  ├── case-document/
  │   ├── {topic}_case_vignette.md       # CITI-style narrative
  │   ├── {topic}_qa_tabs.md             # Q&A content
  │   └── {topic}_clinical_workflow.md   # Process and decisions
  ├── teaching-materials/
  │   ├── {topic}_teaching_notes.md      # Facilitator guide
  │   └── {topic}_learning_objectives.md # Competency alignment
  └── visualizations/
      ├── {topic}_mindmap_ascii.md       # ASCII concept map
      └── {topic}_mindmap_mermaid.md     # Mermaid diagram

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Run with a topic to generate your clinical case study.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**If arguments ARE provided**, proceed with the command below.

---

## Command Purpose

Generate publication-ready clinical case studies in the CITI Program style that serve as educational tools for clinical informatics students, healthcare professionals, and researchers. The case studies integrate:

1. **Realistic Vignettes** - CITI-style narratives with authentic clinical/research context
2. **Interactive Q&A Tabs** - Expandable questions with regulatory analysis
3. **Clinical Workflow Mapping** - Process flows, decision points, stakeholder coordination
4. **Teaching Materials** - Discussion facilitation, learning objectives, assessment rubrics
5. **Visual Knowledge Structures** - Mind maps of case concepts and workflows
6. **Dual Output Formats** - Interactive HTML + Static Markdown

---

## Input Processing

**User Input**: `$ARGUMENTS`

### Parse Arguments

```
TOPIC = First quoted string or unquoted text before options
OPTIONS:
  --specialty <specialty>     Clinical specialty context (default: general)
  --scenario-type <type>      Scenario type (default: mixed)
  --complexity <level>        Complexity level (default: intermediate)
  --learning-objectives <list> Comma-separated objectives (default: auto-generate)
  --output <path>             Output folder (default: artifacts/case-studies/{slug})
```

### Default Values
- `specialty`: general (or auto-detected from topic)
- `scenario-type`: mixed (or auto-detected from topic)
- `complexity`: intermediate
- `learning-objectives`: Auto-generated based on topic and scenario
- `output`: artifacts/case-studies/{topic-slug}/

---

## Execution Workflow

### Phase 0: Setup & Validation (1-2 min)
**Agent**: `@notebooklm-master`

#### Step 0.1: Parse Topic and Options
```markdown
**Extract from input**:
- Topic: [extracted topic name]
- Specialty: [specified or auto-detect]
- Scenario Type: [specified or auto-detect]
- Complexity: [specified or default: intermediate]
- Learning Objectives: [specified or auto-generate]
```

#### Step 0.2: Specialty & Scenario Detection
```
IF specialty not specified:
    Detect from topic keywords:
    - "EHR", "data", "interoperability", "CDS", "CPOE" → informatics
    - "consent", "IRB", "ethics", "privacy", "Common Rule" → research-ethics
    - "cancer", "tumor", "oncology", "chemotherapy" → oncology
    - "heart", "cardiac", "cardiovascular", "MI", "CHF" → cardiology
    - "OMOP", "OHDSI", "cohort", "CDM", "RWE" → ohdsi
    - "pediatric", "child", "infant" → pediatrics
    - "emergency", "trauma", "acute", "triage" → emergency
    - "surgery", "operative", "perioperative" → surgery
    - Default → general

IF scenario-type not specified:
    Detect from topic keywords:
    - "consent", "privacy", "rights", "IRB", "ethics" → ethics
    - "diagnosis", "differential", "workup" → diagnostic
    - "treatment", "therapy", "medication" → treatment
    - "workflow", "process", "EHR", "pathway" → workflow
    - "study", "cohort", "research", "analysis" → research
    - Default → mixed
```

#### Step 0.3: Create Folder Structure
```bash
# Generate topic slug
TOPIC_SLUG=$(echo "$TOPIC" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')

# Create folder structure
FOLDER="artifacts/case-studies/$TOPIC_SLUG"
mkdir -p "$FOLDER"/{case-document,teaching-materials,visualizations/generated,supporting-materials}
```

**Report Progress**:
```markdown
✓ Phase 0 Complete: Setup
- Topic: [topic name]
- Specialty: [detected/specified specialty]
- Scenario Type: [detected/specified type]
- Complexity: [complexity level]
- Learning Objectives: [list or "auto-generating"]
- Folder: [created folder path]
- Next: Case Vignette Generation
```

---

### Phase 1: Case Vignette Generation (5-10 min)
**Agent**: `@notebooklm-clinical-expert`

#### Step 1.1: Generate CITI-Style Vignette

**Instructions to Clinical Expert**:
```markdown
Generate a realistic clinical case study vignette on: "[TOPIC]"

**Specialty Context**: [SPECIALTY]
**Scenario Type**: [SCENARIO-TYPE]
**Complexity Level**: [COMPLEXITY]

**CRITICAL: Voice and Persona**
Write as one of the world's best physicians explaining to a clinical informatics
student. Use the Socratic method and case-based teaching. You are a practicing
physician-researcher who publishes in peer-reviewed journals and mentors junior
clinical researchers.

**Vignette Structure (CITI Program Style)**:

1. **Opening Hook**: Start with a researcher/clinician name and their situation
   Example: "Dr. Jackson plans to conduct genotyping research on stored blood samples..."

2. **Setting & Context**:
   - Geographic context (e.g., "small New England community")
   - Institutional setting (academic medical center, community hospital, biobank)
   - Time period if relevant (original samples collected "several decades ago")

3. **Patient/Subject Profile** (if applicable):
   - Relevant demographics
   - Clinical history
   - Current situation

4. **Research/Clinical Context**:
   - Purpose of the research or clinical intervention
   - Scientific rationale
   - Public health significance

5. **Complicating Factors** (crucial for complexity):
   - Historical consent language (quote verbatim, e.g., "have a portion of their
     blood stored for future research")
   - Changed demographics or circumstances
   - Deceased or unreachable participants
   - New technology not anticipated in original consent
   - Regulatory timeline issues (pre-2018 vs post-2018 Common Rule)

6. **Ethical/Regulatory Elements**:
   - Consent considerations
   - Privacy implications
   - Stakeholder interests

**Word Count by Complexity**:
- BASIC: 150-250 words
- INTERMEDIATE: 250-400 words
- COMPLEX: 400-600 words

**Do NOT include**:
- The questions or answers (those come in Phase 2)
- Explicit statements of what's right or wrong
- Resolution of the dilemma

**Example Opening**:
"Dr. [Name] plans to conduct [type of research] on [subject matter] from [setting].
The purpose of this research is to [scientific goal]. [Background context].
[Historical elements]. [Complicating factors]. The original consent form stated
that the research subject agreed to '[quote consent language].'"
```

#### Step 1.2: Extract Key Elements for Q&A

From the vignette, identify:
```markdown
**Key Elements for Q&A Generation**:
- Primary ethical/clinical question
- Regulatory frameworks that apply
- Stakeholders with different perspectives
- Decision points with multiple valid paths
- Temporal considerations (if applicable)
- Scenario variations to explore
```

**Save to**: `[FOLDER]/case-document/[topic-slug]_case_vignette.md`

**Report Progress**:
```markdown
✓ Phase 1 Complete: Case Vignette
- Word count: [X] words
- Key stakeholders: [list]
- Primary ethical question: [question]
- Regulatory frameworks: [list]
- Output: [path]
- Next: Interactive Q&A Generation
```

---

### Phase 2: Interactive Q&A Generation (10-15 min)
**Agent**: `@notebooklm-clinical-expert`

#### Step 2.1: Generate Q&A Tabs

Based on complexity level, generate appropriate number of Q&A tabs:
- **BASIC**: 3-4 Q&A tabs
- **INTERMEDIATE**: 5-6 Q&A tabs
- **COMPLEX**: 7-10 Q&A tabs

**For each Q&A Tab, follow this structure**:

```markdown
## Question [N]: [Question Header]
<!-- CITI-style: Question appears as golden/olive colored expandable tab -->

**Question**: [Full question text, e.g., "Given the statement in the original
consent form, what is Dr. Jackson's obligation to re-contact the subjects for
their valid consent for a research project submitted in 2017?"]

### Answer Section
<!-- CITI-style: Answer appears as gray expandable section below question -->

**Context**: [Brief context connecting to vignette]

**IRB Considerations** (for ethics scenarios):
- How samples are identified (directly or through coded link)
- Health implications for living participants and family members
- Timing and confidentiality implications of re-contacting subjects
- Minimal risk assessment under waiver criteria

**Regulatory Analysis**:

| Regulatory Framework | Application to This Case |
|---------------------|--------------------------|
| Common Rule (pre-2018) | [Analysis] |
| Common Rule (2018 Requirements) | [Analysis] |
| HIPAA | [Analysis if applicable] |
| State Laws | [Considerations] |

**Key Points**:
- [Main teaching point 1]
- [Main teaching point 2]
- [Main teaching point 3]

**Scenario Variations** (if applicable):
- **If submitted in [Year A]**: [Analysis showing different regulatory context]
- **If submitted in [Year B]**: [Analysis showing how rules changed]
- **If [Alternative Condition]**: [How analysis would differ]

**Stakeholder Perspectives**:
| Stakeholder | Interest | Concern |
|-------------|----------|---------|
| Researcher | [Interest] | [Concern] |
| IRB | [Interest] | [Concern] |
| Participants | [Interest] | [Concern] |
| Institution | [Interest] | [Concern] |

---
<!-- Continue button to next question -->
```

#### Step 2.2: Question Types by Scenario

**For ETHICS scenarios**, include questions about:
1. Re-consent obligations
2. IRB review requirements
3. Waiver criteria applicability
4. Broad consent provisions
5. Exemption categories
6. Privacy and confidentiality
7. Risk-benefit analysis
8. Community considerations

**For WORKFLOW scenarios**, include questions about:
1. Process sequencing
2. Role responsibilities
3. Handoff communication
4. Decision criteria
5. Documentation requirements
6. Quality checkpoints
7. Error prevention
8. Technology integration

**For DIAGNOSTIC scenarios**, include questions about:
1. Differential diagnosis
2. Test selection
3. Pre-test probability
4. Result interpretation
5. Clinical reasoning
6. Diagnostic uncertainty
7. When to escalate
8. Follow-up planning

**For TREATMENT scenarios**, include questions about:
1. Treatment selection criteria
2. Risk-benefit communication
3. Shared decision-making
4. Monitoring requirements
5. Adverse event management
6. Treatment modification
7. Outcome measurement
8. Care transitions

**For INFORMATICS scenarios**, include questions about:
1. Data quality assessment
2. Interoperability challenges
3. CDS design principles
4. Alert management
5. Workflow integration
6. User experience
7. Safety considerations
8. Regulatory compliance

**For RESEARCH scenarios**, include questions about:
1. Study design selection
2. Cohort definition
3. Bias identification
4. Confounding control
5. Data source evaluation
6. Outcome specification
7. Generalizability
8. OHDSI network considerations

#### Step 2.3: Generate Learning Objectives

If not provided, auto-generate based on Q&A content:

```markdown
## Learning Objectives

After completing this case study, learners will be able to:

1. **[Cognitive Verb]** [specific knowledge] in the context of [case domain]
2. **[Cognitive Verb]** [specific skill] when faced with [scenario type]
3. **[Cognitive Verb]** [specific attitude/value] regarding [ethical principle]
4. **[Cognitive Verb]** [specific application] to [real-world situation]

**Bloom's Taxonomy Coverage**:
- Knowledge: Objectives [list]
- Comprehension: Objectives [list]
- Application: Objectives [list]
- Analysis: Objectives [list]
- Synthesis: Objectives [list]
- Evaluation: Objectives [list]
```

**Save to**: `[FOLDER]/case-document/[topic-slug]_qa_tabs.md`

**Report Progress**:
```markdown
✓ Phase 2 Complete: Interactive Q&A
- Q&A tabs generated: [count]
- Learning objectives: [count]
- Regulatory frameworks covered: [list]
- Stakeholder perspectives: [count]
- Output: [path]
- Next: Clinical Workflow Development
```

---

### Phase 3: Clinical Workflow Development (8-12 min)
**Agent**: `@notebooklm-clinical-expert`

#### Step 3.1: Identify Relevant Workflow Type

Based on scenario and vignette content:

```
IF scenario involves research ethics:
    → IRB Review Workflow
    → Research Protocol Submission Workflow
    → Consent Process Workflow

IF scenario involves clinical care:
    → Patient Care Pathway
    → Clinical Decision Workflow
    → Care Coordination Workflow

IF scenario involves informatics:
    → EHR Implementation Workflow
    → Data Flow Workflow
    → CDS Design Workflow

IF scenario involves research methodology:
    → OHDSI Study Design Workflow
    → Cohort Definition Workflow
    → Analysis Execution Workflow
```

#### Step 3.2: Generate Clinical Workflow Document

```markdown
---
title: Clinical Workflow - [Case Topic]
type: Clinical Workflow (Case Study Component)
domain: [Healthcare/Research/Informatics]
case_study: [TOPIC]
specialty: [SPECIALTY]
created: [YYYY-MM-DD]
---

# CLINICAL WORKFLOW: [Case Topic]

**Disclaimer**: This workflow is for educational purposes as part of a case
study. Always follow your institution's protocols and professional judgment.

## Workflow Overview

**Purpose**: [Primary goal of this workflow in context of case]
**Setting**: [From vignette]
**Key Decision Points**: [Number] decision points
**Stakeholders Involved**: [List from vignette]

## Stakeholder Roles

| Role | Responsibilities | Key Decisions |
|------|-----------------|---------------|
| [Role 1] | [Responsibilities] | [Decisions] |
| [Role 2] | [Responsibilities] | [Decisions] |

## Workflow Phases

### Phase 1: [Phase Name]

**Objective**: [What this phase accomplishes]
**Responsible Party**: [Role]
**Timeline**: [Duration]

#### Step 1.1: [Action]

**Purpose**: [Why this step is necessary]

**Procedure**:
1. [Specific action]
   - **Rationale**: [Evidence-based reasoning]
   - **Case Connection**: [How this relates to the vignette]

**Expected Outcome**: [What should result]

**Red Flags**:
- [Warning sign] → [Action required]

#### Decision Point 1: [Decision Name]

**Context**: [How this appears in the case]

**Decision Criteria**:
- **If [Condition A]** → [Path A]
- **If [Condition B]** → [Path B]

**Regulatory Basis**: [Guidelines or regulations]

### Phase 2: [Continue...]

## SBAR Handoff Template

For transitions between stakeholders:

| Component | Content |
|-----------|---------|
| **Situation** | [Current state] |
| **Background** | [Relevant history] |
| **Assessment** | [Analysis] |
| **Recommendation** | [Next steps] |

## Regulatory Compliance Checklist

- [ ] [Requirement 1 from case context]
- [ ] [Requirement 2 from case context]
- [ ] [Requirement 3 from case context]

## Clinical Pathway Diagram

```
[ASCII diagram of workflow]
```

## Connection to Learning Objectives

| Learning Objective | Workflow Phase | Teaching Point |
|-------------------|----------------|----------------|
| [Objective 1] | Phase [X] | [How workflow illustrates objective] |
```

**Save to**: `[FOLDER]/case-document/[topic-slug]_clinical_workflow.md`

---

### Phase 4: Visualization Generation (5-8 min)
**Agent**: `@notebooklm-mindmap-creator`

#### Step 4.1: Generate Case Concept Mind Map

```markdown
# Mind Map: [Case Topic]

## Central Concept
[Case Topic]

## Branch Structure

├── **Case Context**
│   ├── Setting: [Geographic/institutional]
│   ├── Time Period: [When]
│   └── Key Stakeholders
│       ├── [Stakeholder 1]
│       ├── [Stakeholder 2]
│       └── [Stakeholder N]
│
├── **Clinical/Research Elements**
│   ├── [Element 1]
│   ├── [Element 2]
│   └── [Element N]
│
├── **Ethical Considerations**
│   ├── [Principle 1]
│   ├── [Principle 2]
│   └── [Regulatory Framework]
│
├── **Decision Points**
│   ├── Decision 1: [Description]
│   │   ├── Option A → [Consequence]
│   │   └── Option B → [Consequence]
│   └── Decision N: [Description]
│
├── **Learning Objectives**
│   ├── [Objective 1]
│   ├── [Objective 2]
│   └── [Objective N]
│
└── **Key Takeaways**
    ├── [Takeaway 1]
    ├── [Takeaway 2]
    └── [Takeaway N]
```

#### Step 4.2: Generate Output Formats

**ASCII Format** (`*_mindmap_ascii.md`):
- Box-drawing characters for terminal-friendly viewing
- Quick reference format

**Mermaid Format** (`*_mindmap_mermaid.md`):
- `mindmap` syntax for radial view
- `flowchart` syntax for process view
- Jekyll/web compatible

**Save to**: `[FOLDER]/visualizations/`

---

### Phase 5: Teaching Materials Generation (5-10 min)
**Agent**: `@notebooklm-doc-generator`

#### Step 5.1: Generate Teaching Notes

```markdown
---
title: Teaching Notes - [Case Topic]
type: Educator Guide
case_study: [TOPIC]
specialty: [SPECIALTY]
complexity: [COMPLEXITY]
estimated_time: [TIME] minutes
---

# Teaching Notes: [Case Topic]

## Overview for Educators

**Case Purpose**: [1-2 sentences on educational goals]
**Target Audience**: Clinical informatics students, healthcare professionals, researchers
**Prerequisites**: [Required background knowledge]
**Time Required**: [Duration] minutes

## Session Preparation

### Before the Session
- [ ] Review case vignette and Q&A tabs
- [ ] Prepare to address sensitive topics
- [ ] Consider participant background

### Materials Needed
- Case vignette document
- Q&A tabs (interactive HTML or printed)
- Clinical workflow diagram
- Mind map visualization

## Facilitation Guide

### Opening (5-10 min)

**Suggested Approach**:
1. Present the vignette (read aloud or distribute)
2. Allow silent reflection (2-3 min)
3. Opening question: "[Question that sets up case tension]"

**Key Points to Establish**:
- [Contextual element]
- [Stakeholder complexity]

### Core Discussion (20-40 min)

**For Each Q&A Tab**:

**Question [N]**: [Question text]

**Facilitation Notes**:
- What good answers include: [List]
- Common misconceptions: [List]
- Follow-up probes:
  - "What makes you say that?"
  - "What additional information would help?"
  - "How would your answer change if...?"

**Key Teaching Point**: [Main takeaway]
**Connection to Learning Objective**: Objective [N]

### Closing (5-10 min)

**Synthesis Questions**:
- "What's the most important takeaway?"
- "How would you apply this in your practice?"

**Real-World Connection**: [Brief application note]

## Assessment Guidance

### During Discussion
- Listen for: [Indicators of understanding]
- Watch for: [Areas of confusion]

### Post-Session Assessment Options
1. Written reflection memo
2. Role play exercise
3. Follow-up case scenario

### Evaluation Rubric

| Criterion | Exemplary | Proficient | Developing |
|-----------|-----------|------------|------------|
| [Criterion 1] | [Description] | [Description] | [Description] |

## Common Questions

**Q: [Anticipated question]**
A: [Suggested response]

## Adaptations

### For Beginners
- Focus on [subset]
- Provide more scaffolding

### For Advanced Learners
- Add complexity with [element]
- Challenge assumptions about [aspect]
```

**Save to**: `[FOLDER]/teaching-materials/[topic-slug]_teaching_notes.md`

#### Step 5.2: Generate Learning Objectives Document

```markdown
---
title: Learning Objectives - [Case Topic]
type: Competency Alignment
case_study: [TOPIC]
---

# Learning Objectives: [Case Topic]

## Case Learning Objectives

After completing this case study, learners will be able to:

### Objective 1: [Statement]
**Bloom's Level**: [Level]
**Case Element**: [Where addressed]
**Assessment Method**: [How to assess]
**Q&A Tab**: [Which tab]

[Continue for all objectives...]

## Competency Alignment

### AMIA Clinical Informatics Competencies
| Domain | Competency | Case Alignment |
|--------|------------|----------------|
| [Domain] | [Competency] | [How addressed] |

### OHDSI Learning Objectives (if applicable)
| Topic | Objective | Case Alignment |
|-------|-----------|----------------|
| [Topic] | [Objective] | [How addressed] |

### Healthcare Ethics Frameworks (if applicable)
| Framework | Principle | Case Application |
|-----------|-----------|------------------|
| Bioethics | [Principle] | [Application] |
| Belmont Report | [Principle] | [Application] |
```

**Save to**: `[FOLDER]/teaching-materials/[topic-slug]_learning_objectives.md`

---

### Phase 6: Final Assembly (3-5 min)
**Agent**: `@notebooklm-doc-formatter`

#### Step 6.1: Generate Interactive HTML

Create CITI-style interactive HTML with:
- Collapsible Q&A tabs (golden headers, gray content)
- JavaScript for expand/collapse functionality
- "Continue" navigation buttons
- Professional styling matching CITI Program

```html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Case Study: [TOPIC]</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #e8e8e8;
            margin: 0;
            padding: 20px;
        }
        .case-container {
            max-width: 1200px;
            margin: 0 auto;
        }
        .header {
            background-color: #2c5282;
            color: white;
            padding: 20px 30px;
            font-size: 24px;
            font-weight: bold;
        }
        .vignette {
            background-color: #4a7fb5;
            color: white;
            padding: 30px;
            line-height: 1.6;
        }
        .qa-section {
            background-color: #d4d4d4;
            padding: 20px;
        }
        .question-tab {
            background-color: #b8923e;
            color: white;
            padding: 15px 20px;
            margin: 10px 0;
            cursor: pointer;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .question-tab:hover {
            background-color: #a07d35;
        }
        .answer-content {
            background-color: #c8c8c8;
            padding: 20px;
            display: none;
            line-height: 1.6;
        }
        .answer-content.active {
            display: block;
        }
        .expand-icon {
            font-size: 24px;
            font-weight: bold;
        }
        .continue-btn {
            background-color: #6b8fa8;
            color: white;
            border: none;
            padding: 10px 30px;
            cursor: pointer;
            float: right;
            margin-top: 20px;
        }
        .logo {
            float: right;
            background-color: white;
            padding: 10px;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div class="case-container">
        <div class="header">
            CASE STUDY
            <span class="logo">[SPECIALTY] Case</span>
        </div>

        <div class="vignette">
            [VIGNETTE CONTENT]
        </div>

        <div class="qa-section">
            <p>Click on the <strong>tab</strong> to learn more.</p>

            <!-- Q&A Tabs dynamically generated -->
            <div class="question-tab" onclick="toggleAnswer(1)">
                [Question 1 Text]
                <span class="expand-icon" id="icon-1">+</span>
            </div>
            <div class="answer-content" id="answer-1">
                [Answer 1 Content]
                <button class="continue-btn" onclick="toggleAnswer(1)">CONTINUE</button>
                <div style="clear:both;"></div>
            </div>

            <!-- Repeat for each Q&A tab -->
        </div>
    </div>

    <script>
        function toggleAnswer(num) {
            const answer = document.getElementById('answer-' + num);
            const icon = document.getElementById('icon-' + num);

            if (answer.classList.contains('active')) {
                answer.classList.remove('active');
                icon.textContent = '+';
            } else {
                answer.classList.add('active');
                icon.textContent = '-';
            }
        }
    </script>
</body>
</html>
```

**Save to**: `[FOLDER]/[topic-slug]_interactive.html`

#### Step 6.2: Generate Master Markdown Document

Assemble all components into comprehensive case study:

```markdown
---
title: "Clinical Case Study: [Topic]"
type: Clinical Case Study
specialty: [SPECIALTY]
scenario_type: [SCENARIO-TYPE]
complexity: [COMPLEXITY]
estimated_time: [TIME] minutes
learning_objectives_count: [N]
qa_tabs_count: [N]
created: [YYYY-MM-DD]
---

# Clinical Case Study: [Topic]

**Specialty**: [SPECIALTY]
**Scenario Type**: [SCENARIO-TYPE]
**Complexity**: [COMPLEXITY]
**Estimated Time**: [TIME] minutes

---

## Table of Contents
- [Case Vignette](#case-vignette)
- [Learning Objectives](#learning-objectives)
- [Discussion Questions](#discussion-questions)
- [Clinical Workflow](#clinical-workflow)
- [Key Takeaways](#key-takeaways)
- [Teaching Notes Summary](#teaching-notes-summary)

---

## Case Vignette

[Full vignette from Phase 1]

---

## Learning Objectives

[Learning objectives from Phase 2]

---

## Discussion Questions

### Question 1: [Question Header]

[Full Q&A content from Phase 2]

### Question 2: [Question Header]

[Continue for all questions...]

---

## Clinical Workflow

[Workflow summary from Phase 3]

---

## Key Takeaways

1. [Takeaway 1]
2. [Takeaway 2]
3. [Takeaway 3]

---

## Teaching Notes Summary

**Key Teaching Points**:
- [Point 1]
- [Point 2]

**Common Misconceptions**:
- [Misconception 1]
- [Misconception 2]

---

**Case Study Generated by Research Hub Clinical Case Study Generator**
**Version**: 1.0.0
**Generated**: [YYYY-MM-DD]
```

**Save to**: `[FOLDER]/[topic-slug]_complete_case_study.md`

#### Step 6.3: Generate README Index

```markdown
# [Topic] - Clinical Case Study Package

**Generated**: [YYYY-MM-DD]
**Specialty**: [SPECIALTY]
**Scenario Type**: [SCENARIO-TYPE]
**Complexity**: [COMPLEXITY]
**Estimated Time**: [TIME] minutes

## Quick Start

### For Learners
1. Open `[topic]_interactive.html` in a web browser
2. Read the case vignette
3. Work through each Q&A tab
4. Review the clinical workflow

### For Educators
1. Review `teaching-materials/[topic]_teaching_notes.md`
2. Familiarize yourself with the Q&A content
3. Prepare for discussion facilitation
4. Use the learning objectives for assessment

## Files

| File | Description |
|------|-------------|
| `[topic]_interactive.html` | CITI-style interactive case study |
| `[topic]_complete_case_study.md` | Full Markdown document |
| `case-document/[topic]_case_vignette.md` | Case narrative |
| `case-document/[topic]_qa_tabs.md` | Q&A content |
| `case-document/[topic]_clinical_workflow.md` | Workflow documentation |
| `teaching-materials/[topic]_teaching_notes.md` | Facilitator guide |
| `teaching-materials/[topic]_learning_objectives.md` | Competency alignment |
| `visualizations/[topic]_mindmap_ascii.md` | ASCII mind map |
| `visualizations/[topic]_mindmap_mermaid.md` | Mermaid diagram |

## Learning Objectives

1. [Objective 1]
2. [Objective 2]
3. [Objective 3]

## Regeneration

To regenerate this case study:
```bash
/notebooklm-generate-case-study "[TOPIC]" --specialty [SPECIALTY] --scenario-type [SCENARIO-TYPE] --complexity [COMPLEXITY]
```
```

**Save to**: `[FOLDER]/README.md`

---

## Final Output Report

```markdown
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Clinical Case Study Generation Complete!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

**Topic**: [Topic]
**Specialty**: [SPECIALTY]
**Scenario Type**: [SCENARIO-TYPE]
**Complexity**: [COMPLEXITY]

**Location**: [full folder path]

**Generated Artifacts**:

📁 [folder]/
├── 📄 README.md                              # Quick start guide
├── 🌐 [topic]_interactive.html               # CITI-style interactive
├── 📄 [topic]_complete_case_study.md         # Master document
├── 📁 case-document/
│   ├── 📄 [topic]_case_vignette.md           # [X] word narrative
│   ├── 📄 [topic]_qa_tabs.md                 # [N] Q&A tabs
│   └── 📄 [topic]_clinical_workflow.md       # Workflow documentation
├── 📁 teaching-materials/
│   ├── 📄 [topic]_teaching_notes.md          # Facilitation guide
│   └── 📄 [topic]_learning_objectives.md     # [N] objectives
└── 📁 visualizations/
    ├── 📄 [topic]_mindmap_ascii.md           # ASCII concept map
    └── 📄 [topic]_mindmap_mermaid.md         # Mermaid diagram

**Case Study Metrics**:
- Vignette: [word count] words
- Learning Objectives: [N]
- Q&A Tabs: [N]
- Regulatory Frameworks: [list]
- Stakeholders: [N]

**Estimated Session Time**: [TIME] minutes

**Quick Access**:
• Interactive: open [folder]/[topic]_interactive.html
• Teaching Notes: [folder]/teaching-materials/[topic]_teaching_notes.md

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

---

## Success Criteria

Case study generation complete when:
- [ ] CITI-style vignette created (appropriate word count)
- [ ] Interactive Q&A tabs generated (appropriate count)
- [ ] Regulatory analysis included in answers
- [ ] Clinical workflow documented
- [ ] Learning objectives measurable and aligned
- [ ] Teaching notes provide facilitation guidance
- [ ] Mind maps visualize case structure
- [ ] Interactive HTML matches CITI styling
- [ ] Master Markdown document assembled
- [ ] README index complete
- [ ] All files saved to correct locations
- [ ] User informed of completion

---

## Integration Notes

### Agents Used
- `@notebooklm-master` - Orchestration and setup
- `@notebooklm-clinical-expert` - Vignette, Q&A, workflow (physician-researcher voice)
- `@notebooklm-mindmap-creator` - Visual knowledge structures
- `@notebooklm-doc-generator` - Teaching materials
- `@notebooklm-doc-formatter` - Final assembly and HTML generation

### Related Commands
- `/notebooklm-explain-clinical-workflow` - Deep-dive on clinical workflows
- `/notebooklm-generate-mindmap` - Additional visualization options
- `/notebooklm-generate-quiz` - Create assessment from case content
- `/notebooklm-generate-flashcards` - Create study cards from case content
- `/notebooklm-from-topic` - Generate broader research on case topic
- `/notebooklm-summarize` - Summarize source documents for case creation

---

## Error Handling

| Error | Cause | Solution |
|-------|-------|----------|
| Specialty not recognized | Invalid option | Default to "general", suggest valid options |
| Scenario type unclear | Ambiguous topic | Default to "mixed", ask for clarification |
| Complexity mismatch | Topic too simple/complex | Suggest alternative level |
| Regulatory information outdated | Knowledge cutoff | Add disclaimer, suggest SME review |
| Vignette too short/long | Complexity miscalculation | Adjust word count guidance |

---

## Educational Disclaimer

This case study generator creates educational materials for teaching clinical
informatics concepts. Generated content should be reviewed for accuracy and
may require subject matter expert validation before use in formal educational
settings. Regulatory information reflects guidance as of the knowledge cutoff
and may require updates for current use.
