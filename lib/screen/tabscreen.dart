import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nebulashoppy/model/homescreen/itemNewLaunched.dart';
import 'package:nebulashoppy/model/homescreen/itemhomecategory.dart';
import 'package:nebulashoppy/model/recentItemResponse/setRecentItem.dart';
import 'package:nebulashoppy/network/service.dart';
import 'package:nebulashoppy/screen/categorylist.dart';
import 'package:nebulashoppy/screen/productdetail.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/SearchWidget.dart';
import 'package:nebulashoppy/widget/common_widget.dart';
import '../database/sQLHelper.dart';
import '../model/homescreen/itembannerimage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../model/product.dart';
import '../uttils/skeletonloader.dart';
import '../widget/star_rating.dart';
import '../widget/trending_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'account.dart';
import 'home.dart';
import 'myorder/myorderlist.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int int_tablength = 1;
  int _selectedScreenIndex = 0;

  final List _screensWithLogin = [
    {"screen": Home(), "title": "Screen A Title"},
    {"screen": MyOrderList(), "title": "Screen B Title"},
    {"screen": Account(), "title": "Screen B Title"}
  ];

  final List _screensWithoutLogin = [
    {"screen": Home(), "title": "Screen A Title"},
    {"screen": Account(), "title": "Screen B Title"},
  ];

  @override
  void initState() {
    super.initState();
    checkUserLoginOrNot();

    if (is_Login) {
      int_tablength = 2;
    } else {
      int_tablength = 3;
    }
  }

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: FutureBuilder(
          future: checkUserLoginOrNot(),
          builder: (context, snapshot) {
            if (is_Login) {
              return Scaffold(
                body: _screensWithLogin[_selectedScreenIndex]["screen"],
                bottomNavigationBar: _createBottomNavigationBarLogin(),
               
              );
            } else {
              return Scaffold(
                body: _screensWithoutLogin[_selectedScreenIndex]["screen"],
                bottomNavigationBar:_createBottomNavigationBarWithoutLogin(),
              );
            }
          },
        ),
        onWillPop: onWillPop);
  }

  Future<bool> onWillPop() {
    print("BackPress" + "Backpress");
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      showBackPressAlert(context);
      return Future.value(false);
    }
    return Future.value(true);
  }

  Widget _createBottomNavigationBarLogin() {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff87dae0), Color(0xff9ce3d3)],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            tileMode: TileMode.clamp,
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          unselectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(color: Colors.black),
          selectedItemColor: Colors.black,
          currentIndex: _selectedScreenIndex,
          onTap: _selectScreen,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.shippingFast), label: 'My Order'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.user), label: 'Account')
          ],
        ));
  }


  Widget _createBottomNavigationBarWithoutLogin() {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff87dae0), Color(0xff9ce3d3)],
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            tileMode: TileMode.clamp,
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          type: BottomNavigationBarType.fixed,
          elevation: 0,
          unselectedItemColor: Colors.white,
          selectedIconTheme: IconThemeData(color: Colors.black),
          selectedItemColor: Colors.black,
          currentIndex: _selectedScreenIndex,
          onTap: _selectScreen,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
                icon: Icon(FontAwesomeIcons.user), label: 'Account')
          ],
        ));
  }
}
