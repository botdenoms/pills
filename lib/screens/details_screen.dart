import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pills/screens/screens.dart';

import '../models/cart.dart';
import '../models/cart_item.dart';
import '../models/product.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({Key? key, required this.product}) : super(key: key);

  final Product product;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  int quantity = 1;

  final Cart cart = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 300.0,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: 30,
                  left: 10,
                  right: 10,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () {
                          //pop to previous screen
                          Navigator.of(context).pop();
                        },
                        icon: const Icon(
                          Icons.arrow_back_ios_new_rounded,
                          color: Color(0xFF006FAF),
                        ),
                      ),
                      IconButton(
                        iconSize: 28.0,
                        icon: Container(
                          height: 42.0,
                          width: 42.0,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset(0.0, 2.0),
                                  blurRadius: 2.0,
                                  spreadRadius: 2.0,
                                  color: Color(0x66000000))
                            ],
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.shopping_cart_rounded,
                              color: Colors.green,
                              size: 24.0,
                            ),
                          ),
                        ),
                        onPressed: () {
                          // to the cart screen
                          Navigator.of(context).push(slideFrmRight());
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              widget.product.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Text(
              widget.product.description,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16.0,
              ),
              maxLines: 10,
            ),
          ),
          const SizedBox(height: 10.0),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10.0),
            width: MediaQuery.of(context).size.width * .3,
            padding: const EdgeInsets.symmetric(
              horizontal: 5.0,
              vertical: 5.0,
            ),
            decoration: BoxDecoration(
              color: const Color(0xFF0FA958),
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Text(
                widget.product.priceFormat(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Quantity',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 19.0,
                  ),
                ),
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
                        if (quantity == 0) {
                          return;
                        }
                        setState(() {
                          quantity -= 1;
                        });
                      },
                    ),
                    const SizedBox(width: 10.0),
                    Text(
                      quantity.toString(),
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
                        setState(() {
                          quantity += 1;
                        });
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Spacer(),
          Center(
            child: GestureDetector(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                width: MediaQuery.of(context).size.width * .4,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: const Center(
                  child: Text(
                    'Add to cart',
                    style: TextStyle(
                      color: Color(0xFF006FAF),
                    ),
                  ),
                ),
              ),
              onTap: () {
                // add to cart
                CartItem item = CartItem(
                  product: widget.product,
                  quantity: quantity,
                );
                cart.addToCart(item);
              },
            ),
          ),
          const SizedBox(height: 10.0),
        ],
      ),
      backgroundColor: const Color(0xFF006FAF),
    );
  }

  PageRouteBuilder slideFrmRight() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const CartScreen(),
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
    );
  }
}
