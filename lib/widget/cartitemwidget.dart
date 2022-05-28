import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nebulashoppy/screen/home.dart';
import 'package:nebulashoppy/screen/mycartlist.dart';
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

class CartItemWidget extends StatelessWidget {
  final SetCartItem product;
  final List<Color> gradientColors;
  final  double itemWidth = 0.0; 

  const CartItemWidget(
      {required this.product, required this.gradientColors});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Card(
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                        _productImage(context),
                        _productDetails(context),
                        Container(
                        alignment: Alignment.topRight,
                         width: MediaQuery.of(context).size.width/6,
                         child:  Align(
                          alignment: Alignment.topRight,
                          child:  IconButton(onPressed: () {                        
                        }, icon:  Icon(CommunityMaterialIcons.delete)),
                        ) ,
                        )
                                            
                        ],
                      ),
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: () {},
    );
  }

  _productImage(BuildContext context) {
    return 
    Stack(
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
              width: 100,
              height: 80,
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
    return 
    Container(
      width: MediaQuery.of(context).size.width - 200,
     child: 
    Padding(
      padding: EdgeInsets.only(left: 15),
      child: Padding(padding: EdgeInsets.all(10),child: 
       Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            setTextData(product.name, 16),
            Padding(padding: EdgeInsets.only(top: 5),child:  setTextData(product.desc, 12)),
            Padding(padding: EdgeInsets.only(top: 5),child:   setProductPrice(product)),
            Padding(padding: EdgeInsets.only(top: 5),child:   setPvNv(product)), 
            Padding(padding: EdgeInsets.only(top: 10),child:  setProductCounter(product)),           
            
          ]),
    )
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
Container setProductCounter(SetCartItem product){
  return   Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                    
                     
                    },
                    child:  Container(
                    child: Padding(
                      padding: EdgeInsets.all(0),
                      child: CircleAvatar(
                        backgroundColor: Colors.cyan,
                        maxRadius: 15,
                        child: Text(
                          "-",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  ),
                  Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),child: Align(
                    alignment: Alignment.center,
                    child: Text(
                     product.int_cartQuntity.toString(),
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ) ,)
                 ,
                  Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(0),
                          child: CircleAvatar(
                            backgroundColor: Colors.cyan,
                            maxRadius: 15,
                            child: Text(
                              "+",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),
                        ),
                      ))
                ],
              ),
            );
}

Row setProductPrice(SetCartItem product){
  return   Row(
              children: <Widget>[
                Text( rupees_Sybol +" "+ product.price,
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.red))
              ],
            );
}
Row setPvNv(SetCartItem product){
  return  Row(
              children: <Widget>[
                Text( "PV",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),),
                         Padding(padding: EdgeInsets.fromLTRB(5, 0, 10, 0),
                         child: 
                         Text(product.pv,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),),),
                     Text( "NV",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),),
                         Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                         child: 
                         Text(product.nv,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),)),                       
                      Text( "BV",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),),
                         Padding(padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                         child: 
                         Text(product.bv + "%",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: Colors.black),))
              ],
            );
}
