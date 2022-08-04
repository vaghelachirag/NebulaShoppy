import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nebulashoppy/model/homescreen/itemNewLaunched.dart';
import 'package:nebulashoppy/model/homescreen/itemhomecategory.dart';
import 'package:nebulashoppy/model/recentItemResponse/setRecentItem.dart';
import 'package:nebulashoppy/network/service.dart';
import 'package:nebulashoppy/screen/categorylist.dart';
import 'package:nebulashoppy/screen/productdetail.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/common_widget.dart';
import 'package:nebulashoppy/widget/noInternet.dart';
import 'package:nebulashoppy/widget/updateAppVersion.dart';
import '../database/sQLHelper.dart';
import '../model/homescreen/itembannerimage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../model/product.dart';
import '../uttils/sharedpref.dart';
import '../uttils/skeletonloader.dart';
import '../widget/cartCounter.dart';
import '../widget/star_rating.dart';
import '../widget/trending_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();

  static void updateCount() {
    print("Update" + "HomeUpdate");
  }
}

class _HomeState extends State<Home> with WidgetsBindingObserver {
  List<ItembannerimageData> _listBannerImage = [];
  List<HomeCategoryData> _listHomeCategory = [];
  List<itemNewLaunchedProduct> _listNewLaunched = [];
  List<SetRecentItemResponse> _listRecentView = [];

  bool bl_IsNewLaunched = false;
  String categoryName = "";

  Map? _info;
  String device_Id = "";

  DateTime currentBackPressTime = DateTime.now();


  @override
  void initState() {
    super.initState();
    // messaging = FirebaseMessaging.instance;
    //  messaging.getToken().then((value){
    //     print(value);
    // });
    WidgetsBinding.instance?.addObserver(this);
    getRegisterToken();
    isConnectedToInternet();
    getBannerImage();
    getDeviceId();
    checkUserLoginOrNot();
    getCartCount();
    setState(() {
      bl_ShowCart = true;
    });
    _refreshRecentData();
    getAppVersion();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var cartCounter = Provider.of<CartCounter>(context);
    cartCounter.setCartCountity(int_CartCounters);
    var size = MediaQuery.of(context).size;

    ScreenUtil.init(context);
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(int_AppBarWidth),
          child: appBarWidget(context, 3, "Home", true)),
      body: is_InternetConnected == false ? NoInternet(onRetryClick: () {
         onRetryClick();
         print("Home"+"Retry");
      },) :  
         WillPopScope(
          child: SingleChildScrollView(
              child: ConstrainedBox(
            constraints: BoxConstraints(),
            child: Column(
              children: [        
                FutureBuilder(
                  builder: (context, snapshot) {
                    if (_listBannerImage.isEmpty) {
                      return Container(
                        margin: EdgeInsets.only(top: 6),
                        height: ScreenUtil().setHeight(80),
                        child: loadSkeletonLoaders(
                            boxVerticalCategory(), Axis.horizontal),
                      );
                    } else {
                      return homeCategory();
                    }
                  },
                ),
                FutureBuilder(
                  builder: (context, snapshot) {
                    if (_listBannerImage.isEmpty) {
                      return loadSkeletonLoader(skeletontopbannerImage());
                    } else {
                      return topbannerImage();
                    }
                  },
                ),
                SizedBox(
                  height: 5.0,
                ),
                topHeader("Newly launched"),
                FutureBuilder(
                  future: getNewLaunchedProduct(),
                  builder: (context, snapshot) {
                    if (_listNewLaunched.isEmpty) {
                      return loadNewLaunchSkeleton();
                    } else {
                      return buildNewLaunch();
                    }
                  },
                ),
                topHeader("Trending"),
                FutureBuilder(
                  future: getNewLaunchedProduct(),
                  builder: (context, snapshot) {
                    if (_listNewLaunched.isEmpty) {
                      return loadNewLaunchSkeleton();
                    } else {
                      return buildTranding();
                    }
                  },
                ),
                SizedBox(
                  height: 2.0,
                ),
                FutureBuilder(
                  builder: (context, snapshot) {
                    if (_listRecentView.isEmpty) {
                      return Text("");
                    } else {
                      return buildRecentView();
                    }
                  },
                )
              ],
            ),
          )),
          onWillPop:
              onWillPop), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  getBannerImage() async {
    Service().getHomeBanner().then((value) => {
          if (this.mounted)
            {
              setState(() {
                if (value.statusCode == 1) {
                  _listBannerImage = value.data;
                  //  print("Categorylist" + "Get Data");
                  getHomeCategory();
                } else {
                  showSnakeBar(context, somethingWrong);
                  //  print("Categorylist" + "Opps Something Wrong!");
                }
              })
            }
        });
  }

  void getHomeCategory() async {
    Service().getHomeCategory().then((value) => {
          if (this.mounted)
            {
              setState((() {
                if (value.statusCode == 1) {
                  //  print("Categorylist" + value.message);
                  _listHomeCategory = value.data;
                  getNewLaunchedProduct();
                } else {
                  showSnakeBar(context, somethingWrong);
                  print("Categorylist" + "Opps Something Wrong!");
                }
              }))
            }
        });
  }

