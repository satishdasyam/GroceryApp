import 'package:grocery_app/fetch_products_use_case.dart';
import 'package:grocery_app/product.dart';

class GroceryController {
  final FetchProductsUseCase fetchProductsUseCase;

  GroceryController({required this.fetchProductsUseCase});

  Future<List<Product>> fetchGroceryList() async {
    return fetchProductsUseCase.fetchGroceryList();
  }


}
