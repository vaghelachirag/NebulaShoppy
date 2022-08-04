import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nebulashoppy/network/service.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/common_widget.dart';
import 'package:nebulashoppy/widget/mainButton.dart';
import 'package:nebulashoppy/widget/paymentSucessWidget.dart';
import '../model/getCartItemResponse/getCarItemResponse.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../uttils/sharedpref.dart';
import 'package:flutter_svg/svg.dart';

import '../widget/paymentcancelledwidget.dart';
import 'package:payumoney_pro_unofficial/payumoney_pro_unofficial.dart';
import 'package:provider/provider.dart';
import '../../widget/cartCounter.dart';

class OrderSummery extends StatefulWidget {
  String str_Title = "";
  String device_Id = "";
  String str_UserId = "";

  int? int_SubTotal = 0;
  int? int_ShippingCharge = 0;
  int? int_GrandTotal = 0;
  int? int_GrandTotalWallet = 0;
  int? int_ShippingChargeWallet = 0;
  int? int_SubTotalWallet = 0;

  bool? is_WalletFreez = false;
  String is_EwalletOnOff = "0";
  int? int_E_WalletAmount = 0;
  int? int_SettleAmount = 0;

  String txnID = "213428847124";
  String firstname = "";
  String phone = "";
  String email = "";
  String productInfo = "";
  String  str_AddressType = "";
    String str_Address = "";

  OrderSummery({
    required this.str_Title,
    required this.int_SubTotal,
    required this.int_ShippingCharge,
    required this.int_GrandTotal,
    required this.int_GrandTotalWallet,
    required this.int_ShippingChargeWallet,
    required this.int_SubTotalWallet,
    required this.is_WalletFreez,
    required this.is_EwalletOnOff,
    required this.int_E_WalletAmount,
    required this.str_AddressType
  });

  @override
  State<OrderSummery> createState() => _OrderSummeryState();
}

