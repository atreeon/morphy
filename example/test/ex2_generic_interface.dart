//THIS IS IMPOSSIBLE TO GENERATE WITH THE CURRENT IMPLEMENTATION

//IT ISN'T SUPPORTED PROPERLY BY DART EITHER

//THERE ARE HACKS BUT THEY ARE UGLY AND FRAGILE

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
