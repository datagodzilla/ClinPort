# ClinPort — Clinical Patient Portfolio Builder

<p align="center">
  <img src="https://img.shields.io/badge/version-0.1.0--alpha-blue" alt="version"/>
  <img src="https://img.shields.io/badge/license-MIT-green" alt="license"/>
  <img src="https://img.shields.io/badge/python-3.11%2B-yellow" alt="python"/>
  <img src="https://img.shields.io/badge/FHIR-R4-orange" alt="FHIR"/>
  <img src="https://img.shields.io/badge/OMOP-CDM_5.4-purple" alt="OMOP"/>
  <img src="https://img.shields.io/badge/QuantumHelix.ai-bluevoilet" alt="QuantumHelix"/>
</p>

> **Production-ready clinical AI platform** for Real-World Evidence (RWE) cohort studies.  
> Builds structured patient portfolios from FHIR R4 clinical data, maps to OMOP CDM, and powers LLM-driven insights via RAG.

---

## The Problem

Clinical researchers spend 60–80% of study time on data preparation alone. Patient data lives across EHR systems in incompatible formats, making cohort building for RWE studies expensive, slow, and error-prone.

## The Solution

ClinPort automates the full pipeline:

```
FHIR R4              OMOP CDM 📦           RAG Layer 📦          Portfolio 📦
(EHR Sources)  ==>  (Analytics)  ==>  (MedGemma+Claude) ==>  (Dashboard)

[Patient]           [Cohort SQL]          [Clinical NER]        [Streamlit]
[Condition]         [Phenotype]           [Summary]             [Power BI]
[Medication]        [Timeline]            [Q&A]                 [REST API]
[Observation]       [Annotation]          [Recommendations]
```

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────────┐
│                         ClinPort Platform                           │
├──────────────┬──────────────┬──────────────┬────────────────────────┤
│  FHIR Layer  │  OMOP Layer  │  NLP / RAG   │   Presentation Layer   │
│              │              │              │                        │
│ hapipy       │ BigQuery     │ BioBERT NER  │ Streamlit Dashboard    │
│ fhirclient   │ OMOP CDM 5.4 │ MedGemma 2B  │ Power BI Connector     │
│ SMART Auth   │ Cohort SQL   │ Claude API   │ FastAPI REST           │
│ R4 Validator │ Atlas Phenox │ ChromaDB     │ PDF Report Gen         │
└──────────────┴──────────────┴──────────────┴────────────────────────┘
          ↑                                              ↑
    [MIMIC-IV FHIR]                            [Clinician UI]
    [Synthea Patients]                         [Researcher API]
    [Epic/Cerner SMART]                        [Power BI Embed]
```

---

## Tech Stack

| Layer | Technology | Purpose |
|-------|-----------|---------|
| Data Ingestion | FHIR R4 + `hapipy` + `fhirclient` | Patient data normalization |
| Analytics DB | BigQuery + OMOP CDM 5.4 | Cohort definition & RWE queries |
| Clinical NLP | BioBERT + spaCy-Transformers | Named entity extraction |
| LLM Orchestration | MedGemma 2B + Claude API | Clinical RAG & reasoning |
| Vector Store | ChromaDB | Embedding storage & retrieval |
| Frontend | Streamlit + Power BI | Clinician dashboard |
| API | FastAPI + Pydantic v2 | REST endpoints |
| Infra | Docker + Cloud Run + GCP | Deployment |

---

## Repository Structure

```
ClinPort/
├── src/clinport/
│   ├── fhir/           # FHIR R4 client, parser, validator
│   ├── omop/           # OMOP CDM mapper, BigQuery client, cohort SQL
│   ├── nlp/            # BioBERT NER, entity linking, annotation
│   ├── llm/            # RAG pipeline, MedGemma, Claude orchestration
│   ├── api/            # FastAPI routes, schemas, middleware
│   └── utils/          # Logging, config, helpers
├── tests/
│   ├── unit/           # Module-level tests
│   ├── integration/    # FHIR + OMOP pipeline tests
│   └── e2e/            # End-to-end workflow tests
├── docs/
│   ├── architecture/   # ADRs, system design diagrams
│   ├── api/            # OpenAPI spec, endpoint docs
│   └── guides/         # Dev setup, deployment, usage guides
├── notebooks/          # EDA, prototyping, demos
├── data/
│   ├── schemas/        # OMOP DDL, FHIR profiles
│   └── fixtures/       # Synthea test patients (anonymized)
├── .github/
│   ├── workflows/      # CI/CD: test, lint, validate, deploy
│   └── ISSUE_TEMPLATE/ # Bug, feature, data pipeline templates
├── scripts/            # Setup, migration, data load utilities
├── config/             # Environment configs
├── Makefile
├── Dockerfile
├── docker-compose.yml
├── pyproject.toml
└── requirements.txt
```

---

## Milestones

| Milestone | Focus | Status |
|-----------|-------|--------|
| **M1** | Foundation: BigQuery OMOP + Cohort SQL | 🚧 In Progress |
| **M2** | FHIR R4 Ingestion + OMOP Mapping | ⏳ Planned |
| **M3** | Clinical NER + Entity Linking | ⏳ Planned |
| **M4** | RAG Pipeline (MedGemma + Claude) | ⏳ Planned |
| **M5** | Streamlit Dashboard + API | ⏳ Planned |

---

## Quick Start

```bash
# Clone
git clone https://github.com/datagodzilla/ClinPort.git
cd ClinPort

# Setup
make install-dev

# Run tests
make test

# Start dev server
make dev

# Docker
make docker-build && make docker-run
```

---

## Data Sources

- **MIMIC-IV** (PhysioNet) — ICU clinical notes, labs, medications
- **Synthea** — Synthetic patient generator for testing
- **FHIR R4 Servers** — SMART on FHIR endpoints (Epic sandbox, HAPI FHIR)

---

## Contributing

See [CONTRIBUTING.md](docs/guides/CONTRIBUTING.md) for development setup and contribution guidelines.

---

## License

MIT License — © 2026 [QuantumHelix.ai](https://quantumhelix.ai) | [@datagodzilla](https://github.com/datagodzilla)