  getNewLaunchedProduct() async {
    Service().getNewLaunched("1", "0", 1, 50).then((value) => {
          setState((() {
            if (value.statusCode == 1) {
              // print("Categorylist" + value.message);
              _listNewLaunched = value.data.products;
            } else {
              showSnakeBar(context, somethingWrong);
              print("Categorylist" + "Opps Something Wrong!");
            }
          }))
        });
  }

  _productImage(List<itemNewLaunchedProduct> listNewLaunched) {
    return Stack(
      children: <Widget>[
        Center(
          child: Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(_listNewLaunched[0].mainImage.toString()),
                  fit: BoxFit.contain),
            ),
          ),
        )
      ],
    );
  }

  Column skeletonbuildNewLaunch() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          height: 200,
          child: ListView.builder(
              itemCount: 18,
              scrollDirection: Axis.horizontal,
              itemBuilder: (BuildContext ctx, index) {
                return TrendingItem(
                  product: Product(
                      id: 1,
                      productid: 1,
                      catid: 1,
                      company: "Test",
                      name: "Test",
                      icon: "Test",
                      rating: 5,
                      remainingQuantity: 5,
                      price: '\$' + "Test",
                      mrp: '\$' + "Test",
                      qunatity: 1),
                  gradientColors: [Colors.white, Colors.white],
                  onBackPressClicked: () {},
                );
              }),
        )
      ],
    );
  }

  Column buildNewLaunch() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          height: MediaQuery.of(context).size.height / 4,
          child: ListView.builder(
            itemCount: _listNewLaunched.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  showSnakeBar(context, "Click");
                },
                child: TrendingItem(
                  product: Product(
                      id: _listNewLaunched[index].id,
                      productid: _listNewLaunched[index].productId,
                      catid: _listNewLaunched[index].categoryId,
                      company: _listNewLaunched[index].name.toString(),
                      name: _listNewLaunched[index].shortDescription.toString(),
                      icon: _listNewLaunched[index].mainImage.toString(),
                      rating: 5,
                      remainingQuantity: 5,
                      price: rupees_Sybol +
                          "" +
                          _listNewLaunched[index].salePrice.toString(),
                      mrp: rupees_Sybol +
                          "" +
                          _listNewLaunched[index].mrp.toString(),
                      qunatity: _listNewLaunched[index].quantity),
                  gradientColors: [Colors.white, Colors.white],
                  onBackPressClicked: () {
                    _refreshRecentData();
                    getCartCount();
                  },
                ),
              );
              ;
            },
          ),
        )
      ],
    );
  }

  Column buildRecentView() {
    return Column(
      children: <Widget>[
        topHeader("Recently Viewed"),
        Container(
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          height: MediaQuery.of(context).size.height / 4,
          child: ListView.builder(
            itemCount: _listRecentView.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  // showSnakeBar(context, "Click");
                },
                child: TrendingItem(
                  product: Product(
                      id: int.parse(_listRecentView[index].pId.toString()),
                      productid: int.parse(_listRecentView[index].productId),
                      catid: int.parse(_listRecentView[index].ecbId),
                      company: _listRecentView[index].shortdesc.toString(),
                      name: _listRecentView[index].productName.toString(),
                      icon: _listRecentView[index].productImage.toString(),
                      rating: 5,
                      remainingQuantity: 5,
                      price: rupees_Sybol +
                          "" +
                          _listRecentView[index].categorySaleprice.toString(),
                      mrp: rupees_Sybol +
                          "" +
                          _listRecentView[index].mrp.toString(),
                      qunatity: 1),
                  gradientColors: [Colors.white, Colors.white],
                  onBackPressClicked: () {
                    _refreshRecentData();
                    getCartCount();
                  },
                ),
              );
              ;
            },
          ),
        )
      ],
    );
  }

  Container topHeader(String str_Title) {
    return Container(
      padding: EdgeInsets.all(5),
      child: Align(
          alignment: Alignment.topLeft,
          child: setBoldText(str_Title, 16, Colors.black)

          // Text(
          //   str_Title,
          //   style: TextStyle(
          //       fontFamily: 'Ember',
          //       fontSize: ScreenUtil().setSp(20), fontWeight: FontWeight.bold),
          //   textAlign: TextAlign.start,
          // ),
          ),
    );
  }

  Container homeCategory() {
    return Container(
      margin: EdgeInsets.only(top: 6),
      height: MediaQuery.of(context).size.height / 11,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _listHomeCategory.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print("Home" + "home");
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: CategoryList(
                      position: index, id: _listHomeCategory[index].id),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setSp(50),
                    height: ScreenUtil().setSp(40),
                    child: Container(
                      width: ScreenUtil().setSp(50),
                      height: ScreenUtil().setSp(50),
                      child: FadeInImage.assetNetwork(
                          placeholder: placeholder_path,
                          image: _listHomeCategory[index].image,
                          fit: BoxFit.contain),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: setRegularText(
                          _listHomeCategory[index].name.toString(),
                          12,
                          Colors.black))
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Column skeletontopbannerImage() {
    return Column(
      children: [
        Container(
            color: Colors.white,
            child: CarouselSlider.builder(
                itemCount: 1,
                itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) =>
                    Container(
                      margin: EdgeInsets.all(3.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      ),
                    ),
                options: CarouselOptions(
                  height: 150,
                  viewportFraction: 1,
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  enlargeCenterPage: true,
                )))
      ],
    );
  }

  Column topbannerImage() {
    return Column(
      children: [
        Container(
            color: Colors.white,
            child: CarouselSlider.builder(
                itemCount: _listBannerImage.length,
                itemBuilder: (BuildContext context, int itemIndex,
                        int pageViewIndex) =>
                    Container(
                      margin: EdgeInsets.all(3.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.all(Radius.circular(5.0)),
                        child: GestureDetector(
                          onTap: () {},
                          child: FadeInImage.assetNetwork(
                              placeholder: placeholder_path,
                              image: _listBannerImage[itemIndex].imageFile,
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                options: CarouselOptions(
                  height: 150,
                  viewportFraction: 1,
                  aspectRatio: 16 / 9,
                  autoPlay: true,
                  enlargeCenterPage: true,
                )))
      ],
    );
  }

  Column buildTranding() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(0),
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          height: MediaQuery.of(context).size.height / 4,
          child: ListView.builder(
            itemCount: _listNewLaunched.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return TrendingItem(
                product: Product(
                    id: _listNewLaunched[index].id,
                    productid: _listNewLaunched[index].productId,
                    catid: _listNewLaunched[index].categoryId,
                    company: _listNewLaunched[index].name.toString(),
                    name: _listNewLaunched[index].shortDescription.toString(),
                    icon: _listNewLaunched[index].mainImage.toString(),
                    rating: 5,
                    remainingQuantity: 5,
                    price: rupees_Sybol +
                        "" +
                        _listNewLaunched[index].salePrice.toString(),
                    mrp: rupees_Sybol +
                        "" +
                        _listNewLaunched[index].mrp.toString(),
                    qunatity: _listNewLaunched[index].quantity),
                onBackPressClicked: () {
                  _refreshRecentData();
                  getCartCount();
                },
                gradientColors: [Colors.white, Colors.white],
              );
            },
          ),
        )
      ],
    );
  }

  Shimmer loadSkeletonLoader(Column skeletonbuildNewLaunch) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      period: Duration(milliseconds: 2000),
      child: skeletonbuildNewLaunch,
    );
  }

  Future<bool> onWillPop() {
    print("BackPress" + "Backpress");
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
      now.difference(currentBackPressTime) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      return Future.value(false);
    }
    return Future.value(true);
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
      _refreshRecentData();
    } else if (state == AppLifecycleState.inactive) {
      // app is inactive
    } else if (state == AppLifecycleState.paused) {
      // user quit our app temporally
    } else if (state == AppLifecycleState.detached) {
      // user quit our app temporally
    }
  }

  _showPasswordDialog() {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text("Please enter your Password"),
            content: Container(
              child: TextField(),
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("OK"),
                onPressed: () {},
              )
            ],
          );
        });
  }

  void _refreshRecentData() async {
    _listRecentView.clear();
    final data = await SQLHelper.getItems();
    setState(() {
      for (int i = 0; i < data.length; i++) {
        String jsonString = data[i].toString();
        SetRecentItemResponse recentItem =
            new SetRecentItemResponse.fromJson(data[i]);
        _listRecentView.add(recentItem);
      }
    });
  }

