# ClinPort — Project Overview

## 🎯 Objective

Build a **production-grade clinical AI platform** that automates the full data pipeline for **Real-World Evidence (RWE) cohort studies** — from raw EHR data all the way to AI-powered researcher insights — with HIPAA compliance built in from the ground up.

The one-sentence mission: *Enable clinical researchers to ask complex questions about patient cohorts in minutes, not months.*

---

## 🔥 Background — The Problem We're Solving

Clinical research is broken at the data layer. Before a researcher can answer a single scientific question, they face:

**60–80% of study time is spent on data preparation alone.** Specifically:

- Patient records are fragmented across Epic, Cerner, Meditech, and dozens of lab systems — all in different formats
- Clinical coding systems (ICD-10, SNOMED, RxNorm, LOINC) coexist with no universal bridge
- Every new study requires teams to hand-write ad-hoc SQL per EHR, per institution — no reuse
- ~70% of clinical knowledge lives in free-text notes (discharge summaries, progress notes) that structured queries cannot reach
- Every pipeline must implement its own PHI scrubbing, audit logging, and de-identification — from scratch
- Researchers cannot ask natural language questions of their own cohort data

The result: a brilliant cardiologist who wants to study "HTN patients on Lisinopril who developed CKD within 2 years" has to wait 6–12 months for a data team to build that cohort, clean it, and deliver it.

---

## 💡 Why Now — Three Converging Forces

Three things make this the right moment to build ClinPort:

**1. FHIR R4 is now universal.** CMS and ONC mandates (2021 onward) require major EHRs to expose FHIR R4 APIs. Epic, Cerner, and others all have SMART on FHIR endpoints. The universal ingestion layer now *exists*.

**2. OMOP CDM is the proven standard.** The OHDSI community has deployed OMOP across thousands of hospitals globally — including NIH's *All of Us* (1M+ patients) and MIMIC-OMOP. A federated, standardized analytics layer now *exists*.

**3. Clinical LLMs are ready.** MedGemma (Google, fine-tuned on clinical data), Med-PaLM, and Claude make medically-grounded AI Q&A on structured + unstructured clinical data now *viable*.

ClinPort is the engineering layer that connects all three.

---

## 🏗️ What We Are Building

ClinPort is a **four-layer pipeline** where each layer feeds the next:

```
EHR (FHIR R4)  →  OMOP CDM (BigQuery)  →  Clinical NLP (BioBERT)  →  RAG (Claude + MedGemma)  →  Dashboard (Streamlit)
```

| Layer | Purpose | Key Technology |
|---|---|---|
| **FHIR Ingestion** | Connect to EHRs, fetch patient data, validate R4 compliance | fhirclient, SMART Auth, hapipy |
| **OMOP CDM** | Standardize into a common data model, run phenotyping cohort SQL | BigQuery, OMOP CDM 5.4 |
| **Clinical NLP** | Extract knowledge from free-text clinical notes | BioBERT, spaCy, medspaCy, Pinecone |
| **RAG + LLM** | Answer researcher questions with cited, grounded responses | Claude API, MedGemma 2B, Pinecone |
| **Presentation** | Dashboard, REST API, PDF export, Power BI | Streamlit, FastAPI, Docker, Cloud Run |

The key architectural insight: **OMOP CDM is the hub.** Everything ingested becomes OMOP. Everything queried comes from OMOP. This means the same cohort SQL works whether the source was Epic, MIMIC-IV, or Synthea — that's the entire point.

---

## 🗺️ Milestones — How We Get There

Each milestone has **explicit completion gates** — M2 does not start until every M1 gate is checked. This is non-negotiable to prevent foundation rot.

### M1 — BigQuery OMOP Foundation 🚧 *Current*

**Goal:** A working, tested OMOP CDM in BigQuery with cohort SQL templates and a clean Python package.

What's already built: BigQuery client with retry logic, cohort SQL for T2DM + Heart Failure + Metformin, unit test scaffold.

What M1 still needs to deliver:
- `pyproject.toml` + `Makefile` (installable package, developer commands)
- `utils/exceptions.py` + `utils/config.py` (pydantic-settings, error hierarchy)
- HTN cohort (SNOMED 320128) + CKD cohort (SNOMED 4324954) + HTN+Lisinopril composite
- `omop_mapper.py` — Pydantic v2 models for all 5 OMOP tables (person, condition, drug, measurement, visit)
- Test fixtures + unit tests reaching ≥80% coverage
- ruff + black + mypy all clean

**Gate:** `pytest` passes, linting is clean, 1,000 Synthea patients loadable into BigQuery.

---

### M2 — FHIR R4 Ingestion ⏳

**Goal:** Take a raw FHIR bundle from any R4 endpoint and land it correctly into OMOP.

Key deliverables: FHIR client + bundle parser, FHIR→OMOP mapper, **PII scrubber** (removes all 18 HIPAA Safe Harbor identifiers), SMART OAuth2 flow, integration tests.

**Gate:** Pipeline failure rate <2% on Synthea data. Unit test validates all 18 PHI identifiers are removed.

---

### M3 — Clinical NLP ⏳

**Goal:** Unlock the 70% of clinical knowledge locked in free-text notes.

Key deliverables: BioBERT NER pipeline (DISEASE, DRUG, PROCEDURE, LAB_VALUE entities), NegEx negation detection ("no chest pain" → negated), SNOMED entity linker, Pinecone vector index of note embeddings.

