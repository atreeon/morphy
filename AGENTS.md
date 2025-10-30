# Repository Guidelines

## Codex / AI End of Every Task
Check, for my request, whether there are any reusable packages available in public packages or in the existing code base.  If so, ask me if I want to use them.

If the branch is on master/main then stop and do not make any changes.  This is to prevent any accidental changes to the main branch.

## Project Structure & Module Organization
The dart code gen package lives in `morphy/`, with examples and tests under `example/` and the annotation `morphy_annotation/`.
morphy/lib/src/ contains the main code generation logic.
with morphy/lib/src/helpers.dart containing helper functions for code generation.
morphy/lib/src/createMorphy.dart combines the various parts to create the final morphy code generation.

## Codex / AI End of Every Task
run `dart analyze` to check for any violations in the `morphy_annotation`, `morphy` and `example` folders.
Be mindful that this needs to be done in each package separately.
Also run `dart test` in the `morphy` package, then run `dart build_runner build --delete-conflicting-outputs` in the `example` package and then run `dart test` in the `example` package to ensure all tests pass.

## Coding Style & Naming Conventions

## Reusable Components & Packages

## Design / Style Guidelines
All single line if statements without an else should use the a comment to break the line like the following format:
```
if (condition) //
  doSomething();
```
If the data type is not required we don't need to specify it, for example prefer:
```
final myVar = 5;
```
over
```
final int myVar = 5;
```

## Documentation Standards
Document all functions and classes with DartDoc comments (`///`).

For complex widgets or classes, include usage examples.

For any existing files that have been edited, for every line codex changes, add `// codex:` above the line explaining the change and reasoning and what that line of code is doing (skipping import statements, closing brackets and other non functional lines).  Be careful that the line you have commented has actually been changed by codex and is not just an unchanged line that has been moved or reformatted.

For any new files, just comment as normal without the `// codex:` comments
but do add plenty of doc comments, especially where the code is not self explanatory.
As a minimum one doc comment per four lines of code, document any new variables if they are not self explanatory.
Treat the user of the code as someone who has never seen it before and needs to understand what it is doing.  Also especially comment any rarely used apis, functions or complex algorithms or logic.

Use template and macro for any reusable documentation patterns, only where we can reuse the document and add a @macro.
For example, callable classes should duplicate the class doc comment on the `call` method and class constructors should duplicate the class doc comment on the constructor.  Any named parameter, public properties or getter or setters should be have doc comments also For example:

```dart
/// {@template MyClass}
/// Reusable documentation
/// {@endtemplate}
class MyClass {
  /// Property description.
  final double myProperty;  
  
  /// {@macro MyClass}
  MyClass();

  /// {@macro MyClass}
  void call() {}
}
```

## Testing Guidelines
Co-locate unit tests beside the module they exercise (e.g., `morphy/test`).
