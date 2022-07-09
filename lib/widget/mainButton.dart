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

class MainButtonWidget extends StatelessWidget {
  final VoidCallback onPress;
  String buttonText;
  MainButtonWidget({required this.onPress, required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
        child: Text(
          buttonText,
          style: TextStyle(
              fontSize: 14, fontFamily: EmberBold, color: Colors.white),
        ),
        onPressed: () {
          onPress();
        },
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          side: BorderSide(width: 3.0, color: Colors.white),
        ));
  }
}
