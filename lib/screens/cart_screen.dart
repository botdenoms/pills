import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills/controllers/cart_controller.dart';
import 'package:pills/controllers/order_controller.dart';

import '../models/cart.dart';
import '../models/cart_item.dart';
import '../models/order.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartController cart = Get.find();
  final OrderController orderController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFF006FAF),
        leading: IconButton(
          onPressed: () {
            //pop to previous screen
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          IconButton(
            onPressed: () {
              //clear cart items
              cart.clearCart();
              setState(() {});
            },
            icon: const Icon(Icons.remove_shopping_cart_rounded),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF006FAF),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.0,
            ),
            child: Text(
              'Items in your cart',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
              ),
            ),
          ),
          Expanded(
            child: cart.cartItems.isEmpty
                ? const Center(
                    child: Text(
                      'Cart empty',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10.0,
                    ),
                    itemBuilder: itemInCart,
                    itemCount: cart.cartItems.length,
                  ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 20.0,
            ),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8.0),
                topRight: Radius.circular(8.0),
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 15.0,
                      ),
                    ),
                    Text(
                      '${cart.cartTotal().toString()} ksh',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                GestureDetector(
                  child: Container(
                    width: MediaQuery.of(context).size.width * .4,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    decoration: BoxDecoration(
                      color: const Color(0xFF006FAF),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: const Center(
                      child: Text('Order'),
                    ),
                  ),
                  onTap: () {
                    // do checkout
                    if (cart.cartItems.isEmpty) {
                      return;
                    }
                    Cart c = Cart(cartItems: cart.cartItems.toList());
                    Order order = Order(items: c, pickLocation: "near you");
                    orderController.makeOrder(order);
                    cart.clearCart();
                    setState(() {});
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget itemInCart(BuildContext context, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Container(
              height: 70.0,
              width: 50.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            const SizedBox(width: 10.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const SizedBox(height: 10.0),
                Text(
                  cart.cartItems[index].product.name,
                  style: const TextStyle(color: Colors.white),
                ),
                Text(
                  cart.cartItems[index].product.priceFormat(),
                  style: const TextStyle(color: Colors.black),
                ),
              ],
            ),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            const SizedBox(height: 10.0),
            GestureDetector(
              child: const Icon(
                Icons.remove_circle_outline_rounded,
                color: Colors.redAccent,
              ),
              onTap: () {
                cart.removeItem(index);
                setState(() {});
              },
            ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                GestureDetector(
                  child: Container(
                    height: 28.0,
                    width: 28.0,
                    color: Colors.white,
                    child: const Center(
                      child: Text('-'),
                    ),
                  ),
                  onTap: () {
                    // modify count
                    if (cart.cartItems[index].quantity == 0) {
                      return;
                    }
                    cart.cartItems[index].minusQuantity();
                    setState(() {});
                  },
                ),
                const SizedBox(width: 10.0),
                Text(
                  cart.cartItems[index].quantity.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
                const SizedBox(width: 10.0),
                GestureDetector(
                  child: Container(
                    height: 28.0,
                    width: 28.0,
                    color: Colors.white,
                    child: const Center(
                      child: Text('+'),
                    ),
                  ),
                  onTap: () {
                    // modify count
                    cart.cartItems[index].addQuantity();
                    setState(() {});
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
