// ignore_for_file: UNNECESSARY_CAST

part of 'ex42_bug_fixed_test.dart';

// **************************************************************************
// Generator: MorphyGenerator<Morphy>
// **************************************************************************

///
class Task3 extends $Task3 {
  final String id;
  final String? parentId;
  final String description;
  final double orderId;
  final bool? hasChildren;
  final List<String?> parentHierarchy;
  final bool isCollapsed;

  ///
  Task3({
    required this.id,
    this.parentId,
    required this.description,
    required this.orderId,
    this.hasChildren,
    required this.parentHierarchy,
    required this.isCollapsed,
  });
  String toString() =>
      "(Task3-id:${id.toString()}|parentId:${parentId.toString()}|description:${description.toString()}|orderId:${orderId.toString()}|hasChildren:${hasChildren.toString()}|parentHierarchy:${parentHierarchy.toString()}|isCollapsed:${isCollapsed.toString()})";
  int get hashCode => hashObjects([
        id.hashCode,
        parentId.hashCode,
        description.hashCode,
        orderId.hashCode,
        hasChildren.hashCode,
        parentHierarchy.hashCode,
        isCollapsed.hashCode
      ]);
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Task3 &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          parentId == other.parentId &&
          description == other.description &&
          orderId == other.orderId &&
          hasChildren == other.hasChildren &&
          (parentHierarchy).equalUnorderedD(other.parentHierarchy) &&
          isCollapsed == other.isCollapsed;
  Task3 copyWith_Task3({
    Opt<String>? id,
    Opt<String?>? parentId,
    Opt<String>? description,
    Opt<double>? orderId,
    Opt<bool?>? hasChildren,
    Opt<List<String?>>? parentHierarchy,
    Opt<bool>? isCollapsed,
  }) {
    return Task3(
      id: id == null ? this.id as String : id.value as String,
      parentId: parentId == null
          ? this.parentId as String?
          : parentId.value as String?,
      description: description == null
          ? this.description as String
          : description.value as String,
      orderId:
          orderId == null ? this.orderId as double : orderId.value as double,
      hasChildren: hasChildren == null
          ? this.hasChildren as bool?
          : hasChildren.value as bool?,
      parentHierarchy: parentHierarchy == null
          ? this.parentHierarchy as List<String?>
          : parentHierarchy.value as List<String?>,
      isCollapsed: isCollapsed == null
          ? this.isCollapsed as bool
          : isCollapsed.value as bool,
    );
  }
}

extension $Task3_changeTo_E on $Task3 {}

enum Task3$ {
  id,
  parentId,
  description,
  orderId,
  hasChildren,
  parentHierarchy,
  isCollapsed
}
