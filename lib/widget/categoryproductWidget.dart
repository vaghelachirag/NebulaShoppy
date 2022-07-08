import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nebulashoppy/screen/home.dart';
import 'package:nebulashoppy/widget/AddToCart.dart';
import 'package:nebulashoppy/widget/star_rating.dart';
import '../model/product.dart';
import '../uttils/constant.dart';
import 'clip_shadow_path.dart';
import 'package:page_transition/page_transition.dart';
import 'package:nebulashoppy/screen/productdetail.dart';
import 'package:nebulashoppy/screen/categorylist.dart';

class CategoryProductWidget extends StatelessWidget {
  final Product product;
  final List<Color> gradientColors;

  final VoidCallback onCartRemovedClick;
  final VoidCallback onCartAddClick;
  final Function(int) onCountChanges;

  CategoryProductWidget({
    required this.product,
    required this.gradientColors,
    required this.onCartRemovedClick,
    required this.onCartAddClick,
    required this.onCountChanges,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0.0),
              child: Card(
                elevation: 0,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          if (product.remainingQuantity != null) Spacer()
                        ],
                      ),
                      Padding(padding: EdgeInsets.all(5),child:  _productImage(context),),
                      _productDetails(),
                      setProductDetails()
                      //  Container(
                      //   padding: EdgeInsets.all(5),
                      //   child: GestureDetector(
                      //     child: addtoCart(),
                      //     onTap: (){
                      //       onCartAddClick();
                      //     },
                      //   ),
                      // ),
                      
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      onTap: () {},
    );
  }

  _productImage(BuildContext context) {
    return Stack(
      children: <Widget>[
        ClipPath(
          clipper: ProductImageContainerClipper(),
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: gradientColors)),
          ),
        ),
        Center(
            child: Material(
          color: Colors.white,
          child: InkWell(
            onLongPress: () {
              print("Image" + "Image");
              showAlertDialog(context, product.icon);
            },
            onTap: () {
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
            child: Container(
              width: 100,
              height: 80,
              child: FadeInImage.assetNetwork(
                  placeholder: placeholder_path,
                  image: product.icon,
                  fit: BoxFit.contain),
            ),
          ),
        ))
      ],
    );
  }

  _productDetails() {
    return Padding(
      padding: EdgeInsets.only(left: 8,right: 8),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            //setTextData(product.company, 16),
            setBoldText(product.company, 16, Colors.black),
            //setRegularText(product.name, 12, Colors.black),
            Padding(padding: EdgeInsets.only(top: 3),child:setRegularText(product.name, 12,Colors.black),),
            // Row(
            //   children: <Widget>[
            //     setBoldText(rupees_Sybol + product.price, 16,Colors.red),
            //     // Text(rupees_Sybol + product.price,
            //     //     style: TextStyle(
            //     //         fontSize: 16,
            //     //         fontWeight: FontWeight.bold,
            //     //         color: Colors.red)),
            //     Text(
            //       rupees_Sybol + product.mrp,
            //       style: TextStyle(
            //           color: Colors.grey,
            //           fontSize: 12,
            //           fontFamily: Ember,
            //           decoration: TextDecoration.lineThrough),
            //     ),
            //   ],
            // ),
          ]),
    );
  }

  setProductDetails() {
    return Flexible(
        flex: 1, child:  Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child:  setProductPrice(product),
                    )
                   ,
                    Container(
                        padding: EdgeInsets.all(5),
                        child: GestureDetector(
                           child: addtoCart(),
                           onTap: (){
                             onCartAddClick();
                           },
                         ),
                       ),
                  ],
                ));
  }
}
Column setProductPrice(Product product){
  return Column(
    children: [
         Container(
         padding: EdgeInsets.only(left: 8,top: 10,right: 8),
                      child: Flexible(
                      flex: 5,
                      child: setBoldText(rupees_Sybol + product.price, 14,Colors.red),),),
                      Flexible(
                      flex: 5,
                      child:  Text(
                  rupees_Sybol + product.mrp,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 10,
                      fontFamily: Ember,
                      decoration: TextDecoration.lineThrough),
                  ),)
    ],
  );
}
Container addtoCart() {
  return Container(
    decoration:  BoxDecoration(
    border: Border.all(
      color: THEME_COLOR,
    ),
    color:  THEME_COLOR,
    borderRadius: BorderRadius.all(Radius.circular(5))
  ),
    child:  
     
    Container(
        padding: EdgeInsets.fromLTRB(10, 5, 8, 5),
        child: Text(
          'ADD',
           style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontStyle: FontStyle.normal,
              fontWeight: FontWeight.bold),
        ),
    ),
  );
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

showAlertDialog(BuildContext context, String icon) {
  // set up the button
  Widget okButton = FlatButton(
    child: Text(
      "Close",
      style: TextStyle(
          color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
    ),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(""),
    content: Image(image: NetworkImage(icon)),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Container setTextData(String text, double i) {
  return Container(
      padding: EdgeInsets.only(left: 2),
      child: 
      
      Text(
        text,
        maxLines: 1,
        style: TextStyle(fontSize: i, fontWeight: FontWeight.normal),
      ));
}
