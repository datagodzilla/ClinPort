.PHONY: help install install-dev test lint format typecheck clean docker-build docker-run dev

PYTHON := python3.11
PIP := pip
PKG := clinport
SRC := src/$(PKG)

help: ## Show this help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

install: ## Install production dependencies
	$(PIP) install -e .

install-dev: ## Install all dependencies including dev tools
	$(PIP) install -e ".[dev]"
	pre-commit install
	$(PYTHON) -m spacy download en_core_web_sm

test: ## Run full test suite with coverage
	pytest tests/ -v

test-unit: ## Run unit tests only
	pytest tests/unit/ -v

test-integration: ## Run integration tests
	pytest tests/integration/ -v -m integration

lint: ## Run ruff linter
	ruff check $(SRC) tests/

format: ## Format code with black + ruff
	black $(SRC) tests/
	ruff check --fix $(SRC) tests/

typecheck: ## Run mypy type checker
	mypy $(SRC)

clean: ## Remove build artifacts and cache
	rm -rf dist/ build/ *.egg-info .pytest_cache .mypy_cache htmlcov .coverage
	find . -type d -name __pycache__ -exec rm -rf {} +

dev: ## Start Streamlit dev dashboard
	streamlit run src/$(PKG)/app/dashboard.py --server.port 8501

api: ## Start FastAPI dev server
	uvicorn $(PKG).api.main:app --reload --port 8000

docker-build: ## Build Docker image
	docker build -t clinport:latest .

docker-run: ## Run Docker container
	docker run -p 8501:8501 -p 8000:8000 --env-file .env clinport:latest

docker-compose-up: ## Start full stack with docker-compose
	docker-compose up --build

setup-bigquery: ## Setup BigQuery OMOP schema
	$(PYTHON) scripts/setup_bigquery_omop.py

load-synthea: ## Load Synthea test patients into BigQuery
	$(PYTHON) scripts/load_synthea_fhir.py

validate-fhir: ## Validate FHIR resources
	$(PYTHON) scripts/validate_fhir_bundle.py

notebook: ## Launch Jupyter for notebook exploration
	jupyter lab notebooks/
