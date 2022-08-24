import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nebulashoppy/model/getmyorderresponse/getmyorderresponse.dart';
import 'package:nebulashoppy/model/homescreen/itemNewLaunched.dart';
import 'package:nebulashoppy/model/homescreen/itemhomecategory.dart';
import 'package:nebulashoppy/model/setmyAccount/setmyAccount.dart';
import 'package:nebulashoppy/network/service.dart';
import 'package:nebulashoppy/screen/categorylist.dart';
import 'package:nebulashoppy/screen/productdetail.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/screen/webview.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/noInternet.dart';
import '../model/getmyorderresponse/setmyorder.dart';
import '../model/homescreen/itembannerimage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../model/product.dart';
import '../uttils/sharedpref.dart';
import '../widget/Accountwidget.dart';
import '../widget/LoginDialoug.dart';
import '../widget/cartCounter.dart';
import '../widget/common_widget.dart';
import '../widget/myorderwidget.dart';
import '../widget/noInternetDialoug.dart';
import '../widget/searchitem.dart';
import '../widget/star_rating.dart';
import '../widget/trending_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../widget/userprofilewidget.dart';
import 'package:provider/provider.dart';


class Account extends StatefulWidget {
  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> with WidgetsBindingObserver {
  bool bl_showNoData = false;
  List<SetMyAccount> _accountList = [];
  String str_IboKey = "";

  final GlobalKey<State> _dialogKey = GlobalKey<State>();

  @override
  void initState() {
    super.initState();
    isConnectedToInternet();
    hideProgressBar();
    addAccountData();
    getIboKey();
    checkUserLoginOrNot();
    Future.delayed(Duration(seconds: 0), () {
      print("IsLogin" + is_Login.toString());
      if (!is_Login && is_InternetConnected) {
        showDialog(
          barrierColor: Colors.black26,
          barrierDismissible: false,
          context: context,
          builder: (context) {
            return LoginDialoug(
              title: "SoldOut",
              blisrefresh: true,
              description:
                  "This product may not be available at the selected address.", onLoginSuccess: () {  
                    setState(() {
                      is_Login = true;
                       addAccountData();
                       getCartCount();
                    });
                  },
            );
          },
        );
      }
    });

     Future.delayed(Duration(seconds: 0), () {
      print("IsLogin" + is_Login.toString());
      if (!is_InternetConnected) {
         shownoInternetDialoug(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var cartCounter = Provider.of<CartCounter>(context);
    initilizationCounter(context);
    cartCounter.setCartCountity(int_CartCounters);
    ScreenUtil.init(context);
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(int_AppBarWidth),
          child: appBarWidget(context, 3, "Account", true)),
      body: Column(
        children: [
          showMaterialProgressbar(5),
          Container(
            color: white,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: ListView.builder(
              itemCount: _accountList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                  },
                  child: AccountWiget(
                    product: SetMyAccount(
                        postition: _accountList[index].postition,
                        is_Ewallet: _accountList[index].is_Ewallet,
                        Title: _accountList[index].Title,
                        is_ShowLine: _accountList[index].is_ShowLine,
                        is_Divider: _accountList[index].is_Divider),
                    gradientColors: [Colors.white, Colors.white],
                    onProfileClicked: () {
                      getMyProfile();
                    },
                  ),
                );
                ;
              },
            ),
          )
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void addAccountData() {
    _accountList.clear();
    _accountList.add(SetMyAccount(
        postition: 0,
        Title: "My Address",
        is_Ewallet: false,
        is_ShowLine: false,
        is_Divider: false));
    _accountList.add(SetMyAccount(
        postition: 1,
        Title: "My Profile",
        is_Ewallet: false,
        is_ShowLine: false,
        is_Divider: false));
    _accountList.add(SetMyAccount(
        postition: 2,
        Title: "My E-wallet",
        is_Ewallet: true,
        is_ShowLine: false,
        is_Divider: false));
    _accountList.add(SetMyAccount(
        postition: 3,
        Title: "About Us",
        is_Ewallet: false,
        is_ShowLine: false,
        is_Divider: false));
    _accountList.add(SetMyAccount(
        postition: 4,
        Title: "Return Policy",
        is_Ewallet: false,
        is_ShowLine: false,
        is_Divider: false));
    _accountList.add(SetMyAccount(
        postition: 5,
        Title: "Shipping Policy",
        is_Ewallet: false,
        is_ShowLine: false,
        is_Divider: false));
    _accountList.add(SetMyAccount(
        postition: 6,
        Title: "Privacy Policy",
        is_Ewallet: false,
        is_ShowLine: false,
        is_Divider: false));
    _accountList.add(SetMyAccount(
        postition: 7,
        Title: "Contact Us",
        is_Ewallet: false,
        is_ShowLine: false,
        is_Divider: false));
    if (is_Login) {
      _accountList.add(SetMyAccount(
          postition: 8,
          Title: "Logout",
          is_Ewallet: false,
          is_ShowLine: false,
          is_Divider: false));
    }
  }

  void getMyProfile() async {
    setState(() {
      showProgressbar();
    });
    //  showLoadingDialog(context, _dialogKey, "Please Wait..");
    Service().getMyProfile().then((value) => {
          hideProgressBar(),
          setState((() {
            //    Navigator.pop(_dialogKey.currentContext!);
            if (value.statusCode == 1) {
              showProfileDialoug(value);
            } else {
              bl_showNoData = true;
              showSnakeBar(context, "Opps! Something Wrong");
            }
          }))
        });
  }

  void showProfileDialoug(value) {
    showDialog(
      barrierColor: Colors.black26,
      context: context,
      builder: (context) {
        return UserProfileWidget(
          context,
          name: value.data.firstName,
          mobile: value.data.mobile,
          email: value.data.email,
          gender: value.data.gender,
        );
      },
    );
  }

  void getEWalletResponse() {
    Service().getMyWalletResponse(str_IboKey).then((value) => {
          setState((() {
            if (value.statusCode == 1) {
              setState(() {
                str_Ewalltet = value.data.toString();
                print("EWallet" + str_Ewalltet);
              });
            } else {
              showSnakeBar(context, "Opps! Something Wrong");
            }
          }))
        });
  }

  void getIboKey() async {
    str_IboKey = await SharedPref.readString(str_IBO_Id);
    print("IboKeyId" + str_IboKey.toString());
    getEWalletResponse();
  }

  void checkSession() async {
    is_Login = await SharedPref.readBool(str_IsLogin);
    print("IsLogin" + await SharedPref.readBool(str_IsLogin));
  }
}
