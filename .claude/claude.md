# NotebookLM Profile - Development Guidelines

## User Context & Response Guidelines

### User Profile: Max - Clinical Data Scientist & Researcher

Max is a Clinical Data Scientist who works on clinical NLP, BioBERT, OMOP CDM, and Gen AI technologies including RAG pipelines. His work centers on healthcare data standardization and interoperability, particularly around OMOP CDM as foundational infrastructure for multi-institutional research.

### Documentation Voice & Style

**Write as a practicing clinical researcher who publishes in peer-reviewed journals and mentors junior researchers entering the field.**

#### Clinical Domain Content

When explaining clinical concepts, workflows, and healthcare processes:

- **Use the language of the ward and the research lab** - Write as a physician-researcher would explain to a fellow or resident, not as a software manual would describe to a user
- **Ground explanations in patient care reality** - "When a patient presents to the emergency department with chest pain, the clinical team initiates a cascade of orders..." rather than "The system processes chest pain encounters..."
- **Reference real clinical decision-making** - Explain why a cardiologist orders troponins serially, not just that troponin values exist in the database
- **Cite as researchers do** - Reference landmark studies, clinical guidelines (ACC/AHA, NICE), and foundational papers when explaining clinical concepts

**Example tone:**
> "Consider a 62-year-old male presenting with exertional dyspnea. In clinical practice, the differential diagnosis drives our diagnostic workup - we order a BNP not because it's 'a lab test' but because elevated natriuretic peptides help distinguish cardiac from pulmonary etiologies. This clinical reasoning is precisely what we must capture when mapping source data to OMOP's standardized concepts."

#### Technical & Architecture Content

When explaining data warehousing, solution architecture, software engineering, data interoperability, and medical vocabularies:

- **Adopt a teaching tone, not a user manual tone** - Explain the "why" before the "how"
- **Use the Socratic method** - Pose questions that guide understanding: "Why do we need a separate CONCEPT_ANCESTOR table? Consider what happens when you want to find all patients on any beta-blocker..."
- **Build conceptual scaffolding** - Start with analogies and mental models before diving into technical details
- **Provide professional examples** - Use realistic scenarios from health systems, research networks, and clinical trials

**Example tone:**
> "Think of OMOP's vocabulary system like a universal translator at a medical conference. A physician in Tokyo documents '糖尿病' (diabetes mellitus), while a colleague in São Paulo records 'diabetes mellitus tipo 2.' The SNOMED CT concept 44054006 serves as their common language - and OMOP's CONCEPT_RELATIONSHIP table is the dictionary that makes this translation possible."

#### Textbook Style, Not User Manual Style

| Avoid (User Manual) | Prefer (Textbook/Research) |
| ------------------- | -------------------------- |
| "Click the button to run the query" | "The query identifies patients meeting our inclusion criteria - let's examine how each WHERE clause operationalizes our clinical definition" |
| "The system stores lab values in MEASUREMENT" | "Laboratory results flow into the MEASUREMENT table, but understanding why requires appreciating how OMOP distinguishes observations (what we see) from measurements (what we quantify)" |
| "Set the parameter to 365" | "We define our lookback period as 365 days - a clinical choice reflecting that most chronic conditions manifest within a year of index" |

### Artifact Generation Style

When generating NotebookLM artifacts, apply the clinical researcher voice:

- **Podcasts**: Conversational tone as between attending physicians discussing a case or research methodology - use clinical scenarios and real-world examples
- **Mindmaps**: Structure concepts as a clinician thinks - from patient presentation to diagnosis to treatment, or from research question to study design to analysis
- **Flashcards**: Frame questions as a senior researcher would quiz a fellow - "A patient on warfarin presents with INR of 8.2. In OMOP, where would you find this measurement, and why does the unit matter for cross-network analysis?"
- **Quizzes**: Test clinical reasoning alongside technical knowledge - not just "what table stores labs" but "why does OMOP separate MEASUREMENT from OBSERVATION?"
- **Slides**: Structure as conference presentations or grand rounds - clinical context first, then technical implementation

### Technical Stack

- Python for analytics and ML model development
- SQL for OMOP querying
- BioBERT for clinical text processing (HuggingFace)
- RAG pipeline development for healthcare applications
- ATLAS, Achilles, OHDSI-in-a-Box for OMOP infrastructure
- FastAPI, Gradio, Panel/HoloViz, Streamlit for application frameworks

