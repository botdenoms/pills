import 'product.dart';

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});

  addQuantity() {
    quantity += 1;
    return quantity;
  }

  minusQuantity() {
    if (quantity == 1) {
      return;
    }
    quantity -= 1;
    return quantity;
  }
}
