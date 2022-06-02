import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nebulashoppy/model/homescreen/itemNewLaunched.dart';
import 'package:nebulashoppy/model/homescreen/itemhomecategory.dart';
import 'package:nebulashoppy/network/service.dart';
import 'package:nebulashoppy/screen/categorylist.dart';
import 'package:nebulashoppy/screen/productdetail.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/SearchWidget.dart';
import '../model/homescreen/itembannerimage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../model/product.dart';
import '../widget/LoginDialoug.dart';
import '../widget/star_rating.dart';
import '../widget/trending_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_info_plus/device_info_plus.dart';

class Account extends StatefulWidget {
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> with WidgetsBindingObserver {

 
  @override
  void initState() {
    super.initState();
    checkUserLoginOrNotSession();
    
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    ScreenUtil.init(context);
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: appBarWidget(context, 3, "Product detail", false)),
      body:  
      FutureBuilder(
        future: checkUserLoginOrNot(),
        builder: (context, snapshot) {
         if(!is_Login){
           return Text("Login");
         }
         else{
           return Container(
              child: Text("data"),
           );
         }
      },));
         
  }
 void openCheckoutDialoug() {
    if(!is_Login){
    showDialog(
        barrierColor: Colors.black26,
        context: context,
        builder: (context) {
          return LoginDialoug(
            context,
            title: "SoldOut",
            description:
                "This product may not be available at the selected address.",
          );
        },
      );
    }
    else{
      showSnakeBar(context, "Checkout");
    }
   
  }

  void checkUserLoginOrNotSession() async{
    checkUserLoginOrNot();
    showDialog(
        barrierColor: Colors.black26,
        context: context,
        builder: (context) {
          return LoginDialoug(
            context,
            title: "SoldOut",
            description:
                "This product may not be available at the selected address.",
          );
        },
      );
    print("CheckUser"+is_Login.toString());
  }

}
