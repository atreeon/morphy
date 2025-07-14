abstract class Patch<T> {
  Map<dynamic, dynamic> toPatch();
  Map<String, dynamic> toJson();
  T applyTo(T entity);
}
