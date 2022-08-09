// Routes
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nebulashoppy/screen/home.dart';
import 'package:nebulashoppy/screen/myorder/myorderdetail.dart';
import 'package:nebulashoppy/screen/splash.dart';
import 'package:nebulashoppy/screen/tabscreen.dart';
import 'package:nebulashoppy/uttils/sharedpref.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/cartCounter.dart';
import 'package:shimmer/shimmer.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:page_transition/page_transition.dart';

import '../main.dart';
import '../network/service.dart';
import '../screen/address/editmyAddress.dart';
import '../widget/noInternetDialoug.dart';
import '../widget/restartWidget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:provider/provider.dart';

const HOME_SCREEN = 'home_screen';

// const BASE_URL = "https://nebulacompanies.net/"; // Live
// const Scheme = "https";
// const Host = "nebulacompanies.net"; // Live

var BASE_URL = "http://203.88.139.169:9064/";
var Scheme = "http"; // Live
var Host = "203.88.139.169:9064"; // Live

// Routes
const WS_ADVERTISEMENT_IMAGES_ECOM = '/API/ECom/BannerImages';
const WS_GET_CATEGORY_LIST = '/API/ECom/CategoryList';
const WS_CATEGORY = '/API/ECom/ProductListByCategoryWithPaginationV2';
const WS_ProductBanner = '/API/ECom/ProductBanners';
const WS_GET_SEARCH = "/API/ECom/SearchByText";
const WS_GET_PRODUCT_DETAILS = '/Api/ECom/GetEBCDescriptionWithUCQuantityV2';
const WS_GET_PRODUCT_DETAILS_IMAGE = '/Api/ECom/EComEBCImages';
const WS_GET_PRODUCT_VARINT_DATA =
    '/API/EcomAttribute/GetEcomAttributeValuesList';
const WS_GET_CART_COUNT = '/API/ECom/GetCartSumOfQty';
const WS_ADD_TO_CART = '/API/ECom/AddToCart';
const WS_GET_CART_WITHOUT_LOGIN_ITEM = '/API/ECom/GetCartItemsListWithoutUser';
const WS_GET_CART_WITH_LOGIN_ITEM = '/API/ECom/GetCartItemsList';
const WS_REMOVE_CART_ITEM = '/API/ECom/RemoveFromCartWithoutUser';
const WS_REMOVE_CART = '/API/ECom/RemoveFromCart';
const WS_GENERATE_TOKEN = '/API/Token';
const WS_REGISTER_TOKEN = '/API/Notifications/NebProUpdateDeviceToken';
const WS_LOGIN_VALIDATE_KEY = '/Api/NebProDashboard/IBOLogin';
const WS_FORGOT_PASSWORD_OPTION = '/Api/ForgotPassword/CheckUserDetails';
const WS_GET_MY_ORDER_LIST = '/API/ECom/GetOrderList';
const WS_GET_MY_PROFILE = '/API/ECom/Me';
const WS_GET_E_WALLET = 'API/EComCouponCode/GetIBOWalletBalance';
const WS_GET_E_WALLET_History = 'API/EComCouponCode/GetIBOWalletList';
const WS_GET_CART_ITEM_WITH_LOGIN = '/API/ECom/GetCartItemsList';
const WS_GET_MY_ADDRESS = '/API/ECom/GetAddresses';
const WS_GET_DELETE_ADDRESS = '/API/ECom/DeleteAddress';
const WS_GET_STATE_LIST = '/API/Config/StateInfo';
const WS_GET_ADDRESS_BY_CITY = '/API/ECom/GetPickUpAddressByCity';
const WS_GET_ADD_ADDRESS = '/API/ECom/AddAddress';
const WS_GET_EDIT_ADDRESS = '/API/ECom/UpdateAddress';
const WS_GET_CITYLIST_BY_STATE = '/API/Config/CityInfo';
const WS_GET_GENERATE_ORDER = '/API/Ecom/GenerateOrderPaytm';
const WS_GET_GENERATE_ORDER_PAYUMONEY = '/API/Ecom/GenerateOrderPayUMoney';
const WS_GET_DELETE_CART = '/API/ECom/MarkCartDelete';
const WS_GET_NEW_PRODUCT_LIST = '/API/ECom/NewProductList';
const WS_GET_PRODUCT_AVAILABILITY = '/API/ECom/GetOutOfStock';
const WS_GET_APP_VERISON = "/Api/Dashboard/VersionCheckerNebPro";

