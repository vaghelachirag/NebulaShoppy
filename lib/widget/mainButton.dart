import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nebulashoppy/screen/address/getmyAddress.dart';
import 'package:nebulashoppy/screen/getmyEWalletHistory.dart';
import 'package:nebulashoppy/screen/home.dart';
import 'package:nebulashoppy/widget/star_rating.dart';

import '../model/getmyorderresponse/setmyorder.dart';
import '../model/product.dart';
import '../model/setmyAccount/setmyAccount.dart';
import '../network/service.dart';
import '../screen/webview.dart';
import '../uttils/constant.dart';
import 'LoginDialoug.dart';
import 'clip_shadow_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:nebulashoppy/screen/productdetail.dart';

import 'common_widget.dart';
import 'package:community_material_icon/community_material_icon.dart';

class MainButtonWidget extends StatefulWidget {
  final VoidCallback onPress;
  String buttonText;
  
  MainButtonWidget({required this.onPress, required this.buttonText});

    @override
  _MainButtonWidgetState createState() => _MainButtonWidgetState();
 
}
class _MainButtonWidgetState extends State<MainButtonWidget> with SingleTickerProviderStateMixin  {
  late double _scale;
  late AnimationController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 500,
      ),
      lowerBound: 0.0,
      upperBound: 0.1,
    )..addListener(() {
      setState(() {});
    });
  }
  @override
  Widget build(BuildContext context) {
     _scale = 1 - _controller.value;
    return GestureDetector(
      onTapDown: _tapDown,
      onTapUp: _tapUp,
      child:  Transform.scale(
                  scale: _scale,
                  child: _animatedButton(),
                ),
    );
    
   
  }

  Widget  _animatedButton() {
    return  OutlinedButton(
        child: Text(
          widget.buttonText,
          style: TextStyle(
              fontSize: 14, fontFamily: Ember, color: Colors.black),
        ),
        onPressed: () {
          widget.onPress();
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
          backgroundColor: buttonColor,
          side: BorderSide(width: 1, color: buttonBorderCOlor),
        ));
  }

  void _tapDown(TapDownDetails details) {
    _controller.forward();
  }

  void _tapUp(TapUpDetails details) {
    _controller.reverse();
  }
}
