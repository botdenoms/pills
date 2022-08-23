import 'package:get/get.dart';
import 'package:pills/models/order.dart';

class OrderController extends GetxController {
  RxList<Order> orderItems = <Order>[].obs;

  makeOrder(Order order) {
    orderItems.add(order);
  }
}
