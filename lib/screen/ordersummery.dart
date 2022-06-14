import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nebulashoppy/model/getmyorderresponse/getmyorderresponse.dart';
import 'package:nebulashoppy/model/homescreen/itemNewLaunched.dart';
import 'package:nebulashoppy/model/homescreen/itemhomecategory.dart';
import 'package:nebulashoppy/model/setmyAccount/setmyAccount.dart';
import 'package:nebulashoppy/network/service.dart';
import 'package:nebulashoppy/screen/categorylist.dart';
import 'package:nebulashoppy/screen/productdetail.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/SearchWidget.dart';
import '../model/getCartItemResponse/getCarItemResponse.dart';
import '../model/getEwallethistory/GetMyEwalletHistoryResponse.dart';
import '../model/getmyorderresponse/setmyorder.dart';
import '../model/homescreen/itembannerimage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../model/product.dart';
import '../uttils/sharedpref.dart';
import '../widget/Accountwidget.dart';
import '../widget/LoginDialoug.dart';
import '../widget/myorderwidget.dart';
import '../widget/searchitem.dart';
import '../widget/star_rating.dart';
import '../widget/trending_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

class OrderSummery extends StatefulWidget {
  String str_Title = "";
  String device_Id = "";
  String str_UserId = "";

  OrderSummery({required this.str_Title});

  @override
  State<OrderSummery> createState() => _OrderSummeryState();
}

class _OrderSummeryState extends State<OrderSummery>
    with WidgetsBindingObserver {
  List<ItemCart> _listCartItem = [];
  bool is_ShowBottomBar = false;
  bool is_ShowNoData = false;
  GetCartItemData? getCartItemData;
  String str_GrandTotal = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      widget.device_Id = DeviceId.toString();
      checkUserLoginOrNot();
      getUserId();
    });
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
            child: appBarWidget(context, 3, widget.str_Title, false)),
        body: FutureBuilder(
          future: getUserId(),
          builder: (context, snapshot) {
            if (str_UserId != null || !str_UserId.isEmpty) {
              //  getOrderSummery() ;
              return Text("data");
            } else {
              return Text("data");
            }
          },
        ));

    // This trailing comma makes auto-formatting nicer for build methods
  }

  getUserId() async {
    str_UserId = await SharedPref.readString(str_IBO_Id);
    print("UserID" + str_UserId);
  }

  void getOrderSummery() {
    Service()
        .getOrderSummery(widget.device_Id, widget.str_UserId, "1")
        .then((value) => {
              if (value.toString() == str_NoDataMsg) {setState((() {}))},
              if (value.toString() != str_ErrorMsg &&
                  value.toString() != str_NoDataMsg)
                {
                  if (value.toString() != str_NoDataMsg)
                    {
                      setState((() {
                        if (value.statusCode == 1) {
                          _listCartItem = value.data.cart;
                          getCartItemData = value.data;
                          setState(() {
                            str_GrandTotal =
                                value.data.grandTotalWithEwallet.toString();
                          });

                          is_ShowBottomBar = true;
                          print("Categorylist" + str_GrandTotal);
                        } else {
                          showSnakeBar(context, somethingWrong);
                          print("Categorylist" + "Opps Something Wrong!");
                        }
                      }))
                    }
                  else
                    {showSnakeBar(context, somethingWrong)}
                }
            });
  }
}
