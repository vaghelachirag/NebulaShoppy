import 'dart:convert';
import 'dart:io';
import 'package:nebulashoppy/model/getCartItemResponse/getCarItemResponse.dart';
import 'package:nebulashoppy/model/getEwallethistory/GetMyEwalletHistoryResponse.dart';
import 'package:nebulashoppy/model/getMyAddressResponse/getMyAddressResponse.dart';
import 'package:nebulashoppy/model/getMyAddressResponse/getdeleteAddressResponse.dart';
import 'package:nebulashoppy/model/getMyWallteResponse.dart/getMyWalletResponse.dart';
import 'package:nebulashoppy/model/getcartCountResponse/getAddToCartResponse.dart';
import 'package:nebulashoppy/model/getcartCountResponse/getcartCountResponse.dart';
import 'package:nebulashoppy/model/getloginresponse/getgeneratetokenresponse.dart';
import 'package:nebulashoppy/model/getloginresponse/getloginresponse.dart';
import 'package:nebulashoppy/model/getmyorderresponse/getmyorderresponse.dart';
import 'package:nebulashoppy/model/homescreen/itemNewLaunched.dart';
import 'package:nebulashoppy/model/homescreen/itembannerimage.dart';
import 'package:nebulashoppy/model/homescreen/itemhomecategory.dart';
import 'package:nebulashoppy/model/productdetail/itemproductdetail.dart';
import 'package:nebulashoppy/model/productdetail/itemproductdetailimage.dart';
import 'package:nebulashoppy/model/productdetail/itemproductvariant.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/network/EndPoint.dart';
import 'package:http/http.dart' as http;

import '../model/getMyProfileResponse/getMyProfileResponse.dart';
import '../model/productdetail/productbanner.dart';
import '../model/search/SearchProduct.dart';
import 'dart:convert';

class Service {
  Map<String, String> rerequestHeaders = Map();
  var requestHeaders = {
    "Content-Type": "application/json",
    "Accept": "application/json",
    "Access-Control-Allow-Origin": "*"
  };

  Future<Itembannerimage> getHomeBanner() async {
    var client = http.Client();
    var response = await client.get(
        Uri.parse(BASE_URL + WS_ADVERTISEMENT_IMAGES_ECOM),
        headers: requestHeaders);
    var json = response.body;
    // print("Response"+ json.toString());
    return itembannerimageFromJson(json);
  }

  Future<Itemhomecategory> getHomeCategory() async {
    var client = http.Client();
    var response = await client.get(Uri.parse(BASE_URL + WS_GET_CATEGORY_LIST),
        headers: requestHeaders);
    var json = response.body;
    return itemhomecategoryFromJson(json);
  }

  Future<ItemNewLaunched> getNewLaunched(
      String _catid, String pickupid, int pageindex, int pagelenth) async {
    var client = http.Client();
    var response = await client.get(
        Uri.parse(BASE_URL +
            WS_CATEGORY +
            "?" +
            "catid=" +
            _catid +
            "&" +
            "pickupid=" +
            pickupid +
            "&" +
            "PageIndex=" +
            pageindex.toString() +
            "&" "PageLength=" +
            pagelenth.toString()),
        headers: requestHeaders);
    var json = response.body;
    //   print("Json" + json.toString());
    return itemNewLaunchedFromJson(json);
  }

  Future<ItemNewLaunched> getProductListByCategory(
      String _catid, String pickupid, int pageindex, int pagelenth) async {
    var client = http.Client();
    var response = await client.get(
        Uri.parse(BASE_URL +
            WS_CATEGORY +
            "?" +
            "catid=" +
            _catid +
            "&" +
            "pickupid=" +
            pickupid +
            "&" +
            "PageIndex=" +
            pageindex.toString() +
            "&" "PageLength=" +
            pagelenth.toString()),
        headers: requestHeaders);
    // print("object " +
    //     BASE_URL +
    //     WS_CATEGORY +
    //     "?" +
    //     "catid=" +
    //     "1" +
    //     "&" +
    //     "pickupid=" +
    //     pickupid +
    //     "&" +
    //     "PageIndex=" +
    //     pageindex.toString() +
    //     "&" "PageLength=" +
    //     pagelenth.toString());
    var json = response.body;
    //  print("Json" + json.toString());
    return itemNewLaunchedFromJson(json);
  }

  Future<ProductBanner> getProductBanner(String _productid) async {
    var client = http.Client();
    var response = await client.get(
        Uri.parse(
            BASE_URL + WS_ProductBanner + "?" + "productid=" + _productid),
        headers: requestHeaders);
    var json = response.body;
    // print(
    //     "URL" + BASE_URL + WS_ProductBanner + "?" + "productid=" + _productid);
    return productBannerFromJson(json);
  }

