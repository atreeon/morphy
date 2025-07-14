///Prints out a tree
void printTree<T>(
  List<T> tree,
  String Function(T) fnPrint,
  List<T> Function(T) fnChildren,
  String indent,
) {
  tree.forEach((T t) {
    print(indent + "+-" + fnPrint(t));

    if (fnChildren(t).length > 0) //
      printTree(fnChildren(t), fnPrint, fnChildren, indent + " ");
  });
}

TOut? findInTree<TIn, TOut>(
  List<TIn> tree,
  bool Function(TIn) fnFindCondition,
  TOut Function(TIn) fnOutput,
  List<TIn> Function(TIn) fnChildren,
) {
  for (var i = 0; i < tree.length; ++i) {
    var item = tree[i];

    if (fnFindCondition(item)) //
      return fnOutput(item);

    if (fnChildren(item).length > 0) {
      var result = findInTree(fnChildren(item), fnFindCondition, fnOutput, fnChildren);
      if (result != null) //
        return result;
    }
  }

  return null;
}

/// Converts any tree into a map of ids and lists of ids. Useful for testing
///
/// output: {1: {2: null, 3: {4: null, 5: null}}, 6: null}
Map<int, dynamic> convertTreeToMap<T>(
  List<T> tree,
  int Function(T) fnId,
  List<T>? Function(T) fnChildren,
) {
  Map<int, dynamic> newOutput = <int, dynamic>{};

  tree.forEach((w) {
    if (fnChildren(w) != null && fnChildren(w)!.length > 0) {
      newOutput[fnId(w)] = convertTreeToMap(fnChildren(w)!, fnId, fnChildren);
    } else {
      newOutput[fnId(w)] = null;
    }
  });

  return newOutput;
}

/// As [convertTreeToMap] but allows duplicate keys
///
/// Converts any tree into a map of ids and lists of ids. Useful for testing
///
/// output: {1: {2: null, 3: {4: null, 5: null}}, 6: null}List<Map<int, dynamic>> convertTreeToJsonMap<T>(
List<Map<int, dynamic>> convertTreeToJsonMap<T>(
  List<T> tree,
  int Function(T) fnId,
  List<T> Function(T) fnChildren,
) {
  var newOutput = <Map<int, dynamic>>[];

  tree.forEach((w) {
    if (fnChildren(w).length > 0) {
      newOutput.add({fnId(w): convertTreeToJsonMap(fnChildren(w), fnId, fnChildren)});
    } else {
      newOutput.add({fnId(w): null});
    }
  });

  return newOutput;
}

List<Map<TOut, dynamic>> convertTree<TIn, TOut>(
  List<TIn> tree,
  TOut Function(TIn) fnSelect,
  List<TIn> Function(TIn) fnChildren,
) {
  var newOutput = <Map<TOut, dynamic>>[];

  tree.forEach((w) {
    if (fnChildren(w).length > 0) {
      newOutput.add({fnSelect(w): convertTree(fnChildren(w), fnSelect, fnChildren)});
    } else {
      newOutput.add({fnSelect(w): null});
    }
  });

  return newOutput;
}

List<Map<TOut, dynamic>> convertTreeToMap2<TIn, TOut>(
  List<TIn> tree,
  TOut Function(TIn) fnSelect,
  List<TIn> Function(TIn) fnChildren,
) {
  var newOutput = <Map<TOut, dynamic>>[];

  tree.forEach((w) {
    if (fnChildren(w).length > 0) {
      newOutput.add({fnSelect(w): convertTree(fnChildren(w), fnSelect, fnChildren)});
    } else {
      newOutput.add({fnSelect(w): null});
    }
  });

  return newOutput;
}

///Flatten from a list (not a single root object with children)
///
///usage `var list = flattenR<Word>(wordsWithChildren, (x) => x.children);`
List<T1> flatten<T1>(List<T1> data, List<T1>? Function(T1) fnChildren) {
  var newList = <T1>[];

  data.forEach((element) {
    newList.add(element);

    if (fnChildren(element) != null && fnChildren(element)!.length > 0) {
      var result = flatten(fnChildren(element)!, fnChildren);
      newList.addAll(result);
    }
  });

  return newList;
}

///Flatten from a root object (not a list)
///
///usage `var list = flattenR<ChildType>(singleWithChildren, (x) => x.children);`
List<T1> flattenR<T1>(T1 data, List<T1>? Function(T1) fnChildren) {
  var newList = <T1>[data];

  if (fnChildren(data) == null) //
    return newList;

  fnChildren(data)!.forEach((element) {
    newList.add(element);

    if (fnChildren(element) != null && fnChildren(element)!.length > 0) {
      var result = flatten(fnChildren(element)!, fnChildren);
      newList.addAll(result);
    }
  });

  return newList;
}
