import 'cart.dart';

class Order {
  String id = '#order001';
  Cart items;
  int total = 0;
  bool picked = false;
  String pickLocation = '';

  Order({
    required this.items,
    required this.pickLocation,
  });
}
