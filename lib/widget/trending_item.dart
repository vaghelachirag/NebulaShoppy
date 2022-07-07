import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nebulashoppy/screen/home.dart';
import 'package:nebulashoppy/widget/star_rating.dart';

import '../model/product.dart';
import '../screen/productdetail.dart';
import '../uttils/constant.dart';
import 'clip_shadow_path.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:page_transition/page_transition.dart';

class TrendingItem extends StatelessWidget {
  final Product product;
  final List<Color> gradientColors;

  const TrendingItem({required this.product, required this.gradientColors});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    double rectWidth = 95;
    double rectHeight = 26;
    double trendCardWidth = MediaQuery.of(context).size.width / 3;

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Container(
            width: trendCardWidth,
            height: MediaQuery.of(context).size.height / 4,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: GestureDetector(
                  onTap: () {
                    print("NewLaunch" + "New Launch");
                    Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.fade,
                          child: ProductDetail(
                            id: product.id,
                            productid: product.productid,
                            categoryid: product.catid,
                          ),
                        ));
                  },
                  child: Card(
                    elevation: 0,
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              if (product.remainingQuantity != null) Spacer(),
                              Icon(
                                Icons.favorite_border,
                                color: Color(0XFFd0d0d0),
                              )
                            ],
                          ),
                          _productImage(),
                          _productDetails()
                        ],
                      ),
                    ),
                  )),
            ),
          ),
        ],
      ),
      onTap: () {},
    );
  }

  _productImage() {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: ProductImageContainerClipper(),
          child: Container(
            width: 100,
            height: 70,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: gradientColors)),
          ),
        ),
        Center(
          child: Container(
            width: 100,
            height: 80,
            child: FadeInImage.assetNetwork(
                placeholder: placeholder_path,
                image: product.icon,
                fit: BoxFit.contain),
          ),
        )
      ],
    );
  }

  _productDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        // Text(
        //   product.company,
        //   maxLines: 1,
        //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        // ),
        setBoldText(product.company, 14, Colors.black),
        // setRegularText( product.name, 12, Colors.black, FontWeight.normal),
        Text(
          product.name,
          maxLines: 1,
          style: TextStyle(
              fontWeight: FontWeight.normal, fontSize: 12, fontFamily: Ember),
        ),
        StarRating(rating: product.rating, size: 12),
        Row(
          children: <Widget>[
            setBoldText(product.price, 12, Colors.red),
            Text(
              product.mrp,
              style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontFamily: EmberItalic,
                  decoration: TextDecoration.lineThrough),
            )
          ],
        )
      ],
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
