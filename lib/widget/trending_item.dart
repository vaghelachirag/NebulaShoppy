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

  final VoidCallback onBackPressClicked;

  const TrendingItem(
      {required this.product,
      required this.gradientColors,
      required this.onBackPressClicked});

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

                    // Navigator.push(
                    //     context,
                    //     PageTransition(
                    //       type: PageTransitionType.fade,
                    //       child: ProductDetail(
                    //         id: product.id,
                    //         productid: product.productid,
                    //         categoryid: product.catid,
                    //       ),
                    //     ));

                    goToProductDetail(context);
                  },
                  child: Card(
                    elevation: 5,
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
        Padding(
            padding: EdgeInsets.only(top: 3),
            child: setRegularText(product.company, 14, Colors.black)),
        // setRegularText( product.name, 12, Colors.black, FontWeight.normal),
        Padding(
          padding: EdgeInsets.only(top: 3),
          child: Text(
            product.name,
            maxLines: 1,
            style: TextStyle(
                fontWeight: FontWeight.normal, fontSize: 10, fontFamily: Ember),
          ),
        ),
        // StarRating(rating: product.rating, size: 12),
        Padding(
            padding: EdgeInsets.only(top: 3),
            child: Row(
              children: <Widget>[
                setBoldText(removeDecimalAmount(product.price), 14, priceColor),
                Padding(
                    padding: EdgeInsets.only(left: 3),
                    child: Text(
                     removeDecimalAmount(product.mrp),
                      style: TextStyle(
                          color: productPriceBg,
                          fontSize: 12,
                          fontFamily: EmberItalic,
                          decoration: TextDecoration.lineThrough),
                    ))
              ],
            ))
      ],
    );
  }

  void goToProductDetail(BuildContext context) async {
    var push_ProductDetail = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => ProductDetail(
        id: product.id,
        productid: product.productid,
        categoryid: product.catid,
      ),
    ));

    if (push_ProductDetail == null || push_ProductDetail == true) {
      print("Back" + "Product Back");
      onBackPressClicked();
    }
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
