import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:nebulashoppy/model/getmyorderresponse/setmyoderdetailitem.dart';
import 'package:nebulashoppy/model/getstateResponse.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/uttils/CircularProgress.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/categoryproductWidget.dart';
import 'package:nebulashoppy/widget/common_widget.dart';
import 'package:page_transition/page_transition.dart';

import '../../model/getMyAddressResponse/getMyAddressResponse.dart';
import '../../model/getmyorderresponse/getmyorderresponse.dart';
import '../../model/homescreen/itemNewLaunched.dart';
import '../../model/homescreen/itemhomecategory.dart';
import '../../model/product.dart';
import '../../network/service.dart';
import '../../uttils/constant.dart';
import '../../widget/myOrderDetailWidget.dart';
import '../../widget/timelineComponent.dart';
import '../../widget/trending_item.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:community_material_icon/community_material_icon.dart';

class MyOrderDetail extends StatefulWidget {
  String? ordernumber;
  String? shippingAddress;
  String? billingAddress;
  String? mobileNumber;
  final String? subTotal;
  final String? shippingCharge;
  final String? grandTotal;
  final String? shippingTransectionId;
  final int? isPickupPoint;
  final String? shippingAddressUser;
  final String? billingAddressUser;
  final String? status;

  List<OrderDetail>? orderDetails = [];
  int int_orderDeviveryStatus = 0;

  MyOrderDetail(
      {Key? key,
      required this.ordernumber,
      required this.shippingAddress,
      required this.billingAddress,
      required this.mobileNumber,
      required this.subTotal,
      required this.shippingCharge,
      required this.grandTotal,
      required this.shippingTransectionId,
      required this.isPickupPoint,
      required this.shippingAddressUser,
      required this.billingAddressUser,
      required this.orderDetails,
      required this.status})
      : super(key: key);

  @override
  State<MyOrderDetail> createState() => _MyOrderDetailState();
}

class _MyOrderDetailState extends State<MyOrderDetail>
    with WidgetsBindingObserver {
  final GlobalKey<State> _dialogKey = GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    print("Test" + widget.status.toString());
    if (widget.status.toString() == 'DatumStatus.PROCESSING') {
      setState(() {
        widget.int_orderDeviveryStatus = 1;
      });
    }
    if (widget.status.toString() == 'DatumStatus.DELIVERED') {
      setState(() {
        widget.int_orderDeviveryStatus = 3;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: appBarWidget(context, 3, "Order Summary", false)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                            alignment: Alignment.topLeft,
                            child: setBoldText('Order ID', 14, Colors.black)),
                        Align(
                            alignment: Alignment.topRight,
                            child: setRegularText(
                                widget.ordernumber.toString(), 14, Colors.blue))
                      ],
                    ),
                  ),
                  dividerLine(),
                  TotalText("Total", "SubTotal", widget.subTotal.toString()),
                  TotalText(
                      "", "Shipping Charges", widget.shippingCharge.toString()),
                  TotalText("", "Grand Total", widget.grandTotal.toString()),
                  dividerLine(),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: setBoldText('Payment', 14, Colors.black)
                        //setHeaderText('Payment',14)
                        ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: setRegularText(
                            "Transaction ID:" +
                                " " +
                                widget.ordernumber.toString(),
                            12,
                            Colors.grey)),
                  ),
                  dividerLine(),
                  FutureBuilder(
                    builder: (context, snapshot) {
                      if (widget.isPickupPoint == 0) {
                        return setPickupLocation();
                      } else {
                        return setPickupLocation();
                      }
                    },
                  ),
                  dividerLine(),
                  getOderDetail(),
                  orderStatus(),
                  dividerLine(),
                  needHelpContainer(),
                  Container(
                    margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    padding: const EdgeInsets.all(1.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black45)),
                    child: SizedBox(
                      height: 40,
                      child: _productDetails(context),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Visibility orderStatus() {
    return Visibility(
        visible: widget.orderDetails![0].quantity.toString() != "0",
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Align(
            alignment: Alignment.center,
            child: TimelineComponet(ticks: widget.int_orderDeviveryStatus),
          ),
        ));
  }

  Container needHelpContainer() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: setBoldText("Need help with this order?", 16, Colors.black)
              // setHeaderText("Need help with this order?", 20) ,
              )
        ],
      ),
    );
  }

  Column setPickupLocation() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Align(
              alignment: Alignment.topLeft,
              child: setBoldText('Pickup Location', 14, Colors.black)
              //setHeaderText('Pickup Location',14)
              ),
        ),
        setPickupLocationText(widget.billingAddressUser.toString()),
        setPickupLocationText(widget.billingAddress.toString()),
        setPickupLocationText("Mobile: " + widget.mobileNumber.toString())
      ],
    );
  }

  Column setShippingLocation() {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.all(10),
          child: Align(
              alignment: Alignment.topLeft,
              child: setHeaderText('Shipping Detail', 14)),
        ),
        setPickupLocationText(widget.billingAddressUser.toString()),
        setPickupLocationText(widget.billingAddress.toString()),
        setPickupLocationText("Mobile: " + widget.mobileNumber.toString())
      ],
    );
  }

  Padding setPickupLocationText(String str_Data) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
      child: Align(
          alignment: Alignment.topLeft,
          child: setRegularText(str_Data, 14, Colors.black45)
          // Text(str_Data,style: TextStyle(fontSize: 14),)
          ),
    );
  }

  Visibility getOderDetail() {
    return Visibility(
        child: Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: ListView.builder(
        itemCount: widget.orderDetails!.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return GestureDetector(
            child: MyOrderDetailWidget(
                gradientColors: [Colors.white, Colors.white],
                product: SetMyOrderDetailItem(
                    id: 1,
                    productimage: widget.orderDetails?[index].imageUrl,
                    productname: widget.orderDetails?[index].productName,
                    price: widget.orderDetails?[index].price.toString(),
                    qunatity: widget.orderDetails?[index].quantity.toString(),
                    is_Cancelled: widget.orderDetails![index].isCancellable)),
          );
          ;
        },
      ),
    ));
  }

  Padding dividerLine() {
    return Padding(padding: EdgeInsets.only(top: 10), child: divider(context));
  }

  Padding TotalText(String title, String subheader, String str_data) {
    return Padding(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: setBoldText(title, 14, Colors.black)),
          Align(
              alignment: Alignment.topRight,
              child: setRegularText(subheader, 14, Colors.grey)
              // Text(subheader,style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold,fontSize: 14))

              ),
          Align(
              alignment: Alignment.topRight,
              child: setRegularText(str_data, 14, Colors.red)
              //  Text(str_data,style: TextStyle(color: Colors.red, fontWeight: FontWeight.normal,fontSize: 14))

              )
        ],
      ),
    );
  }

  TextField getAddressText(String hint) {
    return TextField(
      decoration: addressText(hint),
      onChanged: (value) {
        // do something
      },
    );
  }

  TextField getDropDownn(String hint) {
    return TextField(
      enabled: false,
      decoration: inputwithdropdown(hint),
      onChanged: (value) {
        // do something
      },
    );
  }

  _productDetails(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            setRegularText("Raise an issue", 16, Colors.black54),
            // Text(
            // "Raise an issue",
            //   maxLines: 1,
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            // ),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(CommunityMaterialIcons.arrow_right))
                ],
              ),
            )
          ],
        ));
  }
}
