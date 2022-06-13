import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:nebulashoppy/screen/ordersummery.dart';
import 'package:nebulashoppy/screen/payumoney/payumoney.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/uttils/CircularProgress.dart';
import 'package:nebulashoppy/uttils/sharedpref.dart';
import 'package:nebulashoppy/uttils/skeletonloader.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/LoginDialoug.dart';
import 'package:nebulashoppy/widget/cartitemwidget.dart';
import 'package:nebulashoppy/widget/categoryproductWidget.dart';
import 'package:nebulashoppy/widget/getmyAddressDialoug.dart';
import 'package:page_transition/page_transition.dart';

import '../model/getCartItemResponse/getCarItemResponse.dart';
import '../model/getCartItemResponse/setcartitem.dart';
import '../model/homescreen/itemNewLaunched.dart';
import '../model/homescreen/itemhomecategory.dart';
import '../model/product.dart';
import '../network/service.dart';
import '../uttils/constant.dart';
import '../widget/common_widget.dart';
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

  String str_UserIds = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      widget.device_Id = DeviceId.toString();
      bl_ShowCart = false;
    });

    checkUserLoginOrNot();
    getMyCartList();
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

  CustomScrollView getMyCartData() {
    return CustomScrollView(shrinkWrap: true, slivers: <Widget>[
      SliverPadding(
        padding: const EdgeInsets.all(0.0),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              locationHeader(),
              FutureBuilder(
                builder: (context, snapshot) {
                  if (_listCartItem.isEmpty) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        child: loadSkeletonLoaders(
                            boxMyCartList(), Axis.vertical));
                  } else {
                    return setCategoryList(false);

                    //  return setCategoryList(false);
                  }
                },
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
                        getMycartDetail("Grand Total",
                            getCartItemData?.grandTotal.toString()),
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
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                            ),
                          ),
                          divider(context),
                          getPVNVDetail(
                              "PV", getCartItemData?.totalNv.toString()),
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
        ),
      ),
    ]);
  }

  Container locationHeader() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 40,
      color: Colors.cyan[500],
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(CommunityMaterialIcons.map_marker_alert_outline),
                color: Colors.black),
            Text(
              "Deliver to",
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            IconButton(
                onPressed: () {
                  onLocationPressed();
                },
                icon:
                    Icon(CommunityMaterialIcons.arrow_down_drop_circle_outline),
                color: Colors.black)
          ],
        ),
      ),
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

  void getCartItemListwithoutLogin() {
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

  void getCartItemListwithLogin() {
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
                  onCartAddClick: () {
                    print("Cart" + "Add Add");
                    showLoadingDialog(context, _dialogKey, "Please Wait..");
                    addToCart(
                        widget.device_Id,
                        str_UserId,
                        _listCartItem[index].productId.toString(),
                        1,
                        Flag_Plus);
                  },
                  onCartRemovedClick: () {
                    print("Cart" + "Add Minus");
                    showLoadingDialog(context, _dialogKey, "Please Wait..");
                    addToCart(
                        widget.device_Id,
                        str_UserId,
                        _listCartItem[index].productId.toString(),
                        1,
                        Flag_Minus);
                  },
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
                openCheckoutDialoug();
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
                      getMyCartList();
                    });
                  } else {
                    showSnakeBar(context, "Opps! Something Wrong");
                  }
                }
              }))
            });
  }

  void addToCart(String deviceId, String str_userId, String productId,
      int quntity, String flag) {
    Service()
        .getAddToCartResponse(
            deviceId, str_userId, productId, quntity.toString(), flag)
        .then((value) => {
              setState((() {
                if (_dialogKey.currentContext != null) {
                  Navigator.pop(_dialogKey.currentContext!);
                  if (value.statusCode == 1) {
                    if (flag == Flag_Plus) {
                      showSnakeBar(context, "Item Added to Cart!");
                      setState(() {
                        _listCartItem.clear();
                        getMyCartList();
                      });
                    } else {
                      showSnakeBar(context, "Item Removed from Cart!");
                      setState(() {
                        _listCartItem.clear();
                        getMyCartList();
                      });
                    }
                  } else {
                    showSnakeBar(context, "Opps! Something Wrong");
                  }
                }
              }))
            });
  }

  void onLocationPressed() {
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Container(
            height: MediaQuery.of(context).size.height / 3,
            color: Colors.transparent, //could change this to Color(0xFF737373),
            //so you don't have to change MaterialApp canvasColor
            child: new Container(
              decoration: new BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.only(
                      topLeft: const Radius.circular(10.0),
                      topRight: const Radius.circular(10.0))),
              child: Align(
                alignment: Alignment.topLeft,
                child: GETMYADDRESSDIALOUG(),
              ),
            ),
          );
        });
  }

  Column locationaddressData() {
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Choose Your Location",
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            )),
        Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Select a delivery location to see product availability and delivery options",
              style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                  fontWeight: FontWeight.normal),
            )),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 2, 10, 0),
            child: GestureDetector(
              onTap: () {
                print("Tap" + "Dorr Click");
              },
              child: Card(
                elevation: 5,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(CommunityMaterialIcons.dump_truck),
                        color: Colors.cyan),
                    Text(
                      "Door step delivery (shipping charges applicable).",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            )),
        Padding(
          padding: EdgeInsets.all(5),
          child: Text(
            "OR",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(10, 2, 10, 0),
            child: GestureDetector(
              onTap: () {},
              child: Card(
                elevation: 5,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: Icon(CommunityMaterialIcons.map_marker_circle),
                        color: Colors.cyan),
                    Text(
                      "Select a pickup point.",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            ))
      ],
    );
  }

  void openCheckoutDialoug() {
    if (!is_Login) {
      showDialog(
        barrierColor: Colors.black26,
        context: context,
        builder: (context) {
          return LoginDialoug(
            context,
            title: "SoldOut",
            description:
                "This product may not be available at the selected address.",
          );
        },
      );
    } else {
      Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: PayUMoney(),
          ));
    }
  }

  void getCartItemWithLogin() {
    is_ShowBottomBar = false;

    Service()
        .getCartItemWithLogin(widget.device_Id, "0", str_UserId)
        .then((value) => {
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
                          print(
                              "Categorylist" + _listCartItem.length.toString());
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

  void getMyCartList() {
    Future.delayed(Duration(seconds: 0), () {
      print("IsLogin" + is_Login.toString());
      if (!is_Login) {
        getCartItemListwithoutLogin();
      } else {
        getUserId();
      }
    });

    Future.delayed(Duration(seconds: 0), () {
      print("IsLogin" + str_UserId.toString());
      getCartItemWithLogin();
    });
  }
}
