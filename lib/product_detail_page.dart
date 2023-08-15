import 'package:flutter/material.dart';
import 'package:grocery_app/product.dart';

class ProductDetailPage extends StatelessWidget {
  final String title = "Product Details";
  final Product item;

  const ProductDetailPage({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Image.network(
          item.image,
          width: 200,
          height: 200,
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            item.title,
            style: const TextStyle(color: Colors.black),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text(
            item.description,
            style: const TextStyle(color: Colors.black),
          ),
        )
      ]),
    );
  }
}
