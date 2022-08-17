import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nebulashoppy/model/getCartItemResponse/getCarItemResponse.dart';
import 'package:nebulashoppy/model/homescreen/itemNewLaunched.dart';
import 'package:nebulashoppy/model/homescreen/itemhomecategory.dart';
import 'package:nebulashoppy/model/productAvailalibilityModel.dart';
import 'package:nebulashoppy/model/productdetail/itemProductColorsVariant.dart';
import 'package:nebulashoppy/model/productdetail/itemproductdetail.dart';
import 'package:nebulashoppy/model/productdetail/itemproductdetailimage.dart';
import 'package:nebulashoppy/model/productdetail/itemproductvariant.dart';
import 'package:nebulashoppy/model/productdetail/productbanner.dart';
import 'package:nebulashoppy/network/service.dart';
import 'package:nebulashoppy/screen/categorylist.dart';
import 'package:nebulashoppy/screen/home.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/uttils/sliderShowFullmageswidget.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/dotted_slider.dart';
import '../database/sQLHelper.dart';
import '../model/homescreen/itembannerimage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../model/product.dart';
import '../widget/cartCounter.dart';
import '../widget/common_widget.dart';
import '../widget/productAvailability.dart';
import '../widget/soldoutdialoug.dart';
import '../widget/star_rating.dart';
import '../widget/trending_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductAvailability extends StatefulWidget {
  List<dynamic> listOutOfStock = [];

  ProductAvailability({Key? key, required this.listOutOfStock,})
      : super(key: key);

  @override
  State<ProductAvailability> createState() => _ProductAvailabilityState();
}

class _ProductAvailabilityState extends State<ProductAvailability> {
   
  @override
  void initState() {
    super.initState();
    print("List"+  widget.listOutOfStock[0]['Id'].toString());

  }
  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(int_AppBarWidth),
          child: appBarWidget(context, 3, "Availability Check", false)),
          body: SingleChildScrollView(
            child: setProductAvailability() ,
          )
         ,
    );
  }
  Container setProductAvailability(){
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
              onPressed: () {},
              icon: IconButton(
                icon: Icon(CommunityMaterialIcons.information_outline),
                onPressed: () {},
                color: buttonColor,
              )),
              Container(
                width: MediaQuery.of(context).size.width - 50,
                child: Text( "Few items from your cart are not available. We regret the inconvenience.", maxLines: 2,  style: TextStyle(color:buttonColor,fontSize: 14,),),
              ),
            ],
          ),
            buildProductAvailablity()       
        ],
      ),
    );
  }

Column  buildProductAvailablity() {

  return  Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.listOutOfStock.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () { },
                child: ProductAvailabilityItem(
                  product: ProductAvailabilityModel(
                    id: widget.listOutOfStock[0]['Id'],
                    catid: widget.listOutOfStock[0]['Id'],
                    name: widget.listOutOfStock[0]['ProductName'],
                    icon: widget.listOutOfStock[0]['MainImage'],
                    company: widget.listOutOfStock[0]['ProductName'],
                    productid: widget.listOutOfStock[0]['Id'],
                    qunatity: 1,
                    remainingQuantity: 1
                  ),
                  gradientColors: [Colors.white, Colors.white],
                  int_width: MediaQuery.of(context).size.width / 4,
                ),
              );
              ;
            },
          ),
        )
      ],
    );
}

}
