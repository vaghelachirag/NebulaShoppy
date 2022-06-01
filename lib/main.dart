import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nebulashoppy/screen/ShoppingCart.dart';
import 'package:nebulashoppy/screen/categorylist.dart';
import 'package:nebulashoppy/screen/home.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/screen/test.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/BottomNavBarWidget.dart';
import 'package:nebulashoppy/widget/BottomNavBarWidgetLogin.dart';

import 'network/service.dart';

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
   
  @override
  void initState() {
    super.initState();
    checkUserLoginOrNot();

    if(is_Login){
      int_tablength = 2;
    }
    else{
        int_tablength = 3;
    }
  }
    
  final List<Widget> viewContainer = [
    Search(),
    Home(),
    Home(),
  ];

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
       future: checkUserLoginOrNot(),
       builder: (context, snapshot) {
      if(is_Login){
      return DefaultTabController(
      length: 3,
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: viewContainer,
        ),
        bottomNavigationBar: BottomNavBarWidget(),
      ),
    );
    }else{
   return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: viewContainer,
        ),
        bottomNavigationBar: BottomNavBarWidgetLogin(),
      ),
    );
    }
    },);
  
  }
}
