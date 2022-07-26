import 'package:flutter/material.dart';

class CartCounter extends ChangeNotifier {
  int total = 0;
  double getCartTotal() {
    double price = 0;
    notifyListeners();
    return price;
  }

  int getCartQuantity() {
    return total;
  }

  addItemToCart() {
    total = 2;
    print("Add" + "Add Item In Cart");
    notifyListeners();
  }
}
