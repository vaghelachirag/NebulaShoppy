import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/uttils/CircularProgress.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/categoryproductWidget.dart';
import 'package:nebulashoppy/widget/common_widget.dart';
import 'package:page_transition/page_transition.dart';

import '../model/homescreen/itemNewLaunched.dart';
import '../model/homescreen/itemhomecategory.dart';
import '../model/product.dart';
import '../network/service.dart';
import '../uttils/constant.dart';
import '../uttils/skeletonloader.dart';
import '../widget/trending_item.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:community_material_icon/community_material_icon.dart';

class CategoryList extends StatefulWidget {
  int position, id;
  CategoryList({Key? key, required this.position, required this.id})
      : super(key: key);
  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>
    with WidgetsBindingObserver {
  List<HomeCategoryData> _listHomeCategory = [];
  List<itemNewLaunchedProduct> _listproductList = [];

  get somethingWrong => null;
  var selectedPosition = 0;
  var selectedId = 0;
  String device_Id = "";

  final GlobalKey<State> _dialogKey = GlobalKey<State>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    selectedPosition = widget.position;
    selectedId = widget.id;
    getDeviceId();
    getCartCount();
    getHomeCategory();
    checkUserLoginOrNot();
  }

  @override
  void dispose() {
    // Remove the observer
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    // These are the callbacks
    switch (state) {
      case AppLifecycleState.resumed:
        // widget is resumed
        print("Activity" + "Resume");
        getCartCount();
        break;
      case AppLifecycleState.inactive:
        print("Activity" + "Inactive");
        // widget is inactive
        break;
      case AppLifecycleState.paused:
        print("Activity" + "Paused");
        // widget is paused
        break;
      case AppLifecycleState.detached:
        print("Activity" + "Detached");
        // widget is detached
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: appBarWidget(context, 3, "Product List", true)),
      body: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          //homeCategory(),
          FutureBuilder(
            builder: (context, snapshot) {
              if (_listHomeCategory.isEmpty) {
                return loadhomeCategorySkeleton();
              } else {
                return homeCategory();
                //  return setCategoryList(false);
              }
            },
          ),
          FutureBuilder(
            builder: (context, snapshot) {
              if (_listproductList.isEmpty) {
                return loadSkeletonLoadersGrid(
                    boxProductCatWise(context), Axis.horizontal, context);
              } else {
                return setCategoryList(false);
                //  return setCategoryList(false);
              }
            },
          )
        ],
      ),
    );
  }

  void getHomeCategory() async {
    Service().getHomeCategory().then((value) => {
          setState((() {
            if (value.statusCode == 1) {
              //  print("Categorylist" + value.message);
              _listHomeCategory = value.data;
              getProductListByCategory(selectedId.toString());
            } else {
              showSnakeBar(context, somethingWrong);
              //  print("Categorylist" + "Opps Something Wrong!");
            }
          }))
        });
  }

  getNewLaunchedProduct() async {
    Service().getNewLaunched("1", "0", 1, 50).then((value) => {
          setState((() {
            if (value.statusCode == 1) {
              // print("Categorylist" + value.statusCode.toString());
              _listproductList = value.data.products;
            } else {
              showSnakeBar(context, somethingWrong);
              //  print("Categorylist" + "Opps Something Wrong!");
            }
          }))
        });
  }

  Container homeCategory() {
    return Container(
      color: Colors.blueGrey[50],
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width / 4,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _listHomeCategory.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.only(top: 20),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  print(
                      "Home" + "home" + _listHomeCategory[index].id.toString());
                  _listproductList.clear();
                  getProductListByCategory(
                      _listHomeCategory[index].id.toString());
                  selectedPosition = index;
                  print("Home" + selectedPosition.toString());
                });
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      width: selectedPosition == index
                          ? ScreenUtil().setSp(65)
                          : ScreenUtil().setSp(50),
                      height: selectedPosition == index
                          ? ScreenUtil().setSp(65)
                          : ScreenUtil().setSp(50),
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(_listHomeCategory[index].image),
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: Text(
                        _listHomeCategory[index].name.toString(),
                        style: TextStyle(
                          fontSize: selectedPosition == index
                              ? ScreenUtil().setWidth(12)
                              : ScreenUtil().setWidth(10),
                          fontWeight: selectedPosition == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: selectedPosition == index
                              ? Colors.black
                              : Colors.grey,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Column buildNewLaunch() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          height: 200,
          child: ListView.builder(
            itemCount: _listproductList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return CategoryProductWidget(
                product: Product(
                    id: _listproductList[index].id,
                    productid: _listproductList[index].productId,
                    catid: _listproductList[index].categoryId,
                    company: _listproductList[index].name.toString(),
                    name: _listproductList[index].shortDescription.toString(),
                    icon: _listproductList[index].mainImage.toString(),
                    rating: 5,
                    remainingQuantity: 5,
                    price: rupees_Sybol +
                        " " +
                        _listproductList[index].salePrice.toString(),
                    mrp: rupees_Sybol +
                        " " +
                        _listproductList[index].mrp.toString()),
                gradientColors: [Colors.white, Colors.white],
                onCartAddClick: () {
                  showLoadingDialog(context, _dialogKey, "Please Wait..");
                  print("AddClick" + "AddClick");
                },
                onCartRemovedClick: () {},
                onCountChanges: (int) {},
              );
            },
          ),
        )
      ],
    );
  }

  getProductListByCategory(String id) async {
    Service().getProductListByCategory(id, "0", 1, 50).then((value) => {
          setState((() {
            if (value.statusCode == 1) {
              print("Categorylist" + value.message);
              _listproductList = value.data.products;
            } else {
              showSnakeBar(context, somethingWrong);
              print("Categorylist" + "Opps Something Wrong!");
            }
          }))
        });
  }

  Container setSkeletonCategoryList() {
    return Container(
      child: Flexible(
          child: GridView.builder(
        padding: EdgeInsets.all(0),
        itemCount: 10,
        itemBuilder: (context, index) {
          return Center(
              child: Container(
                  margin: EdgeInsets.all(0),
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.shade300,
                    highlightColor: Colors.white,
                    period: Duration(milliseconds: 2000),
                    child: CategoryProductWidget(
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
                      onCartAddClick: () {},
                      onCartRemovedClick: () {},
                      onCountChanges: (int) {},
                    ),
                  )));
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 1,
          childAspectRatio: 8.0 / 12.0,
        ),
      )),
    );
  }

  Container setCategoryList(bool bool) {
    return Container(
      child: Flexible(
          child: GridView.builder(
        padding: EdgeInsets.all(0),
        itemCount: _listproductList.length,
        itemBuilder: (context, index) {
          return Center(
              child: Container(
            margin: EdgeInsets.all(0),
            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
            child: CategoryProductWidget(
              product: Product(
                  id: _listproductList[index].id,
                  productid: _listproductList[index].productId,
                  catid: _listproductList[index].categoryId,
                  company: _listproductList[index].name.toString(),
                  name: _listproductList[index].shortDescription.toString(),
                  icon: _listproductList[index].mainImage.toString(),
                  rating: 5,
                  remainingQuantity: 5,
                  price: _listproductList[index].salePrice.toString(),
                  mrp: _listproductList[index].mrp.toString()),
              gradientColors: [Colors.white, Colors.white],
              onCartAddClick: () {},
              onCartRemovedClick: () {},
              onCountChanges: (int) {},
            ),
          ));
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 0,
          mainAxisSpacing: 1,
          childAspectRatio: 8.0 / 12.0,
        ),
      )),
    );
  }

  Shimmer loadSkeletonLoader(Flexible skeletonbuildNewLaunch) {
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
            QTYCount = value.data!.sumOfQty.toString();
          })
        });
  }

  Container loadhomeCategorySkeleton() {
    return Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width / 4,
        child: loadSkeletonLoaders(boxVerticalCategory(), Axis.vertical));
  }

  void showSnakeBar(BuildContext context, somethingWrong) {}

  static addToCart() {}
}
