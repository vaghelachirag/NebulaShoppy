import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:nebulashoppy/screen/address/addnewAddress.dart';
import 'package:nebulashoppy/screen/home.dart';
import 'package:nebulashoppy/screen/ordersummery.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/uttils/CircularProgress.dart';
import 'package:nebulashoppy/uttils/sharedpref.dart';
import 'package:nebulashoppy/uttils/skeletonloader.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/LoginDialoug.dart';
import 'package:nebulashoppy/widget/cartitemwidget.dart';
import 'package:nebulashoppy/widget/categoryproductWidget.dart';
import 'package:nebulashoppy/widget/getmyAddressDialoug.dart';
import 'package:nebulashoppy/widget/paymentSucessWidget.dart';
import 'package:page_transition/page_transition.dart';

import '../model/getCartItemResponse/getCarItemResponse.dart';
import '../model/getCartItemResponse/setcartitem.dart';
import '../model/homescreen/itemNewLaunched.dart';
import '../model/homescreen/itemhomecategory.dart';
import '../model/product.dart';
import '../network/service.dart';
import '../uttils/constant.dart';
import '../widget/cartCounter.dart';
import '../widget/common_widget.dart';
import '../widget/mainButton.dart';
import '../widget/noInternet.dart';
import '../widget/paymentcancelledwidget.dart';
import '../widget/trending_item.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:provider/provider.dart';


class MyCartList extends StatefulWidget {
  String device_Id = "";
  int width = 0;
  int height = 0;
  @override
  State<MyCartList> createState() => _MyCartListState();

  void addToCartMethod() {}
}

class _MyCartListState extends State<MyCartList> with WidgetsBindingObserver  {
  List<ItemCart> _listCartItem = [];
  bool is_ShowBottomBar = false;
  bool is_ShowNoData = false;
  GetCartItemData? getCartItemData;

  String str_GrandTotal = "";
  final GlobalKey<State> _dialogKey = GlobalKey<State>();

  String str_UserIds = "";
   var size ;
 late CartCounter cartCounter;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    isConnectedToInternet();
    setState(() {
      widget.device_Id = DeviceId.toString();
      bl_ShowCart = false;
      if (str_SelectedAddress == null || str_SelectedAddress == "") {
        str_SelectedAddress = str_DeliverTo;
      }
       if (str_SelectedAddressType == null || str_SelectedAddressType == "") {
        str_SelectedAddressType = "0";
      }
    });

    checkUserLoginOrNot();
    getMyCartList();
    hideProgressBar();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

