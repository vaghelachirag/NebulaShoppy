import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:nebulashoppy/uttils/CircularProgress.dart';
import 'package:nebulashoppy/uttils/helper.dart';
import 'package:page_transition/page_transition.dart';

import '../database/sQLHelper.dart';
import '../model/homescreen/itemNewLaunched.dart';
import '../model/homescreen/itemhomecategory.dart';
import '../model/product.dart';
import '../network/service.dart';
import '../uttils/skeletonloader.dart';
import '../widget/categoryproductWidget.dart';
import '../widget/soldoutdialoug.dart';
import '../widget/timelineComponent.dart';
import '../widget/trending_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

import 'package:nebulashoppy/model/homescreen/itemNewLaunched.dart';
import 'package:nebulashoppy/model/homescreen/itembannerimage.dart';
import 'package:nebulashoppy/model/homescreen/itemhomecategory.dart';
import 'package:nebulashoppy/model/productdetail/itemproductdetail.dart';
import 'package:nebulashoppy/model/productdetail/itemproductdetailimage.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/network/EndPoint.dart';
import 'package:http/http.dart' as http;

import '../model/productdetail/productbanner.dart';
import '../model/search/SearchProduct.dart';
import 'dart:convert';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:payumoney_pro_unofficial/payumoney_pro_unofficial.dart';


class Test extends StatefulWidget {
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> with RouteAware {
  final controller = PageController(viewportFraction: 1, keepPage: true);
    bool isReadmore= false;

     var scrollController = ScrollController();
     
  @override
  void initState() {
    super.initState();
   
  }


  
  @override
  void didPush() {
    print('HomePage: Called didPush');
    super.didPush();
  }

  @override
  void didPop() {
    print('HomePage: Called didPop');
    super.didPop();
  }

  @override
  void didPopNext() {
    print('HomePage: Called didPopNext');
    super.didPopNext();
  }

  @override
  void didPushNext() {
    print('HomePage: Called didPushNext');
    super.didPushNext();
  }
 @override
  Widget build(BuildContext context) {
   return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Payu Money Flutter'),
        ),
       body: Center(
          child: ElevatedButton(
            child: Text("Make Payment"),
            onPressed: () async {
              // // Every Transaction should have a unique ID. I am using timestamp as transactionid. Because its always unique :)
              String orderId = DateTime.now().millisecondsSinceEpoch.toString();
              // Amount is in rs. Enter 100 for Rs100.
              final String amount = "1";

              // Phone Number should be 10 digits. Please validate it before passing else it will throw error.
              // hashUrl is required. check github documentation for nodejs code.
              var response = await PayumoneyProUnofficial.payUParams(
                  email: 'vaghelacd99@gmail.com',
                  firstName: "chirag vaghela",
                  merchantName: 'chirag',
                  isProduction: true,
                  merchantKey:
                      '0w2qzK', //You will find these details from payumoney dashboard
                  merchantSalt: 'Oa3o6OCxGvidPIIxnP2tlZ7Wq9z1VEpU',
                  amount: '1.00',
                  productInfo: 'iPhone 12', // Enter Product Name
                  transactionId:
                      orderId, //Every Transaction should have a unique ID
                  hashUrl: '',
                  userCredentials: '0w2qzK:tvaghelacd99@gmail.com',
                  showLogs: true,
                  userPhoneNumber: '9999999999');
              // handling success response
              if (response['status'] == PayUParams.success)
                handlePaymentSuccess(amount);
              // handling failure response
              if (response['status'] == PayUParams.failed)
                handlePaymentFailure(amount, response['message']);
            },
          ),
        ),
      ),
    );

  }

  // Function to implement business login on payment success
  handlePaymentSuccess(String amount) {
    print("Success");
    // Implement your logic here for successful payment.
  }

// Function to implement business login on payment failure
  handlePaymentFailure(String amount, String error) {
    print("Failed");
    print(error);
    // Implement your logic here for failed payment.
  }
}
 
  void startPayment() async {
  
  }
