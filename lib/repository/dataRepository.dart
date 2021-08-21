// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_shoes_ui_practice/models/Product.dart';

// class DataRepository {
//   // 1
//   final CollectionReference collection =
//       FirebaseFirestore.instance.collection('nike/collections/basketball');
//   // 2
//   Stream<QuerySnapshot> getStream() {
//     return collection.snapshots();
//   }

//   // // 3
//   // Future<DocumentReference> addProduct(Product product) {
//   //   return collection.add(product.toJson());
//   // }

//   // // 4
//   // updateProduct(Product product) async {
//   //   await collection.doc(product.reference.id).update(product.toJson());
//   // }
// }
