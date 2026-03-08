# Global Coding Standards (Dart)

This is the source of truth for global coding standards used by agents in this repo.

This document focuses on Dart package coding standards and excludes repo package placement rules. See `RepoArchitectureRules.md` for package boundaries and placement.

## Rule Levels
- `Must`: hard rule / default expectation.
- `Should`: strong default, can be overridden with clear reason.
- `Preference`: style preference / guidance.

## Naming and File Organization
- (`Must`) Use matching file/type naming for new or renamed files: the filename should match the primary class/function/type name in the same case style used by this repo.
- (`Should`) Place public classes/functions in their own files where practical.
- (`Should`) Keep private helpers close to their primary type.
- (`Should`) Apply naming rules forward-only: do not mass-rename legacy files unless explicitly requested.

## General Dart Style
- (`Preference`) Use inferred types when obvious (`final value = ...`) instead of redundant explicit types.
- (`Should`) Prefer top-level functions over single-purpose static utility classes.
- (`Should`) Prefer sealed classes when modeling a closed set of variants.
- (`Must`) Single-line `if` statements without `else` should use:

```dart
if (condition) //
  doSomething();
```

- (`Should`) Single-line `if/else` should use:

```dart
if (condition) //
  doSomething();
else //
  doSomethingElse();
```

## Documentation Standards
- (`Must`) Add DartDoc (`///`) to all public classes and functions.
- (`Should`) Add DartDoc to private classes/functions when intention is not obvious.
- (`Must`) When editing existing files, document newly introduced behavior where needed for clarity.
- (`Should`) For complex classes or APIs, include usage examples.
- (`Should`) Reuse repeated docs with `{@template ...}` and `{@macro ...}` where helpful.

## Refactor Cleanup
- (`Must`) During refactors/renames, update call sites and tests in the same change when feasible.
- (`Must`) Do not leave shim exports, typedef redirects, or temporary compatibility wrappers after a completed refactor.

## Deterministic Tests
- (`Must`) Tests that depend on current time must be deterministic (inject/freeze time source).
- (`Should`) Keep time-freezing scoped to the smallest possible test block.

## Testing Standards
- (`Must`) Test inputs and expected outputs should be explicit and easy to read.
- (`Should`) Keep fixture setup concise but understandable.
- (`Should`) Define test data close to assertions so intent is obvious.
- (`Should`) Prefer behavior-focused test names.
- (`Should`) Place local private test helpers below `main()` so test intent appears first.

## Formatting and Practicality
- (`Must`) Follow package `analysis_options.yaml` and existing style in touched files.
- (`Should`) Keep line breaking readable and consistent with repo conventions.
- (`Should`) Use comments to explain intent in medium/large functions when logic is not self-evident.
