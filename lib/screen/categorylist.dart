import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/uttils/CircularProgress.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/categoryproductWidget.dart';
import 'package:nebulashoppy/widget/common_widget.dart';
import 'package:nebulashoppy/widget/filterWidget.dart';
import 'package:page_transition/page_transition.dart';

import '../model/homescreen/itemNewLaunched.dart';
import '../model/homescreen/itemhomecategory.dart';
import '../model/product.dart';
import '../network/service.dart';
import '../uttils/constant.dart';
import '../uttils/skeletonloader.dart';
import '../widget/LoginDialoug.dart';
import '../widget/trending_item.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:community_material_icon/community_material_icon.dart';

class CategoryList extends StatefulWidget {
  int position, id;
  String device_Id = "";
  CategoryList({Key? key, required this.position, required this.id})
      : super(key: key);
  @override
  State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList>
    with WidgetsBindingObserver {
  List<HomeCategoryData> _listHomeCategory = [];
  List<itemNewLaunchedProduct> _listproductList = [];
  List<itemNewLaunchedProduct> _listDisplayproductList = [];

  get somethingWrong => null;
  var selectedPosition = 0;
  var selectedId = 0;
  bool bl_IsFilterVisible = false;

  final GlobalKey<State> _dialogKey = GlobalKey<State>();
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    selectedPosition = widget.position;
    selectedId = widget.id;
    int_SelectedFilterIndex = 0;
    hideProgressBar();
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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Padding(
          padding: EdgeInsets.all(10),
          child: Visibility(
              visible: bl_IsFilterVisible,
              child: 
         Container(
         width: ScreenUtil().setSp(35),
         height: ScreenUtil().setSp(35),
        child: FloatingActionButton(
                // isExtended: true,
              //  child: Image.asset('assets/images/filtericon.jpg'),
                child: Icon(
                  CommunityMaterialIcons.filter_variant,
                  color: Colors.white,
                ),
                backgroundColor: THEME_COLOR,
                onPressed: () {
                  showDialog(
                    barrierColor: Colors.black26,
                    context: context,
                    builder: (context) {
                      return FilterWidget(
                        context,
                        title: "SoldOut",
                        description:
                            "This product may not be available at the selected address.",
                        onFilterSelection: () {},
                        onIndexSelected: (int index) {
                          int_SelectedFilterIndex = index;
                          setState(() {
                            filterList(index);
                          });

                          print("Index" + index.toString());
                        },
                      );
                    },
                  );
                },
              ),
)
)),
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(int_AppBarWidth),
          child: appBarWidget(context, 3, "Product List", true)),
      body: 
      Column(
        children: [
          showMaterialProgressbar(5),
          Expanded(
            child: Row(
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
      ))
        ],
      )
      ,
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



