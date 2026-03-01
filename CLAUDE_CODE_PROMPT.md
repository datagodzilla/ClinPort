# ClinPort — Claude Code Handoff Prompt

> Copy this entire file contents and paste into Claude Code at project root as your opening instruction.

---

## 🎯 Mission

You are the AI engineering partner for **ClinPort**, a clinical AI platform for Real-World Evidence (RWE) cohort studies. The project is in active development. Your job is to continue building it milestone by milestone, following the architecture, conventions, and clinical domain rules already established.

This is a **healthcare AI** project. Patient data safety, HIPAA compliance, and clinical correctness are non-negotiable constraints — not optional quality attributes.

---

## 📁 Read These Files First (in order)

Before writing a single line of code, read these files to load full context:

```
1. PROJECT-PLAN.md                        — Full milestone specs, architecture, ADRs
2. .claude/CLAUDE.md                      — Project conventions, env vars, coding rules
3. .claude/context/clinical_domain.md     — OMOP concept IDs, clinical abbreviations
4. .claude/context/data_standards.md      — FHIR R4, OMOP CDM 5.4 field mappings
5. .claude/context/regulatory.md          — HIPAA Safe Harbor, FDA RWE, 21 CFR Part 11
6. .claude/context/tech_decisions.md      — ADRs: why BigQuery, Pinecone, Claude+MedGemma
7. .claude/workflows/milestone_checklist.md — Completion gates per milestone
```

Then read the existing source code:
```
8.  src/clinport/omop/cohort_queries.py   — Existing OMOP SQL templates (CohortQuery pattern)
9.  src/clinport/omop/bigquery_client.py  — Existing BigQuery client (OMOPBigQueryClient)
10. tests/unit/test_cohort_queries.py     — Existing unit test pattern to follow
```

---

## 📊 Current State

| Layer | Status | Files Exist |
|-------|--------|-------------|
| OMOP BigQuery client | ✅ Scaffolded | `src/clinport/omop/bigquery_client.py` |
| OMOP Cohort SQL | ✅ Scaffolded | `src/clinport/omop/cohort_queries.py` |
| OMOP Unit Tests | ✅ Scaffolded | `tests/unit/test_cohort_queries.py` |
| FHIR Ingestion | 🔲 Empty `__init__.py` only | `src/clinport/fhir/` |
| Clinical NLP | 🔲 Empty `__init__.py` only | `src/clinport/nlp/` |
| RAG Pipeline | 🔲 Empty `__init__.py` only | `src/clinport/llm/` |
| FastAPI | 🔲 Empty `__init__.py` only | `src/clinport/api/` |
| Streamlit App | 🔲 Not started | — |
| Docker / CI | 🔲 Not started | — |
| Makefile | 🔲 Not started | — |
| pyproject.toml | 🔲 Not started | — |

**All `__init__.py` files are empty stubs.** There is no installed package yet.

---

## 🏃 Milestone 1 — Complete This First (BigQuery OMOP Foundation)

**M1 is "In Progress" — complete it before touching any other milestone.**

### M1 Completion Gate (from `.claude/workflows/milestone_checklist.md`)
- [ ] `pyproject.toml` created with all dependencies and package configured
- [ ] `Makefile` with targets: `setup`, `lint`, `test`, `load-synthea`
- [ ] `src/clinport/omop/cohort_queries.py` extended with **HTN and CKD cohort queries** (T2DM + HF already exist)
- [ ] `src/clinport/omop/omop_mapper.py` — maps raw data rows to OMOP CDM Pydantic models
- [ ] `src/clinport/utils/exceptions.py` — custom exception hierarchy (`ClinPortError`, `OMOPQueryError`, `FHIRValidationError`, `PIIScrubError`)
- [ ] `src/clinport/utils/config.py` — `Settings` class using `pydantic-settings` (reads from env)
- [ ] `tests/unit/test_cohort_queries.py` — extended to cover HTN and CKD
- [ ] `tests/unit/test_omop_mapper.py` — tests for the OMOP mapper
- [ ] `tests/unit/test_config.py` — config loads correctly from env
- [ ] `tests/fixtures/` — sample OMOP-shaped patient rows (JSON) for unit tests
- [ ] `notebooks/01_omop_exploration.ipynb` — exploratory notebook showing cohort queries
- [ ] `pytest` passes all unit tests (no BigQuery connection needed for unit tests — mock it)
- [ ] `ruff check .` and `black --check .` pass (zero linting errors)

