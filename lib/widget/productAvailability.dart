import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nebulashoppy/screen/home.dart';
import 'package:nebulashoppy/widget/star_rating.dart';

import '../model/product.dart';
import '../model/productAvailalibilityModel.dart';
import '../uttils/constant.dart';
import 'clip_shadow_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';
import 'package:nebulashoppy/screen/productdetail.dart';

class ProductAvailabilityItem extends StatelessWidget {
  final ProductAvailabilityModel product;
  final List<Color> gradientColors;
  final double int_width;

  // ignore: non_constant_identifier_names
  const ProductAvailabilityItem(
      {required this.product,
      required this.gradientColors,
      required this.int_width});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    double rectWidth = MediaQuery.of(context).size.width;
    double trendCardWidth = ScreenUtil().setHeight(160);

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Card(
                elevation: 5,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Row(
                    children: <Widget>[_productImage(context), _productDetails()],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: () {
        print("Search" + "SearchClick");
        Navigator.push(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: ProductDetail(
                id: product.id,
                productid: product.productid,
                categoryid: product.catid,
                product: product,
              ),
            ));
      },
    );
  }

  _productImage(BuildContext context){
    return Container(
     width: MediaQuery.of(context).size.width / 3,
     height: MediaQuery.of(context).size.height / 6,
     child: Stack(children: <Widget>[
       Container(
                  width:  MediaQuery.of(context).size.width / 3,
                    height:  MediaQuery.of(context).size.height / 6,
                    child: FadeInImage.assetNetwork(
                        placeholder: placeholder_path,
                        image: product.icon,
                        fit: BoxFit.contain)),
                        Center(
                          child:  Container(
                        
                             padding: EdgeInsets.all(10),
                            color: Colors.grey[300],
                            child: setBoldText("OUT OF STOCK", 12, Colors.red) 
                          ),
                        )                 
     ]),
    );
  }

  _productDetails() {
    return Padding(
        padding: EdgeInsets.only(left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Text(
            //   product.company,
            //   maxLines: 1,
            //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            // ),
            setRegularText(product.company, 16, Colors.black),
            FutureBuilder(builder: (context, snapshot) {
              if(product.remainingQuantity > 1){
                return  Padding(
                padding: EdgeInsets.only(top: 5),
                child: setRegularText(product.remainingQuantity.toString() + " items out of stock", 12, Colors.black));
              }
              else{
                return Padding(
                padding: EdgeInsets.only(top: 5),
                child: setRegularText(product.remainingQuantity.toString() + " item out of stock", 12, Colors.black));
              }
            },)
           ,
            // Text(
            //   product.name,
            //   maxLines: 1,
            //   style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
            // ),
            //  StarRating(rating: product.rating, size: 10),
          ],
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
