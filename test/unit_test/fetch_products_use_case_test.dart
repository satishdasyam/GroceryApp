import 'package:grocery_app/fetch_products_use_case.dart';
import 'package:grocery_app/product.dart';
import 'package:http/testing.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([http.Client])
void main() {
  /*test('String.split() splits the string on the delimiter', () {
    var string = 'foo,bar,baz';
    expect(string.split(','), equals(['foo', 'bar', 'baz']));
  });*/

 /** "dart run build_runner build" to generate mock class */

  group("fetchProducts", () {
    test('returns product list if the http status code is 200', () async {
      final client = MockClient((_) async => http.Response(
          '[{"id": 1, "title": "mock", "title": "mock",'
          ' "image": "https://one.in",'
          '"price":12, "category": "cate", "description":"desc"}]',
          200));
      final FetchProductsUseCase fetchProductsUseCase =
          FetchProductsUseCase(client);
      final List<Product> prodList =
          await fetchProductsUseCase.fetchGroceryList();
      expect(prodList.length, 1);
    });

    test('returns empty product list if the http status code is other than 200',
        () async {
      final client = MockClient((_) async => http.Response('Not found', 400));
      final FetchProductsUseCase fetchProductsUseCase =
          FetchProductsUseCase(client);
      final List<Product> prodList =
          await fetchProductsUseCase.fetchGroceryList();
      expect(prodList.length, 0);
    });
  });
}
