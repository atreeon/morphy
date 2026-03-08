# Agent Checklist

Thin, fast checklist for agents working in this repo.

Use this first, then load only the relevant sections from `GlobalCodingStandards.md` and `RepoArchitectureRules.md`.

## Fast Checklist
- Confirm branch is not `main` or `master` before making changes.
- Read `GlobalCodingStandards.md` (relevant sections only).
- Read `RepoArchitectureRules.md` for touched packages/files.
- Keep changes pragmatic; avoid broad cleanup unless requested.
- If touching or creating a function/class, ensure docs are added per standards.
- During refactor/rename work, do not leave shim exports, typedef redirects, or temporary compatibility wrappers.
- Update relevant changelog/docs when required by the change type.

## Validation Preflight
- If analyze/test failures mention generated files, imports, or package config first run `dart pub get` in affected packages.
- In `example`, if generated outputs are stale/missing, run build_runner before claiming blocked.
- Report exact package and command when validation is blocked or fails.

## AI End-of-Task Validation Flow
- In `morphy_annotation`:
  - Run `dart analyze`.
  - Run `dart test` when `morphy_annotation` was touched.
- In `morphy`:
  - Run `dart analyze`.
  - Run `dart test`.
- In `example`:
  - Run `dart analyze`.
  - Run `dart run build_runner build --delete-conflicting-outputs`.
  - Run `dart test`.

## Change Policy
- Features:
  - Update the relevant `CHANGELOG.md` (`morphy/CHANGELOG.md` and/or `morphy_annotation/CHANGELOG.md`).
  - Update documentation/examples where behavior or usage changes.
- Bugs:
  - Update the relevant `CHANGELOG.md` with concise bug-fix notes.
  - Update docs/examples if externally visible behavior changed.
- Refactor/Restructure:
  - Update standards/docs when expectations change.
  - Do proper rename/reference updates; do not leave compatibility shims.
