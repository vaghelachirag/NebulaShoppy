import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nebulashoppy/model/getmyorderresponse/getmyorderresponse.dart';
import 'package:nebulashoppy/model/homescreen/itemNewLaunched.dart';
import 'package:nebulashoppy/model/homescreen/itemhomecategory.dart';
import 'package:nebulashoppy/network/service.dart';
import 'package:nebulashoppy/screen/categorylist.dart';
import 'package:nebulashoppy/screen/productdetail.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/uttils/skeletonloader.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/SearchWidget.dart';
import 'package:nebulashoppy/widget/common_widget.dart';
import '../../model/getmyorderresponse/setmyorder.dart';
import '../../model/homescreen/itembannerimage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../../model/product.dart';
import '../../widget/LoginDialoug.dart';
import '../../widget/myorderwidget.dart';
import '../../widget/noInternet.dart';
import '../../widget/searchitem.dart';
import '../../widget/star_rating.dart';
import '../../widget/trending_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:intl/intl.dart';

class MyOrderList extends StatefulWidget {
  @override
  State<MyOrderList> createState() => _MyOrderListState();
}

class _MyOrderListState extends State<MyOrderList> with WidgetsBindingObserver {
  bool bl_showNoData = false;
  List<GetMyOrderData> _orderList = [];
  List<String> _orderDate = [];
  String string_Date = "";
  @override
  void initState() {
    super.initState();
    isConnectedToInternet();
    getMyOrderList();
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
          preferredSize: const Size.fromHeight(int_AppBarWidth),
          child: appBarWidget(context, 3, "Order List", false)),
      body: is_InternetConnected == false ? NoInternet(onRetryClick: () {
         onRetryClick();
        },) :
       Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (_orderList.isEmpty) {
                return loadSkeletonLoaders(boxOrderList(), Axis.vertical);
              } else {
                return ListView.builder(
                  itemCount: _orderList.length,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        print("GetMyOderDatat" + _orderList[index].toString());
                      },
                      child: FutureBuilder(
                        future: getformatedDate(_orderList[index].orderDate),
                        builder: (context, snapshot) {
                          return MyOrderWiget(
                            product: SetMyOrder(
                                id: 1,
                                date: _orderDate[index],
                                ordernumber: _orderList[index].orderNumber,
                                shippingAddress:
                                    _orderList[index].shippingAddresses,
                                billingAddress:
                                    _orderList[index].billingAddresses,
                                subTotal: _orderList[index].subTotal.toString(),
                                shippingCharge: _orderList[index]
                                    .shippingCharges
                                    .toString(),
                                grandTotal:
                                    _orderList[index].grandTotal.toString(),
                                shippingTransectionId:
                                    _orderList[index].transactionId.toString(),
                                isPickup: _orderList[index].isPickUpPoint,
                                data: _orderList[index],
                                orderbillingAddressUser: _orderList[index]
                                    .billingAddressUser
                                    .toString(),
                                ordershippingAddressUser: _orderList[index]
                                    .shippingAddressUser
                                    .toString(),
                                mobileNumber:
                                    _orderList[index].mobileNo.toString(),
                                status: _orderList[index].status.toString()),
                            gradientColors: [Colors.white, Colors.white],
                          );
                        },
                      ),
                    );
                    ;
                  },
                );
              }
            },
          )),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Shimmer loadSkeletonLoader(Column skeletonbuildNewLaunch) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      period: Duration(milliseconds: 2000),
      child: skeletonbuildNewLaunch,
    );
  }

  Column skeletonbuildNewLaunch() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  showSnakeBar(context, "Click");
                },
                child: SearchItem(
                  product: Product(
                      id: 1,
                      productid: 1,
                      catid: 1,
                      company: "Test",
                      name: "Test",
                      icon: "Test",
                      rating: 5,
                      remainingQuantity: 5,
                      price: "Test",
                      mrp: "Test",
                      qunatity: 1),
                  gradientColors: [Colors.white, Colors.white],
                ),
              );
              ;
            },
          ),
        )
      ],
    );
  }

  void getMyOrderList() async {
    Service().getMyOrderList().then((value) => {
          setState((() {
            if (value.statusCode == 1) {
              _orderList = value.data;
              bl_showNoData = false;
            } else {
              bl_showNoData = true;
              showSnakeBar(context, "Opps! Something Wrong");
            }
          }))
        });
  }

  getformatedDate(int orderDate) async {
    var date =
        new DateTime.fromMillisecondsSinceEpoch(orderDate * 1000, isUtc: false);
    var timezone = date.timeZoneName;
    final DateFormat formatter = DateFormat('dd-MMMM-yyyy (hh:mm a)');
    var dates = formatter.format(date.toUtc()) + "GMT-0";
    print("OrderDare" + dates.toString());
     string_Date = formatter.format(date);
      _orderDate.add(string_Date);
  }

  void onRetryClick() {
     setState(() {
        isConnectedToInternet();
      });
  }
}