**Gate:** NER F1 ≥0.82 on i2b2 2010 test set. Pinecone `clinport-notes` index populated.

---

### M4 — RAG Pipeline ⏳

**Goal:** Let researchers ask natural language questions and get grounded, cited answers.

Key deliverables: Claude tool-use orchestration (calls `get_patient_omop_data()` as a tool), Pinecone retriever scoped by `person_id` metadata, MedGemma 2B on Vertex AI, hallucination guard (every claim must be cited), RAGAS evaluation.

**Gate:** RAGAS faithfulness ≥0.85. API returns `{answer, citations[], confidence}`.

---

### M5 — Dashboard + API ⏳

**Goal:** Make everything accessible to clinicians, researchers, and downstream systems.

Key deliverables: Streamlit 6-page dashboard (Cohort Browser, Patient Timeline, AI Q&A, Lab Trends, Medications, Export), FastAPI REST endpoints, Docker Compose, GCP Cloud Run deployment, Power BI connector.

**Gate:** API P95 latency <500ms. All services start with `make docker-run`. Cloud Run deploy succeeds.

---

## 🔒 Non-Negotiable Constraints (Clinical Safety)

These are architectural rules, not guidelines:

- **No PHI in logs** — structlog excludes all patient identifiers except OMOP `person_id`
- **No PHI in vector store** — `pii_scrubber.py` runs before any text touches Pinecone or Claude
- **OMOP `person_id` only** — EHR MRNs never travel past the ingestion boundary
- **Concept IDs, not strings** — clinical concepts are always OMOP integer `concept_id`, never raw ICD/SNOMED text
- **Audit log on every patient access** — FastAPI middleware, required by HIPAA Security Rule
- **Synthea only in dev** — zero real PHI in development; MIMIC-IV only under PhysioNet data use agreement

---

## 📍 Where We Are Right Now

The scaffolding and planning infrastructure is complete and committed to GitHub. The `.claude/` directory contains 22 context files — agents, commands, skills, ADRs, clinical domain knowledge, and milestone checklists — so Claude Code picks up full context on every session.

**M1 is ~40% complete.** The BigQuery client and core cohort SQL exist and test. The remaining M1 work (package setup, HTN/CKD cohorts, OMOP mapper, test coverage) is what the next Claude Code session executes using `CLAUDE_CODE_PROMPT.md` as the handoff document.

---

## 🔬 Points for Your Review

Before we proceed to M1 completion, here are the things worth thinking through:

1. **OMOP concept IDs** — the clinical domain file uses slightly different concept IDs for HTN (316866 vs 320128 in the handoff prompt). Worth verifying the correct SNOMED ancestor before writing the SQL.
2. **Synthea data loading** — have you set up a GCP project and BigQuery dataset yet? M1's gate requires loading 1,000 patients.
3. **MedGemma availability** — at the time of the ADR, MedGemma was a planned Vertex AI deployment. Worth confirming current availability and API contract before M4 planning.
4. **MIMIC-IV access** — PhysioNet credentialing is a 2–4 week process. If you need real clinical NLP benchmarking for M3, the MIMIC application should start now.
5. **Power BI vs Streamlit priority** — both are planned for M5. Given your toolset, should Power BI be primary with Streamlit as the rapid-prototype companion, or vice versa?

---

## 📚 Glossary

| Term | Definition |
|---|---|
| **OMOP CDM** | Observational Medical Outcomes Partnership Common Data Model — international standard for harmonizing clinical observational data |
| **FHIR R4** | Fast Healthcare Interoperability Resources Release 4 — HL7 standard for exchanging healthcare information electronically |
| **RWE** | Real-World Evidence — clinical evidence derived from real-world data sources outside of controlled clinical trials |
| **Phenotyping** | Algorithmically defining a clinical condition from structured EHR data (e.g., "T2DM phenotype = 2+ diagnosis codes + HbA1c > 6.5") |
| **BioBERT** | Biomedical language representation model based on BERT, pre-trained on PubMed and clinical notes |
| **NER** | Named Entity Recognition — NLP task of identifying clinical entities (diseases, drugs, labs) in free text |
| **RAG** | Retrieval-Augmented Generation — LLM pattern that grounds responses in retrieved documents/data rather than parametric memory |
| **SMART Auth** | SMART on FHIR — OAuth2-based authorization framework for accessing FHIR APIs |
| **PHI** | Protected Health Information — 18 categories of patient identifiers protected under HIPAA |
| **RAGAS** | RAG Assessment — automated evaluation framework measuring faithfulness, relevancy, and context precision of RAG responses |
| **MedGemma** | Google's medical-domain fine-tuned Gemma model, deployed via Vertex AI, optimized for clinical text understanding |
| **LOINC** | Logical Observation Identifiers Names and Codes — universal standard for laboratory and clinical observations |
| **RxNorm** | Clinical drug vocabulary that provides normalized names for clinical drugs |
| **NegEx** | Negation detection algorithm — identifies negated clinical entities in text (e.g., "no fever" → negated) |

---

*ClinPort — Clinical AI Platform for Real-World Evidence*  
*github.com/datagodzilla/ClinPort | QuantumHelix.ai | March 2026*  
*Version 1.0 — M1 In Progress*
