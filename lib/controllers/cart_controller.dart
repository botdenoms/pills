import 'package:get/get.dart';

import '../models/cart_item.dart';

class CartController extends GetxController {
  RxList<CartItem> cartItems = <CartItem>[].obs;

  int cartTotal() {
    // the cart total cost
    int amount = 0;
    for (var item in cartItems) {
      amount += item.product.itemPrice * item.quantity;
    }
    return amount;
  }

  addToCart(CartItem item) {
    // adds an item to cart
    cartItems.add(item);
  }

  cartItemIncrease(int index) {
    // increase item at given index quantity by 1
    cartItems[index].addQuantity();
  }

  cartItemDecrease(int index) {
    // decrease item at given index quantity by 1
    cartItems[index].minusQuantity();
  }

  removeItem(int index) {
    // remove item at given index
    cartItems.removeAt(index);
  }

  clearCart() {
    // remove all items in cart
    cartItems.clear();
  }

  cartCheckOut() {
    //check the cart out
  }
}