const MerchantKey = "0w2qzK";
const MerchantSalt = "Oa3o6OCxGvidPIIxnP2tlZ7Wq9z1VEpU";

const placeholder_path = 'assets/images/placeholder.jpg';
const rupees_Sybol = '\u{20B9}';
const Flag_Plus = 'plus';
const Flag_Minus = 'minus';
var DeviceId = '';
int int_CartCounters = 0;
String QTYCount = "0";
bool bl_ShowCart = true;
const double int_AppBarWidth = 50;

String str_ErrorMsg = "Opps! Something Wrong...";
String str_NoDataMsg = "No Data Found!";

String str_DeliverTo = "Deliver To";

// Message
const somethingWrong = "Opps Something Wrong!";

// Sharred Prefrences
String str_FCMToken = "fcmToken";
String str_Token = "accessToken";
String str_RefreshToken = "refreshToken";
String str_Role = "role";
String str_DisplayName = "displayName";
String str_IBO_Id = "iboKeyId";
String str_Refrence_Id = "encryptUserName";
String str_IsLogin = "IsLogin";

// Is Login
bool is_Login = false;
String str_AuthId = "";
String str_UserId = "";

// For Address Selection
String str_SelectedAddress = "";
String str_SelectedAddressType = "";

int int_SelectedFilterIndex = 0;

const PRIMARY_COLOR = Color(0xFF1A8D1C);
const YELLOW_THEME_COLOR = Color(0xFFF5EE88);
const YELLOW_DARK = Color(0xFFffe725);
const GRAY = Color(0xFFeaeaea);
const BLACK = Color(0xFF232323);
const LIGHT_GREEN = Color(0xFF459A16);
const SECONDARY_COLOR = Color(0xFF0f464c);
const DARK_GRAY = Color(0xFFDADADA);
const LIGHT_BLACK = Color(0xFF50555C);
const PISTACHIO = Color(0xFFe4f6e8);
const GREEN = Color(0xFF589677);
const Orange = Color(0xFFFFA500);
const RED = Color(0xFFFF0000);
const Blue = Color(0xFF0000FF);
const LIGHT_BLUE = Color(0xFFe7edf8);
const TRANSPARENT_WHITE = Color.fromRGBO(255, 255, 255, 0.1);
const SCREEN_BACKGROUND = Color(0xFFDFE6E6);
const CLOSE_ICON = Color(0xFF393A3A);
const MARUN = Color(0xFF5D5073);
const DARK_MARUN = Color(0xFF862663);
const HOME_BG = Color(0xFFFBFBFB);
const CHOCOLATE = Color(0xFF924D23);
const SEARCH_CLR = Color(0xFF0F2851);
const SEARCH_BAR_CLR = Color(0xFFDADADA);
const SETTINGS_GB = Color(0xFFE5E5E5);
const PIC_IMAGE = Color(0xFFFAFAFA);
const SILVER = Color(0XFFC0C0C0);
const LIGHT_SILVER = Color(0XFFD3D3D3);
const SEGMENTCLR = Color(0XFFE1E1E1);
const HOME_CIGAR = Color(0XFF924D23);
const CARD_BORDER = Color(0XFFDEDEDE);
const WRITE_REVIEW = Color(0XFFF2970E);
const REWARD_COLOR = Color(0XFFfaf8df);
const SHADOW_GRAY = Color.fromRGBO(0, 0, 0, 0.16);
const LIGHT_ACCENT_GRAY = Color(0xFFE5DBDD);
const PRODUCT_PRICE = Color(0xFF44293B);
const PRODUCT_OLD_PRICE = Color(0xFF898989);
const white = Color(0xFFffffff);
const THEME_COLOR = Colors.cyan;

