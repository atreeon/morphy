import 'package:morphy_annotation/morphy_annotation.dart';
import 'package:test/test.dart';

part 'ex63_empty_super_class_test.morphy.dart';

@Morphy(
  explicitSubTypes: [
    $AgreedEulaState,
  ]
)
abstract class $EulaState
{
 // lack of members should not be a problem
}

@Morphy()
abstract class $AgreedEulaState implements $EulaState
{
  bool get test;
}