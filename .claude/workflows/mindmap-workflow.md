# Mind Map Creation Workflow

## Overview
Create visual knowledge structures that enhance understanding and learning.

## Prerequisites
- Source content (document or topic)
- Target audience defined
- Mind map type selected

## Phase 1: Content Analysis (15-20 min)
**Agent**: @research-doc-parser + domain expert

1. Parse source document (if applicable)
2. Identify central concept
3. Extract main categories (3-7 branches)
4. Note subconcepts and details
5. Map relationships between concepts

## Phase 2: Structure Design (10-15 min)
**Agent**: @research-mindmap-creator

1. Select mind map type (Concept/Process/Domain/Problem-Solution/Comparative)
2. Define hierarchy levels (3-4 optimal)
3. Organize branches logically
4. Balance complexity across branches
5. Plan relationship indicators

## Phase 3: Mind Map Creation (20-30 min)
**Agent**: @research-mindmap-creator

1. Create central concept
2. Build main branches
3. Add subconcepts (2-5 per branch)
4. Include details (2-4 per subconcept)
5. Document relationships
6. Add learning path
7. List key takeaways

## Phase 4: Quality Review (10 min)
**Agent**: @research-mindmap-creator

- [ ] 3-7 main branches
- [ ] Appropriate depth (3-4 levels)
- [ ] Clear hierarchy
- [ ] Relationships explicit
- [ ] Learning path included
- [ ] Balanced branches

## Phase 5: Formatting (5-10 min)
**Agent**: @research-doc-formatter

1. Apply standard template
2. Add metadata
3. Format consistently
4. Add visual elements
5. Proofread

**Output**: `docs/[topic]/mindmaps/[filename]_mindmap_final.md`

## Success Criteria
- Clear central concept
- Logical organization
- Easy to scan
- Supports learning
- Accurate relationships