class _OrderSummeryState extends State<OrderSummery>
    with WidgetsBindingObserver {
  List<ItemCart> _listCartItem = [];
  bool is_ShowBottomBar = false;
  bool is_ShowNoData = false;
  GetCartItemData? getCartItemData;
  String str_GrandTotal = "";
  final GlobalKey<State> _dialogKey = GlobalKey<State>();
  int? int_TotalItemCount = 0;

  // Selected Position selection
  bool selectedPosition = false;
  bool isCheckedEWallet = false;
  bool isShowCheckedEWallet = false;

  int? int_Total = 0;
  int? int_SubTotal = 0;
  int? int_ShippingCharge = 0;


  @override
  void initState() {
    super.initState();
    setState(() {
      if (widget.is_EwalletOnOff == "1") {
        isShowCheckedEWallet = true;
      }
      widget.device_Id = DeviceId.toString();
      checkUserLoginOrNot();
      getUserId();
      getDeviceId();
      setSummeryData();
      Future.delayed(Duration(seconds: 0), () {
        print("DeviceId" + widget.str_AddressType);
        getTotalCountResponse();
      });
    });

    if(widget.str_AddressType == "1"){
      widget.str_Address = "Pickup Point";
    }
    else{
      widget.str_Address = "Deliver To";
    }
    
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    initilizationCounter(context);
    ScreenUtil.init(context);
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: appBarWidget(context, 3, widget.str_Title, false)),
        bottomNavigationBar: Visibility(visible: true, child: bottomBar()),
        body: Column(
          children: [
            showMaterialProgressbar(5),
               AbsorbPointer(
          absorbing: showProgress,
         child:   getOrderSummeryData())
          ],
        )
     );

    // This trailing comma makes auto-formatting nicer for build methods
  }

  getUserId() async {
    str_UserId = await SharedPref.readString(str_IBO_Id);
    print("UserID" + str_UserId);
  }

  void getOrderSummery() {
    Service().getOrderSummery(widget.device_Id, widget.str_UserId, "1")
        .then((value) => {
              if (value.toString() == str_NoDataMsg) {setState((() {}))},
              if (value.toString() != str_ErrorMsg &&
                  value.toString() != str_NoDataMsg)
                {
                  if (value.toString() != str_NoDataMsg)
                    {
                      setState((() {
                        if (value.statusCode == 1) {
                          _listCartItem = value.data.cart;
                          getCartItemData = value.data;
                          setState(() {
                            str_GrandTotal =
                                value.data.grandTotalWithEwallet.toString();
                          });

                          is_ShowBottomBar = true;
                          print("Categorylist" + str_GrandTotal);
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

  CustomScrollView getOrderSummeryData() {
    return CustomScrollView(shrinkWrap: true, slivers: <Widget>[
      SliverPadding(
        padding: const EdgeInsets.all(0.0),
        sliver: SliverList(
          delegate: SliverChildListDelegate(
            <Widget>[
              FutureBuilder(
                builder: (context, snapshot) {
                  if (int_TotalItemCount != 0) {
                    return orderSummeryTitle("Total Items",
                        int_TotalItemCount.toString(), false, "Black");
                  } else {
                    return orderSummeryTitle(
                        "Total Items", "0", false, "Black");
                  }
                },
              ),
              Padding(padding: EdgeInsets.fromLTRB(10, 3, 10, 3),child: divider(context),)
               ,
             Column(
                  children: [
                    orderSummeryTitle(
                        "Subtotal", int_SubTotal.toString(), true, "Gray"),
                    Padding(
                      padding: EdgeInsets.all(0),
                      child: EwalletOption(),
                    ),
                    orderSummeryTitle("Shipping Charges",
                        int_ShippingCharge.toString(), true, "Gray"),
                        
                    orderSummeryTitle(
                        "Grand Total", int_Total.toString(), true, "Black"),
                  ],
                ),
                 Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 8),child: divider(context),),
              setPickupAddress(),
            ],
          ),
        ),
      ),
    ]);
  }

  Container EwalletOption() {
    return Container(
        padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: Visibility(
            visible: isShowCheckedEWallet,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Checkbox(
                      activeColor: THEME_COLOR,
                      hoverColor: THEME_COLOR,
                      focusColor: THEME_COLOR,
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: isCheckedEWallet,
                      checkColor: Colors.white,
                      onChanged: (value) {
                        setState(() {
                          isCheckedEWallet = value!;
                          print("Checked" + isCheckedEWallet.toString());
                          settleWithEWallet();
                        });
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text(
                          "Settle E-Wallet balance" +
                              " " +
                              "(" +
                              widget.int_E_WalletAmount.toString() +
                              ".0" +
                              ")",
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.normal,
                              fontSize: 12)),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text("-" + rupees_Sybol),
                    Align(
                      alignment: Alignment.topRight,
                      child: Text(
                        widget.int_SettleAmount.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 14,
                            color: Colors.green),
                      ),
                    )
                  ],
                )
              ],
            )));
  }

  getTotalCountResponse() {
    setState(() {
      showProgressbar();
    });
    //showLoadingDialog(context, _dialogKey, "Please Wait..");
    Service().getCartTotal(DeviceId, str_UserId).then((value) => {
          setState((() {
            hideProgressBar();
            //Navigator.pop(_dialogKey.currentContext!);
            if (value.statusCode == 1) {
              int_TotalItemCount = value.data?.sumOfQty;
            } else {
              showSnakeBar(context, "Opps! Something Wrong");
            }
          }))
        });
  }

  Container orderSummeryTitle(
    String title,
    String? detail,
    bool showRuppes,
    String str_color,
  ) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
              alignment: Alignment.topLeft,
              child: 
              Text(title,style: TextStyle(fontSize: 14,color:str_color == "Black" ? Colors.black : Colors.grey,fontWeight: str_color == "Black" ? FontWeight.bold : FontWeight.normal ),)
               
              // Text(
              //   title,
              //   style: TextStyle(
              //       color: str_color == "Black" ? Colors.black : Colors.grey,
              //       fontWeight: str_color == "Black"
              //           ? FontWeight.bold
              //           : FontWeight.normal,
              //       fontSize: 14),
              // ),
              ),
          Row(
            children: [
              Visibility(
                child: Text(rupees_Sybol),
                visible: showRuppes,
              ),
              Align(
                alignment: Alignment.topRight,
                child: setBoldText(detail.toString(), 14, priceColor),
              )
            ],
          ),
        ],
      ),
    );
  }

  Column setPickupAddress() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text( 
                widget.str_Address,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 14),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
          child: Container(
              padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(str_SelectedAddress,
                    style: TextStyle(fontSize: 14, fontFamily: Ember),
                    softWrap: true)
                //setRegularText( str_SelectedAddress, 12, Colors.black)
                ,
              ),
            ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
          child: Container(
            width: MediaQuery.of(context).size.width,
            color: Colors.grey[300],
            margin: EdgeInsets.all(0),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "SELECT PAYMENT METHOD",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => {
            setState(() {
              this.selectedPosition = true;
            })
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Card(
              color: selectedPosition == true
                        ? selectpaymentBg
                        : Colors.white,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: selectedPosition == true
                        ? Colors.black38
                        : Colors.white,
                    width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Image.asset(
                      'assets/images/upi.png',
                      height: 50,
                      width: 50,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Text(
                      "UPI",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Container bottomBar() {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 10,
      child: Row(
        children: [
          Container(
              width: MediaQuery.of(context).size.width - 20,
              child: MainButtonWidget(
                buttonText: 'Confirm Order',
                onPress: () {
                  if (!selectedPosition) {
                    showSnakeBar(context, "Please Select Payment Method!");
                  } else {
                    callOrderApi();
                  }
                },
              )

              //  OutlinedButton(
              //   style: OutlinedButton.styleFrom(
              //     backgroundColor: THEME_COLOR,
              //   ),
              //   onPressed: () {

              //   },
              //   child: const Text(
              //     'Confirm Order',
              //     style: TextStyle(fontSize: 14, color: Colors.white),
              //   ),
              // ),
              )
        ],
      ),
    );
  }

  void callOrderApi() {
    //showLoadingDialog(context, _dialogKey, "Please Wait..");
     setState(() {
       showProgressbar();
     });
    Service()
        .getGenerateOrderPayUResponse(str_UserId, int_Total.toString(), "", "",
            "PickUp", "1", "", "", "Online%20Payment", "true", "UPI", "0")
        .then((value) => {
              if (this.mounted)
                {
                  setState((() {
                   // Navigator.pop(_dialogKey.currentContext!);
                   hideProgressBar();
                    if (value.statusCode == 1) {
                      widget.txnID = "Order_637946852342729071";
                      widget.firstname = value.data!.firstname.toString();
                      widget.productInfo = value.data!.productinfo.toString();
                      widget.email = value.data!.email.toString();
                      widget.phone = value.data!.phone.toString();
                     // print("TransectionId" + widget.txnID);
                      initializePayments();
                    } else {
                      showSnakeBar(context, somethingWrong);
                      print("Categorylist" + "Opps Something Wrong!");
                    }
                  }))
                }
            });
  }

  Future<void> initializePayments() async {
    final response = await PayumoneyProUnofficial.payUParams(
        email: widget.email,
        firstName: widget.firstname,
        merchantName: 'Nebula',
        isProduction: true,
        merchantKey: MerchantKey,
        merchantSalt: MerchantSalt,
        amount: int_Total.toString(),
        hashUrl: '<Checksum URL to generate dynamic hashes>',
        productInfo: widget.productInfo,
        transactionId: widget.txnID,
        showExitConfirmation: true,
        showLogs: false, // true for debugging, false for production
        userCredentials: MerchantKey + ":" + widget.email,
        userPhoneNumber: widget.phone);

    if (response['status'] == PayUParams.success) {
      getMarkDeleteCart();
     
    }

    if (response['status'] == PayUParams.failed) {
      handlePaymentFailure(response['message']);
    }
  }

  handlePaymentSuccess() {
    showSucessDialoug("Payment Successful.", "");
  }

  handlePaymentFailure(String errorMessage) {
    if (errorMessage == 'Payment canceled') {
      showAlertDialoug("Payment Cancelled.",
          "If the amount was debited, kindly wait for 8 hours until we verify and update your payment.");
    } else {
      showAlertDialoug("Payment Cancelled.", errorMessage);
    }
  }

  void showAlertDialoug(String str_Title, String str_Message) {
    showDialog(
      barrierColor: Colors.black26,
      context: context,
      builder: (context) {
        return PaymentCancelledWidget(
          title: str_Title,
          description: str_Message,
          onClickClicked: () {
            print("OnClick" + "onClick");
            Navigator.pop(context);
          },
        );
      },
    );
  }

  void showSucessDialoug(String str_Title, String str_Message) {
    showDialog(
      barrierColor: Colors.black26,
      context: context,
      builder: (context) {
        return PaymentSucessWidget(
          title: str_Title,
          description: str_Message,
          onClickClicked: () {
            print("OnClick" + "onClick");
            Navigator.pop(context);
          }, str_Amount: str_GrandTotal,
        );
      },
    );
  }

  void settleWithEWallet() {
    if (isCheckedEWallet) {
      setState(() {
        int_Total = widget.int_GrandTotalWallet;
        int_ShippingCharge = widget.int_ShippingChargeWallet;
        int_SubTotal = widget.int_SubTotal;
        widget.int_SettleAmount = widget.int_E_WalletAmount;
        print("Wallet" + widget.int_SubTotalWallet.toString());
      });
    } else {
      setState(() {
        int_Total = widget.int_GrandTotal;
        int_ShippingCharge = widget.int_ShippingCharge;
        int_SubTotal = widget.int_SubTotal;
        widget.int_SettleAmount = 0;
        print("Wallet" + int_Total.toString());
      });
    }
  }

  void setSummeryData() {
    int_Total = widget.int_GrandTotal;
    int_SubTotal = widget.int_SubTotal;
    int_ShippingCharge = widget.int_ShippingCharge;
  }

  void getMarkDeleteCart() {
     Service().getDeleteCartResponse("true",str_UserId,DeviceId)
        .then((value) => {
         
              if (value.toString() == str_ErrorMsg)
                {
                  // Navigator.pop(_dialogKey.currentContext!),
                  showSnakeBar(
                      context, "The user name or password is incorrect")
                }
              else
                {
                  cartCounter.setCartZero(),
                  handlePaymentSuccess()
                }
            });
  }
}