import 'package:analyzer/dart/element/element.dart';

void main() {
  // Test to see what ClassElement types are available
  print('Available element types:');

  // Try different ClassElement types to see which ones exist
  var typeNames = [
    'ClassElement',
    'ClassElement2',
    'InterfaceElement',
    'ClassDeclaration',
    'Element',
  ];

  for (var typeName in typeNames) {
    try {
      switch (typeName) {
        case 'ClassElement':
          print('$typeName: Available');
          break;
        case 'ClassElement2':
          // This will fail if ClassElement2 doesn't exist
          print('$typeName: Available');
          break;
        case 'InterfaceElement':
          print('$typeName: Available');
          break;
        default:
          print('$typeName: Unknown');
      }
    } catch (e) {
      print('$typeName: Not available - $e');
    }
  }
}
