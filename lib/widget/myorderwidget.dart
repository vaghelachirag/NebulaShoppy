import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nebulashoppy/screen/home.dart';
import 'package:nebulashoppy/screen/myorder/myorderdetail.dart';
import 'package:nebulashoppy/widget/mainButton.dart';
import 'package:nebulashoppy/widget/star_rating.dart';

import '../model/getmyorderresponse/setmyorder.dart';
import '../model/product.dart';
import '../uttils/constant.dart';
import 'clip_shadow_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:nebulashoppy/screen/productdetail.dart';

import 'common_widget.dart';

class MyOrderWiget extends StatelessWidget {
  final SetMyOrder product;
  final List<Color> gradientColors;

  const MyOrderWiget({required this.product, required this.gradientColors});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    double rectWidth = MediaQuery.of(context).size.width;

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 4.0,right: 8.0,left: 8.0),
              child: Card(
                elevation: 5,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(0),
                        child: _productImage(context),
                      ),
                      _productDetails(context)
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        print("OnTap" + "OnTap" + product.data.orderDetails!.length.toString());
      },
    );
  }

  _productImage(BuildContext context) {
    return  Container(
          color: Colors.white,
          padding: EdgeInsets.all(5),
          width: MediaQuery.of(context).size.width / 4,
          height: MediaQuery.of(context).size.height / 8,
          child: Image.asset(
            'assets/images/order_image.png',
            fit: BoxFit.contain,
          ),
        );
  }

  _productDetails(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 10),
              child:
                  setBoldText(product.ordernumber.toString(), 14, Colors.black),
            ),
            // Text(
            //   product.ordernumber.toString(),
            //   maxLines: 1,
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            // ),
            Padding(
              padding: EdgeInsets.only(top: 8),
              child: setRegularText(product.date.toString(), 12, Colors.black),
            ),
            //     Text(
            // product.date.toString(),
            //       maxLines: 1,
            //       style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
            //     ),
            Container(
                padding: EdgeInsets.only(top: 8),
                width: MediaQuery.of(context).size.width / 2 ,
                height:  MediaQuery.of(context).size.height / 17,
                child: MainButtonWidget(
                  buttonText: "View Order",
                  onPress: () {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: MyOrderDetail(
                                ordernumber: product.ordernumber,
                                shippingAddress: product.shippingAddress,
                                billingAddress: product.billingAddress,
                                mobileNumber: product.mobileNumber,
                                subTotal: product.subTotal,
                                shippingCharge:
                                    product.shippingCharge.toString(),
                                grandTotal: product.grandTotal.toString(),
                                shippingTransectionId:
                                    product.shippingTransectionId,
                                isPickupPoint: product.isPickup,
                                billingAddressUser:
                                    product.orderbillingAddressUser,
                                shippingAddressUser:
                                    product.ordershippingAddressUser,
                                orderDetails: product.data.orderDetails,
                                status: product.data.status.toString())));
                  },
                )

                //  ElevatedButton(
                //       // style: elevatedButtonStyle(),
                //       style: buttonShapeOrderDetail(),
                //       onPressed: () async {
                //          Navigator.push(
                //   context,
                //   PageTransition(
                //     type: PageTransitionType.fade,
                //     child: MyOrderDetail(ordernumber: product.ordernumber,shippingAddress: product.shippingAddress,  billingAddress: product.billingAddress, mobileNumber: product.mobileNumber, subTotal: product.subTotal,shippingCharge: product.shippingCharge.toString(),grandTotal:product.grandTotal.toString(),shippingTransectionId: product.shippingTransectionId,isPickupPoint: product.isPickup,billingAddressUser: product.orderbillingAddressUser,shippingAddressUser: product.ordershippingAddressUser,orderDetails: product.data.orderDetails,status: product.data.status.toString(), ),
                //   ),
                // );
                //       },
                //       child: const Text(
                //         'View Order',
                //         style: TextStyle(
                //           fontSize: 18,
                //           color: Colors.white,
                //         ),
                //       ),
                //     ) ,
                )
          ],
        ));
  }
}

@override
bool shouldReclip(CustomClipper<Path> oldClipper) {
  return true;
}

class ProductImageContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.cubicTo(
        0, size.height - 20, 0, size.height, size.width - 20, size.height - 6);
    //path.cubicTo(size.width, size.height, size.width, size.width - 10, size.width, 10);
    // path.lineTo(size.width/2, 0);
    path.quadraticBezierTo(size.width, size.height, size.width - 4, 15);
    // path.quadraticBezierTo(0, 60, 40, size.height);
    // path.quadraticBezierTo(0, 60, 40, size.height);
    //path.lineTo(0, size.height);
    //path.lineTo(size.width, size.height);
    path.lineTo(size.width - 10, 10);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
