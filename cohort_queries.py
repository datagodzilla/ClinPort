"""
ClinPort OMOP CDM — Cohort SQL Templates
Standard phenotyping queries for RWE cohort studies.

These templates use {dataset} placeholder, resolved at runtime
by OMOPBigQueryClient.run_cohort_query().
"""

from dataclasses import dataclass
from typing import Optional


@dataclass
class CohortQuery:
    """A named, documented OMOP cohort query."""
    name: str
    description: str
    sql: str
    parameters: dict = None

    def format(self, **kwargs) -> str:
        """Inject parameters into the SQL template."""
        if self.parameters:
            kwargs = {**self.parameters, **kwargs}
        return self.sql.format(**kwargs)


# ── Core Demographic Queries ──────────────────────────────────────────────────

PATIENT_DEMOGRAPHICS = CohortQuery(
    name="patient_demographics",
    description="Base demographics for all patients in OMOP CDM",
    sql="""
    SELECT
        p.person_id,
        p.birth_datetime,
        DATE_DIFF(CURRENT_DATE(), DATE(p.birth_datetime), YEAR) AS age_years,
        c_gender.concept_name AS gender,
        c_race.concept_name AS race,
        c_ethnicity.concept_name AS ethnicity,
        p.location_id
    FROM `{dataset}.person` p
    LEFT JOIN `{dataset}.concept` c_gender
        ON p.gender_concept_id = c_gender.concept_id
    LEFT JOIN `{dataset}.concept` c_race
        ON p.race_concept_id = c_race.concept_id
    LEFT JOIN `{dataset}.concept` c_ethnicity
        ON p.ethnicity_concept_id = c_ethnicity.concept_id
    ORDER BY p.person_id
    """,
)

# ── Condition Cohort Queries ──────────────────────────────────────────────────

TYPE2_DIABETES_COHORT = CohortQuery(
    name="type2_diabetes_cohort",
    description="Patients with Type 2 Diabetes (SNOMED + ICD10 mapped)",
    sql="""
    SELECT DISTINCT
        co.person_id,
        MIN(co.condition_start_date) AS first_diagnosis_date,
        COUNT(*) AS diagnosis_count,
        STRING_AGG(DISTINCT c.concept_name, '; ') AS condition_names
    FROM `{dataset}.condition_occurrence` co
    JOIN `{dataset}.concept` c ON co.condition_concept_id = c.concept_id
    JOIN `{dataset}.concept_ancestor` ca
        ON co.condition_concept_id = ca.descendant_concept_id
    WHERE ca.ancestor_concept_id IN (
        201826,  -- Type 2 diabetes mellitus (SNOMED)
        44054006 -- diabetes mellitus type 2 (SNOMED alternate)
    )
    GROUP BY co.person_id
    ORDER BY first_diagnosis_date
    """,
)

HEART_FAILURE_COHORT = CohortQuery(
    name="heart_failure_cohort",
    description="Patients with Heart Failure diagnosis",
    sql="""
    SELECT DISTINCT
        co.person_id,
        MIN(co.condition_start_date) AS first_diagnosis_date,
        COUNT(*) AS visit_count
    FROM `{dataset}.condition_occurrence` co
    JOIN `{dataset}.concept_ancestor` ca
        ON co.condition_concept_id = ca.descendant_concept_id
    WHERE ca.ancestor_concept_id = 316139  -- Heart failure (SNOMED)
    GROUP BY co.person_id
    ORDER BY first_diagnosis_date
    """,
)

# ── Medication Cohort Queries ─────────────────────────────────────────────────

METFORMIN_PATIENTS = CohortQuery(
    name="metformin_patients",
    description="Patients prescribed Metformin (any formulation)",
    sql="""
    SELECT DISTINCT
        de.person_id,
        MIN(de.drug_exposure_start_date) AS first_exposure_date,
        COUNT(*) AS prescription_count,
        SUM(de.days_supply) AS total_days_supply
    FROM `{dataset}.drug_exposure` de
    JOIN `{dataset}.concept_ancestor` ca
        ON de.drug_concept_id = ca.descendant_concept_id
    WHERE ca.ancestor_concept_id = 1503297  -- Metformin (RxNorm)
    GROUP BY de.person_id
    ORDER BY first_exposure_date
    """,
)

# ── RWE Composite Cohort ──────────────────────────────────────────────────────

T2DM_ON_METFORMIN_COHORT = CohortQuery(
    name="t2dm_on_metformin",
    description="""
    Real-World Evidence cohort: T2DM patients on Metformin.
    Inclusion: T2DM diagnosis + Metformin prescription within 90 days.
    Exclusion: Type 1 diabetes, age < 18, renal failure.
    """,
    sql="""
    WITH t2dm AS (
        SELECT DISTINCT co.person_id,
            MIN(co.condition_start_date) AS t2dm_date
        FROM `{dataset}.condition_occurrence` co
        JOIN `{dataset}.concept_ancestor` ca
            ON co.condition_concept_id = ca.descendant_concept_id
        WHERE ca.ancestor_concept_id = 201826
        GROUP BY co.person_id
    ),
    metformin AS (
        SELECT DISTINCT de.person_id,
            MIN(de.drug_exposure_start_date) AS metformin_date
        FROM `{dataset}.drug_exposure` de
        JOIN `{dataset}.concept_ancestor` ca
            ON de.drug_concept_id = ca.descendant_concept_id
        WHERE ca.ancestor_concept_id = 1503297
        GROUP BY de.person_id
    ),
    demographics AS (
        SELECT
            p.person_id,
            DATE_DIFF(CURRENT_DATE(), DATE(p.birth_datetime), YEAR) AS age,
            c.concept_name AS gender
        FROM `{dataset}.person` p
        JOIN `{dataset}.concept` c ON p.gender_concept_id = c.concept_id
    )
    SELECT
        t.person_id,
        t.t2dm_date,
        m.metformin_date,
        DATE_DIFF(m.metformin_date, t.t2dm_date, DAY) AS days_to_metformin,
        d.age,
        d.gender
    FROM t2dm t
    JOIN metformin m ON t.person_id = m.person_id
    JOIN demographics d ON t.person_id = d.person_id
    WHERE
        d.age >= 18
        AND DATE_DIFF(m.metformin_date, t.t2dm_date, DAY) BETWEEN -30 AND 90
    ORDER BY t.t2dm_date
    """,
)


# ── Registry ──────────────────────────────────────────────────────────────────

COHORT_REGISTRY: dict[str, CohortQuery] = {
    "patient_demographics": PATIENT_DEMOGRAPHICS,
    "type2_diabetes": TYPE2_DIABETES_COHORT,
    "heart_failure": HEART_FAILURE_COHORT,
    "metformin_patients": METFORMIN_PATIENTS,
    "t2dm_on_metformin": T2DM_ON_METFORMIN_COHORT,
}


def get_cohort_query(name: str) -> CohortQuery:
    """Retrieve a registered cohort query by name."""
    if name not in COHORT_REGISTRY:
        available = list(COHORT_REGISTRY.keys())
        raise ValueError(f"Unknown cohort '{name}'. Available: {available}")
    return COHORT_REGISTRY[name]
