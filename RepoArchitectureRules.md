# Repo Architecture Rules

This document is the source of truth for package boundaries, code placement, and repo-specific architecture conventions.

For global coding/documentation/testing standards, see `GlobalCodingStandards.md`.

## Project Layout

### `morphy_annotation`
- Owns annotations and lightweight runtime helpers exposed to consumers.
- Public API is exported from `morphy_annotation/lib/morphy_annotation.dart`.
- Keep package free of generator/build-runner internals.

### `morphy`
- Owns code generation implementation and builder wiring.
- Builder entrypoints live in `morphy/lib/morphyBuilder.dart` and `morphy/lib/morphy2Builder.dart`.
- Generation internals belong under `morphy/lib/src/` (including `src/common/`).
- `morphy/build.yaml` is the source of truth for builder registration/order.

### `example`
- Owns integration-style usage examples and behavior tests for generated output.
- This package validates end-to-end annotation + generator behavior.

### `release`
- Owns manual helper scripts for dry-run/publish workflows.
- Scripts here are operational helpers, not runtime package APIs.

## Package Boundary Rules
- Place new annotation options, annotation docs, and annotation-time helpers in `morphy_annotation`.
- Place analyzer/source_gen/build logic only in `morphy`.
- Keep consumer-style examples and regression scenarios in `example/test`.
- Do not move release operational shell scripts into runtime packages.

## Test Placement Rules
- `morphy_annotation/test`: annotation/runtime helper unit tests.
- `morphy/test`: generator helper/unit tests.
- `example/test`: integration/regression tests that rely on generated files.

## Morphy Generation Rules
- Use `@morphy` or `@morphy2` on abstract definition classes.
- Morphy definition class naming follows morphy conventions (`$Type` for generated concrete type, `$$Type` for abstract/sealed scenarios).
- Include correct `part` declarations for generated outputs (`.morphy.dart`, `.morphy2.dart`, and `.g.dart` when JSON serialization is enabled).
- For JSON generation, use `@Morphy(generateJson: true)` and ensure consumer package setup includes required json dependencies/codegen.
- When polymorphic JSON/copy transitions are required, configure `explicitSubTypes` with correct ordering.
- Use `hidePublicConstructor` only when constructor visibility behavior is intentional and documented.

## Generated File and Validation Expectations
- Generated outputs are part of normal `example` validation flow via build_runner.
- If generated files or imports are stale, run package preflight (`dart pub get`) and rebuild generated outputs before reporting blocked validation.

## Refactor/Rename Boundary Safety
- Keep package responsibilities stable during refactors.
- When renaming or restructuring, update references directly; do not introduce compatibility shims/typedef redirects to bridge old names.
