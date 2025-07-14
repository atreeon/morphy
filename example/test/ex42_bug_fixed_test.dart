import 'package:test/test.dart';
import 'package:zikzak_morphy_annotation/morphy_annotation.dart';

part 'ex42_bug_fixed_test.morphy.dart';

//nullable generic bug

@morphy
abstract class $Task3 {
  String get id;

  String? get parentId;

  String get description;

  double get orderId;

  bool? get hasChildren;

  List<String?> get parentHierarchy;

  bool get isCollapsed;
}

main() {
  test("1", () {
    var a = Task3(
      id: "1",
      description: "description",
      orderId: 1.0,
      isCollapsed: true,
      parentHierarchy: [],
    );

    expect(a.id, "1");
  });
}