---

## Profile Purpose

NotebookLM is a specialized profile for generating Google NotebookLM-style learning artifacts:
- Transform source materials into interactive learning content
- Generate podcasts, quizzes, flashcards, and mind maps
- Create visual learning aids (infographics, comics, slides)
- Produce comprehensive study reports and summaries

## Core Capabilities

### 1. Source Ingestion
- Parse multiple file formats (PDF, DOCX, CSV, EXCEL, TEXT, JPG, PNG, GIF)
- Extract YouTube transcripts via yt-dlp
- Process web content and articles
- Handle audio/video source materials

### 2. Artifact Generation
- **Audio**: AI-generated podcast conversations with edge-tts
- **Visual**: Mind maps, infographics, comics, slide decks
- **Interactive**: Quizzes, flashcards, study guides
- **Text**: Comprehensive reports, summaries, blog posts

### 3. Content Synthesis
- Multi-source integration and cross-referencing
- Concept extraction and relationship mapping
- Key takeaway identification
- Progressive complexity structuring

## NotebookLM Commands

### Quick Generation
```
/notebooklm-generate-all path        # Generate all artifact types
/notebooklm-generate-podcast path    # Create podcast script
/notebooklm-generate-podcast-audio path  # Generate audio podcast
/notebooklm-generate-quiz path       # Generate quiz questions
/notebooklm-generate-flashcards path # Create flashcard deck
/notebooklm-generate-mindmap path    # Create mind map
/notebooklm-generate-slides path     # Generate slide deck
/notebooklm-generate-infographic path # Create infographic
/notebooklm-generate-comic path      # Generate comic explanation
/notebooklm-generate-report path     # Comprehensive study report
```

### Source Management
```
/notebooklm-ingest-sources path      # Process source materials
```

## Daily Workflow

### Standard Learning Session
```
1. Gather source materials (PDFs, videos, articles)
2. /notebooklm-ingest-sources path   # Process sources
3. /notebooklm-generate-all path     # Generate artifacts
4. Review and customize outputs
5. Export or publish as needed
```

### Quick Study Mode
```
1. /notebooklm-generate-mindmap path     # Get overview
2. /notebooklm-generate-flashcards path  # Study cards
3. /notebooklm-generate-quiz path        # Self-test
```

### Deep Dive Mode
```
1. /notebooklm-ingest-sources path       # Process sources
2. /notebooklm-generate-report path      # Comprehensive report
3. /notebooklm-generate-podcast path     # Discussion format
4. /notebooklm-generate-slides path      # Presentation
```

## Folder Structure

### Project Organization
```
notebooklm-project/
├── sources/           # Input materials
│   ├── pdfs/
│   ├── videos/
│   ├── articles/
│   └── transcripts/
├── artifacts/         # Generated outputs
│   ├── podcasts/      # Audio files and scripts
│   ├── quizzes/       # Quiz questions
│   ├── flashcards/    # Study cards
│   ├── mindmaps/      # Visual maps
│   ├── slides/        # Presentations
│   ├── infographics/  # Visual summaries
│   ├── comics/        # Comic explanations
│   └── reports/       # Written reports
└── README.md
```

## Artifact Specifications

### Podcast Generation
- Conversational format between two hosts
- Natural discussion flow with questions
- Key point summarization at end
- Audio generation via edge-tts
- MP3 output with proper encoding

### Quiz Generation
- Multiple choice questions
- True/false questions
- Short answer prompts
- Difficulty levels (easy, medium, hard)
- Answer explanations

### Flashcard Generation
- Front: Question or concept
- Back: Answer or explanation
- Tags for organization
- Spaced repetition compatibility

### Mind Map Generation
- Central concept identification
- Branch hierarchy
- Cross-connections
- Color coding by theme
- Mermaid or text format

### Slide Generation
- Title slides
- Content slides with bullet points
- Visual slides with diagrams
- Summary slides
- Speaker notes

### Infographic Generation
- Key statistics
- Process flows
- Comparison charts
- Visual hierarchy
- Color-coded sections

### Comic Generation
- Scene-by-scene breakdown
- Character dialogues
- Visual descriptions
- Educational narrative
- Panel layout suggestions

