import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nebulashoppy/screen/account.dart';
import 'package:nebulashoppy/screen/categorylist.dart';
import 'package:nebulashoppy/screen/home.dart';
import 'package:nebulashoppy/screen/mycartlist.dart';
import 'package:nebulashoppy/screen/myorder/myorderlist.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/screen/tabscreen.dart';
import 'package:nebulashoppy/screen/test.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/BottomNavBarWidget.dart';
import 'package:nebulashoppy/widget/BottomNavBarWidgetLogin.dart';
import 'network/service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    checkUserLoginOrNot();
    return MaterialApp(
      home: TabScreen(),
      theme: ThemeData(
          fontFamily: 'Roboto',
          primaryColor: Colors.white,
          primaryColorDark: Colors.white,
          backgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
    );
  }
}

int currentIndex = 1;

void navigateToScreens(int index) {
  currentIndex = index;
}
