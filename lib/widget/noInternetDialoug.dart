import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/services.dart';
import 'package:nebulashoppy/uttils/sharedpref.dart';
import 'package:nebulashoppy/widget/common_widget.dart';
import '../model/getcartCountResponse/getAddToCartResponse.dart';
import '../network/service.dart';
import '../uttils/constant.dart';
import 'package:page_transition/page_transition.dart';
import '../uttils/constant.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoInternetDialoug extends StatefulWidget {
   final VoidCallback onRetryClick;

  const NoInternetDialoug(
    BuildContext context, {
    Key? key,
    required this.title,
    required this.description,
    required this.onRetryClick
  }) : super(key: key);

  final String title, description;

  @override
  _NoInternetDialougState createState() => _NoInternetDialougState();
}

class _NoInternetDialougState extends State<NoInternetDialoug> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  static final _formKey = GlobalKey<FormState>();

  bool _passwordInVisible = true;
  final GlobalKey<State> _dialogKey = GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    hideProgressBar();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Container(
        height: MediaQuery.of(context).size.height / 4,
        child: 
         Column(
              children: [     
              IconButton(
            icon: const Icon(Icons.signal_wifi_connected_no_internet_4,size: 30,color: THEME_COLOR,),
            tooltip: 'Source Code',
            onPressed: () {
            
            },
          ),
          Padding(padding: EdgeInsets.only(top:  ScreenUtil().setSp(5)),child:
           Text(
          "Network Error",
          style: TextStyle(fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.bold,fontFamily: EmberBold)),),
           Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 0),child:
           Text(
          "Faild to connect to NebulaPro. Please check your device's network connection.",
          style: TextStyle(fontSize: ScreenUtil().setSp(14), fontWeight: FontWeight.normal,fontFamily: EmberBold)),),          
          GestureDetector(
            onTap: () {
            widget.onRetryClick();       
            },
            child: 
           Padding(padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
           child:
           Center(
            child: 
            ElevatedButton(
                // style: elevatedButtonStyle(),
                style: buttonOK(),
                onPressed: () async {
                 Navigator.pop(context);
                },
                child: const Text(
                  'Ok',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),)))],
          )),
    );
  }
}