 @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    print("didChangeDependencies");
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print("APP_STATE: $state");
    if (state == AppLifecycleState.resumed) {
      // user returned to our app
      // _showPasswordDialog();
       print("MyCart"+"OnResume");
        isConnectedToInternet();
        setState(() {
      widget.device_Id = DeviceId.toString();
      bl_ShowCart = false;
      if (str_SelectedAddress == null || str_SelectedAddress == "") {
        str_SelectedAddress = str_DeliverTo;
      }
       if (str_SelectedAddressType == null || str_SelectedAddressType == "") {
        str_SelectedAddressType = "0";
      }
    });

    checkUserLoginOrNot();
    getMyCartList();
    hideProgressBar();
    } else if (state == AppLifecycleState.inactive) {
      // app is inactive
    } else if (state == AppLifecycleState.paused) {
      // user quit our app temporally
    } else if (state == AppLifecycleState.detached) {
      // user quit our app temporally
    }
  }


  final GlobalKey<_MyCartListState> _myWidgetState =
      GlobalKey<_MyCartListState>();

  @override
  Widget build(BuildContext context) {
    cartCounter = Provider.of<CartCounter>(context);
     ScreenUtil.init(context);
     size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(int_AppBarWidth),
          child: appBarWidget(context, 3, "My Cart", false)),
      bottomNavigationBar:
          Visibility(visible: is_ShowBottomBar && is_InternetConnected, child: bottomBar()),
      body:  is_InternetConnected == false ? NoInternet(onRetryClick: () {
         isConnectedToInternet();
         onRetryClick();
         print("Home"+"Retry");
        },) : getCartItem(),
    );
  }
  Container getCartItem(){
    return Container(
      child:  is_ShowNoData == true ? noDataFound() : 
      AbsorbPointer(
        absorbing: showProgress,
         child:   
          Column(
        mainAxisSize: MainAxisSize.max,
        children: [
           locationHeader(),
          showMaterialProgressbar(5),
           Expanded(
            child: 
            NotificationListener<OverscrollIndicatorNotification>(
           onNotification: (OverscrollIndicatorNotification overscroll) {
          overscroll.disallowGlow();
         return false;
         },
        child: getMyCartData()))
        ])
        ),
    );
  }
  Container noDataFound() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child:  
         Column(
               mainAxisAlignment: MainAxisAlignment.center,
              children: [
           SizedBox(width: MediaQuery.of(context).size.width/3,height:  MediaQuery.of(context).size.height/5,
           child:  Image.asset(
            'assets/images/no_cart.png',
            fit: BoxFit.fill,
          ),)     
          ,    
          Padding(padding: EdgeInsets.only(top:  ScreenUtil().setSp(30)),child:
           Text(
          "Cart is Empty",
          style: TextStyle(fontSize: ScreenUtil().setSp(20), fontWeight: FontWeight.bold,fontFamily: EmberBold)),),
           Padding(padding: EdgeInsets.fromLTRB(20, 5, 20, 0),child:
           Text(
          "Looks like you have no items in your shopping cart.",
          style: TextStyle(fontSize: ScreenUtil().setSp(16), fontWeight: FontWeight.normal,fontFamily: Ember)),)],
          ),);
  }

   handlePaymentFailure(String errorMessage){
  print("Payment"+"Fail" + errorMessage);
  showDialog(
        barrierColor: Colors.black26,
        context: context,
        builder: (context) {
          return PaymentSucessWidget(
            title: "Payment Cancelled.",
            description:
                "If the amount was debited, kindly wait for 8 hours until we verify and update your payment.", onClickClicked: () { 
                  print("OnClick"+"onClick");
                    Navigator.pop(context);
                 }, str_Amount: "50",
          );
        },
      );
   }
   
  CustomScrollView getMyCartData() {
    return CustomScrollView(shrinkWrap: true, slivers: <Widget>[
      SliverPadding(
        padding: const EdgeInsets.all(0.0),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
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
                    margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10),
                          width: MediaQuery.of(context).size.width,
                          child: setRegularText("Order Details", 16, orderDetailbg),
                          //  Text(
                          //   "Order Detail",
                          //   style: TextStyle(color: Colors.grey, fontSize: 16),
                          // ),
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
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: divider(context),
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                          child: getMycartDetail("Grand Total",
                              getCartItemData?.grandTotal.toString()),
                        ),
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
                        side: new BorderSide(color: Colors.grey, width: 0.5),
                      ),
                      margin: EdgeInsets.fromLTRB(10, 5, 10, 20),
                      child: Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(10),
                              width: MediaQuery.of(context).size.width,
                              child: Text( "Pv and NV generated on this order", style: TextStyle(fontSize: 16,color: Colors.black,fontStyle: FontStyle.italic),)
                              // setRegularText(
                              //     "Pv and NV generated on this order",
                              //     16,
                              //     Colors.black)
                              // Text(
                              //   "Pv and NV generated on this order",
                              //   style:
                              //       TextStyle(color: Colors.black, fontSize: 16),
                              // ),
                              ),
                          divider(context),
                          
                          getPVNVDetail(
                              "PV", getCartItemData?.totalPv.toString()),
                          Container(
                              color: Colors.grey[300],
                              child: getPVNVDetail(
                                  "NV", getCartItemData?.totalNv.toString()))
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
      decoration: grandientBackgroundMyCart(),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              child:  SizedBox(
              width: size.width/ 10,
              height: size.height/ 15,
              child:  
              Image.asset(
          assestPath+'location.png',
          fit: BoxFit.contain,
        )
            ),
            )
           ,
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 0),child: 
            SizedBox(
              width: MediaQuery.of(context).size.width - 100,
              child: Text(str_SelectedAddress,
                  maxLines: 2,
                  style: TextStyle(fontSize: 14, fontFamily: Ember),
                  softWrap: true),
            )),
            //setBoldText(str_SelectedAddress, 12, Colors.black),
            Padding(padding: EdgeInsets.fromLTRB(0, 0, 10, 0),child: 
            GestureDetector(
              onTap: () {
                onLocationPressed();
              },
              child:  Container(
              child:  SizedBox(
              width: size.width/ 12,
              height: size.height/ 15,
              child:  
              Image.asset(
          assestPath+'down_arrow.png',
          fit: BoxFit.contain,
            )
            ),
            ),
            ))
           
           
          ],
        ),
      ),
    );
  }

  Container getMycartDetail(String title, String? detail) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: setBoldText(title, 14, Colors.black)
              // Text(
              //   title,
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              // ),
              ),
          Align(
              alignment: Alignment.topRight,
              child: setRegularText(
                  rupees_Sybol + detail.toString(), 16, priceColor)
              // Text(
              //   rupees_Sybol + detail.toString(),
              //   style: TextStyle(
              //       fontWeight: FontWeight.normal,
              //       fontSize: 14,
              //       color: Colors.red),
              // ),
              )
        ],
      ),
    );
  }

  Container getPVNVDetail(String title, String? detail) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 8, 10, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: setBoldText(title, 14, Colors.black)
              // Text(
              //   title,
              //   style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              // ),
              ),
          Align(
              alignment: Alignment.topRight,
              child: setBoldText(detail!, 16, pvtextBg)
              // Text(
              //   detail!,
              //   style: const TextStyle(
              //       fontWeight: FontWeight.bold,
              //       fontSize: 14,
              //       color: Colors.blue),
              // ),
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
                       compareproductquntity(_listCartItem);
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
   void compareproductquntity(List<ItemCart> listCartItem) {
    if (listCartItem.isNotEmpty) {
      for (int i = 0; i < listCartItem.length; i++) {
        if (listCartItem[i].productId == productid) {
          setState(() {
            int_CartQuantity = listCartItem[i].cartQuantity;
          });
          break;
        }
        else{
            int_CartQuantity = 0;
        }
      }
    }
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
                int_cartQuntity: 0, is_Free: false, rankRewardText: '',
                
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
                    price: _listCartItem[index].pricePerPiece.toString(),
                    pv: _listCartItem[index].pv.toString(),
                    bv: _listCartItem[index].bv.toString(),
                    nv: _listCartItem[index].nv.toString(),
                    int_cartQuntity: _listCartItem[index].cartQuantity,
                    is_Free: _listCartItem[index].isFree, rankRewardText: _listCartItem[index].rankRewardText
                  ),
                  gradientColors: [Colors.white, Colors.white],
                  onItemRemovedClick: (int) {
                    print("ItemRemovedIt" + int.toString());
                   // showLoadingDialog(context, _dialogKey, "Please Wait..");
                   setState(() {
                     showProgressbar();
                   });
                    callMethodRemoveItemFromCart(int);
                  },
                  onCountChanges: (int) {},
                  onCartAddClick: () {
                    print("Cart" + "Add Add");
                  //  showLoadingDialog(context, _dialogKey, "Please Wait..");
                   setState(() {
                     showProgressbar();
                   });
                    addToCart(
                        widget.device_Id,
                        str_UserId,
                        _listCartItem[index].productId.toString(),
                        1,
                        Flag_Plus);
                  },
                  onCartRemovedClick: () {
                    print("Cart" + "Add Minus");
                      setState(() {
                     showProgressbar();
                   });
                   // showLoadingDialog(context, _dialogKey, "Please Wait..");
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
      decoration: grandientBackground(),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 13,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                setBoldText("Payable Amount :  ", 20, Colors.black),
                // Text(
                //   "Payable Amount:  ",
                //   style: TextStyle(
                //       color: Colors.black,
                //       fontWeight: FontWeight.bold,
                //       fontSize: 16),
                // ),
                setRegularText(rupees_Sybol +" " + str_GrandTotal, 16, Colors.black)
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: MainButtonWidget(
                onPress: () {
                  if(str_SelectedAddress == "Deliver To"){
                    showSnakeBar(context, "Please Select Your Delivery Location");
                  }
                  else{
                    openCheckoutDialoug();
                  }
                
                },
                buttonText: "Checkout"),
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
    if (!is_Login) {
      Service()
          .getCartRemoveItemWithoutLogin(DeviceId, productId.toString())
          .then((value) => {
                setState((() {
                   hideProgressBar();
                   if (value.statusCode == 1) {         
                      showSnakeBar(context, "Item Removed From Cart!");
                      setState(() {
                        //  _listCartItem.clear();
                        getMyCartList();
                        getCartCount();
                      });
                    } else {
                      showSnakeBar(context, "Opps! Something Wrong");
                    }
                }))
              });
    } else {
      getUserId();
      Future.delayed(Duration(seconds: 0), () {
        print("IsLogin" + str_UserId.toString());
        Service()
            .getCartRemoveItemWithLogin(
                DeviceId, productId.toString(), str_UserId)
            .then((value) => {
                  setState((() {
                  hideProgressBar();
                  if (value.statusCode == 1) {
                        showSnakeBar(context, "Item Removed From Cart!");
                        setState(() {
                          //  _listCartItem.clear();
                           getMyCartList();
                           getCartCount();
                        });
                      } else {
                        showSnakeBar(context, "Opps! Something Wrong");
                      }
                  }))
                });
      });
    }
  }

  void addToCart(String deviceId, String str_userId, String productId,
      int quntity, String flag) {
    Service()
        .getAddToCartResponse(
            deviceId, str_userId, productId, quntity.toString(), flag)
        .then((value) => {
              setState((() {
                hideProgressBar();
                 if (value.statusCode == 1) {
                    if (flag == Flag_Plus) {
                      cartCounter.addItemInCart();
                      showSnakeBar(context, "Item Added to Cart!");
                      setState(() {
                        // _listCartItem.clear();
                        getMyCartList();
                      });
                    } else {
                      cartCounter.removeItemFromCart();
                      showSnakeBar(context, "Item Removed from Cart!");
                      setState(() {
                        //  _listCartItem.clear();
                        getMyCartList();
                      });
                    }
                  } else {
                    showSnakeBar(context, "Opps! Something Wrong");
                  }
              }))
            });
  }

  void onLocationPressed() {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (builder) {
          return new Container(
            height: MediaQuery.of(context).size.height - 200,
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
                child: GETMYADDRESSDIALOUG(
                  onAddressSelection: () {
                    setState(() {
                      str_SelectedAddress = str_SelectedAddress;
                      str_SelectedAddressType = str_SelectedAddressType;
                       getMyCartList();
                     //  getProductAvailabilityCheck();
                      print("AddressType"+str_SelectedAddressType);
                      
                    });
                  }, onNewAddressSelection: () { 
                    print("NewAddress"+"New Address");
                    gotoAddNewAddress();
                  //   Navigator.push(context,PageTransition(type: PageTransitionType.fade,child: AddNewAddress(),));
                   },
                ),
              ),
            ),
          );
        });
  }

  getProductAvailabilityCheck(){
    Service()
        .getProductAvailabilityCheck("0")
        .then((value) => {
              print("CartList" + value.toString())
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
 void gotoAddNewAddress() async{
   var push_AddNewAddress = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => AddNewAddress(),
    ));
    if (push_AddNewAddress == null || push_AddNewAddress == true) {
     Navigator.pop(context);
        onLocationPressed();
    }
  }
  void openCheckoutDialoug() {
      if(!is_Login){
         showDialog(
        barrierColor: Colors.black26,
        context: context,
        builder: (context) {
          return LoginDialoug(
            title: "SoldOut",
            description:
                "This product may not be available at the selected address.", onLoginSuccess: () { 
                  print("onLogin"+"OnloginnSuccess");
                   setState(() {
                     is_Login = true;
                      getMyCartList();
                   });
                 },
          );
        },
      );
      }
      else{
          // showSnakeBar(context, "Login");
           Navigator.push(
          context,
          PageTransition(
            type: PageTransitionType.fade,
            child: OrderSummery(
              str_Title: "Order Summery",
              int_SubTotal: getCartItemData?.subTotal,
              int_GrandTotal: getCartItemData?.grandTotal,
              int_ShippingCharge: getCartItemData?.shippingCharge,
              int_GrandTotalWallet: getCartItemData?.grandTotalWithEwallet,
              int_ShippingChargeWallet: getCartItemData?.shippingWithEwallet,
              int_SubTotalWallet: getCartItemData?.subTotalWithEwallet,
              int_E_WalletAmount: getCartItemData?.ewalletAmount,
              is_EwalletOnOff: getCartItemData?.isEwalletOnOff,
              is_WalletFreez: getCartItemData?.isEwalletfreeze,
              str_AddressType: str_SelectedAddressType,
            ),
          ));
      }
    // if (!is_Login) {
    //   showDialog(
    //     barrierColor: Colors.black26,
    //     context: context,
    //     builder: (context) {
    //       return LoginDialoug(
    //         context,
    //         title: "SoldOut",
    //         description:
    //             "This product may not be available at the selected address.",
    //       );
    //     },
    //   );
    // } else {
    //   Navigator.push(
    //       context,
    //       PageTransition(
    //         type: PageTransitionType.fade,
    //         child: OrderSummery(
    //           str_Title: "Order Summery",
    //           int_SubTotal: getCartItemData?.subTotal,
    //           int_GrandTotal: getCartItemData?.grandTotal,
    //           int_ShippingCharge: getCartItemData?.shippingCharge,
    //           int_GrandTotalWallet: getCartItemData?.grandTotalWithEwallet,
    //           int_ShippingChargeWallet: getCartItemData?.shippingWithEwallet,
    //           int_SubTotalWallet: getCartItemData?.subTotalWithEwallet,
    //           int_E_WalletAmount: getCartItemData?.ewalletAmount,
    //           is_EwalletOnOff: getCartItemData?.isEwalletOnOff,
    //           is_WalletFreez: getCartItemData?.isEwalletfreeze,
    //         ),
    //       ));
    // }
  }

  void getCartItemWithLogin() {
    is_ShowBottomBar = false;

    Service()
        .getCartItemWithLogin(widget.device_Id, str_SelectedAddressType, str_UserId)
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
                          compareproductquntity(_listCartItem);
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


  void onRetryClick() {}
}
