# Code Standards Index

This file is a thin index to reduce context bloat and drift in agent prompts.

Source of truth is split into focused documents:

## Read Order (Agents)
1. `AGENTS.md` (collaboration/runtime behavior)
2. `AgentChecklist.md` (fast workflow + validation + change policy)
3. `GlobalCodingStandards.md` (global Dart coding, docs, testing standards)
4. `RepoArchitectureRules.md` (repo/package placement and architecture rules)

## What Goes Where
- `AGENTS.md`: collaboration/runtime behavior (tone, workflow gating, safety constraints).
- `AgentChecklist.md`: short actionable checklist and validation workflow.
- `GlobalCodingStandards.md`: reusable coding/documentation/testing standards.
- `RepoArchitectureRules.md`: package boundaries, code placement, and morphy generation rules.

## Reality Notes (Current Repo)
- Lints are intentionally light in this repo (`camel_case_types: false` in `morphy/analysis_options.yaml`).
- Naming is mixed in legacy files/tests; standards are forward-looking for new/touched files unless explicitly requested otherwise.
- `build_runner` code generation is central to `example` validation and should be treated as part of the normal test workflow.

## Maintenance Notes
- Update source documents above, not this index, when standards change.
- Keep non-negotiable collaboration behavior in `AGENTS.md`.
- Prefer CI/scripts/lints for objective rules when feasible.
