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
    notifyListeners();
    return total;
  }

   int addItemInCart() {
    total = total + 1;
    int_CartCounters = total;
    notifyListeners();
    return total;
  }

  
   int removeItemFromCart() {
    if(total > 0){
     total = total - 1;
    int_CartCounters = total;
    notifyListeners();
    return total;
    }
    else{    
      return total;
    }
   
  }
}
