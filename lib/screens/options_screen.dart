import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pills/controllers/order_controller.dart';
import 'package:pills/screens/screens.dart';

class OptionsScreen extends StatefulWidget {
  const OptionsScreen({Key? key}) : super(key: key);

  @override
  State<OptionsScreen> createState() => _OptionsScreenState();
}

class _OptionsScreenState extends State<OptionsScreen> {
  int tabIndex = 0;

  TextEditingController productCon = TextEditingController();
  TextEditingController descriptCon = TextEditingController();

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
      ),
      backgroundColor: const Color(0xFF006FAF),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        child: Column(
          children: [
            Row(
              children: [
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'Orders',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: tabIndex == 0
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFF80B7D7),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (tabIndex == 0) {
                      return;
                    }
                    setState(() {
                      tabIndex = 0;
                    });
                  },
                ),
                GestureDetector(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Text(
                      'Request',
                      style: TextStyle(
                        fontSize: 20.0,
                        color: tabIndex == 1
                            ? const Color(0xFFFFFFFF)
                            : const Color(0xFF80B7D7),
                      ),
                    ),
                  ),
                  onTap: () {
                    if (tabIndex == 1) {
                      return;
                    }
                    setState(() {
                      tabIndex = 1;
                    });
                  },
                ),
              ],
            ),
            const SizedBox(height: 10.0),
            tabIndex == 0 ? orderTab() : requestsTab(),
          ],
        ),
      ),
    );
  }

  Widget requestsTab() {
    return Expanded(
      child: Column(
        children: [
          TextField(
            controller: productCon,
            style: const TextStyle(
              fontSize: 17.0,
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFF80B7D7),
              hintText: 'Product',
              hintStyle: TextStyle(
                color: Color(0xFF006FAF),
                fontSize: 18.0,
              ),
              enabledBorder: InputBorder.none,
            ),
          ),
          const SizedBox(height: 5.0),
          TextField(
            controller: descriptCon,
            style: const TextStyle(
              fontSize: 17.0,
              color: Colors.white,
            ),
            decoration: const InputDecoration(
              filled: true,
              fillColor: Color(0xFF80B7D7),
              hintText: 'Description...',
              hintStyle: TextStyle(
                color: Color(0xFF006FAF),
                fontSize: 18.0,
              ),
              enabledBorder: InputBorder.none,
            ),
          ),
          const Spacer(),
          GestureDetector(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10.0),
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              width: 100.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: const Center(
                child: Text(
                  'Send',
                  style: TextStyle(
                    color: Color(0xFF006FAF),
                  ),
                ),
              ),
            ),
            onTap: () {
              // send request logic
            },
          ),
        ],
      ),
    );
  }

  Widget orderTab() {
    return Expanded(
      child: orderController.orderItems.isEmpty
          ? const Center(
              child: Text(
                'Order disappears after being picked',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            )
          : ListView.builder(
              itemBuilder: orderCard,
              itemCount: orderController.orderItems.length,
            ),
    );
  }

  Widget orderCard(BuildContext context, int index) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              orderController.orderItems[index].id,
              style: const TextStyle(
                color: Colors.white60,
              ),
            ),
            Text(
              '${orderController.orderItems[index].items.cartTotal()} Ksh',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
        const SizedBox(height: 5.0),
        ExpansionTile(
          title: Text(
            '${orderController.orderItems[index].items.cartItems.length} items',
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
          iconColor: Colors.white,
          collapsedIconColor: Colors.white,
          children: orderController.orderItems[index].items.cartItems.map((e) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      e.product.name,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '${e.quantity} items',
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      e.product.priceFormat(),
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5.0),
              ],
            );
          }).toList(),
        ),
        const SizedBox(height: 5.0),
        GestureDetector(
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Center(
              child: Row(
                children: const [
                  Icon(Icons.place_rounded, color: Color(0xFF006FAF)),
                  SizedBox(width: 5.0),
                  Text(
                    'Pick location',
                    style: TextStyle(
                      color: Color(0xFF006FAF),
                    ),
                  ),
                ],
              ),
            ),
          ),
          onTap: () {
            // open maps to view location
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const MapViewScreen(),
              ),
            );
          },
        ),
        const SizedBox(height: 5.0),
      ],
    );
  }
}
