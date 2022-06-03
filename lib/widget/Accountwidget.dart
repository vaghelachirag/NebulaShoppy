import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nebulashoppy/screen/getmyEWalletHistory.dart';
import 'package:nebulashoppy/screen/home.dart';
import 'package:nebulashoppy/widget/star_rating.dart';

import '../model/getmyorderresponse/setmyorder.dart';
import '../model/product.dart';
import '../model/setmyAccount/setmyAccount.dart';
import '../network/service.dart';
import '../screen/webview.dart';
import '../uttils/constant.dart';
import 'clip_shadow_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:nebulashoppy/screen/productdetail.dart';

import 'common_widget.dart';
import 'package:community_material_icon/community_material_icon.dart';

class AccountWiget extends StatelessWidget {

  String about = 'https://shop.nebulacare.in/Home/About';
  String returnpolicy = 'https://shop.nebulacare.in/Home/ReturnPolicy';
  String shipping = 'https://shop.nebulacare.in/Home/ShippingPolicy';
  String privacy = 'https://shop.nebulacare.in/Home/PrivacyPolicy';
  String contactus = 'https://shop.nebulacare.in/Home/Contact';

  final SetMyAccount product;
  final List<Color> gradientColors;

    final VoidCallback onProfileClicked;


  AccountWiget({
    required this.product,
    required this.gradientColors,
    required this.onProfileClicked
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    double rectWidth = MediaQuery.of(context).size.width;

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            padding: const EdgeInsets.all(1.0),
            decoration:
                BoxDecoration(border: Border.all(color: Colors.black45)),
            child: _productDetails(context),
          ),
        ],
      ),
      onTap: () {
       openAccountData(product.postition,context);
      },
    );
  }

   void openAccountData(int index, BuildContext context) {
      print("OnTap" + "Test");
    if (index == 0) {
    
    }
    if (index == 1) {
     onProfileClicked();
    }
    if (index == 2) {
        onEWalletClick(context);
    }
    if (index == 3) {
      openWebview(context,about,"About Us");
    }
    if (index == 4) {
      openWebview(context,returnpolicy,"Return Policy");
    }

    if (index == 5) {
       openWebview(context,shipping,"Shipping Policy");
    }
    if (index == 6) {
       openWebview(context,privacy,"Privacy Policy");
    }
    if (index == 7) {
       openWebview(context,contactus,"Contact Us");
    }
  }
void openWebview(BuildContext context, String about,String  title) {
     Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: Webview(
                          str_Title: title,
                          str_Url: about,
                        ),
                      ));
  }

  _productDetails(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(left: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              product.Title,
              maxLines: 1,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Row(
                children: [
                  Visibility(
                      visible: product.is_Ewallet,
                      child: Text(
                        rupees_Sybol + "0.0",
                        style: TextStyle(color: Colors.green, fontSize: 12),
                      )),
                  IconButton(
                      onPressed: () {
                         openAccountData(product.postition,context);
                      },
                      icon: Icon(CommunityMaterialIcons.arrow_right))
                ],
              ),
            )
          ],
        ));
  }

  void onEWalletClick(BuildContext context) {
      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: GetMyEWalletHistory(
                            str_Title: "E-Wallet",
                            str_Url: "fdf",
                          ),
                        ));
  }

 
}

@override
bool shouldReclip(CustomClipper<Path> oldClipper) {
  return true;
}

class ProductImageContainerClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.moveTo(size.width / 2, 0);
    path.cubicTo(
        0, size.height - 20, 0, size.height, size.width - 20, size.height - 6);
    //path.cubicTo(size.width, size.height, size.width, size.width - 10, size.width, 10);
    // path.lineTo(size.width/2, 0);
    path.quadraticBezierTo(size.width, size.height, size.width - 4, 15);
    // path.quadraticBezierTo(0, 60, 40, size.height);
    // path.quadraticBezierTo(0, 60, 40, size.height);
    //path.lineTo(0, size.height);
    //path.lineTo(size.width, size.height);
    path.lineTo(size.width - 10, 10);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