const kPurpleColor = Color(0xFFB97DFE);
const kRedColor = Color(0xFFFE4067);
const kGreenColor = Color(0xFFADE9E3);
const buttonColor = Color(0XFFf0c350);
const buttonBorderCOlor = Color(0XFF7e6a37);
const loginButtonColor = Color(0XFFd34836);

const pvtextBg = Color(0xFF2c2cd0);
const priceColor = Color(0xFFcf1615);
const orderDetailbg =  Color(0xFF7e7e7e);
const productNameColor =  Color(0xFF711212);
const productDetailColor =  Color(0xFF696969);
const productPriceBg =  Color(0xFFaaaaaa);
const selectpaymentBg =  Color(0xFFfdf9ee);
const selectpickuppointBg =  Color(0xFF12808d);



// Font Family
const String Montserrat = "Montserrat";
const String Ember = "Ember";
const String EmberBold = "Ember-Bold";
const String EmberItalic = "Ember-Italic";

const String assestPath = 'assets/images/';

DateTime currentBackPressTime = DateTime.now();

// E Wallet
String str_Ewalltet = "0.0";

 late CartCounter cartCounter ;

// For Product Counter
int? int_CartQuantity = 0;
int? productid = 0;

String register =
    'https://nebulacompanies.net/Structure/Register/IndexMobileView?Isloggedin=False';

// For Show Progress
bool showProgress = true;

// Is Interent Connected
bool is_InternetConnected = false;

showSnakeBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

initilizationCounter(BuildContext context){
   cartCounter = Provider.of<CartCounter>(context);
}

changeBaseURL(int int_BaseUrl) {
  if (int_BaseUrl == 0) {
    BASE_URL = "http://203.88.139.169:9064/";
    Scheme = "http"; // Testing
    Host = "203.88.139.169:9064"; // Testing
  } else {
    BASE_URL = "https://nebulacompanies.net/";
    Scheme = "https"; // Live
    Host = "nebulacompanies.net"; // Live
  }
}

gotoNextScreen(BuildContext context, MyOrderDetail myOrderDetail) {}

// For Check Interent Connected
checkUserLoginOrNot() async {
  is_Login = await SharedPref.readBool(str_IsLogin);
  if (is_Login) {
    getAuthId();
  }
  print("IsLogin" + is_Login.toString());
}

// For Internet Connection
Future<bool> isConnectedToInternet() async {
  is_InternetConnected = await SimpleConnectionChecker.isConnectedToInternet();
  print("IsConnected" + is_InternetConnected.toString());
  return is_InternetConnected;
}

shownoInternetDialoug(BuildContext context) {
  showDialog(
    barrierColor: Colors.black26,
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return NoInternetDialoug(
        context,
        title: "SoldOut",
        description:
            "This product may not be available at the selected address.",
        onRetryClick: () {},
      );
    },
  );
}

Text setRegularText(String text, int size, Color black) {
  return Text(
    text,
    maxLines: 1,
overflow: TextOverflow.ellipsis,
    style: TextStyle(
        fontFamily: Ember, fontSize: ScreenUtil().setSp(size), color: black),
    textAlign: TextAlign.start,
  );
}

Text setBoldText(String text, int size, Color black) {
  return Text(
    text,
    maxLines: 1,
    overflow: TextOverflow.ellipsis,
    style: TextStyle(
        fontFamily: EmberBold,
        fontWeight: FontWeight.bold,
        fontSize: ScreenUtil().setSp(size),
        color: black),
    textAlign: TextAlign.start,
  );
}

Text setItalicText(String text, int size, Color black) {
  return Text(
    text,
    style: TextStyle(
        fontFamily: EmberItalic,
        fontSize: ScreenUtil().setSp(size),
        color: black),
    textAlign: TextAlign.start,
  );
}

