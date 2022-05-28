import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nebulashoppy/model/homescreen/itemNewLaunched.dart';
import 'package:nebulashoppy/model/homescreen/itemhomecategory.dart';
import 'package:nebulashoppy/network/service.dart';
import 'package:nebulashoppy/screen/categorylist.dart';
import 'package:nebulashoppy/screen/productdetail.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/SearchWidget.dart';
import '../model/homescreen/itembannerimage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../model/product.dart';
import '../widget/star_rating.dart';
import '../widget/trending_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_info_plus/device_info_plus.dart';

class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<ItembannerimageData> _listBannerImage = [];
  List<HomeCategoryData> _listHomeCategory = [];
  List<itemNewLaunchedProduct> _listNewLaunched = [];

  bool bl_IsNewLaunched = false;
  String categoryName = "";

  Map? _info;
  String device_Id = "";
  @override
  void initState() {
    super.initState();
    getBannerImage();
    getDeviceId();
    getCartCount();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    ScreenUtil.init(context);
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return Scaffold(
      body: SingleChildScrollView(
          child: ConstrainedBox(
        constraints: BoxConstraints(),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: Search(),
                  ),
                );
              },
              child: SearchWidget(),
            ),
            homeCategory(),
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
            topHeader("New Launch"),
            FutureBuilder(
              future: getNewLaunchedProduct(),
              builder: (context, snapshot) {
                if (_listNewLaunched.isEmpty) {
                  return loadSkeletonLoader(skeletonbuildNewLaunch());
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
                  return loadSkeletonLoader(skeletonbuildNewLaunch());
                } else {
                  return buildTranding();
                }
              },
            )
          ],
        ),
      )), // This trailing comma makes auto-formatting nicer for build methods.
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
                      mrp: '\$' + "Test"),
                  gradientColors: [Colors.white, Colors.white],
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
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          height: ScreenUtil().setHeight(200),
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
                          " " +
                          _listNewLaunched[index].salePrice.toString(),
                      mrp: rupees_Sybol +
                          " " +
                          _listNewLaunched[index].mrp.toString()),
                  gradientColors: [Colors.white, Colors.white],
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
        child: Text(
          str_Title,
          style: TextStyle(
              fontSize: ScreenUtil().setSp(20), fontWeight: FontWeight.bold),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  Container homeCategory() {
    return Container(
      margin: EdgeInsets.only(top: 6),
      height: ScreenUtil().setHeight(80),
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
                    width: ScreenUtil().setSp(60),
                    height: ScreenUtil().setSp(60),
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
                    child: Text(
                      _listHomeCategory[index].name.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontFamily: 'Regular',
                        color: Colors.black,
                      ),
                    ),
                  )
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
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          height: ScreenUtil().setHeight(200),
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
                        " " +
                        _listNewLaunched[index].salePrice.toString(),
                    mrp: rupees_Sybol +
                        " " +
                        _listNewLaunched[index].mrp.toString()),
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

  void getCartCount() async {
    setState(() {
      device_Id = DeviceId.toString();
    });
    Service().getCartCount(DeviceId.toString(), "").then((value) => {
          setState(() {
            int_CartCounters = value.data!.sumOfQty;
          })
        });
  }
}
