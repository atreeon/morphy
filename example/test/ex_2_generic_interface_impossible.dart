//This shows an impossible generic interface implementation

/*
  - A’s API promises a method that is polymorphic over any U (no bound).
  - B, due to its class constraint, can only construct B<V> for V extends Z.
  - Implementing A’s unconstrained method in B but trying to instantiate B<U> in the body is
    unsound; for some caller-chosen U (e.g., int), B<U> is illegal.

  In short: with A exposing an unconstrained generic on the method, and B’s class type argument
  constrained, there is no way for B to both:
 */

// class A<T> {
//   A<T> copyWith_A<T>({T Function()? x}){
//     throw UnimplementedError();
//   }
// }
//
// class B<T extends Z> implements A<T> {
//   final T y;
//   final String z;
//
//   B({required this.y, required this.z});
//
//   @override
//   A<T> copyWith_A<T extends Z>() {
//     return B<T>._(
//       y: (this as B).y,
//       z: (this as B).z,
//     )
//     as A<T>;
//   }
// }
//
// class Z {}
//
// main(){
//   var a = A<int> ();
//
//   var b = B<Z>(x: 5, y: Z(), z: "null");
// }