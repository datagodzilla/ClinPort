"""
ClinPort OMOP CDM — BigQuery Client
Handles all BigQuery interactions for OMOP CDM 5.4 analytics.

Milestone 1: Foundation layer for cohort queries.
"""

from __future__ import annotations

import os
from dataclasses import dataclass, field
from typing import Optional

import pandas as pd
from google.cloud import bigquery
from google.oauth2 import service_account
from loguru import logger
from tenacity import retry, stop_after_attempt, wait_exponential


@dataclass
class OMOPConfig:
    """Configuration for OMOP CDM BigQuery connection."""
    project_id: str
    dataset_id: str = "omop_cdm"
    credentials_path: Optional[str] = None
    location: str = "US"
    max_bytes_billed: int = 10 * 1024**3  # 10 GB safety cap

    @classmethod
    def from_env(cls) -> "OMOPConfig":
        """Load config from environment variables."""
        return cls(
            project_id=os.environ["GCP_PROJECT_ID"],
            dataset_id=os.getenv("OMOP_DATASET_ID", "omop_cdm"),
            credentials_path=os.getenv("GOOGLE_APPLICATION_CREDENTIALS"),
            location=os.getenv("BQ_LOCATION", "US"),
        )


class OMOPBigQueryClient:
    """
    BigQuery client for OMOP CDM 5.4 queries.

    Usage:
        config = OMOPConfig.from_env()
        client = OMOPBigQueryClient(config)
        df = client.run_cohort_query("SELECT * FROM person LIMIT 10")
    """

    def __init__(self, config: OMOPConfig) -> None:
        self.config = config
        self._client = self._build_client()
        self.dataset_ref = f"{config.project_id}.{config.dataset_id}"
        logger.info(f"OMOPBigQueryClient initialized: {self.dataset_ref}")

    def _build_client(self) -> bigquery.Client:
        if self.config.credentials_path:
            credentials = service_account.Credentials.from_service_account_file(
                self.config.credentials_path,
                scopes=["https://www.googleapis.com/auth/bigquery"],
            )
            return bigquery.Client(
                project=self.config.project_id,
                credentials=credentials,
                location=self.config.location,
            )
        # Use default ADC (Application Default Credentials)
        return bigquery.Client(
            project=self.config.project_id,
            location=self.config.location,
        )

    @retry(
        stop=stop_after_attempt(3),
        wait=wait_exponential(multiplier=1, min=2, max=10),
        reraise=True,
    )
    def run_cohort_query(self, sql: str, dry_run: bool = False) -> pd.DataFrame:
        """
        Execute a cohort SQL query against OMOP CDM.

        Args:
            sql: SQL query string. Use {dataset} placeholder for dataset ref.
            dry_run: If True, estimate cost without running.

        Returns:
            DataFrame with query results.
        """
        # Inject dataset reference
        resolved_sql = sql.format(dataset=self.dataset_ref)

        job_config = bigquery.QueryJobConfig(
            maximum_bytes_billed=self.config.max_bytes_billed,
            dry_run=dry_run,
            use_query_cache=True,
        )

        logger.debug(f"Running OMOP query (dry_run={dry_run})")
        job = self._client.query(resolved_sql, job_config=job_config)

        if dry_run:
            gb_billed = job.total_bytes_processed / 1024**3
            logger.info(f"Dry run: {gb_billed:.2f} GB will be processed")
            return pd.DataFrame()

        df = job.to_dataframe()
        logger.info(f"Query returned {len(df):,} rows")
        return df

    def get_person_count(self) -> int:
        """Return total patient count in the OMOP person table."""
        sql = "SELECT COUNT(*) AS n FROM `{dataset}.person`"
        df = self.run_cohort_query(sql)
        return int(df["n"].iloc[0])

    def get_table_info(self, table_name: str) -> pd.DataFrame:
        """Get schema and row count for an OMOP CDM table."""
        sql = f"""
        SELECT
            column_name,
            data_type,
            is_nullable
        FROM `{self.config.project_id}.{self.config.dataset_id}.INFORMATION_SCHEMA.COLUMNS`
        WHERE table_name = '{table_name}'
        ORDER BY ordinal_position
        """
        return self._client.query(sql).to_dataframe()
