import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:nebulashoppy/uttils/CircularProgress.dart';
import 'package:page_transition/page_transition.dart';

import '../model/homescreen/itemNewLaunched.dart';
import '../model/homescreen/itemhomecategory.dart';
import '../model/product.dart';
import '../network/service.dart';
import '../widget/categoryproductWidget.dart';
import '../widget/soldoutdialoug.dart';
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

class Test extends StatefulWidget {
  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  final controller = PageController(viewportFraction: 1, keepPage: true);
  @override
  void initState() {
    super.initState();
    getProductDetailImage();
  }

  @override
  Widget build(BuildContext context) {
   return Scaffold(
      body: Center(
        child: MaterialButton(
          color: Theme.of(context).primaryColor,
          onPressed: () {
            showNoProduct();
            
          },
          child: Text("Click Button"),
        ),
      ),
    );
  }

  void getProductDetailImage() async {
    final response = await http.get(Uri.parse(BASE_URL +
        WS_GET_PRODUCT_DETAILS_IMAGE +
        "?" +
        "EComProductDetailsId=" +
        "31"));
    dynamic myjson = json.decode(response.body.toString());
    List<dynamic> imagedata = myjson["Data"];

    print("ResponseCode" + imagedata.toString());
  }

  void showNoProduct() {
    showDialog(
              barrierColor: Colors.black26,
              context: context,
              builder: (context) {
                return SoldOutDialoug(
                  title: "Soldout",
                  description: "This product may not be available at the selected address.",
                );
              },
            );
  }
}

final colors = const [
  Colors.red,
  Colors.green,
  Colors.greenAccent,
  Colors.amberAccent,
  Colors.blue,
  Colors.amber,
];
