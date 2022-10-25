import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:pills/controllers/cart_controller.dart';
import 'package:pills/controllers/order_controller.dart';

import '../models/cart.dart';
import '../models/order.dart';

class PayScreen extends StatefulWidget {
  const PayScreen({Key? key}) : super(key: key);

  @override
  State<PayScreen> createState() => _PayScreenState();
}

class _PayScreenState extends State<PayScreen> {
  final CartController cart = Get.find();
  final OrderController orderController = Get.find();
  int step = 0;
  bool dropPicked = false;
  bool paid = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF006FAF),
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
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Stepper(
              currentStep: step,
              steps: [
                Step(
                  title: const Text('Pickup Location'),
                  content: Row(
                    children: [
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Center(
                            child: Text(
                              'Open Map',
                              style: TextStyle(color: Color(0xFF006FAF)),
                            ),
                          ),
                        ),
                        onTap: () {
                          // pick a drop location
                          setState(() {
                            dropPicked = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Step(
                  title: const Text('Payment Method'),
                  content: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Center(
                            child: Text(
                              'Mpesa',
                              style: TextStyle(color: Color(0xFF006FAF)),
                            ),
                          ),
                        ),
                        onTap: () {
                          // pick a drop location
                          setState(() {
                            paid = true;
                          });
                        },
                      ),
                      GestureDetector(
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 10.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: const Center(
                            child: Text(
                              'Paypal',
                              style: TextStyle(color: Color(0xFF006FAF)),
                            ),
                          ),
                        ),
                        onTap: () {
                          // pick a drop location
                          setState(() {
                            paid = true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                Step(
                  isActive: false,
                  title: const Text('Make order'),
                  content: GestureDetector(
                    child: Container(
                      width: MediaQuery.of(context).size.width * .4,
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      decoration: BoxDecoration(
                        color: Colors.greenAccent,
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      child: const Center(
                        child: Text('Order'),
                      ),
                    ),
                    onTap: () {
                      // do checkout
                      Cart c = Cart(cartItems: cart.cartItems.toList());
                      Order order = Order(items: c, pickLocation: "near you");
                      orderController.makeOrder(order);
                      cart.clearCart();
                      setState(() {});
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              ],
              onStepTapped: (int v) {
                switch (v) {
                  case 0:
                    setState(() {
                      step = v;
                    });
                    break;
                  case 1:
                    if (dropPicked) {
                      setState(() {
                        step = v;
                      });
                    }
                    break;
                  case 2:
                    if (paid) {
                      setState(() {
                        step = v;
                      });
                    }
                    break;
                  default:
                    return;
                }
              },
              onStepContinue: () {
                switch (step) {
                  case 0:
                    if (dropPicked) {
                      setState(() {
                        step += 1;
                      });
                    }
                    break;
                  case 1:
                    if (paid) {
                      setState(() {
                        step += 1;
                      });
                    }
                    break;
                  case 2:
                    break;
                  default:
                    return;
                }
              },
              onStepCancel: () {
                if (step == 0) {
                  return;
                }
                setState(() {
                  step -= 1;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
