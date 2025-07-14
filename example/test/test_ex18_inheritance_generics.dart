import 'package:test/test.dart';
import 'ex18_inheritance_generics.dart';

void main() {
  group('Ex18 Inheritance Generics - changeToA No Casting Tests', () {
    late X x1, x2, x3;
    late B originalB;

    setUp(() {
      x1 = X(id: 1);
      x2 = X(id: 2);
      x3 = X(id: 3);
      originalB = B(batchItems: [x1, x2]);
    });

    group('changeToA method without casting', () {
      test('changeToA should work without casting - basic functionality', () {
        // Arrange
        final newItems = [x2, x3];

        // Act - This should work without any casting issues
        final result = originalB.changeToA(batchItems: newItems);

        // Assert
        expect(result, isA<A>());
        expect(result.batchItems, equals(newItems));
        expect(result.batchItems.length, equals(2));
        expect(result.batchItems[0].id, equals(2));
        expect(result.batchItems[1].id, equals(3));
      });

      test('changeToA with null parameter should preserve original items', () {
        // Act
        final result = originalB.changeToA();

        // Assert
        expect(result, isA<A>());
        expect(result.batchItems, equals(originalB.batchItems));
        expect(result.batchItems.length, equals(2));
        expect(result.batchItems[0].id, equals(1));
        expect(result.batchItems[1].id, equals(2));
      });

      test('changeToA with empty list should work', () {
        // Arrange
        final emptyList = <X>[];

        // Act
        final result = originalB.changeToA(batchItems: emptyList);

        // Assert
        expect(result, isA<A>());
        expect(result.batchItems, isEmpty);
      });

      test('changeToA should return A instance, not B instance', () {
        // Arrange
        final newItems = [x3];

        // Act
        final result = originalB.changeToA(batchItems: newItems);

        // Assert
        expect(result, isA<A>());
        expect(result, isNot(isA<B>()));
        expect(result.runtimeType.toString(), contains('A'));
      });

      test('changeToA should not modify original B instance', () {
        // Arrange
        final originalItems = List<X>.from(originalB.batchItems);
        final newItems = [x3];

        // Act
        originalB.changeToA(batchItems: newItems);

        // Assert - Original B should be unchanged
        expect(originalB.batchItems, equals(originalItems));
        expect(originalB.batchItems.length, equals(2));
        expect(originalB.batchItems[0].id, equals(1));
        expect(originalB.batchItems[1].id, equals(2));
      });
    });

    group('Type safety verification', () {
      test('changeToA parameter type matches exactly - no casting needed', () {
        // This test verifies that the generated code works without casting
        // by ensuring the types are compatible at compile time

        // Arrange
        final List<X> newItems = [x1, x2, x3]; // Explicitly typed as List<X>

        // Act - This should compile and run without any casting
        final result = originalB.changeToA(batchItems: newItems);

        // Assert
        expect(result.batchItems, equals(newItems));
        expect(result.batchItems.runtimeType.toString(), contains('List'));
      });

      test('changeToA preserves item types correctly', () {
        // Arrange
        final newItems = [x1, x3];

        // Act
        final result = originalB.changeToA(batchItems: newItems);

        // Assert
        expect(result.batchItems, isA<List<X>>());
        expect(result.batchItems.every((item) => item is X), isTrue);
        expect(result.batchItems[0], isA<X>());
        expect(result.batchItems[1], isA<X>());
      });
    });

    group('Method behavior comparison', () {
      test('changeToA vs copyWithA behavior difference', () {
        // Arrange
        final newItems = [x3];

        // Act
        final changedA = originalB.changeToA(batchItems: newItems);
        final copiedA = originalB.copyWithA(batchItems: newItems);

        // Assert - Both should have same content but different types
        expect(changedA.batchItems, equals(copiedA.batchItems));
        expect(changedA.runtimeType.toString(), contains('A'));
        expect(copiedA.runtimeType.toString(), contains('B'));
        expect(copiedA, isA<B>());
        expect(changedA, isNot(isA<B>()));
      });

      test('changeToA vs patchWithA behavior difference', () {
        // Arrange
        final newItems = [x3];
        final patch = APatch().withBatchItems(newItems);

        // Act
        final changedA = originalB.changeToA(batchItems: newItems);
        final patchedA = originalB.patchWithA(patchInput: patch);

        // Assert - Both should have same content but different types
        expect(changedA.batchItems, equals(patchedA.batchItems));
        expect(changedA.runtimeType.toString(), contains('A'));
        expect(patchedA.runtimeType.toString(), contains('B'));
        expect(patchedA, isA<B>());
        expect(changedA, isNot(isA<B>()));
      });
    });

    group('Edge cases and robustness', () {
      test('changeToA with single item list', () {
        // Arrange
        final singleItem = [x1];

        // Act
        final result = originalB.changeToA(batchItems: singleItem);

        // Assert
        expect(result.batchItems, equals(singleItem));
        expect(result.batchItems.length, equals(1));
        expect(result.batchItems[0].id, equals(1));
      });

      test('changeToA with large list', () {
        // Arrange
        final largeList = List.generate(100, (index) => X(id: index));

        // Act
        final result = originalB.changeToA(batchItems: largeList);

        // Assert
        expect(result.batchItems.length, equals(100));
        expect(result.batchItems[0].id, equals(0));
        expect(result.batchItems[99].id, equals(99));
      });

      test('changeToA multiple times should work consistently', () {
        // Arrange
        final items1 = [x1];
        final items2 = [x2, x3];
        final items3 = [x1, x2, x3];

        // Act
        final result1 = originalB.changeToA(batchItems: items1);
        final result2 = originalB.changeToA(batchItems: items2);
        final result3 = originalB.changeToA(batchItems: items3);

        // Assert
        expect(result1.batchItems, equals(items1));
        expect(result2.batchItems, equals(items2));
        expect(result3.batchItems, equals(items3));

        // All should be A instances
        expect(result1, isA<A>());
        expect(result2, isA<A>());
        expect(result3, isA<A>());
      });
    });

    group('Verification that no casting is needed in generated code', () {
      test('Generated changeToA method compiles without casting', () {
        // This test specifically verifies that the generated changeToA method
        // in class B can accept List<X> parameters without requiring casting

        // Arrange
        final List<X> items = [x1, x2];

        // Act - If this compiles and runs, it means no casting was needed
        final result = originalB.changeToA(batchItems: items);

        // Assert
        expect(result.batchItems, equals(items));
        expect(result, isA<A>());
      });

      test('APatch.withBatchItems accepts correct type without casting', () {
        // This verifies that the patch system can handle the types correctly

        // Arrange
        final List<X> items = [x1, x2];
        final patch = APatch();

        // Act - This should work without casting in the generated code
        patch.withBatchItems(items);
        final patchMap = patch.toPatch();

        // Assert
        expect(patchMap[A$.batchItems], equals(items));
      });

      test('changeToA works with interface compliance', () {
        // This test ensures that B's changeToA method properly creates an A
        // instance that complies with the A interface

        // Arrange
        final items = [x1, x3];

        // Act
        final result = originalB.changeToA(batchItems: items);

        // Assert - result should be a valid A instance
        expect(result, isA<A>());
        expect(result.batchItems, isA<List<X>>());
        expect(result.batchItems, equals(items));

        // Should be able to use A interface methods
        final toString = result.toString();
        expect(toString, contains('A-batchItems'));
        expect(toString, contains('X-id:1'));
        expect(toString, contains('X-id:3'));
      });
    });

    group('changeToB method casting verification', () {
      test('changeToB compilation test - exposes type mismatch', () {
        // This test will fail to compile if there's a type mismatch
        // between the changeToB parameter type and BPatch.withBatchItems

        // Arrange
        final newItems = [x2, x3];

        // Act - If this compiles, the types are compatible
        final result = originalB.changeToB(batchItems: newItems);

        // Assert
        expect(result, isA<B>());
        expect(result.batchItems, equals(newItems));
      });

      test('changeToB with null should work', () {
        // This should work regardless of the typing issue
        final result = originalB.changeToB();

        expect(result, isA<B>());
        expect(result.batchItems, equals(originalB.batchItems));
      });

      test('Direct type mismatch demonstration', () {
        // This test explicitly shows the type mismatch issue
        final patch = BPatch();
        final List<X> items = [x1, x2];

        // This works because BPatch.withBatchItems expects List<X>
        patch.withBatchItems(items);
        expect(patch.toPatch()[B$.batchItems], equals(items));

        // The issue: changeToB parameter is List<$X> but patch expects List<X>
        // If the generated code tries to pass List<$X> to withBatchItems(List<X>),
        // it should require casting like you manually added: .cast<X>()
      });

      test('Verify the exact type signatures', () {
        // Let's examine the exact types involved
        final b = B(batchItems: [x1]);

        // B.batchItems should be List<X> (note: X not $X)
        expect(b.batchItems, isA<List<X>>());

        // But the changeToB parameter type in the signature is List<$X>?
        // This creates the mismatch you had to fix with .cast<X>()

        // The patch method clearly expects List<X>
        final patch = BPatch();
        patch.withBatchItems([x1]); // This compiles because [x1] is List<X>

        expect(patch.toPatch()[B$.batchItems], isA<List<X>>());
      });
    });
  });
}
