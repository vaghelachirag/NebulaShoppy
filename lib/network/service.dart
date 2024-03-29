import 'dart:convert';
import 'dart:io';
import 'package:nebulashoppy/model/generateorderresponse/generateorderResponse.dart';
import 'package:nebulashoppy/model/getAppVersionResponse/getAppVersionResponse.dart';
import 'package:nebulashoppy/model/getCartItemDeleteResponse/getCartItemDeleteResponse.dart';
import 'package:nebulashoppy/model/getCartItemResponse/getCarItemResponse.dart';
import 'package:nebulashoppy/model/getCityByStateResponse/getCityByStateResponse.dart';
import 'package:nebulashoppy/model/getEwallethistory/GetMyEwalletHistoryResponse.dart';
import 'package:nebulashoppy/model/getMyAddressResponse/getAddressByCityResponse.dart';
import 'package:nebulashoppy/model/getMyAddressResponse/getMyAddressResponse.dart';
import 'package:nebulashoppy/model/getMyAddressResponse/getdeleteAddressResponse.dart';
import 'package:nebulashoppy/model/getMyWallteResponse.dart/getMyWalletResponse.dart';
import 'package:nebulashoppy/model/getNewProductResponse/getNewProductResponse.dart';
import 'package:nebulashoppy/model/getSendPasswordOptionResponse/getSendPasswordOptionResponse.dart';
import 'package:nebulashoppy/model/getTrackOrderResponse/getTrackOrderResponse.dart';
import 'package:nebulashoppy/model/getcartCountResponse/getAddToCartResponse.dart';
import 'package:nebulashoppy/model/getcartCountResponse/getCartTotalResponse.dart';
import 'package:nebulashoppy/model/getcartCountResponse/getMyCartCountResponse.dart';
import 'package:nebulashoppy/model/getcartCountResponse/getcartCountResponse.dart';
import 'package:nebulashoppy/model/getgeneratepayumoneyresponse/getgeneatepaymoneyresponse.dart';
import 'package:nebulashoppy/model/getloginresponse/getgeneratetokenresponse.dart';
import 'package:nebulashoppy/model/getloginresponse/getloginresponse.dart';
import 'package:nebulashoppy/model/getmyorderresponse/getmyorderlistResponse.dart';
import 'package:nebulashoppy/model/getmyorderresponse/getmyorderresponse.dart';
import 'package:nebulashoppy/model/getoutofstockresponse/getoutofstockresponse.dart';
import 'package:nebulashoppy/model/getstateResponse.dart';
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
import '../model/getRegisterFcmTokenResponse/getRegisterFcmTokenResponse.dart';
import '../model/productdetail/productbanner.dart';
import '../model/search/SearchProduct.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

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
    print("HomeBanner" + BASE_URL + WS_ADVERTISEMENT_IMAGES_ECOM);
    return itembannerimageFromJson(json);
  }

  Future<itemHomeCategory> getHomeCategory() async {
     var getUsersData ;
   try {
      var response = await Dio().get(BASE_URL + WS_GET_CATEGORY_LIST );
      if (response.statusCode == 200) {
       getUsersData = response.data! ;
       var itemHome =  itemHomeCategory.fromJson(getUsersData);
        return itemHome;
      } else {
        throw Exception('Failed to load users');      
      }
    } catch (e) {
      print(e);
    }
    return  itemHomeCategory.fromJson(getUsersData);
  }

  
  Future<dynamic> getOrderList() async{
     Dio dio = new Dio();
     dio.options.headers['Authorization'] =  '${str_AuthId}';
     var response = await dio.get(BASE_URL + WS_GET_MY_ORDER_LIST );
      var getUsersData ;
      if (response.statusCode == 200) {
        getUsersData = response.data ;
        var itemHome =  getMyOrderListResponse.fromJson(getUsersData);
      } else {
        throw Exception('Failed to load users'); 
      }
  }


  Future<dynamic> getNewLaunched(
      String _catid, String pickupid, int pageindex, int pagelenth) async {
    var getProduct ;
  
   try {
      var response = await Dio().get(BASE_URL +
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
            pagelenth.toString());
            
      if (response.statusCode == 200) {
        getProduct = response.data ;
        var itemProduct =  ItemNewLaunched.fromJson(getProduct);
        return itemProduct;
      } else {
        throw Exception('Failed to load users');  
      }
    } catch (e) {
      print(e);
    }
    return ItemNewLaunched.fromJson(getProduct);
  }

  Future<dynamic> getProductListByCategory(
      String _catid, String pickupid, int pageindex, int pagelenth) async {
          var getProduct ;
  try {  
      var response = await Dio().get(BASE_URL +
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
            pagelenth.toString());
            
      if (response.statusCode == 200) {
        getProduct = response.data ;
       var itemProduct =  ItemNewLaunched.fromJson(getProduct);
        return getProduct;
      } else {
        throw Exception('Failed to load users');
      }
    } catch (e) {
      print(e);
    }
    return ItemNewLaunched.fromJson(getProduct);
  }

  Future<dynamic> getProductBanner(String _productid) async {
    var client = http.Client();
    dynamic response = await client.get(
        Uri.parse(
            BASE_URL + WS_ProductBanner + "?" + "productid=" + _productid),
        headers: requestHeaders);
    dynamic jsons = response.body;
    
      final jsonBody = json.decode(response.body);
      if (response.statusCode == 200) {
      if (jsonBody["StatusCode"] == 0) {
        return str_NoDataMsg;
      } else {
        return getProductBannerImageResponseFromJson(jsons);
      }
    } else {
      return str_ErrorMsg;
    }
  }

  // Future<SearchProduct> getSearchProduct() async {
  //   var client = http.Client();
  //   var response = await client.get(
  //       Uri.parse(BASE_URL + WS_GET_SEARCH + "?" + "searchtext=" + ""),
  //       headers: requestHeaders);
  //   var json = response.body;
  //     print("Json" + BASE_URL + WS_GET_SEARCH + "?" + "searchtext=" + "");
  //   return searchProductFromJson(json);
  // }


 Future<getSearchDataResonse> getSearchProduct() async{
    Dio dio = new Dio();
     var response = await dio.get(BASE_URL + WS_GET_SEARCH + "?" + "searchtext=" + "");
      var getUsersData ;
      if (response.statusCode == 200) {
        getUsersData = response.data ;
        var itemHome =  getSearchDataResonse.fromJson(getUsersData);
         print("Data"+itemHome.data![0].name.toString());
      } else {
        throw Exception('Failed to load users'); 
      }
      return getSearchDataResonse.fromJson(getUsersData);
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
    print("ProductDetailJson" +
        BASE_URL +
        WS_GET_PRODUCT_DETAILS +
        "?" +
        "Id=" +
        _productid +
        "&" +
        "pickupid=" +
        pickupid.toString());
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
    Uri uri = Uri.parse(BASE_URL +
        WS_GET_PRODUCT_VARINT_DATA +
        "?" +
        "pickupid=" +
        _pickupId +
        "&" +
        "Id=" +
        _productId);
    var response = await client.get(uri);
    var json = response.body;

    print("ProductVarint" + uri.toString());
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
        str_UserId));
    var json = response.body;

    print("CartCount"+ BASE_URL +
        WS_GET_CART_COUNT +
        "?" +
        "deviceid=" +
        _deviceid +
        "&" +
        "userid=" +
        str_UserId);

    return getCartCountResponseFromJson(json);
  }

 Future<getMyCartCountResponse> getMyCartCount(
      String _deviceid, String _userid) async {

     Dio dio = new Dio();
      var response = await dio.get(BASE_URL + WS_GET_CART_COUNT +
        "?" +
        "deviceid=" +
        _deviceid +
        "&" +
        "userid=" +
        str_UserId);
    
      var getCartCounter ;
      if (response.statusCode == 200) {
        getCartCounter = response.data ;
        var itemHome =  getMyCartCountResponse.fromJson(getCartCounter);
         print("Data"+itemHome.data.sumOfQty.toString());
      } else {
        throw Exception('Failed to load users'); 
      }
    return getMyCartCountResponse.fromJson(getCartCounter);
  }


  Future<GetCartTotalResponse> getCartTotal(
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

    // print("ProductVarint " + json.toString());
    return getCartTotalResponseFromJson(json);
  }

   Future<dynamic> getNewProductList() async {
    var client = http.Client();
    dynamic response = await client.get(
        Uri.parse(BASE_URL + WS_GET_NEW_PRODUCT_LIST));
    dynamic jsons = response.body;
    
      final jsonBody = json.decode(response.body);
      if (response.statusCode == 200) {
      if (jsonBody["StatusCode"] == 0) {
        return str_NoDataMsg;
      } else {
        return getNewProductResponseFromJson(jsons);
      }
    } else {
      return str_ErrorMsg;
    }
  }

 Future<GetAddToCartResponse> getAddToCartResponse(String _deviceid,
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
     var itemaddtocart ;
     Uri httpsUri = Uri.https(Host, WS_ADD_TO_CART, queryparams);
     var response = await Dio().postUri(httpsUri);
      if (response.statusCode == 200) {
        var getUsersData = response.data ;
        itemaddtocart = GetAddToCartResponse.fromJson(getUsersData);
        print("User Data"+ getUsersData.toString());
        return itemaddtocart;
      } else {
        throw Exception('Failed to load users');     
      } 
  }

  // Future<GetAddToCartResponse> getAddToCartResponse(
  //     String _deviceid,
  //     String _userid,
  //     String productid,
  //     String quantity,
  //     String cartFlag) async {

  //   var queryparams = {
  //     'deviceid': _deviceid,
  //     'userid': _userid,
  //     'productid': productid,
  //     'quantity': quantity,
  //     'CartFlag': cartFlag
  //   };

  //   Uri httpsUri = Uri.https(Host, WS_ADD_TO_CART, queryparams);
  //   final response = await http.post(httpsUri);
  //   print("ResponseCode" + httpsUri.toString() + " "+ queryparams.toString());
  //   print("AddToCart" + httpsUri.toString());

  //   if (response.statusCode == 200) {
  //     return GetAddToCartResponse.fromJson(jsonDecode(response.body));
  //   } else {
  //     throw Exception('Failed to create album.');
  //   }
  // }

  Future<dynamic> getCartItemWithoutLogin(
      String _deviceid, String _pickupid) async {
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL +
        WS_GET_CART_WITHOUT_LOGIN_ITEM +
        "?" +
        "deviceid=" +
        _deviceid +
        "&" +
        "pickupid=" +
        _pickupid);
    var response = await client.get(uri);
    var jsons = response.body;

    final jsonBody = json.decode(response.body);
    print("MyJson" + jsonBody["Data"].toString());

    if (response.statusCode == 200) {
      if (jsonBody["Data"] == 0) {
        return str_NoDataMsg;
      } else {
        return getCartlistItemFromJson(jsons);
      }
    } else {
      // If the server did not return a 201 CREATED response,
      // then throw an exception.
      return str_ErrorMsg;
    }
  }

  Future<dynamic> getCartItemWithLogin(
      String _deviceid, String _pickupid, String _userid) async {
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL +
        WS_GET_CART_WITH_LOGIN_ITEM +
        "?" +
        "deviceid=" +
        _deviceid +
        "&" +
        "pickupid=" +
        _pickupid +
        "&" +
        "userid=" +
        _userid);
    var response = await client.get(uri);
    var jsons = response.body;

    final jsonBody = json.decode(response.body);
    print("MyJson" +
        BASE_URL +
        WS_GET_CART_WITH_LOGIN_ITEM +
        "?" +
        "deviceid=" +
        _deviceid +
        "&" +
        "pickupid=" +
        _pickupid +
        "&" +
        "userid=" +
        _userid);

    if (response.statusCode == 200) {
      if (jsonBody["Message"] == 'No records found!') {
        return str_NoDataMsg;
      } else {
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
    var queryparams = {'deviceid': _deviceid, 'productid': productid};

    Uri httpsUri = Uri(
        scheme: Scheme,
        host: Host,
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

  Future<GetAddToCartResponse> getCartRemoveItemWithLogin(
      String _deviceid, String productid, String userId) async {
    var queryparams = {
      'deviceid': _deviceid,
      'productid': productid,
      'userid': userId
    };

    Uri httpsUri = Uri(
        scheme: Scheme,
        host: Host,
        path: WS_REMOVE_CART,
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

  Future<dynamic> getGenerateTokenResponse(
      String str_username, String str_password, String str_type) async {
    Map<String, dynamic> body = {
      'username': str_username,
      'password': str_password,
      'grant_type': str_type
    };

    final response = await http.post(Uri.parse(BASE_URL + WS_GENERATE_TOKEN),
        //body: body,
        body: body,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        encoding: Encoding.getByName("utf-8"));

    print("Response" + response.statusCode.toString());
    if (response.statusCode == 200) {
      return GetGenerateTokenresponse.fromJson(jsonDecode(response.body));
    } else {
      return str_ErrorMsg;
    }
  }

  Future<dynamic> getRegisterTokenResponse(String str_TokenKey,
      String str_IMEI1, String str_IMEI2, String str_UserId) async {
    Map<String, dynamic> body = {
      'TokenKey': str_TokenKey,
      'IMEI1': str_IMEI1,
      'IMEI2': str_IMEI2,
      'UserId': str_UserId
    };

    final response = await http.post(Uri.parse(BASE_URL + WS_REGISTER_TOKEN),
        //body: body,
        body: body,
        encoding: Encoding.getByName("utf-8"));

    print("Response" + response.statusCode.toString());

    if (response.statusCode == 200) {
      return GetRegisterFcmResponse.fromJson(jsonDecode(response.body));
    } else {
      return str_ErrorMsg;
    }
  }

  Future<dynamic> getDeleteCartResponse(String issuccess, String userid, String deviceid) async {
    
      var queryparams = {
      'issuccess': issuccess,
      'userid': userid,
      'deviceid': deviceid
    };

    Uri httpsUri = Uri(
        scheme: Scheme,
        host: Host,
        path: WS_GET_DELETE_CART,
        queryParameters: queryparams);

    final response = await http.post(httpsUri);

    print("Response" + response.toString());

    if (response.statusCode == 200) {
      return GetDeleteCartResponse.fromJson(jsonDecode(response.body));
    } else {
      return str_ErrorMsg;
    }
  }

  Future<dynamic> getLoginResponse(String _ibokey) async {
    var client = http.Client();
    Uri uri = Uri.parse(
        BASE_URL + WS_LOGIN_VALIDATE_KEY + "?" + "IBOKeyID=" + _ibokey);

    var response = await client.get(uri);
    var json = response.body;

    print("Response" + response.statusCode.toString());

    if (response.statusCode == 200) {
      return GetLoginResponse.fromJson(jsonDecode(response.body));
    } else {
      return str_ErrorMsg;
    }
  }

  Future<dynamic> getSendPasswordOptionResponse(String _ibokey) async {
    var client = http.Client();
    Uri uri = Uri.parse(
        BASE_URL + WS_FORGOT_PASSWORD_OPTION + "?" + "IBOID=" + _ibokey);

    var response = await client.get(uri);
    var json = response.body;

    if (response.statusCode == 200) {
      return GetSendPasswordOptionResponse.fromJson(jsonDecode(response.body));
    } else {
      return str_ErrorMsg;
    }
  }

  Future<dynamic> getMyOrderList() async {
    requestHeaders = {
      'Authorization': '${str_AuthId}',
    };
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL + WS_GET_MY_ORDER_LIST);

      print("Response" + BASE_URL + WS_GET_MY_ORDER_LIST);

    var response = await client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print("Response" + response.body.toString());
      return getMyOrderResponseFromJson(json);
    } else {
      return str_ErrorMsg;
    }
  }

  Future<dynamic> getTrackMyOrder(String orderId) async {
      var client = http.Client();
    Uri uri = Uri.parse(
        BASE_URL + WS_GET_TRACk_ORDER + "?" + "order_id=" + orderId);

    var response = await client.get(uri);
    var json = response.body;
    if (response.statusCode == 200) {
       print("Tracking"+ response.statusCode.toString());
      return getTrackOrderResponseFromJson(json);
    } else {
      return str_ErrorMsg;
    }
  }

  Future<dynamic> getMyProfile() async {
    requestHeaders = {
      'Authorization': '${str_AuthId}',
    };
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL + WS_GET_MY_PROFILE);

    var response = await client.get(uri, headers: requestHeaders);
    if (response.statusCode == 200) {
      var json = response.body;
      print("Response" + response.body.toString());
      return getMyProfileResponseFromJson(json);
    } else {
      return str_ErrorMsg;
    }
  }

  Future<dynamic> getMyWalletResponse(String _ibokey) async {
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL +
        "API/EComCouponCode/GetIBOWalletBalance" +
        "?" +
        "IBOKeyID=" +
        _ibokey);

    var response = await client.get(uri);
    var json = response.body;

    print("EWalltet" + json.toString());

    if (response.statusCode == 200) {
      return GetMyWalletResponse.fromJson(jsonDecode(response.body));
    } else {
      return str_ErrorMsg;
    }
  }

  Future<dynamic> getMyWalletHistoryResponse(String _ibokey) async {
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL +
        "API/EComCouponCode/GetIBOWalletList" +
        "?" +
        "IBOKeyID=" +
        _ibokey);

    var response = await client.get(uri);
    var json = response.body;

    print("Response" + BASE_URL +
        "API/EComCouponCode/GetIBOWalletList" +
        "?" +
        "IBOKeyID=" +
        _ibokey);

    if (response.statusCode == 200) {
      return getMyEwalletHistoryResponseFromJson(json);
    } else {
      return str_ErrorMsg;
    }
  }

  Future<dynamic> getOrderSummery(
      String _deviceid, String userid, String _pickupid) async {
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
    print("MyJson" + uri.toString());

    if (response.statusCode == 200) {
      if (jsonBody["Data"] == 0) {
        return str_NoDataMsg;
      } else {
        return getCartlistItemFromJson(jsons);
      }
    } else {
      return str_ErrorMsg;
    }
  }

  Future<dynamic> getMyAddress() async {
    requestHeaders = {
      'Authorization': '${str_AuthId}',
    };
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL + WS_GET_MY_ADDRESS);

    var response = await client.get(uri, headers: requestHeaders);
     print("Response" + BASE_URL + WS_GET_MY_ADDRESS);
    if (response.statusCode == 200) {
      var json = response.body;
      print("Response" + uri.toString()+ " ");
      return getMyAddressResponseFromJson(json);
    } else {
      return str_ErrorMsg;
    }
  }

  Future<dynamic> getStateListResponse(String country) async {
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL +
        "API/EComCouponCode/GetIBOWalletList" +
        "?" +
        "IBOKeyID=" +
        country);

    var response = await client.get(uri);
    var json = response.body;

    print("Response" + response.body.toString());

    if (response.statusCode == 200) {
      return getMyEwalletHistoryResponseFromJson(json);
    } else {
      return str_ErrorMsg;
    }
  }

  Future<dynamic> getCityByState(String stateId) async {
    var client = http.Client();
    Uri uri = Uri.parse(
        BASE_URL + WS_GET_CITYLIST_BY_STATE + "?" + "StateId=" + stateId);

    var response = await client.get(uri);
    var json = response.body;
    print("Response" + response.body.toString());
    if (response.statusCode == 200) {
      return getCityByStateResponseFromJson(json);
    } else {
      return str_ErrorMsg;
    }
  }

  Future<dynamic> getDeletMyAddressResponse(String id) async {
    requestHeaders = {
      'Authorization': '${str_AuthId}',
    };
    var queryparams = {'id': id};
    Uri httpsUri = Uri(
        scheme: Scheme,
        host: Host,
        path: WS_GET_DELETE_ADDRESS,
        queryParameters: queryparams);

    final response = await http.post(httpsUri, headers: requestHeaders);
    print("Response" + response.body.toString());
    var json = response.body;

    if (response.statusCode == 200) {
      return getdeleteaddressResponseFromJson(json);
    } else {
      throw Exception('Failed to create album.');
    }
  }

  Future<GetstateResponse> getStateList() async {
    var client = http.Client();
    var response = await client.get(
        Uri.parse(
            BASE_URL + WS_GET_STATE_LIST + "?" + "CountryName=" + "India"),
        headers: requestHeaders);
    var json = response.body;
    print("object" + json.toString());
    return getstateResponseFromJson(json);
  }

  Future<GetAddressByCityResponse> getAddressByCitySelection(String cityId) async {
    var client = http.Client();
    var response = await client.get(
        Uri.parse(BASE_URL + WS_GET_ADDRESS_BY_CITY + "?" + "cityId=" + cityId),
        headers: requestHeaders);
    var json = response.body;
    print("object" + json.toString());
    return getAddressByCityResponseFromJson(json);
  }

  Future<dynamic> getAddNewAddressResponse(
      String _mobile,
      String _fullName,
      String _addressLine1,
      String _addressLine2,
      String _landmark,
      String _city,
      String _state,
      String _pinCode,
      String _addressType,
      String _deviceid) async {
     
    requestHeaders = {
      'Authorization': '${str_AuthId}',
    };
    var queryparams = {
      'mobile': _mobile,
      'fullName': _fullName,
      'addressLine1': _addressLine1,
      'addressLine2': _addressLine2,
      'landmark': _landmark,
      'city': _city,
      'state': _state,
      'pinCode': _pinCode,
      'addressType': _addressType,
      'deviceid': _deviceid
    };

    
     var itemaddtocart ;

    Uri httpsUri = Uri(
        scheme: 'https',
        host: Host,
        path: WS_GET_ADD_ADDRESS,
        queryParameters: queryparams);
      Dio dio = new Dio();
      dio.options.headers['Authorization'] = '${str_AuthId}';
     var response = await dio.postUri(httpsUri);
      if (response.statusCode == 200) {
        var getUsersData = response.data ;
        itemaddtocart = GetAddToCartResponse.fromJson(getUsersData);
        print("User Data"+ getUsersData.toString());
        return itemaddtocart;
      } else {
        throw Exception('Failed to load users');     
      } 
  }

  Future<dynamic> getEditAddressResponse(
      String _mobile,
      String _fullName,
      String _addressLine1,
      String _addressLine2,
      String _landmark,
      String _city,
      String _state,
      String _pinCode,
      String _addressType,
      String _id) async {
    requestHeaders = {
      'Authorization': '${str_AuthId}',
    };
    var queryparams = {
      'mobile': _mobile,
      'fullName': _fullName,
      'addressLine1': _addressLine1,
      'addressLine2': _addressLine2,
      'landmark': _landmark,
      'city': _city,
      'state': _state,
      'pinCode': _pinCode,
      'addressType': _addressType,
      'id': _id
    };
       
     var itemaddtocart ;
     Uri httpsUri = Uri.https(Host, WS_GET_EDIT_ADDRESS, queryparams);
      Dio dio = new Dio();
      dio.options.headers['Authorization'] = '${str_AuthId}';
     var response = await dio.postUri(httpsUri);
      if (response.statusCode == 200) {
        var getUsersData = response.data ;
        itemaddtocart = GetAddToCartResponse.fromJson(getUsersData);
        print("User Data"+ getUsersData.toString());
        return itemaddtocart;
      } else {
        throw Exception('Failed to load users');     
      } 
  }

  Future<GetGenerateOrderResponse> getGenerateOrderResponse(
      String _IboId,
      String _totalAmount,
      String _paymentid,
      String _signature,
      String _addresstype,
      String _shippingaddress,
      String _billingaddress,
      String _pickuppoint,
      String _paymentmode,
      String _IsWaiveOff,
      String _UserPaymentType,
      String _ewalletamt) async {
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL +
        WS_GET_GENERATE_ORDER +
        "?" +
        "IBOKeyId=" +
        _IboId +
        "&" +
        "TotalAmount=" +
        _totalAmount +
        "&" +
        "paymentid=" +
        _paymentid +
        "&" +
        "signature=" +
        _signature +
        "&" +
        "addresstype=" +
        _addresstype +
        "&" +
        "shippingaddress=" +
        _shippingaddress +
        "&" +
        "billingaddress=" +
        _billingaddress +
        "&" +
        "pickuppoint=" +
        _pickuppoint +
        "&" +
        "paymentmode=" +
        _paymentmode +
        "&" +
        "IsWaiveOff=" +
        _IsWaiveOff +
        "&" +
        "UserPaymentType=" +
        _UserPaymentType +
        "&" +
        "ewalletamt=" +
        _ewalletamt);
    print("Uri" + uri.toString());
    var response = await client.get(uri);
    var jsons = response.body;

    return getGenerateOrderResponseFromJson(jsons);
  }

  Future<GenerateOrderPayUMoney> getGenerateOrderPayUResponse(
      String _IboId,
      String _totalAmount,
      String _paymentid,
      String _signature,
      String _addresstype,
      String _shippingaddress,
      String _billingaddress,
      String _pickuppoint,
      String _paymentmode,
      String _IsWaiveOff,
      String _UserPaymentType,
      String _ewalletamt) async {
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL +
        WS_GET_GENERATE_ORDER_PAYUMONEY +
        "?" +
        "IBOKeyId=" +
        _IboId +
        "&" +
        "TotalAmount=" +
        _totalAmount +
        "&" +
        "paymentid=" +
        _paymentid +
        "&" +
        "signature=" +
        _signature +
        "&" +
        "addresstype=" +
        _addresstype +
        "&" +
        "shippingaddress=" +
        _shippingaddress +
        "&" +
        "billingaddress=" +
        _billingaddress +
        "&" +
        "pickuppoint=" +
        _pickuppoint +
        "&" +
        "paymentmode=" +
        _paymentmode +
        "&" +
        "IsWaiveOff=" +
        _IsWaiveOff +
        "&" +
        "UserPaymentType=" +
        _UserPaymentType +
        "&" +
        "ewalletamt=" +
        _ewalletamt);
    print("Uri" + uri.toString());
    var response = await client.get(uri);
    var jsons = response.body;

    return generateOrderPayUMoneyFromJson(jsons);
  }


   Future<dynamic> getProductAvailabilityCheck(String pickupid) async {
       requestHeaders = {
      'Authorization': '${str_AuthId}',
    };
    var client = http.Client();

     Uri uri = Uri.parse(BASE_URL +
       WS_GET_PRODUCT_AVAILABILITY+ "?" +
        "pickupid=" +
        "0");
  
    var response = await client.get(uri, headers: requestHeaders);
    var json = response.body;

    print("Response" + BASE_URL +
       WS_GET_PRODUCT_AVAILABILITY+
        "?" +
        "pickupid=" +
        "0" + requestHeaders.toString());

    if (response.statusCode == 200) {
      return getProductAvailabilityCheck(json);
    } else {
      return str_ErrorMsg;
    }
  }

  
  Future<GetAppVersionResponse> getAppVersion() async {
    var client = http.Client();
    var response = await client.get(Uri.parse(BASE_URL + WS_GET_APP_VERISON));
    var json = response.body;
    print("Json" + json.toString());
    return getAppVersionResponseFromJson(json);
  }

   Future<dynamic> getOutOfStockResponse(String userId, String str_selectedAddressType) async {
     requestHeaders = {
      'Authorization': '${str_AuthId}',
    };
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL +WS_GET_OUT_OF_STOCK+ "?" + "pickupid=" + str_selectedAddressType);
    var response = await client.get(uri, headers: requestHeaders);
    var jsons = response.body;
    final jsonBody = json.decode(response.body);
    if (response.statusCode == 200) {
      if(jsonBody["Data"]["Count"] == 0){
           return str_NoDataMsg;
      }
      else{
       print("Status"+ jsonBody["Data"]["Count"].toString());
       return jsonBody;
      }      
    } else {
      return str_ErrorMsg;
    }
  }

    Future<dynamic> getRemoveOutOfStock(String userId,String pickupId) async {
      print("Remove"+ (BASE_URL + WS_GET_REMOVE_OUT_OF_STOCK+ "?" + "pickupid=" + pickupId));
     requestHeaders = {
      'Authorization': '${str_AuthId}',
    };
    var client = http.Client();
    Uri uri = Uri.parse(BASE_URL + WS_GET_REMOVE_OUT_OF_STOCK+ "?" + "pickupid=" + pickupId);
    var response = await client.get(uri, headers: requestHeaders);
    print("Remove"+ (BASE_URL + WS_GET_REMOVE_OUT_OF_STOCK+ "?" + "pickupid=" + pickupId));
    var jsons = response.body;
    final jsonBody = json.decode(response.body);
    if (response.statusCode == 200) {
      return jsonBody;   
    } else {
      return str_ErrorMsg;
    }
  }
}
