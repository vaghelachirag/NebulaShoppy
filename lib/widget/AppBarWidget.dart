import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:nebulashoppy/network/service.dart';
import 'package:nebulashoppy/screen/mycartlist.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:page_transition/page_transition.dart';

import '../screen/search.dart';

Widget appBarWidget(context, int i, String str_title, bool isshowCart) {
  int int_CartCount = i;
  getDeviceId();
  return AppBar(
      backgroundColor: Colors.cyan[400],
      elevation: 0.0,
      title: Text(
        str_title,
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      actions: <Widget>[
        Visibility(
          visible: isshowCart,
          child:
        IconButton(
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
          color: Colors.white,
        )),
        new 
        Visibility(
          visible: isshowCart,
          child: 
         Padding(
          padding: const EdgeInsets.all(10.0),
          child: new Container(
              height: 150.0,
              width: 30.0,
              child: new GestureDetector(
                onTap: () {
                  print("CartClick"+ "CartClick");
                   Navigator.push(
              context,
              PageTransition(
                type: PageTransitionType.rightToLeft,
                child: MyCartList(),
              ),
            );
                },
                child: new Stack(
                  children: <Widget>[
                    new IconButton(
                      icon: new Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                      onPressed: null,
                    ),
                    int_CartCounters == 0
                        ? new Container()
                        : new Positioned(
                            child: new Stack(
                            children: <Widget>[
                              new Icon(Icons.brightness_1,
                                  size: 20.0, color: Colors.red[400]),
                              new Positioned(
                                  top: 3.0,
                                  right: 3.0,
                                  left: 3.0,
                                  child: new Center(
                                    child: new Text(
                                      int_CartCounters.toString(),
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.0,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            ],
                          )),
                  ],
                ),
              ))),
        )
      ]);
}
