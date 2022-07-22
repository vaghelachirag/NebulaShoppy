import 'package:flutter/material.dart';

class CartCounter extends ChangeNotifier {
  CartCounter() {
    notifyListeners();
  }

  int getCartQuantity() {
    int total = 0;
    return total;
  }
}
