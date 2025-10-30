import 'package:morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

part 'ex68_generics_test.morphy.dart';

@morphy
abstract class $$EditableFieldI<TState> {
  String get label;

  $$TouchInput? get touchInput;

  /// Returns `null` when [rawValue] is valid for the surrounding [state] or an error message when it is not.
  String? Function(TState state, String rawValue) get isValid;
}

/// A generic editable field definition that can represent different types of input fields
@morphy
abstract class $EditableField_Text<TState> implements $$EditableFieldI<TState> {
  $TextInputField? get textInput;

  String Function(TState) get deserializeValue;

  TState Function(TState, String) get serializeValue;
}

/// A generic editable field definition that can represent different types of input fields
@morphy
abstract class $EditableField_List<TState> implements $$EditableFieldI<TState> {}

/// A text input field with specific input formatters and validation
@morphy
abstract class $TextInputField {
  List<String> get inputFormatters;

  List<String>? get validator;

  bool? get isMultiline;
}

/// A base class for different types of touch input fields
@morphy
abstract class $$TouchInput {
  String get icon;

  String get tooltip;
}

@morphy
abstract class $TouchInput_Dropdown implements $$TouchInput {
  List<$TouchDropdownOption> get options;

  bool get useRadio;
}

@morphy
abstract class $TouchDropdownOption {
  String get label;

  String? get value;
}

@morphy
abstract class $TouchInput_Duration implements $$TouchInput {}

@morphy
abstract class $TouchInput_Date implements $$TouchInput {
  /// Lower bound for the date picker, if any.
  DateTime? get minimumDate;

  /// Upper bound for the date picker, if any.
  DateTime? get maximumDate;
}

@morphy
abstract class $TouchInput_DependencyTask implements $$TouchInput {}

main() {
  test("ex68 generics test", () {
    expect(true, true);
  });
}
