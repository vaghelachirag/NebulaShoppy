import 'package:flutter/material.dart';
import 'package:nebulashoppy/uttils/constant.dart';

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
   // print("Total" + total.toString());
    notifyListeners();
    return total;
  }

  int addItemInCart() {
    total = total + 1;
    int_CartCounters = total;
   // print("Total" + total.toString());
    notifyListeners();
    return total;
  }

  int removeItemFromCart() {
    if (total > 0) {
      total = total - 1;
      int_CartCounters = total;
    //  print("Total" + total.toString());
      notifyListeners();
      return total;
    } else {
      return total;
    }
  }

  setLoginTrue(){
    
  }

  setCartZero(){
     total = 0;
      int_CartCounters = total;
    //  print("Total" + total.toString());
      notifyListeners();
  }
}