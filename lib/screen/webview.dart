import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nebulashoppy/model/getmyorderresponse/getmyorderresponse.dart';
import 'package:nebulashoppy/model/homescreen/itemNewLaunched.dart';
import 'package:nebulashoppy/model/homescreen/itemhomecategory.dart';
import 'package:nebulashoppy/model/setmyAccount/setmyAccount.dart';
import 'package:nebulashoppy/network/service.dart';
import 'package:nebulashoppy/screen/categorylist.dart';
import 'package:nebulashoppy/screen/productdetail.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/common_widget.dart';
import '../model/getmyorderresponse/setmyorder.dart';
import '../model/homescreen/itembannerimage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../model/product.dart';
import '../widget/Accountwidget.dart';
import '../widget/LoginDialoug.dart';
import '../widget/myorderwidget.dart';
import '../widget/searchitem.dart';
import '../widget/star_rating.dart';
import '../widget/trending_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Webview extends StatefulWidget {

  String str_Url = "";
 String str_Title = "";

 

Webview({Key? key, required this.str_Url , required this.str_Title })
      : super(key: key);
  
  @override
  State<Webview> createState() => _WebviewState();
}

class _WebviewState extends State<Webview> with WidgetsBindingObserver {
  
   bool isLoading=true;
  final _key = UniqueKey();
  @override
  void initState() {
    super.initState();
    setState(() {
      showProgressbar();
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    ScreenUtil.init(context);
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: appBarWidget(context, 3,widget.str_Title, false)),
        body: Stack(
        children: <Widget>[
          WebView(
            key: _key,
            initialUrl: widget.str_Url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
                hideProgressBar();
              });
            },
          ),
          isLoading ? showMaterialProgressbar(6)
                    : Stack(),
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}