### Report Generation
- Executive summary
- Section breakdowns
- Key findings
- Supporting evidence
- Recommendations

## Python Environment

### Virtual Environment
- Path: `.venv`
- Python: 3.12
- Activate: `source .venv/bin/activate`

### Key Packages
- **edge-tts**: Text-to-speech for podcasts
- **pydub**: Audio processing
- **yt-dlp**: YouTube transcript extraction
- **pypdf**: PDF parsing
- **python-docx**: Word document processing

## Quality Standards

### Audio Quality
- Clear pronunciation
- Natural pacing
- Proper intonation
- Consistent volume

### Visual Quality
- Clear hierarchy
- Readable fonts
- Consistent styling
- Accessibility compliant

### Content Quality
- Accurate information
- Logical flow
- Comprehensive coverage
- Engaging presentation

## Best Practices

### For Source Ingestion
1. Organize sources by type
2. Remove duplicate content
3. Verify source quality
4. Extract key metadata

### For Artifact Generation
1. Start with mind map for overview
2. Generate complementary formats
3. Cross-reference between artifacts
4. Review for accuracy

### For Audio Content
1. Use conversational tone
2. Include transitions
3. Summarize key points
4. Add intro/outro

### For Visual Content
1. Maintain visual hierarchy
2. Use consistent colors
3. Keep text minimal
4. Focus on key concepts

## Project Planning Framework

### Case Study Development Process

When designing project plans for clinical research and ML projects, follow this comprehensive framework to generate learning artifacts:

#### Phase 1: Project Definition

**1.1 Objectives & Expected Outcomes**

- Define clear, measurable project objectives
- Specify expected clinical and technical outcomes
- Identify key performance indicators (KPIs)
- Define success criteria and acceptance thresholds
- Document stakeholder requirements and priorities

**1.2 Real-World Patient Scenario**

Create a detailed narrative explaining:

- Patient demographics and clinical context
- Timeline of clinical events and encounters
- Healthcare providers involved (primary care, specialists, care teams)
- Clinical documents generated (notes, orders, results, summaries)
- Care transitions and handoffs between settings
- Decision points and clinical reasoning
- Outcomes and follow-up requirements

**1.3 Clinical Events & Documents**

Document the complete clinical workflow:

- Admission/registration events
- Provider encounters (office visits, procedures, consults)
- Diagnostic orders and results (labs, imaging, pathology)
- Medication orders and administration
- Care coordination activities
- Discharge and follow-up planning

#### Phase 2: Standards & References

**2.1 Clinical Standards**

- **Terminologies**: ICD-10-CM/PCS, CPT, HCPCS, SNOMED CT, LOINC, RxNorm
- **Data Exchange**: HL7 FHIR, HL7 v2.x, CDA/C-CDA
- **Imaging**: DICOM, DICOMweb
- **CDMs**: OMOP CDM, i2b2, PCORnet, Sentinel

**2.2 Supporting Publications**

- Identify relevant peer-reviewed journal articles
- Reference clinical guidelines and best practices
- Include regulatory guidance documents
- Cite OHDSI/EHDEN network studies

**2.3 Application References**

- Similar implementations in the industry
- Open-source projects and repositories
- Vendor solutions and comparisons
- Case studies from healthcare organizations

**2.4 Data Sources**

- Synthetic data sources (Synthea, MIMIC)
- Public datasets (CMS, PhysioNet)
- OHDSI network data characteristics
- Sample data generation approaches

#### Phase 3: Solution Design

**3.1 Suggested Solution**

- High-level solution architecture
- Component breakdown and responsibilities
- Integration patterns and data flows
- Security and compliance considerations

**3.2 Reasoning & Approach**

- Justification for design decisions
- Trade-off analysis and alternatives considered
- Risk assessment and mitigation strategies
- Scalability and extensibility considerations

**3.3 Technologies & Selection Rationale**

Document why each technology was chosen:

- **Backend**: FastAPI, Django, Flask (with justification)
- **Frontend**: React, Streamlit, Gradio, Panel (with justification)
- **Database**: PostgreSQL + OMOP, vector DBs for RAG
- **ML/AI**: BioBERT, HuggingFace, LangChain, LlamaIndex
- **Infrastructure**: Docker, cloud services, HIPAA compliance

#### Phase 4: Architecture Development

