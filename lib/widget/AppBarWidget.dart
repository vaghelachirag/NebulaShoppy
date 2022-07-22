import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:nebulashoppy/network/service.dart';
import 'package:nebulashoppy/screen/mycartlist.dart';
import 'package:nebulashoppy/screen/test.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:page_transition/page_transition.dart';
import 'package:badges/badges.dart';

import '../screen/search.dart';

Widget appBarWidget(context, int i, String str_title, bool isshowCart) {
  return AppBar(
      iconTheme: IconThemeData(color: Colors.black),
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [Color(0xff87dae0), Color(0xff9ce3d3)])),
      ),
      backgroundColor: Colors.cyan[400],
      elevation: 0.0,
      title: Text(
        str_title,
        style:
            TextStyle(color: Colors.black, fontSize: 16, fontFamily: EmberBold),
      ),
      actions: <Widget>[
        //  Image.asset("assets/images/search_icon.png"),
        Visibility(
            visible: isshowCart,
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeft,
                    child: Search(),
                  ),
                );
              },
              icon: IconButton(
                icon: Icon(CommunityMaterialIcons.magnify),
                onPressed: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: Search(),
                    ),
                  );
                },
              ),
              color: Colors.black,
            )),
        Visibility(
          visible: isshowCart,
          child: QTYCounter(isshowCart),
        )
      ]);
}

class QTYCounter extends StatefulWidget {
  const QTYCounter(bool isshowCart, {Key? key}) : super(key: key);

  @override
  State<QTYCounter> createState() => _QTYCounterState();
}

class _QTYCounterState extends State<QTYCounter> {
  String device_Id = "";
  static bool bl_IsShow = false;

  final GlobalKey<State> _dialogKey = GlobalKey<State>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDeviceId();
    checkUserLoginOrNot();
    getCartCounter();
  }

  @override
  Widget build(BuildContext context) {
    // getUserID();
    setState(() {});
    return Container(
      margin: EdgeInsets.only(top: 3),
      child: Stack(
        children: <Widget>[
          Padding(
              padding: const EdgeInsets.all(15.0),
              child: new Container(
                  height: 150.0,
                  width: 30.0,
                  child: new GestureDetector(
                    onTap: () {
                      print("CartClick" + "CartClick");
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: MyCartList(),
                        ),
                      );
                    },
                    child: Badge(
                      animationType: BadgeAnimationType.fade,
                      badgeContent: Text(
                        QTYCount,
                        style: TextStyle(
                            fontSize: 10,
                            fontFamily: Ember,
                            color: Colors.white),
                      ),
                      child: Icon(Icons.shopping_cart_outlined),
                    ),
                    // child: new Stack(
                    //   children: <Widget>[
                    //     new IconButton(
                    //       icon: new Icon(
                    //         Icons.shopping_cart,
                    //         color: Colors.black,
                    //       ),
                    //       onPressed: null,
                    //     ),
                    //     new Positioned(
                    //         child: new Stack(
                    //       children: <Widget>[
                    //         new Icon(Icons.brightness_1,
                    //             size: 22.0, color: Colors.red[400]),
                    //         new Positioned(
                    //             top: 3.0,
                    //             right: 3.0,
                    //             left: 3.0,
                    //             child: new Center(
                    //               child: new Text(
                    //                 QTYCount,
                    //                 style: new TextStyle(
                    //                     color: Colors.white,
                    //                     fontSize: 10.0,
                    //                     fontWeight: FontWeight.w500),
                    //               ),
                    //             )),
                    //       ],
                    //     )),
                    //   ],
                    // ),
                  ))),
        ],
      ),
    );
  }

  void getCartCounter() {
    setState(() {
      device_Id = DeviceId.toString();
    });

    Future.delayed(Duration(seconds: 0), () {
      print("IsLogin" + is_Login.toString());
      if (!is_Login) {
        Service().getCartCount(DeviceId.toString(), "").then((value) => {
              setState(() {
                int_CartCounters = value.data!.sumOfQty;
                QTYCount = value.data!.sumOfQty.toString();
              })
            });
      } else {
        getUserId();
      }
    });

    Future.delayed(Duration(seconds: 0), () {
      print("IsLogin" + str_UserId.toString());
      Service()
          .getCartCount(DeviceId.toString(), str_UserId.toString())
          .then((value) => {
                setState(() {
                  int_CartCounters = value.data!.sumOfQty;
                  QTYCount = value.data!.sumOfQty.toString();
                })
              });
    });
  }
}