  Future<SearchProduct> getSearchProduct() async {
    var client = http.Client();
    var response = await client.get(
        Uri.parse(BASE_URL + WS_GET_SEARCH + "?" + "searchtext=" + ""),
        headers: requestHeaders);
    var json = response.body;
    //  print("Json" + json.toString());
    return searchProductFromJson(json);
  }

  Future<ItemProductDetail> getProductDetail(
      String _productid, String pickupid) async {
    var client = http.Client();
    var response = await client.get(
        Uri.parse(BASE_URL +
            WS_GET_PRODUCT_DETAILS +
            "?" +
            "Id=" +
            _productid +
            "&" +
            "pickupid=" +
            pickupid),
        headers: requestHeaders);
    var json = response.body;
    //  print("Json" + json.toString());
    return itemProductDetailFromJson(json);
  }

  Future<ItemProductDetailImage> getProductDetailImage(
      String _productid) async {
    var client = http.Client();
    var response = await client.get(Uri.parse(BASE_URL +
        WS_GET_PRODUCT_DETAILS_IMAGE +
        "?" +
        "EComProductDetailsId=" +
        _productid));
    var json = response.body;

    //   print("ImageTest " + json.toString());
    return itemProductDetailImageFromJson(json);
  }

  Future<ItemProductVariant> getProductVarintData(
      String _pickupId, String _productId) async {
    var client = http.Client();
    var response = await client.get(Uri.parse(BASE_URL +
        WS_GET_PRODUCT_VARINT_DATA +
        "?" +
        "pickupid=" +
        _pickupId +
        "&" +
        "Id=" +
        _productId));
    var json = response.body;

    //  print("ProductVarint " + json.toString());
    return itemProductVariantFromJson(json);
  }

  Future<GetCartCountResponse> getCartCount(
      String _deviceid, String _userid) async {
    var client = http.Client();
    var response = await client.get(Uri.parse(BASE_URL +
        WS_GET_CART_COUNT +
        "?" +
        "deviceid=" +
        _deviceid +
        "&" +
        "userid=" +
        _userid));
    var json = response.body;

    print("ProductVarint " + json.toString());
    return getCartCountResponseFromJson(json);
  }

  Future<GetAddToCartResponse> getAddToCartResponse(
      String _deviceid,
      String _userid,
      String productid,
      String quantity,
      String cartFlag) async {
    var queryparams = {
      'deviceid': _deviceid,
      'userid': _userid,
      'productid': productid,
      'quantity': quantity,
      'CartFlag': cartFlag
    };

    Uri httpsUri = Uri(
        scheme: 'https',
        host: 'nebulacompanies.net',
        path: WS_ADD_TO_CART,
        queryParameters: queryparams);

    final response = await http.post(httpsUri);

    print("ResponseCode" + queryparams.toString());
    print("AddToCart" + httpsUri.toString());

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return GetAddToCartResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

  Future<dynamic> getCartItemWithoutLogin(
      String _deviceid, String _pickupid) async {
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL +
        WS_GET_CART_ITEM +
        "?" +
        "deviceid=" +
        _deviceid +
        "&" +
        "pickupid=" +
        _pickupid);
      var response = await client.get(uri);
      var jsons = response.body;

        final jsonBody = json.decode(response.body);
        print("MyJson"+ jsonBody["Data"].toString());

    if (response.statusCode == 200) { 
        if(jsonBody["Data"] == 0){
           return str_NoDataMsg;
        }
        else{
        return getCartlistItemFromJson(jsons);
        }
     
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
       return str_ErrorMsg;
    }
  }

   Future<GetAddToCartResponse> getCartRemoveItemWithoutLogin(
       String _deviceid, String productid) async {
    var queryparams = {
      'deviceid': _deviceid,
      'productid': productid
    };

    Uri httpsUri = Uri(
        scheme: 'https',
        host: 'nebulacompanies.net',
        path: WS_REMOVE_CART_ITEM,
        queryParameters: queryparams);

    final response = await http.post(httpsUri);

    print("ResponseCode" + queryparams.toString());
    print("AddToCart" + response.body.toString());

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return GetAddToCartResponse.fromJson(jsonDecode(response.body));
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

   Future<dynamic> getGenerateTokenResponse(String str_username, String str_password, String str_type) async {
   Map<String, dynamic> body = {'username': str_username, 'password': str_password,'grant_type': str_type};

   final response = await http.post(Uri.parse(BASE_URL +
        WS_GENERATE_TOKEN ),
       //body: body,
       body: body,
       headers: {
         "Accept": "application/json",
         "Content-Type": "application/x-www-form-urlencoded"
       },
       encoding: Encoding.getByName("utf-8")
   );

    print("Response"+ response.statusCode.toString());
    if (response.statusCode == 200) {
      return GetGenerateTokenresponse.fromJson(jsonDecode(response.body));
    } else {
     return str_ErrorMsg; 
    }
  }


 Future<dynamic> getLoginResponse(
      String _ibokey) async {
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL +
        WS_LOGIN_VALIDATE_KEY +
        "?" +
        "IBOKeyID=" +
        _ibokey);

   var response = await client.get(uri);
   var json = response.body;

     print("Response"+ response.statusCode.toString());

     if (response.statusCode == 200) {
      return GetLoginResponse.fromJson(jsonDecode(response.body));
    } else {
     return str_ErrorMsg;   
    }
  }