### M1 OMOP Additions Needed

**Add these cohort queries to `cohort_queries.py`** (following the existing `CohortQuery` dataclass pattern):

```
HYPERTENSION_COHORT        — ancestor_concept_id: 320128 (Essential hypertension, SNOMED)
CKD_COHORT                 — ancestor_concept_id: 4324954 (Chronic kidney disease, SNOMED)
LISINOPRIL_PATIENTS        — ancestor_concept_id: 1308216 (Lisinopril, RxNorm)
HTN_ON_LISINOPRIL_COHORT   — composite: HTN + Lisinopril within 180 days, age >= 18
```

**Add `omop_mapper.py`** with Pydantic v2 models for:
```python
class OMOPPerson(BaseModel):         # maps to OMOP person table
class OMOPCondition(BaseModel):      # maps to condition_occurrence
class OMOPDrugExposure(BaseModel):   # maps to drug_exposure
class OMOPMeasurement(BaseModel):    # maps to measurement
class OMOPVisit(BaseModel):          # maps to visit_occurrence
```

---

## 📐 Architecture Constraints

### Pipeline (DO NOT deviate from this)
```
FHIR R4 (EHR) → OMOP CDM (BigQuery) → NLP (BioBERT) → RAG (Claude+MedGemma) → Streamlit
```

### Tech Stack (locked — do not substitute)
| Purpose | Library | Why |
|---------|---------|-----|
| OMOP DB | `google-cloud-bigquery` | ADR-001 |
| Vector store | `pinecone-client` | ADR-003 (ChromaDB is prototype-only) |
| LLM | `anthropic` + MedGemma via Vertex AI | ADR-004 |
| NLP | `transformers` (BioBERT) + `spacy` + `medspacy` | ADR-005 |
| API | `fastapi` + `pydantic>=2.0` | ADR-005 |
| UI | `streamlit` | ADR-005 |
| Logging | `structlog` | CLAUDE.md |
| Retry | `tenacity` | Already in bigquery_client.py |
| Config | `pydantic-settings` | CLAUDE.md |

### Clinical Rules (never violate these)
1. **No PHI in logs** — structlog must exclude all patient identifiers except OMOP `person_id`
2. **No PHI in vector store** — `pii_scrubber.py` must run before any text touches Pinecone or Claude
3. **OMOP person_id only** — never use EHR MRNs or FHIR UUIDs as internal identifiers
4. **Concept IDs, not strings** — clinical concepts must map to OMOP `concept_id` integers
5. **Audit log on patient access** — FastAPI middleware must write audit entries for any endpoint returning patient data

---

## 🔢 Coding Conventions (from `.claude/CLAUDE.md`)

```python
# ✅ DO: Type hints, Google docstrings, Pydantic v2, async FastAPI, structlog
async def get_patient_cohort(
    person_id: int,
    db: Annotated[OMOPBigQueryClient, Depends(get_db)],
) -> CohortResult:
    """Retrieve cohort membership for a patient.

    Args:
        person_id: OMOP CDM person identifier.
        db: Injected BigQuery client.

    Returns:
        CohortResult with cohort assignments and metadata.

    Raises:
        OMOPQueryError: If BigQuery query fails after retries.
    """

# ❌ DON'T: No hardcoded IDs, no bare except, no print() for logging
person_id = 12345          # ❌ hardcoded
except Exception:          # ❌ too broad
print("Query done")        # ❌ use structlog
```

### File naming
- Snake_case for all Python files
- Pydantic models in `models.py` per module
- Exceptions in `utils/exceptions.py`
- Config in `utils/config.py`

### Test conventions
- Every new `src/` module → matching `tests/unit/test_<module>.py`
- Mock BigQuery with `pytest-mock` — unit tests must not require GCP credentials
- Use `tests/fixtures/` JSON files for sample data, not inline dicts in tests
- Coverage target: >= 80% on `src/clinport/`

---

## 🛠️ Commands Available (`.claude/commands/`)

| Command | What it does |
|---------|-------------|
| `build_cohort` | Generate parameterized OMOP cohort SQL |
| `run_pipeline` | Execute FHIR → OMOP ETL pipeline |
| `validate_fhir` | Validate FHIR R4 bundle against US Core |
| `generate_schema` | Generate Pydantic v2 models from specs |
| `test_coverage` | Run pytest with coverage reporting |

---

## 🧩 Agents Available (`.claude/agents/`)

Activate the appropriate agent for each task domain:

