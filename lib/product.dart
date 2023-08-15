import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Product {
  //https://app.quicktype.io/
  @JsonKey(name: 'id')
  final int productId;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'image')
  final String image;
  final num price;
  final String category;
  final String description;

  Product({
    required this.productId,
    required this.title,
    required this.image,
    required this.price,
    required this.category,
    required this.description
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["id"],
        title: json["title"],
        image: json["image"],
        price: json["price"],
        category: json["category"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": productId,
        "title": title,
        "image": image,
        "price": price,
        "category": category,
        "description": description,
      };
}
