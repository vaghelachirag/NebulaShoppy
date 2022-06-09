import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nebulashoppy/screen/ShoppingCart.dart';
import 'package:nebulashoppy/screen/account.dart';
import 'package:nebulashoppy/screen/categorylist.dart';
import 'package:nebulashoppy/screen/home.dart';
import 'package:nebulashoppy/screen/mycartlist.dart';
import 'package:nebulashoppy/screen/myorder/myorderlist.dart';
import 'package:nebulashoppy/screen/search.dart';
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
      home: MyHomePage(),
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

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageNewState createState() => _MyHomePageNewState();
}

class _MyHomePageNewState extends State<MyHomePage> {
  int int_tablength = 1;
  int _selectedScreenIndex = 0;

  final List _screensWithLogin = [
    {"screen": Home(), "title": "Screen A Title"},
    {"screen": Test(), "title": "Screen B Title"},
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
    return  WillPopScope(child:  FutureBuilder(
      future: checkUserLoginOrNot(),
      builder: (context, snapshot) {
        if (is_Login) {
          return Scaffold(
            body: _screensWithLogin[_selectedScreenIndex]["screen"],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.cyan[400],
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              currentIndex: _selectedScreenIndex,
              onTap: _selectScreen,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.shippingFast),
                    label: 'My Order'),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.user), label: 'Account')
              ],
            ),
          );
        } else {
          return Scaffold(
            body: _screensWithoutLogin[_selectedScreenIndex]["screen"],
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.cyan[400],
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.white,
              currentIndex: _selectedScreenIndex,
              onTap: _selectScreen,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(FontAwesomeIcons.user), label: 'Account')
              ],
            ),
          );
        }
      },
    ), onWillPop: onWillPop);
    
   
  }

   Future<bool> onWillPop() {
    print("BackPress"+"Backpress");
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || 
        now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
     showBackPressAlert(context);
      return Future.value(false);
    }
    return Future.value(true);
  }
}