| Agent | Activate when working on |
|-------|--------------------------|
| `omop_agent` | BigQuery, cohort SQL, OMOP CDM tables |
| `fhir_agent` | FHIR R4 parsing, SMART auth, bundle validation |
| `nlp_agent` | BioBERT NER, entity linking, embeddings |
| `rag_agent` | Pinecone, Claude orchestration, RAG pipeline |
| `review_agent` | HIPAA compliance check, clinical correctness review |

---

## 📦 Dependency Reference (for `pyproject.toml`)

```toml
[project]
name = "clinport"
version = "0.1.0"
requires-python = ">=3.11"

dependencies = [
    "google-cloud-bigquery[pandas]>=3.11",
    "google-auth>=2.23",
    "fhirclient>=4.1",
    "anthropic>=0.25",
    "pinecone-client>=3.0",
    "transformers>=4.40",
    "spacy>=3.7",
    "medspacy>=1.0",
    "fastapi>=0.111",
    "uvicorn[standard]>=0.29",
    "pydantic>=2.7",
    "pydantic-settings>=2.2",
    "streamlit>=1.35",
    "pandas>=2.2",
    "structlog>=24.1",
    "tenacity>=8.3",
    "loguru>=0.7",
]

[project.optional-dependencies]
dev = [
    "pytest>=8.2",
    "pytest-asyncio>=0.23",
    "pytest-mock>=3.14",
    "pytest-cov>=5.0",
    "ruff>=0.4",
    "black>=24.4",
    "mypy>=1.10",
]
```

---

## 🔑 Environment Variables (never hardcode, always read from env)

```bash
# GCP / BigQuery
GOOGLE_APPLICATION_CREDENTIALS=/path/to/service-account.json
GCP_PROJECT_ID=your-gcp-project
OMOP_DATASET_ID=clinport_omop
BQ_LOCATION=US

# Anthropic
ANTHROPIC_API_KEY=sk-ant-...

# Pinecone
PINECONE_API_KEY=...
PINECONE_INDEX_NAME=clinport-notes

# FHIR
FHIR_BASE_URL=http://hapi.fhir.org/baseR4

# App
CLINPORT_ENV=development      # development | staging | production
LOG_LEVEL=INFO
```

---

## 🚦 Before Committing Any Code

Run this sequence:
```bash
ruff check . --fix        # lint + autofix
black .                   # format
mypy src/                 # type check
pytest tests/unit/ -v --cov=src/clinport --cov-report=term-missing
```

All four must pass with zero errors before any commit.

---

## 🔢 Working Order (follow this sequence)

1. **Create `pyproject.toml`** — package setup, dependencies, tool configs (ruff, black, mypy, pytest)
2. **Create `Makefile`** — developer commands: `make setup`, `make lint`, `make test`
3. **Create `src/clinport/utils/exceptions.py`** — exception hierarchy
4. **Create `src/clinport/utils/config.py`** — pydantic-settings `Settings` class
5. **Extend `src/clinport/omop/cohort_queries.py`** — add HTN, CKD, Lisinopril queries
6. **Create `src/clinport/omop/omop_mapper.py`** — Pydantic v2 OMOP models
7. **Create `tests/fixtures/`** — sample patient, condition, drug JSON files
8. **Extend `tests/unit/test_cohort_queries.py`** — cover HTN, CKD
9. **Create `tests/unit/test_omop_mapper.py`** — test OMOP models
10. **Create `tests/unit/test_config.py`** — test settings loading
11. **Run `pytest tests/unit/ -v --cov`** — confirm >= 80% coverage
12. **Run `ruff check . && black --check . && mypy src/`** — confirm zero errors
13. **Git commit** with message: `feat(M1): Complete M1 OMOP foundation layer`

Do **not** start M2 (FHIR Ingestion) until all M1 gate items are checked off in `.claude/workflows/milestone_checklist.md`.

---

## ✋ When You Are Unsure

- Clinical concept IDs → check `.claude/context/clinical_domain.md`
- FHIR → OMOP mappings → check `.claude/skills/fhir_r4_mapping.md`
- BigQuery patterns → check `.claude/skills/bigquery_sql.md`
- HIPAA rules → check `.claude/context/regulatory.md`
- Architecture decisions → check `.claude/context/tech_decisions.md`

If a question isn't answered in the `.claude/` context files, **pause and ask** rather than guessing — especially for clinical domain questions.

---

*Last updated: 2026-02-28 | Milestone: M1 In Progress | Next: M1 → M2 FHIR Ingestion*