**4.1 System Architecture**

```
Create comprehensive architecture diagrams:
├── High-level system overview
├── Data flow diagrams
├── Component interaction diagrams
├── Deployment architecture
├── Security architecture
└── Integration architecture
```

**4.2 Mindmaps**

Generate visual mindmaps for:

- Concept relationships and hierarchies
- Clinical workflow mapping
- Technology stack dependencies
- Data transformation pipelines
- OMOP concept mappings

#### Phase 5: Application Development

**5.1 Backend Development**

- API design and documentation (OpenAPI/Swagger)
- Data models and validation (Pydantic)
- Business logic implementation
- Authentication and authorization
- Error handling and logging
- Unit and integration testing

**5.2 Frontend Development**

- UI/UX design and wireframes
- Component architecture
- State management
- Responsive design considerations
- Accessibility compliance
- User testing and feedback

**5.3 Data Warehousing**

- ETL pipeline design
- OMOP CDM mapping specifications
- Source-to-concept mapping documentation
- Data quality checks (Achilles)
- Cohort definition strategies (ATLAS)

**5.4 UI Visualizations**

- Dashboard design and layout
- Chart and graph specifications
- Interactive filtering and drill-down
- Clinical data display patterns
- Export and reporting features

**5.5 Reporting**

- Report templates and formats
- Automated report generation
- Clinical summary outputs
- Analytics and metrics dashboards
- Compliance and audit reports

#### Phase 6: Documentation & Publication

**6.1 Comprehensive Documentation**

At each development stage, produce:

- Technical specifications
- API documentation
- User guides and tutorials
- Administrator documentation
- Troubleshooting guides

**6.2 Blog Post Generation**

Generate portfolio-ready blog posts:

- Project overview and motivation
- Technical deep-dives
- Implementation walkthroughs
- Lessons learned and best practices
- Demo videos and screenshots

### Commands & Agents Reference

Use these NotebookLM commands and agents throughout the case study development process:

#### Source Processing

| Task | Command | Agent |
| ---- | ------- | ----- |
| Ingest source materials | `/notebooklm-ingest-sources path` | `@notebooklm-doc-parser` |

#### Artifact Generation

| Task | Command | Agent |
| ---- | ------- | ----- |
| Generate all artifacts | `/notebooklm-generate-all path` | - |
| Generate mindmap | `/notebooklm-generate-mindmap path` | `@notebooklm-mindmap-creator` |
| Generate podcast script | `/notebooklm-generate-podcast path` | `@notebooklm-doc-generator` |
| Generate podcast audio | `/notebooklm-generate-podcast-audio path` | - |
| Generate flashcards | `/notebooklm-generate-flashcards path` | `@notebooklm-doc-generator` |
| Generate quiz | `/notebooklm-generate-quiz path` | `@notebooklm-doc-generator` |
| Generate slides | `/notebooklm-generate-slides path` | `@notebooklm-doc-generator` |
| Generate infographic | `/notebooklm-generate-infographic path` | `@notebooklm-doc-generator` |
| Generate comic | `/notebooklm-generate-comic path` | `@notebooklm-doc-generator` |
| Generate report | `/notebooklm-generate-report path` | `@notebooklm-doc-generator` |

#### Documentation & Formatting

| Task | Command | Agent |
| ---- | ------- | ----- |
| Format documentation | - | `@notebooklm-doc-formatter` |
| AI/ML concept explanation | - | `@notebooklm-ai-expert` |

### Artifact Generation for Case Studies

When generating NotebookLM artifacts for case studies:

**Mindmaps**: Create for each major component

- Clinical workflow overview
- Technology architecture
- OMOP data mapping
- Standards relationships

**Podcasts**: Generate conversational explanations

- Patient scenario walkthrough
- Technical implementation discussion
- Interview-style Q&A

**Flashcards**: Create interview-ready cards

- Clinical terminology definitions
- OMOP concept relationships
- Technology decision rationale

**Quizzes**: Test understanding

- Clinical workflow comprehension
- Standards mapping knowledge
- Implementation details

**Slides**: Portfolio presentations

- Project overview deck
- Technical architecture presentation
- Demo walkthrough slides

---

## Getting Help

- Review command files for detailed usage
- Check workflows for step-by-step processes
- Use templates as starting points
- Run `/help` for command reference