// Register Token
  void getRegisterToken() async{
   var str_FcmToken = await SharedPref.readString(str_FCMToken);
   if(is_Login){
    getUserId();
     Future.delayed(Duration(seconds: 0), () {
      sendTokenToServer(str_FcmToken);
     });   
   }
   print("DeviceID"+ str_FcmToken);
  }

  void onRetryClick() {
    setState(() {
      isConnectedToInternet();
    });
  }

  void getAppVersion() {
       Service().getAppVersion()
        .then((value) => {
              if (value.toString() == str_ErrorMsg)
                {
                 print("Success"+"Fail")
                }
              else
                {
                //  showUpdateAppDialoug(),
                 print("Success" + value.data)
                }
            });
  }

  showUpdateAppDialoug() {
     showDialog(
      barrierColor: Colors.black26,
      context: context,
      builder: (context) {
        return UpdateAppVersion();
      },
    );
  }
  }

  // Send Token to Server
  void sendTokenToServer(str_fcmToken) {
    Service().getRegisterTokenResponse(str_fcmToken,"IMEI1","0",str_UserId)
        .then((value) => {
              if (value.toString() == str_ErrorMsg)
                {
                 print("Success"+"Fail")
                }
              else
                {
                 print("Success"+"Success")
                }
            });
}
