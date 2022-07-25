import 'package:flutter/material.dart';
import 'package:nebulashoppy/screen/tabscreen.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:page_transition/page_transition.dart';

class Splash extends StatefulWidget {
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final color = const Color(0xfffcfcff);

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      changeBaseURL(1);
      goToHomeScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.all(50),
        color: color,
        child: Image.asset(
          'assets/images/nebula_logo_news.gif',
          fit: BoxFit.contain,
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void goToHomeScreen() async {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (dialogContex) => TabScreen(int_Selectedtab: 0)),
        ModalRoute.withName("/tabscreen"));
  }
}
 