  Container homeCategory() {
    return Container(
      color: Colors.blueGrey[50],
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width / 4,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: _listHomeCategory.length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  print(
                      "Home" + "home" + _listHomeCategory[index].id.toString());
                  _listproductList.clear();
                  _listDisplayproductList.clear();
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
                        _listproductList[index].mrp.toString(),
                        qunatity: _listproductList[index].quantity),
                gradientColors: [Colors.white, Colors.white],
                onCartAddClick: () {
                  setState(() {
                    showProgressbar();
                  });
               //   showLoadingDialog(context, _dialogKey, "Please Wait..");
                  print("AddClick" + "AddClick");
                },
                onCartRemovedClick: () {},
                onCountChanges: (int) {},
                onBackPressClicked: () {
                  getCartCount();
                },
              );
            },
          ),
        )
      ],
    );
  }

  getProductListByCategory(String id) async {
    setState(() {
      int_SelectedFilterIndex = 0;
      bl_IsFilterVisible = false;
    });
    Service().getProductListByCategory(id, "0", 1, 50).then((value) => {
          setState((() {
            if (value.statusCode == 1) {
              print("Categorylist" + value.message);
              _listproductList = value.data.products;
              _listDisplayproductList = value.data.products;
              //  filterList(0);
              print("Filter" + _listDisplayproductList.length.toString());
              setState(() {
                bl_IsFilterVisible = true;
              });
            } else {
              setState(() {
                bl_IsFilterVisible = false;
              });
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
                          mrp: '\$' + "Test", qunatity: _listproductList[index].quantity),
                      gradientColors: [Colors.white, Colors.white],
                      onCartAddClick: () {},
                      onCartRemovedClick: () {},
                      onCountChanges: (int) {},
                      onBackPressClicked: () {},
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
          child: 
          SingleChildScrollView(
            child: 
          GridView.builder(
        padding: EdgeInsets.all(0),
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: _listproductList.length,
        itemBuilder: (context, index) {
          return Center(
              child: Container(
            color: Colors.blueGrey,
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
                  mrp: _listproductList[index].mrp.toString(),
                  qunatity: _listproductList[index].quantity),
              gradientColors: [Colors.white, Colors.white],
              onCartAddClick: () {
                print("CartAdd" + "This");
                setState(() {
                  showProgressbar();
                });
                addToCart(widget.device_Id, _listproductList[index].productId);
              },
              onCartRemovedClick: () {},
              onCountChanges: (int) {},
              onBackPressClicked: () {
                getCartCount();
              },
            ),
          ));
        },
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.8,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
      ))),
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
      widget.device_Id = DeviceId.toString();
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

  void addToCart(String device_id, int productId) {
    Future.delayed(Duration(seconds: 0), () {
      if (!is_Login) {
        print("IsLogin" + "Not Login");
        addProductInCart(productId.toString());
      } else {
        print("IsLogin" + "Is Login");
        getUserId();
        addProductInCart(productId.toString());
      }
    });
  }

  void addProductInCart(String productId) {
    //showLoadingDialog(context, _dialogKey, "Please Wait..");
    // setState(() {
    //   showProgressbar();
    // });
    Future.delayed(Duration(seconds: 0), () {
      Service()
          .getAddToCartResponse(DeviceId.toString(), str_UserId,
              productId.toString(), "1", Flag_Plus)
          .then((value) => {
                setState((() {
                  hideProgressBar();
                  showSnakeBar(context, "Item Added to Cart!");
                  getCartCount();
                  // if (_dialogKey.currentContext != null) {
                  //   //Navigator.pop(_dialogKey.currentContext!);
                    
                  // }
                  
                }))
              });
    });
  }

  void filterList(int index) {
    // if (index.toString() == "0") {
    //   setState(() {
    //     //  _listproductList.clear();
    //     for (int i = 0; i < _listDisplayproductList.length; i++) {
    //       _listproductList.add(_listDisplayproductList[i]);
    //     }
    //     print("FliterZero" + _listDisplayproductList.length.toString());
    //   });
    // }

   if (index.toString() == "0") {
      
    }
    if (index.toString() == "1") {
      _listproductList.sort((a, b) {
        return a.salePrice.compareTo(b.salePrice);
      });
    }
    if (index.toString() == "2") {
      print("Index" + "2");
      _listproductList.sort((a, b) {
        return b.salePrice.compareTo(a.salePrice);
      });
    }
    if (index.toString() == "3") {
      print("Index" + "2");
      _listproductList.sort((a, b) {
        return a.name
            .toString()
            .toLowerCase()
            .compareTo(b.name.toString().toLowerCase());
      });
    }

    if (index.toString() == "4") {
      print("Index" + "2");
      _listproductList.sort((a, b) {
        return b.name
            .toString()
            .toLowerCase()
            .compareTo(a.name.toString().toLowerCase());
      });
    }

    print("FilterList" + index.toString());
    // if (index.toString() == "0") {
    //   print("FilterList" + "0");
    //   _listproductList.sort((a, b) {
    //     return a.name
    //         .toString()
    //         .toLowerCase()
    //         .compareTo(a.name.toString().toLowerCase());
    //   });
    // }
    // if (index.toString() == "1") {
    //   _listproductList.sort((a, b) {
    //     return a.salePrice.compareTo(b.salePrice);
    //   });
    // }
    // if (index.toString() == "2") {
    //   _listproductList.sort((a, b) {
    //     return b.salePrice.compareTo(a.salePrice);
    //   });
    // }
    // if (index.toString() == "3") {
    //   _listproductList.sort((a, b) {
    //     return a.salePrice.compareTo(b.salePrice);
    //   });
    // }
    // if (index.toString() == "4") {
    //   _listproductList.sort((a, b) {
    //     return b.name
    //         .toString()
    //         .toLowerCase()
    //         .compareTo(a.name.toString().toLowerCase());
    //   });
    // }
    // if (index.toString() == "5") {
    //   _listproductList.sort((a, b) {
    //     return b.name
    //         .toString()
    //         .toLowerCase()
    //         .compareTo(a.name.toString().toLowerCase());
    //   });
    // }
    // if (index.toString() == "6") {}
    // _listproductList.sort((a, b) {
    //   return a.salePrice.compareTo(b.salePrice);
    // });
  }
}
