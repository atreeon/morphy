// // dart format width=80
// // ignore_for_file: UNNECESSARY_CAST
// // ignore_for_file: unused_element
//
// import 'package:morphy_annotation/morphy_annotation.dart';
// import 'package:test/test.dart';
//
//
// @morphy
// abstract class $$Changed<T> {}
//
// @morphy
// abstract class $Changed_add<T> implements $$Changed<T> {
//   T get doc;
// }
//
// @morphy
// abstract class $Changes<T> {
//   List<$$Changed<T>> get changes;
// }
//
// @morphy
// abstract class $Task {
//   int get id;
// }
//
// @morphy
// abstract class $$TasksRepoState {}
//
// @morphy
// abstract class $TasksRepoState_Data implements $$TasksRepoState, $Changes<$Task> {
//   List<$Task> get tasks;
// }
//
// void main() {
//   group("generics 67", () {
//     test("0 ", () {
//       // var result = ;
//       //
//       // var expected = [
//       // ];
//       // expect(result, expected);
//     });
//   });
// }
//
//
// // **************************************************************************
// // Generator: MorphyGenerator<Morphy>
// // **************************************************************************
//
// ///
// sealed class Changed<T> extends $$Changed<T> {
//   Changed<T> copyWith_Changed<T>();
// }
//
// extension $$Changed_changeTo_E on $$Changed {}
//
// ///
// ///implements [$$Changed]
// ///
//
// ///
// class Changed_add<T> extends $Changed_add<T> implements Changed<T> {
//   final T doc;
//
//   ///
//   ///implements [$$Changed]
//   ///
//
//   ///
//   Changed_add({required this.doc});
//   Changed_add._({required this.doc});
//   int get hashCode => hashObjects([doc.hashCode]);
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Changed_add &&
//           runtimeType == other.runtimeType &&
//           doc == other.doc;
//   Changed<T> copyWith_Changed<T>() {
//     return Changed_add._(doc: (this as Changed_add).doc) as Changed<T>;
//   }
//
//   Changed_add<T> copyWith_Changed_add<T>({T Function()? doc}) {
//     return Changed_add._(doc: doc == null ? this.doc as T : doc() as T)
//         as Changed_add<T>;
//   }
// }
//
// extension $Changed_add_changeTo_E on $Changed_add {
//   Changed_add<T> changeTo_Changed_add<T>({T Function()? doc}) {
//     return Changed_add._(doc: doc == null ? this.doc as T : doc() as T)
//         as Changed_add<T>;
//   }
// }
//
// enum Changed_add$ { doc }
//
// ///
// class Changes<T> extends $Changes<T> {
//   final List<Changed<T>> changes;
//
//   ///
//   Changes({required this.changes});
//   Changes._({required this.changes});
//   int get hashCode => hashObjects([changes.hashCode]);
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Changes &&
//           runtimeType == other.runtimeType &&
//           (changes).equalUnorderedD(other.changes);
//   Changes<T> copyWith_Changes<T>({List<Changed<T>> Function()? changes}) {
//     return Changes._(
//           changes: changes == null
//               ? this.changes as List<Changed<T>>
//               : changes() as List<Changed<T>>,
//         )
//         as Changes<T>;
//   }
// }
//
// extension $Changes_changeTo_E on $Changes {
//   Changes<T> changeTo_Changes<T>({List<Changed<T>> Function()? changes}) {
//     return Changes._(
//           changes: changes == null
//               ? this.changes as List<Changed<T>>
//               : changes() as List<Changed<T>>,
//         )
//         as Changes<T>;
//   }
// }
//
// enum Changes$ { changes }
//
// ///
// class Task extends $Task {
//   final int id;
//
//   ///
//   Task({required this.id});
//   Task._({required this.id});
//   int get hashCode => hashObjects([id.hashCode]);
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is Task && runtimeType == other.runtimeType && id == other.id;
//   Task copyWith_Task({int Function()? id}) {
//     return Task._(id: id == null ? this.id as int : id() as int) as Task;
//   }
// }
//
// extension $Task_changeTo_E on $Task {
//   Task changeTo_Task({int Function()? id}) {
//     return Task._(id: id == null ? this.id as int : id() as int) as Task;
//   }
// }
//
// enum Task$ { id }
//
// ///
// sealed class TasksRepoState extends $$TasksRepoState {
//   TasksRepoState copyWith_TasksRepoState();
// }
//
// extension $$TasksRepoState_changeTo_E on $$TasksRepoState {}
//
// class TasksRepoState_Data extends $TasksRepoState_Data
//     implements TasksRepoState, Changes<$Task> {
//   final List<Changed<T>> changes;
//   final List<Task> tasks;
//
//   TasksRepoState_Data({required this.changes, required this.tasks});
//   TasksRepoState_Data._({required this.changes, required this.tasks});
//   int get hashCode => hashObjects([changes.hashCode, tasks.hashCode]);
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//       other is TasksRepoState_Data &&
//           runtimeType == other.runtimeType &&
//           (changes).equalUnorderedD(other.changes) &&
//           (tasks).equalUnorderedD(other.tasks);
//   TasksRepoState copyWith_TasksRepoState() {
//     return TasksRepoState_Data._(
//           changes: (this as TasksRepoState_Data).changes,
//           tasks: (this as TasksRepoState_Data).tasks,
//         )
//         as TasksRepoState;
//   }
//
//   Changes<T> copyWith_Changes<T>({List<Changed<T>> Function()? changes}) {
//     return TasksRepoState_Data._(
//           changes: changes == null
//               ? this.changes as List<Changed<T>>
//               : changes() as List<Changed<T>>,
//           tasks: (this as TasksRepoState_Data).tasks,
//         )
//         as Changes<T>;
//   }
//
//   TasksRepoState_Data copyWith_TasksRepoState_Data({
//     List<Changed<T>> Function()? changes,
//     List<Task> Function()? tasks,
//   }) {
//     return TasksRepoState_Data._(
//           changes: changes == null
//               ? this.changes as List<Changed<T>>
//               : changes() as List<Changed<T>>,
//           tasks: tasks == null
//               ? this.tasks as List<Task>
//               : tasks() as List<Task>,
//         )
//         as TasksRepoState_Data;
//   }
// }
//
// extension $TasksRepoState_Data_changeTo_E on $TasksRepoState_Data {
//   TasksRepoState_Data changeTo_TasksRepoState_Data({
//     List<Changed<T>> Function()? changes,
//     List<Task> Function()? tasks,
//   }) {
//     return TasksRepoState_Data._(
//           changes: changes == null
//               ? this.changes as List<Changed<T>>
//               : changes() as List<Changed<T>>,
//           tasks: tasks == null
//               ? this.tasks as List<Task>
//               : tasks() as List<Task>,
//         )
//         as TasksRepoState_Data;
//   }
// }
