import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:nebulashoppy/uttils/CircularProgress.dart';
import 'package:nebulashoppy/uttils/helper.dart';
import 'package:page_transition/page_transition.dart';

import '../database/sQLHelper.dart';
import '../model/homescreen/itemNewLaunched.dart';
import '../model/homescreen/itemhomecategory.dart';
import '../model/product.dart';
import '../network/service.dart';
import '../uttils/skeletonloader.dart';
import '../widget/categoryproductWidget.dart';
import '../widget/soldoutdialoug.dart';
import '../widget/timelineComponent.dart';
import '../widget/trending_item.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:http/http.dart' as http;

import 'package:nebulashoppy/model/homescreen/itemNewLaunched.dart';
import 'package:nebulashoppy/model/homescreen/itembannerimage.dart';
import 'package:nebulashoppy/model/homescreen/itemhomecategory.dart';
import 'package:nebulashoppy/model/productdetail/itemproductdetail.dart';
import 'package:nebulashoppy/model/productdetail/itemproductdetailimage.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/network/EndPoint.dart';
import 'package:http/http.dart' as http;

import '../model/productdetail/productbanner.dart';
import '../model/search/SearchProduct.dart';
import 'dart:convert';
import 'dart:convert';
import 'package:http/http.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Test extends StatefulWidget {
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> with RouteAware {
  final controller = PageController(viewportFraction: 1, keepPage: true);
  @override
  void initState() {
    super.initState();
  }

  @override
  void didPush() {
    print('HomePage: Called didPush');
    super.didPush();
  }

  @override
  void didPop() {
    print('HomePage: Called didPop');
    super.didPop();
  }

  @override
  void didPopNext() {
    print('HomePage: Called didPopNext');
    super.didPopNext();
  }

  @override
  void didPushNext() {
    print('HomePage: Called didPushNext');
    super.didPushNext();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "Skeleton Loading with shimmer",
          style: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
