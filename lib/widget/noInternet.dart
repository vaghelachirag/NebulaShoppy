import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nebulashoppy/screen/home.dart';
import '../model/product.dart';
import '../uttils/constant.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class NoInternet extends StatelessWidget {
  final VoidCallback onRetryClick;

  NoInternet({
    required this.onRetryClick
  });

  @override
  Widget build(BuildContext context) {
    return  Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:  
         Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [  
                SizedBox(
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.width / 5,
                  child: Image.asset(
                assestPath+ 'no_internet.png',
                 fit: BoxFit.contain,
                 ),
                ) ,
          Padding(padding: EdgeInsets.only(top:  ScreenUtil().setSp(20)),child:
           Text(
          "Network Error",
          style: TextStyle(fontSize: ScreenUtil().setSp(20), fontWeight: FontWeight.bold,fontFamily: EmberBold)),),
           Padding(padding: EdgeInsets.fromLTRB(20, 30, 5, 0),child:
           Text(
          "Faild to connect to NebulaPro. Please check your device's network connection.",
          style: TextStyle(fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.normal,fontFamily: EmberBold)),),          
          GestureDetector(
            onTap: () {
           onRetryClick();       
            },
            child: 
           Padding(padding: EdgeInsets.fromLTRB(20, 30, 20, 0),
           child:
           Center(
            child: 
           Text(
          "Retry",
          style: TextStyle(fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.normal,fontFamily: EmberBold,color: THEME_COLOR))),))],
          ),);
  }
}
