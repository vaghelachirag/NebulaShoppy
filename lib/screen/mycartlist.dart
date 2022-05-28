import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/uttils/CircularProgress.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/cartitemwidget.dart';
import 'package:nebulashoppy/widget/categoryproductWidget.dart';
import 'package:page_transition/page_transition.dart';

import '../model/getCartItemResponse/getCarItemResponse.dart';
import '../model/getCartItemResponse/setcartitem.dart';
import '../model/homescreen/itemNewLaunched.dart';
import '../model/homescreen/itemhomecategory.dart';
import '../model/product.dart';
import '../network/service.dart';
import '../uttils/constant.dart';
import '../widget/trending_item.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:community_material_icon/community_material_icon.dart';

class MyCartList extends StatefulWidget {
  String device_Id = "";
  @override
  State<MyCartList> createState() => _MyCartListState();


  void addToCartMethod() {

  }
}

class _MyCartListState extends State<MyCartList> {

  List<ItemCart> _listCartItem = [];
  
  @override
  void initState() {
    super.initState();
     setState(() {
       widget.device_Id = DeviceId.toString();
    });
     getCartItemList();
  }

  final GlobalKey<_MyCartListState> _myWidgetState = GlobalKey<_MyCartListState>();

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
          child: appBarWidget(context,3,"My Cart",false)
      ),
      body: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          FutureBuilder(
            builder: (context, snapshot) {
              if (_listCartItem.isEmpty) {
                return setSkeletonCategoryList();
              } else {
                return setCategoryList(false);
                //  return setCategoryList(false);
              }
            },
          )
        ],
      ),
    );
  }

 void getCartItemList() {
    Service().getCartItemWithoutLogin(widget.device_Id, "0").then((value) => {
          setState((() {
            print("CartList" + value.statusCode.toString());
            if (value.statusCode == 1) {
              _listCartItem = value.data.cart;
               print("Categorylist" + _listCartItem.length.toString());
            } else {
              showSnakeBar(context, somethingWrong);
              print("Categorylist" + "Opps Something Wrong!");
            }
          }))
        });
  }


 
 Container setSkeletonCategoryList() {
   return Container(
      child: Flexible(
          child:         
          ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    period: Duration(milliseconds: 2000),
                    child: 
               CartItemWidget(
                product: SetCartItem(
                     id:  1,
                     productid: 1,
                     name: "Test",
                     desc: "Test",
                     icon: "Test",
                     price: "Test",
                     pv: "Test",
                     bv: "Test",
                     nv: "Test",
                     int_cartQuntity: 0,
                     ),
                gradientColors: [Colors.white, Colors.white],
              ));
            },
          ))
    );
  }
  Container setCategoryList(bool bool) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Flexible(
          child:         
          ListView.builder(
            itemCount: _listCartItem.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return CartItemWidget(
                product: SetCartItem(
                     id: _listCartItem[index].id,
                     productid: _listCartItem[index].productId,
                     name: _listCartItem[index].productName,
                     desc: _listCartItem[index].volWt.toString(),
                     icon: _listCartItem[index].mainImage,
                     price: _listCartItem[index].mrpPrice.toString(),
                     pv: _listCartItem[index].pv.toString(),
                     bv: _listCartItem[index].bv.toString(),
                     nv: _listCartItem[index].nv.toString(),
                     int_cartQuntity: _listCartItem[index].cartQuantity,
                     ),
                gradientColors: [Colors.white, Colors.white],
              );
            },
          ))
    );
  }

   Shimmer loadSkeletonLoader(Flexible skeletonbuildNewLaunch) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      period: Duration(milliseconds: 2000),
      child: skeletonbuildNewLaunch,
    );
  }

  
  void myMethodIWantToCallFromAnotherWidget() {
    print('calling myMethodIWantToCallFromAnotherWidget..');
    // actual implementation here
  }

}
