import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pills/data/db_test.dart';
import 'package:pills/models/cart.dart';
import 'package:pills/models/cart_item.dart';
import 'package:pills/screens/screens.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tabIndex = 0;
  bool loading = false;
  final Cart cart = Get.put(Cart());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF006FAF),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: const Color(0xFF006FAF),
        title: const Text('Pills'),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.menu_rounded,
            color: Colors.white,
          ),
          onPressed: () {
            // to orders & request screen
            Navigator.of(context).push(slideFrmLeft()
                // MaterialPageRoute<void>(
                //   builder: (BuildContext context) => const OptionsScreen(),
                // ),
                );
          },
        ),
        actions: [
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
              Navigator.of(context).push(slideFrmRight()
                  //MaterialPageRoute<void>(
                  // builder: (BuildContext context) => const CartScreen(),
                  //),
                  );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Search the store',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.white,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    // open search delegate
                  },
                  icon: const Icon(
                    Icons.search_rounded,
                    color: Colors.white,
                  ),
                )
              ],
            ),
            const SizedBox(height: 10.0),
            SizedBox(
              width: double.infinity,
              height: 30.0,
              child: ListView.builder(
                itemBuilder: tabItem,
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
              ),
            ),
            Expanded(
              child: loading
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(
                        backgroundColor: Colors.white,
                      ),
                    )
                  : ListView.builder(
                      itemBuilder: itemCard,
                      itemCount: products.length,
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget tabItem(BuildContext context, int index) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        child: Text(
          categories[index],
          style: TextStyle(
            fontSize: 19.0,
            color: tabIndex == index
                ? const Color(0xFFFFFFFF)
                : const Color(0xFF80B7D7),
          ),
        ),
      ),
      onTap: () {
        if (tabIndex == index) return;
        setState(() {
          tabIndex = index;
          loading = true;
        });
        // simulate data fetching
        Future.delayed(
          const Duration(seconds: 3),
          () {
            setState(() {
              loading = false;
            });
          },
        );
      },
    );
  }

  Widget itemCard(BuildContext context, int index) {
    return GestureDetector(
      child: Container(
        margin: const EdgeInsets.all(5.0),
        height: 200.0,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            Positioned(
              bottom: 5.0,
              left: 5.0,
              right: 5.0,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        products[index].name,
                        style: const TextStyle(
                          fontSize: 17.0,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Container(
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
                            products[index].priceFormat(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15.0,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: const Color(0xFF006FAF),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: const Icon(
                        Icons.add_shopping_cart_rounded,
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      // add item to cart
                      CartItem item = CartItem(product: products[index]);
                      cart.addToCart(item);
                    },
                  )
                ],
              ),
            )
          ],
        ),
      ),
      onTap: () {
        // to detailed screen
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (BuildContext context) => DetailsScreen(
              product: products[index],
            ),
          ),
        );
      },
    );
  }

  PageRouteBuilder slideFrmLeft() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          const OptionsScreen(),
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (context, animation, anotherAnimation, child) {
        return SlideTransition(
          position: Tween(
            begin: const Offset(-1.0, 0.0),
            end: Offset.zero,
          ).animate(animation),
          child: child,
        );
      },
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
