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

  void addToCartMethod() {}
}

class _MyCartListState extends State<MyCartList> {
  List<ItemCart> _listCartItem = [];
  bool is_ShowBottomBar = false;
  bool is_ShowNoData = false;
  GetCartItemData? getCartItemData;

  String str_GrandTotal = "";
  final GlobalKey<State> _dialogKey = GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    setState(() {
      widget.device_Id = DeviceId.toString();
      bl_ShowCart = false;
    });
    getCartItemList();
  }

  final GlobalKey<_MyCartListState> _myWidgetState =
      GlobalKey<_MyCartListState>();

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
          child: appBarWidget(context, 3, "My Cart", false)),
      bottomNavigationBar:
          Visibility(visible: is_ShowBottomBar, child: bottomBar()),
      body: is_ShowNoData == true ? noDataFound() : getMyCartData(),
    );
  }

  Container noDataFound() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Center(
            child: Text(
          "No Data Found!",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        )));
  }

  SingleChildScrollView getMyCartData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
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
          FutureBuilder(builder: (context, snapshot) {
            if (_listCartItem.isEmpty) {
              return Text("");
            } else {
              return Card(
                margin: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(10),
                      width: MediaQuery.of(context).size.width,
                      child: Text(
                        "Order Detail",
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    divider(context),
                    getMycartDetail(
                        "MRP", getCartItemData?.calculatedMrp.toString()),
                    getMycartDetail("Your Retail Price",
                        getCartItemData?.retailProfit.toString()),
                    getMycartDetail(
                        "SubTotal", getCartItemData?.subTotal.toString()),
                    getMycartDetail("Shipping Charges",
                        getCartItemData?.shippingCharge.toString()),
                    divider(context),
                    getMycartDetail(
                        "Grand Total", getCartItemData?.grandTotal.toString()),
                  ],
                ),
              );
            }
          }),
          FutureBuilder(
            builder: (context, snapshot) {
              if (_listCartItem.isEmpty) {
                return Text("");
              } else {
                return Card(
                  shape: RoundedRectangleBorder(
                    side: new BorderSide(color: Colors.black, width: 0.5),
                  ),
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(10),
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Pv and NV generated on this order",
                          style: TextStyle(color: Colors.black, fontSize: 16),
                        ),
                      ),
                      divider(context),
                      getPVNVDetail("PV", getCartItemData?.totalNv.toString()),
                      Container(
                          color: Colors.grey[300],
                          child: getPVNVDetail(
                              "NV", getCartItemData?.totalBv.toString()))
                    ],
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }

  Container divider(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      height: 0.5,
    );
  }

  Container getMycartDetail(String title, String? detail) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              rupees_Sybol + detail.toString(),
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 14,
                  color: Colors.red),
            ),
          )
        ],
      ),
    );
  }

  Container getPVNVDetail(String title, String? detail) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Text(
              detail!,
              style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.blue),
            ),
          )
        ],
      ),
    );
  }

  void getCartItemList() {
    is_ShowBottomBar = false;
    Service().getCartItemWithoutLogin(widget.device_Id, "0").then((value) => {
          print("CartList" + value.toString()),
          if (value.toString() == str_NoDataMsg)
            {
              setState((() {
                is_ShowNoData = true;
              }))
            },
          if (value.toString() != str_ErrorMsg &&
              value.toString() != str_NoDataMsg)
            {
              if (value.toString() != str_NoDataMsg)
                {
                  setState((() {
                    print("CartList" + value.toString());
                    if (value.statusCode == 1) {
                      _listCartItem = value.data.cart;
                      getCartItemData = value.data;
                      setState(() {
                        str_GrandTotal = value.data.grandTotal.toString();
                      });

                      is_ShowBottomBar = true;
                      print("Categorylist" + _listCartItem.length.toString());
                    } else {
                      showSnakeBar(context, somethingWrong);
                      print("Categorylist" + "Opps Something Wrong!");
                    }
                  }))
                }
              else
                {showSnakeBar(context, somethingWrong)}
            }
        });
  }

  Container setSkeletonCategoryList() {
    return Container(
        child: Flexible(
            child: ListView.builder(
      itemCount: 10,
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.white,
            period: Duration(milliseconds: 2000),
            child: CartItemWidget(
              product: SetCartItem(
                id: 1,
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
              onItemRemovedClick: (int) {},
              onCountChanges: (int) {},
              onCartRemovedClick: () {},
              onCartAddClick: () {},
            ));
      },
    )));
  }

  Column setCategoryList(bool bool) {
    return Column(
      children: [
        Container(
            width: MediaQuery.of(context).size.width,
            child: ListView.builder(
              itemCount: _listCartItem.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
                  onItemRemovedClick: (int) {
                    print("ItemRemovedIt" + int.toString());
                    showLoadingDialog(context, _dialogKey, "Please Wait..");
                    callMethodRemoveItemFromCart(int);
                  },
                  onCountChanges: (int) {},
                  onCartAddClick: () {},
                  onCartRemovedClick: () {},
                );
              },
            ))
      ],
    );
  }

  Container bottomBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      color: Colors.cyan,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 11,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Text(
                  "Payable Amount:  ",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  rupees_Sybol + str_GrandTotal,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton(
              child: Text('Checkout'),
              style: OutlinedButton.styleFrom(
                primary: Colors.black,
                shadowColor: Colors.black,
                backgroundColor: Colors.yellow[200],
                textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 12,
                    fontStyle: FontStyle.normal,
                    fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                print('Pressed');
              },
            ),
          )
        ],
      ),
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

  void callMethodRemoveItemFromCart(int productId) {
    Service()
        .getCartRemoveItemWithoutLogin(DeviceId, productId.toString())
        .then((value) => {
              setState((() {
                if (_dialogKey.currentContext != null) {
                  Navigator.pop(_dialogKey.currentContext!);
                  if (value.statusCode == 1) {
                    showSnakeBar(context, "Item Removed From Cart!");
                    setState(() {
                      _listCartItem.clear();
                      getCartItemList();
                    });
                  } else {
                    showSnakeBar(context, "Opps! Something Wrong");
                  }
                }
              }))
            });
  }
}
