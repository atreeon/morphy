import 'package:collection/collection.dart';

// ignore: top_level_instance_method
var _listDeepEqualsOrdered = const DeepCollectionEquality().equals;

// ignore: top_level_instance_method
var _listDeepEqualsUnordered = const DeepCollectionEquality.unordered().equals;

extension List_E<T> on List<T> {
  bool equalOrdered(List<T> compareTo) {
    return _listDeepEqualsOrdered(this, compareTo);
  }

  bool equalUnordered(List<T> compareTo) {
    return _listDeepEqualsUnordered(this, compareTo);
  }

  T? getPreviousByItem(T item) => //
      this.getNthInRelationToXByItem(item, -1);

  T? getNextByItem(T item) => //
      this.getNthInRelationToXByItem(item, 1);

  T? getNthInRelationToXByItem(T item, int nth) {
    var index = this.indexOf(item);
    var nthIndex = index + nth;

    if (nthIndex < 0 || nthIndex >= this.length) //
      return null;

    var previousItem = this.elementAt(nthIndex);
    return previousItem;
  }

  T? getPreviousById<T2>(T2 Function(T item) getId, T2 id) => //
      this.getNthInRelationToXById(getId, id, -1);

  T? getNextById<T2>(T2 Function(T item) getId, T2 id) => //
      this.getNthInRelationToXById(getId, id, 1);

  T? getNthInRelationToXById<T2>(T2 Function(T item) getId, T2 id, int nth) {
    var item = firstWhere((element) => getId(element) == id);
    return getNthInRelationToXByItem(item, nth);
  }
}

extension List__E on List {
  bool equalOrderedD(List compareTo) {
    return _listDeepEqualsOrdered(this, compareTo);
  }

  ///Deep equals
  bool equalUnorderedD(List compareTo) {
    return _listDeepEqualsUnordered(this, compareTo);
  }
}
