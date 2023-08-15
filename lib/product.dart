import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: 'id')
  final int productId;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'image')
  final String image;

  Product({required this.productId, required this.title, required this.image});

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        productId: json["id"],
        title: json["title"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": productId,
        "title": title,
        "image": image,
      };
}
