import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/paymentcancelledwidget.dart';
import  'package:payumoney_pro_unofficial/payumoney_pro_unofficial.dart';

import '../../network/service.dart';
import '../../uttils/constant.dart';

class PayUMoney extends StatefulWidget {
  @override
  State<PayUMoney> createState() => _PayUMoneyState();
}

class _PayUMoneyState extends State<PayUMoney> with WidgetsBindingObserver {
 
   // Payment Details
  String phone = "8318045008";
  String email = "gmail@gmail.com";
  String productName = "My Product Name";
  String firstName = "Vaibhav";
  String txnID = "213428847124";
  String amount = "1.0";


  final GlobalKey<State> _dialogKey = GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    generateOrder();
   //initializePayments();
  }
 @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

   
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: appBarWidget(context, 3, "Paymoney", false)),
      body: Container(
        margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
        child: Text("")
        
      )
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

   handlePaymentSuccess(){
   //Implement Your Success Logic
    print("Payment"+"Sucess");
   }

  handlePaymentFailure(String errorMessage){
  print("Payment"+"Fail" + errorMessage);
  showDialog(
        barrierColor: Colors.black26,
        context: context,
        builder: (context) {
          return PaymentCancelledWidget(
            title: "Payment Cancelled.",
            description:
                "If the amount was debited, kindly wait for 8 hours until we verify and update your payment.", onClickClicked: () { 
                  print("OnClick"+"onClick");
                    Navigator.pop(context);
                 },
          );
        },
      );
   }
  Future<void> initializePayments() async { 
   final response= await  PayumoneyProUnofficial.payUParams(
    email: 'vaghelacd99@gmail.com',
    firstName: 'chirag vaghela', 
    merchantName: 'chirag',
    isProduction: true,
    merchantKey: '0w2qzK',
    merchantSalt: 'Oa3o6OCxGvidPIIxnP2tlZ7Wq9z1VEpU',
    amount: '1.00',
    hashUrl:'<Checksum URL to generate dynamic hashes>', //nodejs code is included. Host the code and update its url here.
    productInfo: '<Product Name>',
    transactionId: '<Unique ID>',
    showExitConfirmation:true,
    showLogs:false, // true for debugging, false for production
    userCredentials:'<Merchant Key>:' + '<Customer Email or User ID>',
    userPhoneNumber: phone);

   if(response['status'] == PayUParams.success){
    handlePaymentSuccess();
   }

   if (response['status'] == PayUParams.failed)
    handlePaymentFailure(response['message']);
   }

  void generateOrder() {
  showLoadingDialog(context, _dialogKey, "Please Wait..");
    Service().getGenerateOrderResponse("8bb7fb09-269f-4912-81a1-30c70252e069","4727","","","PickUp","1","","","Online%20Payment","true","UPI","0").then((value) => {
          if (this.mounted)
            {
              setState((() {
               if (value.statusCode == 1) {
                   txnID = value.data!.orderId.toString();
                   Navigator.pop(_dialogKey.currentContext!);
                   print("TransectionId"+ txnID);
                   initializePayments();
                } else {
                  showSnakeBar(context, somethingWrong);
                  print("Categorylist" + "Opps Something Wrong!");
                }
              }))
            }
        });
  }

  }