getAuthId() async {
  str_AuthId = await SharedPref.readString(str_Token);
  print("Auth" + str_AuthId.toString());
}

getUserId() async {
  str_UserId = await SharedPref.readString(str_IBO_Id);
  print("Auth" + str_UserId.toString());
}

Future<void> showLoadingDialog(
    BuildContext context, GlobalKey _key, String message) async {
  return Future.delayed(
    Duration.zero,
    () => {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          final width = MediaQuery.of(context).size.width / 2;
          final height = MediaQuery.of(context).size.height / 2;
          return Container(
            key: _key,
            height: height,
            width: width,
            color: Colors.white.withOpacity(0.2),
            child: Center(
              child: CircularProgressIndicator(color: Colors.cyan[400]),
            ),
          );
        },
      )
    },
  );
}

// For Show Progress
void showProgressbar() {
  showProgress = true;
}

// For Hide Progress
void hideProgressBar() {
  showProgress = false;
}

getDeviceId() async {
  var deviceInfo = DeviceInfoPlugin();
  var androidDeviceInfo = await deviceInfo.androidInfo;
  DeviceId = androidDeviceInfo.androidId.toString();
  print("DeviceId" + androidDeviceInfo.androidId.toString());

  return androidDeviceInfo.androidId.toString(); // Unique ID on Android
}

Future<void> _deviceDetails() async {
  final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
  var build = await deviceInfoPlugin.androidInfo;
  var identifier = build.androidId;
  print("DeviceId" + identifier.toString());
}

String getDeviceHeight(BuildContext context) {
  double device = MediaQuery.of(context).size.height;
  print("object" + device.toString());
  if (device < 700) {
    return "Small";
  } else {
    return "Medium";
  }
}

String removeDecimalAmount(String amount){
   if(amount.contains(".")){
    var arr = amount.split('.');
    amount = arr[0]; 
    return amount;
   }
   else {
    return amount;
   }
}

Future<bool> willPopCallback() async {
  // await showDialog or Show add banners or whatever
  // then
  return Future.value(true);
}

showBackPressAlert(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("No"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes"),
    onPressed: () {
      exit(0);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Alert"),
    content: Text("Are you sure want to exit from this app?"),
    actions: [
      cancelButton,
      continueButton,
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

showLogoutDialoug(BuildContext context) {
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("No"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes"),
    onPressed: () {
      clearSession(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Alert"),
    content: Text("Are you sure want to Logout?"),
    actions: [
      cancelButton,
      continueButton,
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

refreshApp(BuildContext context) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
          builder: (dialogContex) => TabScreen(
                int_Selectedtab: 0,
              )),
      ModalRoute.withName("/tabscreen"));

  // dsdsd
  // Navigator.push(
  //     context,
  //     PageTransition(
  //       type: PageTransitionType.fade,
  //       child: TabScreen(),
  //     ));
}

void clearSession(BuildContext context) async {
  await SharedPref.resetData();
  Navigator.pop(context);
  SharedPref.clearData();
  str_UserId = "";
  refreshApp(context);
}

void getCartCount() async {
  Future.delayed(Duration(seconds: 0), () {
    print("IsLogin" + is_Login.toString());
    if (!is_Login) {
      Service().getCartCount(DeviceId.toString(), "").then((value) => {
            int_CartCounters = value.data!.sumOfQty,
             QTYCount = value.data!.sumOfQty.toString(),
             cartCounter.setCartCountity(int_CartCounters)
          });
    } else {
      getUserId();
    }
  });

  Future.delayed(Duration(seconds: 0), () {
    print("IsLogin" + str_UserId.toString());
    Service()
        .getCartCount(DeviceId.toString(), str_UserId.toString())
        .then((value) => {
              int_CartCounters = value.data!.sumOfQty,
              QTYCount = value.data!.sumOfQty.toString(),
              cartCounter.setCartCountity(int_CartCounters)
            });
  });
}