  Future<dynamic> getMyOrderList() async {
     requestHeaders = {
        'Authorization': '${str_AuthId}',
      };
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL +WS_GET_MY_ORDER_LIST );

   var response = await client.get(uri,headers: requestHeaders);
     if (response.statusCode == 200) {
      var json = response.body;
     print("Response"+ response.body.toString());
    return getMyOrderResponseFromJson(json);
    } else {
     return str_ErrorMsg;   
    }
  }

  
  Future<dynamic> getMyProfile() async {
     requestHeaders = {
        'Authorization': '${str_AuthId}',
      };
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL +WS_GET_MY_PROFILE );

   var response = await client.get(uri,headers: requestHeaders);
     if (response.statusCode == 200) {
      var json = response.body;
     print("Response"+ response.body.toString());
    return getMyProfileResponseFromJson(json);
    } else {
     return str_ErrorMsg;   
    }
  }

  
  Future<dynamic> getMyWalletResponse(
      String _ibokey) async {
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL +
        "API/EComCouponCode/GetIBOWalletBalance" +
        "?" +
        "IBOKeyID=" +
        _ibokey);

   var response = await client.get(uri);
   var json = response.body;

     if (response.statusCode == 200) {
      return GetMyWalletResponse.fromJson(jsonDecode(response.body));
    } else {
     return str_ErrorMsg;   
    }
  }



  Future<dynamic> getMyWalletHistoryResponse(
      String _ibokey) async {
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL +
        "API/EComCouponCode/GetIBOWalletList"+
        "?" +
        "IBOKeyID=" +
        _ibokey);

   var response = await client.get(uri);
   var json = response.body;

    print("Response"+ response.body.toString());

     if (response.statusCode == 200) {
      return getMyEwalletHistoryResponseFromJson(json);
    } else {
     return str_ErrorMsg;   
    }
  }


 Future<dynamic> getOrderSummery(
      String _deviceid, String userid,  String _pickupid) async {
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL +
        WS_GET_CART_ITEM_WITH_LOGIN +
        "?" +
        "deviceid=" +
        _deviceid +
        "&" +
         "userid=" +
         userid +
        "pickupid=" +
        _pickupid);
      var response = await client.get(uri);
      var jsons = response.body;

        final jsonBody = json.decode(response.body);
        print("MyJson"+ uri.toString());

    if (response.statusCode == 200) { 
        if(jsonBody["Data"] == 0){
           return str_NoDataMsg;
        }
        else{
        return getCartlistItemFromJson(jsons);
        }
     
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
       return str_ErrorMsg;
    }
  }

   Future<dynamic> getMyAddress() async {
  
     requestHeaders = {
        'Authorization': '${str_AuthId}',
      };
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL + WS_GET_MY_ADDRESS );

   var response = await client.get(uri,headers: requestHeaders);
     if (response.statusCode == 200) {
      var json = response.body;
     print("Response"+ response.body.toString());
    return getMyAddressResponseFromJson(json);
    } else {
     return str_ErrorMsg;   
    }
  }

   Future<dynamic> getDeletMyAddressResponse(
      String id) async {

          requestHeaders = {
        'Authorization': '${str_AuthId}',
      };

    var queryparams = {
      'id': id
    };

    Uri httpsUri = Uri(
        scheme: 'https',
        host: 'nebulacompanies.net',
        path: WS_GET_DELETE_ADDRESS,
        queryParameters: queryparams);

    final response = await http.post(httpsUri,headers: requestHeaders);
     print("Response"+ response.body.toString());
     var json = response.body;

    if (response.statusCode == 200) {
      // If the server did return a 201 CREATED response,
      // then parse the JSON.
      return getdeleteaddressResponseFromJson(json);
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      throw Exception('Failed to create album.');
    }
  }

}
