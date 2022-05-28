// Routes
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:shimmer/shimmer.dart';
import 'package:device_info_plus/device_info_plus.dart';

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

const placeholder_path = 'assets/images/placeholder.jpg';
const rupees_Sybol = '\u{20B9}';
const Flag_Plus = 'plus';
const Flag_Minus = 'minus';
var DeviceId = '';
int int_CartCounters = 0;
// Message
const somethingWrong = "Opps Something Wrong!";

showSnakeBar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
    ),
  );
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
