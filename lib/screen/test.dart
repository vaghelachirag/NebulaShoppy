import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:nebulashoppy/main.dart';
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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Test extends StatefulWidget {
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> with RouteAware {
 late  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  late AndroidNotificationChannel channel;
     
  @override
  void initState() {
    super.initState();
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = new IOSInitializationSettings();
    var initSetttings = new InitializationSettings();
    flutterLocalNotificationsPlugin.initialize(initSetttings);
  }
  
  Future onSelectNotification(String payload) async {
    debugPrint("payload : $payload");
    showDialog(
      context: context,
      builder: (_) => new AlertDialog(
        title: new Text('Notification'),
        content: new Text('$payload'),
      ),
    );
  }


 @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter Local Notification'),
      ),
      body: new Center(
        child: new RaisedButton(
          onPressed:() {
          //  showlocalNotification(flutterLocalNotificationsPlugin);
          },
          child: new Text(
            'Demo'
          ),
        ),
      ),
    );
  }

// showLocaNotification() async {
//  print("Click"+"Click");
//  AndroidNotificationChannel   channel = const AndroidNotificationChannel(
//     'nebulashoppy', // id
//     'Nebula Shoppy', // title
//     importance: Importance.high,
//     enableLights: true,
//     enableVibration: true,
//     showBadge: true,
//    );

//     flutterLocalNotificationsPlugin.show(
//      2,
//      "test",
//       "test",
//       NotificationDetails(
//           android: AndroidNotificationDetails(
//         channel.id,
//         channel.name,
//         icon: '@mipmap/ic_launcher',
//         importance: Importance.max,
//         priority: Priority.high,
//         playSound: true,
//       )),
//     );
//   }

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

 