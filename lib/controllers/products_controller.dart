import 'package:get/get.dart';

import '../models/product.dart';

class ProductController extends GetxController {
  RxList<Product> products = <Product>[].obs;
  RxList<String> categories = <String>[].obs;

  getProducts() {
    // request products from db(20 per request)
    return products.toList();
  }

  getProductsOn(String category) {
    getProducts();
    // filter on a given category string
    return products.map((element) => element.category == category).toList();
  }

  getCategories() {
    getProducts();
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
