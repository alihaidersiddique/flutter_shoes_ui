import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  String? name, description, collection;
  num? price;
  List<num>? sizes;
  List<String>? images;
  DocumentReference? reference;

  Product(
      {required this.name,
      required this.description,
      required this.collection,
      required this.price,
      required this.sizes,
      required this.images,
      required this.reference});

  // will maps the data from cloud firestore to Product class

  Product.fromMap(Map<String, dynamic> map, {this.reference}) {
    name = map["name"];
    description = map["description"];
    collection = map["collection"];
    price = map["price"];
    sizes = map["sizes"];
    images = map["images"];
    reference = map["reference"];
  }

  //

  Product.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
      : this.fromMap(snapshot.data()!, reference: snapshot.reference);

  // factory Product.fromSnapshot(
  //     DocumentSnapshot<Map<String, dynamic>?> snapshot) {
  //   Product newProduct = Product.fromJson(snapshot.data());
  //   newProduct.reference = snapshot.reference;
  //   return newProduct;
  // }

  // factory Product.fromJson(Map<String, dynamic>? json) =>
  //     _ProductFromJson(json);

  // Map<String, dynamic> toJson() => _ProductToJson(this);
  // @override
  // String toString() => "Product<$name>";
}

// Product _ProductFromJson(Map<String, dynamic>? json) {
//   return Product(
//       name: json!['name'] as String,
//       description: json['description'] as String,
//       collection: json['collection'] as String,
//       price: json['price'] as num,
//       sizes: json['sizes'] as List<num>,
//       images: json['images'] as List<String>,
//       reference: json['reference']);
// }

// Map<String, dynamic> _ProductToJson(Product instance) => <String, dynamic>{
//       'name': instance.name,
//       'description': instance.description,
//       'collection': instance.collection,
//       'price': instance.price,
//       'sizes': instance.sizes,
//       'images': instance.images,
//       'reference': instance.reference
//     };
