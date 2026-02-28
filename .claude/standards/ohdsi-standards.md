# OHDSI Standards

## Overview
Standards for OHDSI (Observational Health Data Sciences and Informatics) research, analysis, and development within the research-hub profile.

## OMOP CDM Standards

### Version Compliance
- Target: OMOP CDM v5.4 (current)
- Support: v5.3 for legacy databases
- Reference: [OMOP CDM Documentation](https://ohdsi.github.io/CommonDataModel/)

### Table Naming Conventions
```
- Use exact OMOP table names (UPPER_SNAKE_CASE in docs, case-insensitive in practice)
- Prefix custom tables with 'x_' or 'cohort_'
- Never modify core CDM tables directly
```

### Concept ID Standards
- Always use standard concepts for analysis
- Map source concepts to standard via CONCEPT_RELATIONSHIP
- Document concept sets with names and IDs
- Version control concept set definitions

## Vocabulary Standards

### Primary Vocabularies by Domain

| Domain | Primary Vocabulary | Concept Class |
|--------|-------------------|---------------|
| Condition | SNOMED-CT | Clinical Finding |
| Drug | RxNorm | Ingredient, Clinical Drug |
| Procedure | SNOMED-CT, CPT4 | Procedure |
| Measurement | LOINC | Lab Test, Clinical Observation |
| Device | SNOMED-CT | Device |
| Observation | SNOMED-CT | Observable Entity |

### Vocabulary Mapping Rules
1. Always map to standard concepts for analytics
2. Preserve source codes in `_source_value` fields
3. Use CONCEPT_ANCESTOR for hierarchy navigation
4. Document vocabulary version used in analysis

### Concept Set Best Practices
```json
{
  "name": "Type 2 Diabetes Mellitus",
  "id": 1,
  "expression": {
    "items": [
      {
        "concept": {
          "CONCEPT_ID": 201826,
          "CONCEPT_NAME": "Type 2 diabetes mellitus"
        },
        "includeDescendants": true,
        "includeMapped": true
      }
    ]
  }
}
```

## Cohort Definition Standards

### Cohort Structure
```
- Clear index date definition
- Explicit inclusion criteria
- Explicit exclusion criteria
- Observation period requirements
- Washout periods where applicable
```

### Cohort Naming Convention
```
[StudyAcronym]_[Population]_[Version]
Example: LEGEND_T2DM_Metformin_v3
```

### Required Documentation
- Clinical rationale for each criterion
- Concept set definitions
- Temporal logic explanation
- Expected cohort size estimates

## Study Design Standards

### Study Types

1. **Characterization**
   - Population-level summaries
   - ACHILLES for data quality
   - Feature extraction via FeatureExtraction package

2. **Population-Level Estimation (PLE)**
   - Comparative effectiveness
   - Safety surveillance
   - Use CohortMethod or SelfControlledCaseSeries

3. **Patient-Level Prediction (PLP)**
   - Risk prediction models
   - Use PatientLevelPrediction package
   - Report AUROC, calibration, clinical utility

### Required Study Elements
- Protocol registration (EU PAS, ClinicalTrials.gov)
- Pre-specified analysis plan
- Negative control outcomes
- Sensitivity analyses
- Diagnostic plots

## Code Standards

### R Code (HADES)
```r
# Standard library loading order
library(DatabaseConnector)
library(SqlRender)
library(CohortGenerator)
library(CohortMethod)

# Connection pattern
connectionDetails <- createConnectionDetails(
  dbms = "postgresql",
  server = "localhost/ohdsi",
  user = Sys.getenv("DB_USER"),
  password = Sys.getenv("DB_PASSWORD")
)

# Always use parameterized SQL
sql <- SqlRender::render(
  "SELECT * FROM @cdm_schema.person WHERE person_id = @person_id",
  cdm_schema = cdmSchema,
  person_id = targetId
)
```

### SQL Standards
```sql
-- Use schema qualifiers
SELECT p.person_id, p.year_of_birth
FROM @cdm_schema.person p
INNER JOIN @cdm_schema.observation_period op
  ON p.person_id = op.person_id
WHERE op.observation_period_start_date <= '@study_start_date';

-- Always parameterize for SqlRender
-- Use meaningful aliases
-- Include comments for complex logic
```

### Python Code
```python
# Standard imports for OHDSI work
import pandas as pd
from sqlalchemy import create_engine
import psycopg2

# Connection pattern
engine = create_engine(
    f"postgresql://{user}:{password}@{host}:{port}/{database}"
)

# Use parameterized queries
query = """
SELECT person_id, condition_concept_id
FROM {schema}.condition_occurrence
WHERE condition_concept_id = %(concept_id)s
"""
df = pd.read_sql(query.format(schema=cdm_schema),
                  engine,
                  params={'concept_id': 201826})
```

## Data Quality Standards

### ACHILLES Analysis
- Run ACHILLES before any analysis
- Review Data Quality Dashboard
- Document known data quality issues
- Apply appropriate exclusion criteria

### Required Quality Checks
1. Person count and demographics
2. Observation period coverage
3. Concept prevalence verification
4. Temporal consistency
5. Missing data assessment

## Reporting Standards

### Study Results
- Report per RECORD or STROBE guidelines
- Include network-level summary statistics
- Provide forest plots for multi-database studies
- Share concept set definitions

### Code Sharing
- All analysis code in version control
- README with execution instructions
- Environment/dependency documentation
- Example output format

## Security and Privacy

### Data Handling
- Never export patient-level data
- Use minimum necessary identifiers
- Apply k-anonymity where required
- Document all data access

### Credential Management
```bash
# Use environment variables
export OHDSI_DB_USER="username"
export OHDSI_DB_PASSWORD="password"

# Never hardcode credentials
# Use .Renviron for R sessions
# Use .env files (gitignored) for Python
```

## Network Study Standards

### Participation Requirements
- IRB approval or exemption
- Data Use Agreement
- CDM version compatibility
- Vocabulary version alignment

### Result Sharing
- Use standardized result schemas
- Submit via OHDSI study coordinator
- Include diagnostics and quality metrics
- Participate in meta-analysis

## References

- [OHDSI Methods Library](https://ohdsi.github.io/MethodsLibrary/)
- [Book of OHDSI](https://ohdsi.github.io/TheBookOfOhdsi/)
- [OMOP CDM Wiki](https://ohdsi.github.io/CommonDataModel/)
- [ATLAS User Guide](https://ohdsi.github.io/Atlas/)
- [HADES Packages](https://ohdsi.github.io/Hades/)
