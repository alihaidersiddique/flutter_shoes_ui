import 'dart:convert';

class Shoes {
  final int id;
  final String name;
  final int price;
  final String image;
  final String logo;

  Shoes({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.logo,
  });

  static List<Shoes> runningShoes = [];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'image': image,
      'logo': logo,
    };
  }

  factory Shoes.fromMap(Map<String, dynamic> map) {
    return Shoes(
      id: map['id'],
      name: map['name'],
      price: map['price'],
      image: map['image'],
      logo: map['logo'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Shoes.fromJson(String source) => Shoes.fromMap(json.decode(source));
}
