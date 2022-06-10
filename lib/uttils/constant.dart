// Routes
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nebulashoppy/screen/home.dart';
import 'package:nebulashoppy/screen/myorder/myorderdetail.dart';
import 'package:nebulashoppy/uttils/sharedpref.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:page_transition/page_transition.dart';

import '../main.dart';
import '../screen/address/editmyAddress.dart';
import '../widget/restartWidget.dart';

const HOME_SCREEN = 'home_screen';

const BASE_URL = "https://nebulacompanies.net/"; // Live

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
const WS_GET_CART_ITEM = '/API/ECom/GetCartItemsListWithoutUser';
const WS_REMOVE_CART_ITEM = '/API/ECom/RemoveFromCartWithoutUser';
const WS_GENERATE_TOKEN = '/API/Token';
const WS_LOGIN_VALIDATE_KEY = '/Api/NebProDashboard/IBOLogin';
const WS_GET_MY_ORDER_LIST = '/API/ECom/GetOrderList';
const WS_GET_MY_PROFILE = '/API/ECom/Me';
const WS_GET_E_WALLET = 'API/EComCouponCode/GetIBOWalletBalance';
const WS_GET_E_WALLET_History = 'API/EComCouponCode/GetIBOWalletList';
const WS_GET_CART_ITEM_WITH_LOGIN = '/API/ECom/GetCartItemsList';
const WS_GET_MY_ADDRESS = '/API/ECom/GetAddresses';
const WS_GET_DELETE_ADDRESS = '/API/ECom/DeleteAddress';
const WS_GET_STATE_LIST = '/API/Config/StateInfo';
const WS_GET_GENERATE_ORDER = '/API/Ecom/GenerateOrderPaytm';


const placeholder_path = 'assets/images/placeholder.jpg';
const rupees_Sybol = '\u{20B9}';
const Flag_Plus = 'plus';
const Flag_Minus = 'minus';
var DeviceId = '';
int int_CartCounters = 0;
String QTYCount = "0";
bool bl_ShowCart = true;

String str_ErrorMsg = "Opps! Something Wrong...";
String str_NoDataMsg = "No Data Found!";

// Message
const somethingWrong = "Opps Something Wrong!";

// Sharred Prefrences
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
const SHADOW_GRAY = Color.fromRGBO(0, 0, 0, 0.16);
const LIGHT_ACCENT_GRAY = Color(0xFFE5DBDD);
const PRODUCT_PRICE = Color(0xFF44293B);
const PRODUCT_OLD_PRICE = Color(0xFF898989);
const white = Color(0xFFffffff);
const THEME_COLOR = Colors.cyan;


  const kPurpleColor = Color(0xFFB97DFE);
   const kRedColor = Color(0xFFFE4067);
   const kGreenColor = Color(0xFFADE9E3);

     DateTime currentBackPressTime = DateTime.now();

showSnakeBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
    ),
  );
}

gotoNextScreen(BuildContext context, MyOrderDetail myOrderDetail){
 
}

checkUserLoginOrNot() async {
  is_Login = await SharedPref.readBool(str_IsLogin);
  if (is_Login) {
    getAuthId();
  }

  print("IsLogin" + is_Login.toString());
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

Future<bool> willPopCallback() async {
   // await showDialog or Show add banners or whatever
   // then
   return Future.value(true);
}



  showBackPressAlert(BuildContext context) {
 
  // set up the buttons
  Widget cancelButton = TextButton(
    child: Text("No"),
    onPressed:  () {
       Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes"),
    onPressed:  () {
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
    onPressed:  () {
       Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes"),
    onPressed:  () {
     SharedPref.resetData();
     Navigator.pop(context);
      runApp(MyApp());
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
  