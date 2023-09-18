
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:grocery_app/product.dart';
import 'package:http/http.dart' as http;

class FetchProductsUseCase {
  Future<List<Product>> fetchGroceryList() async {
    List<Product> products = [];
    http.Response response =
    await http.get(Uri.parse("https://fakestoreapi.com/products"));
    if (response.statusCode == 200) {
      List<Product> prods = (json.decode(response.body) as List)
          .map((i) => Product.fromJson(i))
          .toList();
      if (kDebugMode) {
        print("Response:$prods");
      }
      products.addAll(prods);
    }
    return products;
  }

}