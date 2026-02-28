#!/bin/bash
# ============================================================
# ClinPort — Initial Repository Push Script
# Run this in your terminal after cloning ClinPort repo
# ============================================================

set -e

echo "🏥 ClinPort — Pushing scaffold to GitHub..."

# Step 1: Clone the empty repo (skip if already cloned)
if [ ! -d "ClinPort/.git" ]; then
    git clone https://github.com/datagodzilla/ClinPort.git
fi

cd ClinPort

# Step 2: Copy scaffold files from wherever Claude generated them
# If running Claude Code, Claude will handle this directly.
# Otherwise, copy from /home/claude/ClinPort/:
#   cp -r /home/claude/ClinPort/* .

# Step 3: Stage everything
git add -A

# Step 4: Commit
git commit -m "feat: ClinPort initial scaffold — M1 OMOP BigQuery foundation

- Complete project directory structure (src/clinport/*)
- OMOP CDM 5.4 BigQuery client with retry logic
- Cohort SQL templates (T2DM, Heart Failure, Metformin, RWE composite)
- Unit test suite for cohort query registry
- GitHub Actions CI workflow (lint, test, docker)
- Dockerfile multi-stage build (Python 3.11)
- Makefile developer workflow targets
- pyproject.toml with full dependency spec
- .env.example with GCP/FHIR/LLM config template
- Issue templates (bug, feature)

Milestone 1 foundation: BigQuery OMOP + Cohort SQL ✅

Co-authored-by: QuantumHelix.ai"

# Step 5: Push
git push origin main

echo ""
echo "✅ ClinPort scaffold pushed successfully!"
echo "🔗 https://github.com/datagodzilla/ClinPort"
echo ""
echo "Next steps:"
echo "  1. Create issues from backlog (M1 tasks)"
echo "  2. Set up BigQuery OMOP dataset"
echo "  3. Run: make install-dev && make test"
