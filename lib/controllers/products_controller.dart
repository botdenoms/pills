import 'package:get/get.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product.dart';

class ProductController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  RxList<String> categories = <String>[].obs;

  Future<List<Product>> getProducts() async {
    // request products from db(20 per request)
    final db = FirebaseFirestore.instance;
    await db.collection("products").get().then((event) {
      for (var doc in event.docs) {
        // ignore: avoid_print
        // print("${doc.id} => ${doc.data()}");
        // Product.fromMap(map);
        Map<String, dynamic> map = {};
        map['id'] = doc.id;
        map.addAll(doc.data());
        // ignore: avoid_print
        // print(map['name']);
        // print(map['description']);
        // print(map['category']);
        // ignore: avoid_print
        // print('');
        // ignore: avoid_print
        // print(map['id'].runtimeType);
        // ignore: avoid_print
        // print(map['category'].runtimeType);
        // print(map['imageurl']);
        // print(map['id']);
        // ignore: avoid_print
        // print('');
        Product prd = Product(
          name: map['name'],
          description: map['description'],
          category: map['category'],
          price: map['price'],
          amount: map['amount'],
          imageUrl: map['imageurl'],
          id: map['id'],
        );
	// print(prd.toMap());
        addProduct(prd);
      }
    });
    return products.toList();
  }

  List<Product> getProductsOn(String category) {
    //await getProducts();
    // filter on a given category string
    if (category == 'All') {
      return products.toList();
    }
    if (category == 'Popular') {
      return products.toList();
    }
    List<Product> items = [];
    for (Product prd in products) {
	if(prd.category == category){
	   items.add(prd);
	}
    }
    return items;
  }

  List<String> getCategories() {
    //await getProducts();
    // return categories of requested products
    List<String> cat = ['All', 'Popular'];
    List<String> ctName = [];
    for (Product prd in products) {
      if (ctName.contains(prd.category)) {
        continue;
      }
      ctName.add(prd.category);
    }
    cat.addAll(ctName);
    return cat;
  }

  addProduct(Product product) {
    products.add(product);
  }
}
