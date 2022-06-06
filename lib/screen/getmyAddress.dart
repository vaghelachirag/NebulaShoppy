import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/uttils/CircularProgress.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/categoryproductWidget.dart';
import 'package:page_transition/page_transition.dart';

import '../model/homescreen/itemNewLaunched.dart';
import '../model/homescreen/itemhomecategory.dart';
import '../model/product.dart';
import '../network/service.dart';
import '../uttils/constant.dart';
import '../widget/trending_item.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:community_material_icon/community_material_icon.dart';

class GetMyAddress extends StatefulWidget {
  int position, id;
  GetMyAddress({Key? key, required this.position, required this.id})
      : super(key: key);
  @override
  State<GetMyAddress> createState() => _GetMyAddressState();
}

class _GetMyAddressState extends State<GetMyAddress>
    with WidgetsBindingObserver {
 
  final GlobalKey<State> _dialogKey = GlobalKey<State>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
  
  }

  @override
  void dispose() {
    // Remove the observer
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // These are the callbacks
    switch (state) {
      case AppLifecycleState.resumed:
        // widget is resumed
        print("Activity" + "Resume");

        break;
      case AppLifecycleState.inactive:
        print("Activity" + "Inactive");
        // widget is inactive
        break;
      case AppLifecycleState.paused:
        print("Activity" + "Paused");
        // widget is paused
        break;
      case AppLifecycleState.detached:
        print("Activity" + "Detached");
        // widget is detached
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: appBarWidget(context, 3, "Product List", true)),
      body: Text("Test"),
    );
  }

  
}
