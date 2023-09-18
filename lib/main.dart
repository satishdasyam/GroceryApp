import 'package:flutter/material.dart';
import 'package:grocery_app/fetch_products_use_case.dart';
import 'package:grocery_app/grocery_controller.dart';
import 'package:grocery_app/product_detail_page.dart';

import 'product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Groceries',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
        useMaterial3: true,
      ),
      home: const GroceryHomePage(),
    );
  }
}

class GroceryHomePage extends StatefulWidget {
  const GroceryHomePage({super.key});

  @override
  State<StatefulWidget> createState() => _GroceryHomePageState();
}

class _GroceryHomePageState extends State<GroceryHomePage> {
  final GroceryController groceryController =
      GroceryController(fetchProductsUseCase: FetchProductsUseCase());
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductDetailPage(item: productList[index])),
                        );
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
}
