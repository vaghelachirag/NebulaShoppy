import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:nebulashoppy/model/homescreen/itemNewLaunched.dart';
import 'package:nebulashoppy/model/homescreen/itemhomecategory.dart';
import 'package:nebulashoppy/model/search/SearchProduct.dart';
import 'package:nebulashoppy/network/service.dart';
import 'package:nebulashoppy/screen/categorylist.dart';
import 'package:nebulashoppy/screen/productdetail.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/widget/SearchWidget.dart';
import '../model/homescreen/itembannerimage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:community_material_icon/community_material_icon.dart';

import '../model/product.dart';
import '../widget/AppBarWidget.dart';
import '../widget/searchitem.dart';
import '../widget/star_rating.dart';
import '../widget/trending_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Search extends StatefulWidget {
  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  TextEditingController searchData = new TextEditingController();
  List<SearchData> _listSearch = [];
  List<SearchData> _listSearchAllList = [];
  // This list holds the data for the list view
  List<SearchData> _searchList = [];

  bool bl_showNoData = false;
  bool bl_IsEdibleSearch = false;
  @override
  void initState() {
    super.initState();
    getseachProduct();
  }

  getseachProduct() async {
    Service().getSearchProduct().then((value) => {
          setState(() {
            if (value.statusCode == 1) {
              _listSearch = value.data;
              _listSearchAllList = _listSearch;
              bl_IsEdibleSearch = true;
              _listSearch.sort((a, b) {
                return a.name
                    .toString()
                    .toLowerCase()
                    .compareTo(b.name.toString().toLowerCase());
                //softing on alphabetical order (Ascending order by Name String)
              });
              print("SearchData" + "" + _listSearch.length.toString());
            } else {
              showSnakeBar(context, somethingWrong);
              print("Categorylist" + "Opps Something Wrong!");
              bl_IsEdibleSearch = false;
            }
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: appBarWidget(context, 3, "Search", false)),
      body: SingleChildScrollView(
          child: ConstrainedBox(
        constraints: BoxConstraints(),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Theme(
                    child: Container(
                      height: 40,
                      child: TextField(
                        controller: searchData,
                        enabled: bl_IsEdibleSearch,
                        onChanged: (value) => _runFilter(value),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          prefixIcon: Icon(Icons.search),
                          fillColor: Color(0xFFF2F4F5),
                          hintStyle: new TextStyle(color: Colors.grey[600]),
                          hintText: "Enter Text Here",
                        ),
                        autofocus: false,
                      ),
                    ),
                    data: Theme.of(context).copyWith(
                      primaryColor: Colors.grey[600],
                    )),
              ),
            ),
            Visibility(
                visible: bl_showNoData,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: Center(
                      child: Text(
                        "No Data Found!",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ))),
            Visibility(
                visible: !bl_showNoData,
                child: FutureBuilder(
                  builder: (context, snapshot) {
                    if (_listSearch.isEmpty) {
                      return loadSkeletonLoader(skeletonbuildNewLaunch());
                    } else {
                      return buildSearchProduct();
                    }
                  },
                ))
          ],
        ),
      )), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Column skeletonbuildNewLaunch() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: 10,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  showSnakeBar(context, "Click");
                },
                child: SearchItem(
                  product: Product(
                      id: 1,
                      productid: 1,
                      catid: 1,
                      company: "Test",
                      name: "Test",
                      icon: "Test",
                      rating: 5,
                      remainingQuantity: 5,
                      price: "Test",
                      mrp: "Test"),
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

  Column buildSearchProduct() {
    return Column(
      children: <Widget>[
        Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: _listSearch.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.fade,
                        child: ProductDetail(
                          id: _listSearch[index].id,
                          productid: _listSearch[index].productId,
                          categoryid: _listSearch[index].categoryId,
                        ),
                      ));
                },
                child: SearchItem(
                  product: Product(
                      id: _listSearch[index].id,
                      productid: _listSearch[index].productId,
                      catid: _listSearch[index].categoryId,
                      company: _listSearch[index].name.toString(),
                      name: _listSearch[index].name.toString(),
                      icon: _listSearch[index].mainImage.toString(),
                      rating: 5,
                      remainingQuantity: 5,
                      price: _listSearch[index].salePrice.toString(),
                      mrp: _listSearch[index].mrp.toString()),
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

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    print("SearchKeyword" + enteredKeyword);

    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      // Refresh the UI
      setState(() {
        _listSearch = _listSearchAllList;
        print("Emplty" + _listSearch.toString());
      });
    } else {
      _searchList = _listSearch
          .where((user) => user.name
              .toString()
              .toLowerCase()
              .contains(enteredKeyword.toLowerCase()))
          .toList();

      print("SearchList" + _searchList.length.toString());

      if (_searchList.length > 0) {
        setState(() {
          _listSearch = _searchList;
          bl_showNoData = false;
        });
      } else {
        bl_showNoData = true;
      }

      // we use the toLowerCase() method to make it case-insensitive
    }
  }

  Shimmer loadSkeletonLoader(Column skeletonbuildNewLaunch) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      period: Duration(milliseconds: 2000),
      child: skeletonbuildNewLaunch,
    );
  }
}