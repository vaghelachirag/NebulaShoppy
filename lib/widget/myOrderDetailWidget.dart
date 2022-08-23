import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nebulashoppy/screen/home.dart';
import 'package:nebulashoppy/widget/star_rating.dart';

import '../model/getmyorderresponse/setmyoderdetailitem.dart';
import '../model/product.dart';
import '../uttils/constant.dart';
import 'clip_shadow_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:nebulashoppy/screen/productdetail.dart';

class MyOrderDetailWidget extends StatelessWidget {
  final SetMyOrderDetailItem product; 
  final List<Color> gradientColors;

  const MyOrderDetailWidget({required this.gradientColors,required this.product});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
          Container(
          alignment: Alignment.topLeft,
          width: 80,
          height: 80,
          color: Colors.white,
          child: 
           FadeInImage.assetNetwork(
            width: 80,
            height: 80,
              placeholder: placeholder_path,
              image: product.productimage.toString(),
              fit: BoxFit.contain),
        ),
        _productDetails(),
        Visibility(
          visible: product.qunatity == "0",
          child:   Expanded(child: Align(
            alignment: Alignment.topRight,
            child:  Visibility(child:  cancelText()),
          )))
      
        
         
     ],
          )
         
        ],
      ),
      onTap: () {
        
      },
    );
  }

  
  _productDetails() {
    return Padding(
        padding: EdgeInsets.only(left: 0),
        child:
        Align(
          alignment: Alignment.topLeft,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            setBoldText(product.productname.toString(), 16, Colors.black),          
            Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
            child: 
            setRegularText(rupees_Sybol+  product.price.toString(), 14, Colors.red) ,)
          ,
           Padding(padding: EdgeInsets.only(top: 10),
            child: 
            setRegularText("Quantity:" + " "+product.qunatity.toString(), 14, Colors.black)
              ,)
          ,
          
          ],
        ) ,
        )
         );
  }

  cancelText() {
     return  Align(
              alignment: Alignment.topRight,
              child: 
              setBoldText("Cancelled", 16, Colors.red),
            );
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
