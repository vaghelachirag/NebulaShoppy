import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nebulashoppy/network/service.dart';
import 'package:nebulashoppy/screen/home.dart';
import 'package:nebulashoppy/screen/mycartlist.dart';
import 'package:nebulashoppy/widget/AddToCart.dart';
import 'package:nebulashoppy/widget/star_rating.dart';
import '../model/getCartItemResponse/setcartitem.dart';
import '../model/product.dart';
import '../uttils/constant.dart';
import 'clip_shadow_path.dart';
import 'package:page_transition/page_transition.dart';
import 'package:nebulashoppy/screen/productdetail.dart';
import 'package:nebulashoppy/screen/categorylist.dart';
import 'package:nebulashoppy/screen/mycartlist.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemWidget extends StatelessWidget {
  final SetCartItem product;
  final List<Color> gradientColors;
  final double itemWidth = 0.0;
  final Function(int) onItemRemovedClick;

  final VoidCallback onCartRemovedClick;
  final VoidCallback onCartAddClick;
  final Function(int) onCountChanges;

  CartItemWidget({
    required this.product,
    required this.gradientColors,
    required this.onItemRemovedClick,
    required this.onCartRemovedClick,
    required this.onCartAddClick,
    required this.onCountChanges,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
            width: MediaQuery.of(context).size.width,
            child: Card(
                elevation: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 0.0),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  _productImage(context),
                                  _productDetails(context),
                                  // Container(
                                  //   alignment: Alignment.topRight,
                                  //   width: MediaQuery.of(context).size.width / 6,
                                  //   child: Align(
                                  //     alignment: Alignment.topRight,
                                  //     child: IconButton(
                                  //         onPressed: () {
                                  //           print("Delete" + "Delete");
                                  //           onItemRemovedClick(product.productid);
                                  //         },
                                  //         icon: Icon(CommunityMaterialIcons.delete)),
                                  //   ),
                                  // )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topRight,
                      width: MediaQuery.of(context).size.width / 6,
                      child: Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                            onPressed: () {
                              print("Delete" + "Delete");
                              onItemRemovedClick(product.productid);
                            },
                            icon: Icon(CommunityMaterialIcons.delete)),
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
      onTap: () {},
    );
  }

  _productImage(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: ProductImageContainerClipper(),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: gradientColors)),
          ),
        ),
        Center(
            child: Material(
          color: Colors.white,
          child: InkWell(
            onLongPress: () {
              print("Image" + "Image");
              showAlertDialog(context, product.icon);
            },
            onTap: () {
              Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: ProductDetail(
                      id: product.id,
                      productid: product.productid,
                      categoryid: product.productid,
                    ),
                  ));
            },
            child: Container(
              width: MediaQuery.of(context).size.width / 5,
              height: ScreenUtil().setSp(100),
              child: FadeInImage.assetNetwork(
                  placeholder: placeholder_path,
                  image: product.icon,
                  fit: BoxFit.contain),
            ),
          ),
        ))
      ],
    );
  }

  _productDetails(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width - 200,
        child: Padding(
            padding: EdgeInsets.only(left: 5),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    setRegularText(product.name, 16, Colors.black),
                    // setTextData(product.name, 16),
                    Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: setRegularText(product.desc, 14, Colors.green)),
                    Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: setProductPrice(product)),
                    Padding(
                        padding: EdgeInsets.only(top: 5),
                        child: setPvNv(product)),
                    Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Container(
                          child: AddToCart(
                            count: product.int_cartQuntity,
                            onItemAdd: () {
                              print("Add TO Cart");
                              onCartAddClick();
                            },
                            onItemRemoved: () {
                              print("Cart" + "Removed inner");
                              onCartRemovedClick();
                            },
                            onCountChanged: (int) {},
                          ),
                        )),
                  ]),
            )));
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

showAlertDialog(BuildContext context, String icon) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text(
      "Close",
      style: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(""),
    content: Image(image: NetworkImage(icon)),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Container setTextData(String text, double i) {
  return Container(
      padding: EdgeInsets.only(left: 2),
      child: Text(
        text,
        maxLines: 1,
        style: TextStyle(fontSize: i, fontWeight: FontWeight.bold),
      ));
}

Row setProductPrice(SetCartItem product) {
  return Row(
    children: <Widget>[
      setRegularText(rupees_Sybol  + removeDecimalAmount(product.price) , 16, priceColor)
    ],
  );
}

Row setPvNv(SetCartItem product) {
  return Row(
    children: <Widget>[
      setBoldText("PV", 14, Colors.black),
      // Text(
      //   "PV",
      //   style: TextStyle(
      //       fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
      // ),
      Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
        child: setRegularText(removeDecimalAmount(product.pv) , 14, pvtextBg),
      ),
      setBoldText("NV", 14, Colors.black),
      // Text(
      //   "NV",
      //   style: TextStyle(
      //       fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black),
      // ),

      Padding(
        padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
        child: setRegularText(removeDecimalAmount(product.nv) , 14, pvtextBg),
      ),
      setBoldText("BV", 14, Colors.black),
      Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          child: setRegularText(removeDecimalAmount(product.bv) + "%", 14, pvtextBg))
      // Text(
      //   product.bv + "%",
      //   style: TextStyle(
      //       fontSize: 12,
      //       fontWeight: FontWeight.normal,
      //       color: Colors.black),
      // ))
    ],
  );
}
