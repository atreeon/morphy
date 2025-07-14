import 'package:test/test.dart';
import 'package:zikzak_morphy_annotation/morphy_annotation.dart';

// ignore_for_file: unnecessary_type_check

part 'ex45_copyWithPolymorphic_test.morphy.dart';

/// ChangeTo_ function is used to change the underlying type from one to another
/// To enable ChangeTo on a class we need to add the type to the list of explicitSubTypes in the annotation

/// To copy from a super class to a sub we will always change the underlining type.
/// Therefore we will always use changeTo_

/// A reminder that copyWith always retains the original type
/// even though it can be used polymorphically; ie on super and sub classes.

// ignore_for_file: unqualified_reference_to_non_local_static_member

@Morphy(generateCopyWithFn: true, explicitSubTypes: [$Sub])
abstract class $Super {
  String get id;
}

@morphy
abstract class $Sub implements $Super {
  String get description;
}

main() {
  group("", () {
    test("1a", () {
      var supers = <Super>[
        Super(id: "id"),
        Sub(id: "id", description: "description"),
      ];

      //copyWith_Super called on both Super & Sub objects
      var result = supers
          .map(
            (e) => //
                e.copyWithSuperFn(id: () => e.id + "_"),
          )
          .toList();

      //they both retain their original type
      expect(result[0] is Sub, false);
      expect(result[0] is Super, true);

      expect(result[1] is Sub, true);
      expect(result[1] is Super, true);
    });
  });
}
