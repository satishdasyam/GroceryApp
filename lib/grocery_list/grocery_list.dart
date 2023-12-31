import 'package:flutter/material.dart';

import '../grocery_details/product_detail_page.dart';
import '../models/product.dart';
import 'fetch_products_use_case.dart';
import 'grocery_controller.dart';
import '../main.dart';
import 'package:http/http.dart' as http;

class GroceryList extends State<GroceryHomePage> {
  final GroceryController groceryController =
  GroceryController(fetchProductsUseCase: FetchProductsUseCase(http.Client()));
  final List<Product> productList = [];
  final String screenTitle = "Groceries";
  late bool isProgressIndicatorToBeShown;

  @override
  void initState() {
    super.initState();
    isProgressIndicatorToBeShown = true;
    fetchGroceryList();
  }

  void fetchGroceryList() async {
    List<Product> prodList =  await groceryController.fetchGroceryList();
    setState(() {
      productList.addAll(prodList);
      isProgressIndicatorToBeShown = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(screenTitle),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Stack(children: <Widget>[
        ListView.builder(
            itemCount: productList.length,
            itemBuilder: (context, index) {
              return Card(
                // In many cases, the key isn't mandatory
                key: ValueKey(productList[index].productId),
                margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: ListTile(
                      onTap: () {
                        navigateToDetailsPage(index);
                      },
                      title: Text(
                        productList[index].title,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                        productList[index].category,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.black),
                      ),
                      trailing: Text(
                        '\u{20B9}${productList[index].price.toString()}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style:
                        const TextStyle(color: Colors.black, fontSize: 18),
                      ),
                      leading: Image.network(
                        productList[index].image,
                        width: 80,
                        height: 80,
                      ),
                    )),
              );
            }),
        Visibility(
            visible: isProgressIndicatorToBeShown,
            child: const Center(
              child: CircularProgressIndicator(),
            ))
      ]),
    );
  }

  void navigateToDetailsPage(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              ProductDetailPage(item: productList[index])),
    );
  }
}