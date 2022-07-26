import 'package:flutter/material.dart';

class CartCounter extends ChangeNotifier {
  int total = 0;
  CartCounter() {
    notifyListeners();
  }

  int getCartQuantity() {
    return total;
  }

  int setCartCountity(int int_Counter) {
    total = int_Counter;
    notifyListeners();
    return total;
  }
}
