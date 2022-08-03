import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nebulashoppy/model/getCartItemResponse/getCarItemResponse.dart';
import 'package:nebulashoppy/model/homescreen/itemNewLaunched.dart';
import 'package:nebulashoppy/model/homescreen/itemhomecategory.dart';
import 'package:nebulashoppy/model/productdetail/itemProductColorsVariant.dart';
import 'package:nebulashoppy/model/productdetail/itemproductdetail.dart';
import 'package:nebulashoppy/model/productdetail/itemproductdetailimage.dart';
import 'package:nebulashoppy/model/productdetail/itemproductvariant.dart';
import 'package:nebulashoppy/model/productdetail/productbanner.dart';
import 'package:nebulashoppy/network/service.dart';
import 'package:nebulashoppy/screen/categorylist.dart';
import 'package:nebulashoppy/screen/home.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/uttils/sliderShowFullmageswidget.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/dotted_slider.dart';
import '../database/sQLHelper.dart';
import '../model/homescreen/itembannerimage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../model/product.dart';
import '../widget/cartCounter.dart';
import '../widget/common_widget.dart';
import '../widget/soldoutdialoug.dart';
import '../widget/star_rating.dart';
import '../widget/trending_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  int id;
  int productid;
  int categoryid;
  String device_Id = "";
  String mrp = "";

  ProductDetail(
      {Key? key,
      required this.id,
      required this.productid,
      required this.categoryid})
      : super(key: key);
  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> {
  bool isClicked = false;
  List<ProductBannerData> _listBannerImage = [];
  List<dynamic> _listProductImageDetail = [];
  List<itemNewLaunchedProduct> _listNewLaunched = [];
  List<ItemProductVariantData> _listProductVariant = [];
  List<ItemProductColorsVariant> _listProductVariantColor = [];
  List<int> _listProductVariantColorSkuList = [];
  List<ItemProductColorsVariant> _listProductVariantWeight = [];
  List<int> _listProductVariantWeightSkuList = [];
  List<ItemCart> _listCartItem = [];
  List<ItemProductColorsVariant> _listProductVariantSize = [];
  List<int> _listProductVariantSizeSkuList = [];

  // Product Detail Data
  String str_Mrp = "";
  String str_saleprice = "";
  String str_PV = "";
  String str_BV = "";
  String str_NV = "";
  String str_SKU = "";
  String str_Description = "";
  String str_ShortDescription = "";
  String str_highlightsIds = "";
  String str_SelectedColor = "";
  String str_SelectedSize = "";

  int? int_ProductQuantity = 0;
  int? int_CartQuantity = 0;
  int? int_CartCounter = 0;
  bool is_ShowDescription = false;
  bool is_ShowCart = false;
  bool is_ShowProductVariant = false;
  int int_SelectedVariantId = 0;

  final controller = PageController(viewportFraction: 1, keepPage: true);

  final GlobalKey<State> _dialogKey = GlobalKey<State>();
  late CartCounter cartCounter;
  @override
  void initState() {
    super.initState();
    is_ShowProductVariant = false;
    print("Detail" + widget.productid.toString() + " " + widget.id.toString());
    hideProgressBar();
    setDeviceId();
    getCartCounter();
    getProductBanner(widget.productid.toString());

    Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }

  @override
  Widget build(BuildContext context) {
    initilizationCounter(context);
    cartCounter = Provider.of<CartCounter>(context);
    cartCounter.setCartCountity(int_CartCounters);
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(int_AppBarWidth),
          child: appBarWidget(context, 3, "Product detail", true)),
      bottomNavigationBar: Visibility(
        visible: is_ShowCart,
        child: addToCartContainer(),
      ),
      body: setProductDesc(),
    );
  }

  Container setProductDesc() {
    return Container(
      child: Column(
        children: [
          showMaterialProgressbar(5),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _getTopImage(context),
                _setNubulaCustomised(),
                Visibility(
                    visible: _listProductVariant.length > 0,
                    child: productVarint()),
                //_getproductVariantSize(context),
                //Product Info
                // _buildExtra(context),
                //_buildDescription(context),
                //  _buildComments(context),
                Visibility(
                    visible: str_Description.length > 0,
                    child: setDescription()),
                _buildProductImageData(context),
                _buildProducts(context),
              ],
            ),
          ))
        ],
      ),
    );
  }

  Container productVarint() {
    return Container(
        child: Visibility(
      visible: _listProductVariant.length > 0,
      child: Column(
        children: [
          Container(
            child: chooseColorHeader(),
          ),
          Visibility(
              visible: !_listProductVariantColor.isEmpty,
              child: getproductVariantColor()),
          //   _getproductVariantColor(context),
          chooseWeightHeader(),
          Visibility(
              visible: !_listProductVariantWeight.isEmpty,
              child: getproductVariantWeight()),
          // _getproductVariantWeight(context),
          //  chooseSizeHeader(),
          Visibility(
              visible: !_listProductVariantSize.isEmpty,
              child: Column(
                children: [chooseSizeHeader(), getproductVariantSize()],
              )),
        ],
      ),
    ));
  }

  Container getproductVariantSize() {
    return Container(
      height: MediaQuery.of(context).size.height / 15,
      child: FutureBuilder(
        builder: (context, snapshot) {
          if (_listProductVariantSize.isEmpty) {
            return Text("");
          } else {
            return Center(
                child: Container(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _listProductVariantSize.length,
                  itemBuilder: (context, index) {
                    return Container(
                        margin: EdgeInsets.fromLTRB(8, 0, 5, 0),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: int_SelectedVariantId == index
                              ? Colors.black
                              : Colors.black12,
                        )),
                        child: FutureBuilder(
                          future: setSelectedHeighlitSizetId(
                              _listProductVariantSize),
                          builder: (context, snapshot) {
                            return Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                child: GestureDetector(
                                  onTap: () {
                                    print("OnTap" + "Size Click");
                                    showProgressbar();
                                    widget.id = _listProductVariantSize[index]
                                        .EcomAttributeSKUList[0];
                                    getProductDetail(widget.id, true);
                                  },
                                  child: Container(
                                    child: Padding(
                                        padding: EdgeInsets.all(0),
                                        child: Center(
                                          child: Text(
                                            _listProductVariantSize[index]
                                                .AttributeName
                                                .toString(),
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )),
                                  ),
                                ));
                          },
                        ));
                  },
                ),
              ),
            ));
          }
        },
      ),
    );
  }

  Container getproductVariantColor() {
    return Container(
      padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
      child: Container(
          height: MediaQuery.of(context).size.height / 20,
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (_listProductVariantColor.isEmpty) {
                return Text("");
              } else {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                      padding: const EdgeInsets.all(0.0),
                      child: ListView.builder(
                        itemCount: _listProductVariantColor.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return FutureBuilder(
                            future:
                                setSelectedHeighlitId(_listProductVariantColor),
                            builder: (context, snapshot) {
                              return Padding(
                                  padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                                  child: GestureDetector(
                                    child: Container(
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                int_SelectedVariantId == index
                                                    ? Colors.black
                                                    : Colors.white,
                                          ),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(40))),
                                      child: Padding(
                                        padding: EdgeInsets.all(2),
                                        child: CircleAvatar(
                                          backgroundColor: Color(int.parse(
                                              _listProductVariantColor[index]
                                                  .AttributeColor)),
                                          maxRadius: 15,
                                          child: Text(
                                            "",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      showProgressbar();
                                      widget.id =
                                          _listProductVariantColor[index]
                                              .EcomAttributeSKUList[0];
                                      getProductDetail(
                                          _listProductVariantColor[index]
                                              .EcomAttributeSKUList[0],
                                          true);
                                      print("Color" +
                                          "OnTap" +
                                          _listProductVariantColor[index]
                                              .EcomAttributeSKUList[0]
                                              .toString());
                                    },
                                  ));
                            },
                          );
                        },
                      )),
                );
              }
            },
          )),
    );
  }

  Container getproductVariantWeight() {
    return Container(
      child: Container(
          height: MediaQuery.of(context).size.height / 15,
          child: FutureBuilder(
            builder: (context, snapshot) {
              if (_listProductVariantWeight.isEmpty) {
                return Text("");
              } else {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: ListView.builder(
                      itemCount: _listProductVariantWeight.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                            ),
                            child: FutureBuilder(
                              future: setSelectedHeighlitWeightId(
                                  _listProductVariantWeight),
                              builder: (context, snapshot) {
                                return Container(
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Center(
                                      child: Text(
                                        _listProductVariantWeight[index]
                                            .AttributeName
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ));
                      },
                    ),
                  ),
                );
              }
            },
          )),
    );
  }

  Container addToCartContainer() {
    return Container(
        color: Theme.of(context).backgroundColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 12,
        child: Container(
            padding: EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(width: 0.5, color: Colors.black12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                        print("OnCart" + "Add ToCart");
                      },
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: CircleAvatar(
                                backgroundColor: buttonColor,
                                maxRadius: 20,
                                child: Icon(
                                  CommunityMaterialIcons.heart,
                                  color: Colors.white,
                                )),
                          ),
                        ),
                      ),
                    )),
                Align(
                    alignment: Alignment.centerRight,
                    child: setRegularText("Add To Cart", 16, Colors.black)
                    // Text(
                    //   "Add To Cart",
                    //   style: TextStyle(fontSize: 20, color: Colors.black),
                    // ),
                    ),
                Container(
                  child: GestureDetector(
                      onTap: () {
                        if (int_CartQuantity == 0) {
                          return;
                        }
                        setState(() {
                          widget.device_Id = DeviceId.toString();
                        });
                        setState(() {
                          showProgressbar();
                        });
                        // showLoadingDialog(
                        //     context, _dialogKey, "Please Wait..");
                        addToCart(widget.device_Id, str_UserId,
                            widget.productid.toString(), 1, Flag_Minus);
                      },
                      child: Padding(
                        padding: EdgeInsets.all(0),
                        child: CircleAvatar(
                            backgroundColor: int_CartQuantity == 0
                                ? Colors.amber.shade100
                                : buttonColor,
                            maxRadius: 20,
                            child: setBoldText("-", 16, Colors.black)
                            // Text(
                            //   "-",
                            //   style: TextStyle(
                            //       color: Colors.white,
                            //       fontSize: 20,
                            //       fontWeight: FontWeight.bold),
                            // ),
                            ),
                      )),
                ),
                Align(
                    alignment: Alignment.center,
                    child: setBoldText(
                        int_CartQuantity.toString(), 16, Colors.black)
                    // Text(
                    //   int_CartQuantity.toString(),
                    //   style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 20,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    ),
                Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                        onTap: () {
                          setState(() {
                            widget.device_Id = DeviceId.toString();
                          });
                          print("AddDeviceId" + widget.device_Id);
                          // showLoadingDialog(
                          //     context, _dialogKey, "Please Wait..");
                          setState(() {
                            showProgressbar();
                          });
                          addToCart(widget.device_Id, str_UserId,
                              widget.productid.toString(), 1, Flag_Plus);
                          print("onCart" + "Add To Cart");
                        },
                        child: Container(
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: CircleAvatar(
                                backgroundColor: buttonColor,
                                maxRadius: 20,
                                child: setBoldText("+", 16, Colors.black)
                                // Text(
                                //   "+",
                                //   style: TextStyle(
                                //       color: Colors.white,
                                //       fontSize: 20,
                                //       fontWeight: FontWeight.normal),
                                // ),
                                ),
                          ),
                        )))
              ],
            )));
  }

  Row _setNubulaCustomised() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildInfo(context),
        Column(
          children: [
            SizedBox(
              width: ScreenUtil().setSp(30),
              height: ScreenUtil().setSp(30),
              child: Image.asset(assestPath + "nebulacustomised.png"),
            ),
            SizedBox(
              height: 8,
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                child:
                    setRegularText("Nebulacare Customised", 10, Colors.black))
          ],
        )
      ],
    );
  }

  Column setDescription() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
          child: setBoldText("Description", 18, Colors.black),
        ),
        SizedBox(
          height: 8,
        ),
        Container(
          padding: EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: Html(data: str_Description),
        ),
      ],
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Shopping Cart"),
      content: Text("Your product has been added to cart."),
      actions: [
        okButton,
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

  _productSlideImage(String imageUrl) {
    return Container(
      height: ScreenUtil().setSp(30),
      width: double.infinity,
      decoration: BoxDecoration(
        image:
            DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.contain),
      ),
    );
  }

  dottedSlider() {
    return DottedSlider(
      color: Colors.white,
      maxHeight: 200,
      children: <Widget>[
        _productSlideImage(_listBannerImage[0].imageFile),
      ],
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
                        child: Image.network(
                          _listBannerImage[itemIndex].imageFile,
                          fit: BoxFit.cover,
                          width: 1000.0,
                        ),
                      ),
                    ),
                options: CarouselOptions(
                  height: ScreenUtil().setSp(150),
                  viewportFraction: 1,
                  aspectRatio: 16 / 9,
                  autoPlay: false,
                  enlargeCenterPage: true,
                )))
      ],
    );
  }

  setProductName(contex) {
    Row(
      children: [
        Text(
          _listBannerImage[0].name,
          style: TextStyle(
              fontSize: 14,
              color: Colors.red[100],
              fontStyle: FontStyle.normal),
        )
      ],
    );
  }

  _getTopImage(context) {
    final pages = List.generate(
        _listBannerImage.length,
        (index) => Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: Colors.white,
              ),
              child: InkWell(
                onTap: () {
                  print("Test" + "Test");
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => SliderShowFullmages(
                            listBannerImage: _listBannerImage,
                            current: index,
                          )));
                },
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: ScreenUtil().setSp(280),
                  child: Center(
                    child: FadeInImage.assetNetwork(
                        placeholder: placeholder_path,
                        image: _listBannerImage[index].imageFile,
                        fit: BoxFit.fill),
                  ),
                ),
              ),
            ));

    return Container(
        width: MediaQuery.of(context).size.width,
        child: FutureBuilder(
          future: getProductBanner(widget.id.toString()),
          builder: (context, snapshot) {
            if (_listBannerImage.isEmpty) {
              return loadSkeletonLoader(skeletontopbannerImage());
            } else {
              return Column(
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 3),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              setRegularText(_listBannerImage[0].name, 16,
                                  productNameColor),
                              // Text(
                              //   _listBannerImage[0].name,
                              //   style: TextStyle(
                              //       fontSize: 20,
                              //       color: Colors.red,
                              //       fontWeight: FontWeight.normal),
                              // ),
                              // Align(
                              //   alignment: Alignment.topRight,
                              //   child: StarRating(rating: 5, size: 16),
                              // ),
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: setItalicText(str_ShortDescription, 12,
                                    productDetailColor),
                                // Text(
                                //   str_ShortDescription,
                                //   style: TextStyle(
                                //       fontSize: 14,
                                //       color: Colors.grey,
                                //       fontWeight: FontWeight.normal),
                                // ),
                              ))
                        ],
                      )),
                  Column(
                    children: [
                      SizedBox(
                        height: ScreenUtil().setSp(200),
                        child: PageView.builder(
                          controller: controller,
                          // itemCount: pages.length,
                          itemBuilder: (_, index) {
                            return pages[index % pages.length];
                          },
                        ),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.white,
                        child: SmoothPageIndicator(
                            controller: controller,
                            count: _listBannerImage.length,
                            effect: ScrollingDotsEffect(
                                activeStrokeWidth: 2.6,
                                activeDotScale: 1.3,
                                maxVisibleDots: 5,
                                radius: 8,
                                spacing: 10,
                                dotHeight: 10,
                                dotWidth: 10,
                                dotColor: Colors.grey,
                                activeDotColor: Colors.grey.shade200)),
                      )
                    ],
                  )
                ],
              );
            }
          },
        ));
  }

  Container chooseColorHeader() {
    return Container(child: FutureBuilder(
      builder: (context, snapshot) {
        if (_listProductVariantColor == null ||
            _listProductVariantColor.isEmpty) {
          return Text("");
        } else {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: [
                      Text("Choose Color:"),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          str_SelectedColor,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      },
    ));
  }

  Container chooseWeightHeader() {
    return Container(child: FutureBuilder(
      builder: (context, snapshot) {
        if (_listProductVariantWeight == null ||
            _listProductVariantWeight.isEmpty) {
          return Text("");
        } else {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: [
                      Text("Choose Weight:"),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          _listProductVariantWeight[0].AttributeName,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      },
    ));
  }

  Container chooseSizeHeader() {
    return Container(child: FutureBuilder(
      builder: (context, snapshot) {
        if (_listProductVariantSize == null ||
            _listProductVariantSize.isEmpty) {
          return Text("");
        } else {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: [
                      Text("Choose Size:"),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          str_SelectedSize,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      },
    ));
  }

  _getproductVariantColor(context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (_listProductVariantColor.isEmpty) {
          return Text("");
        } else {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: [
                      Text("Choose Color:"),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          str_SelectedColor,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _listProductVariantColor.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return FutureBuilder(
                        future: setSelectedHeighlitId(_listProductVariantColor),
                        builder: (context, snapshot) {
                          return Container(
                            width: 25,
                            height: 25,
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: int_SelectedVariantId == index
                                      ? Colors.black
                                      : Colors.black12,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Padding(
                              padding: EdgeInsets.all(0),
                              child: CircleAvatar(
                                backgroundColor: Color(int.parse(
                                    _listProductVariantColor[index]
                                        .AttributeColor)),
                                maxRadius: 15,
                                child: Text(
                                  "",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }

  _getproductVariantWeight(context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (_listProductVariantWeight.isEmpty) {
          return Text("");
        } else {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: [
                      Text("Choose Weight:"),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          _listProductVariantWeight[0].AttributeName,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _listProductVariantWeight.length,
                    itemBuilder: (context, index) {
                      return Container(
                          width: 200,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: FutureBuilder(
                            future: setSelectedHeighlitWeightId(
                                _listProductVariantWeight),
                            builder: (context, snapshot) {
                              return Container(
                                width: 200,
                                child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Text(
                                    _listProductVariantWeight[index]
                                        .AttributeName
                                        .toString(),
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            },
                          ));
                    },
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }

  _getproductVariantSize(context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (_listProductVariantSize.isEmpty) {
          return Text("");
        } else {
          return Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Row(
                    children: [
                      Text("Choose Size:"),
                      Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          str_SelectedSize,
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _listProductVariantSize.length,
                    itemBuilder: (context, index) {
                      return Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                            color: int_SelectedVariantId == index
                                ? Colors.black
                                : Colors.black12,
                          )),
                          child: FutureBuilder(
                            future: setSelectedHeighlitSizetId(
                                _listProductVariantSize),
                            builder: (context, snapshot) {
                              return Container(
                                child: Padding(
                                  padding: EdgeInsets.all(0),
                                  child: Text(
                                    _listProductVariantSize[index]
                                            .AttributeName
                                            .toString() +
                                        "ss",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              );
                            },
                          ));
                    },
                  )
                ],
              ),
            ),
          );
        }
      },
    );
  }

  _buildInfo(context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                setRegularText('\u{20B9}${str_saleprice}', 20, Colors.black)
                // Text(
                //   '\u{20B9}${str_saleprice}',
                //   style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold),
                // )
              ],
            ),
            SizedBox(
              height: ScreenUtil().setSp(8),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "MRP:  " + rupees_Sybol,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontFamily: Ember,
                      fontWeight: FontWeight.normal),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 1),
                    child: Text(
                      removeDecimalAmount(str_Mrp),
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          decoration: TextDecoration.lineThrough),
                    ))
              ],
            ),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    setRegularText("PV:", 12, Colors.black),
                    // Text(
                    //   "PV:",
                    //   style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: setRegularText(
                          removeDecimalAmount(str_PV), 12, Colors.red),
                      // Text(
                      //   str_PV,
                      //   style: TextStyle(
                      //       color: Colors.red,
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.normal),
                      // ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: setRegularText("BV:", 12, Colors.black)
                        //  Text(
                        //   "BV:",
                        //   style: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        ),
                    Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: setRegularText(
                            removeDecimalAmount(str_BV), 12, Colors.red)
                        // Text(
                        //   str_BV,
                        //   style: TextStyle(
                        //       color: Colors.red,
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.normal),
                        // ),
                        ),
                    Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: setRegularText("NV:", 12, Colors.black)
                        // Text(
                        //   "NV:",
                        //   style: TextStyle(
                        //       color: Colors.black,
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.bold),
                        // ),
                        ),
                    Padding(
                        padding: EdgeInsets.only(left: 5),
                        child: setRegularText(
                            removeDecimalAmount(str_NV), 12, Colors.red)
                        // Text(
                        //   str_NV,
                        //   style: TextStyle(
                        //       color: Colors.red,
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.normal),
                        // ),
                        )
                  ],
                )),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    setRegularText("SKU:", 14, Colors.black),
                    // Text(
                    //   "SKU:",
                    //   style: TextStyle(
                    //       color: Colors.black,
                    //       fontSize: 14,
                    //       fontWeight: FontWeight.bold),
                    // ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: setRegularText(str_SKU, 14, Colors.black),
                      //   Text(
                      //   str_SKU,
                      //   style: TextStyle(
                      //       color: Colors.red,
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.normal),
                      // ),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }

  _buildExtra(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        top: BorderSide(width: 1.0, color: Colors.black12),
        bottom: BorderSide(width: 1.0, color: Colors.black12),
      )),
      padding: EdgeInsets.all(4.0),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("Capacity"),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 8,
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text("Color"),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 8,
                ),
                SizedBox(
                  width: 8,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  _buildDescription(BuildContext context) {
    return Visibility(
      visible: is_ShowDescription,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          child: Container(
              padding: EdgeInsets.all(16.0),
              child: Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      "Description",
                      maxLines: 5,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        color: Colors.black45,
                        fontSize: 14,
                      ),
                    ),
                    Visibility(
                        visible: is_ShowDescription,
                        child: Expanded(child: Html(data: str_Description))),
                    SizedBox(
                      height: 8,
                    ),
                    // Center(
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       _settingModalBottomSheet(context, str_Description);
                    //     },
                    //     child: Text(
                    //       "View More",
                    //       style: TextStyle(
                    //           fontWeight: FontWeight.bold,
                    //           color: Colors.blueGrey,
                    //           fontSize: 16),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ))),
    );
  }

  _buildComments(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(width: 1.0, color: Colors.black12),
          bottom: BorderSide(width: 1.0, color: Colors.black12),
        ),
      ),
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  "Comments",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black54),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                StarRating(rating: 4, size: 20),
                SizedBox(
                  width: 8,
                ),
                Text(
                  "1250 Comments",
                  style: TextStyle(color: Colors.black54),
                )
              ],
            ),
            SizedBox(
              child: Divider(
                color: Colors.black26,
                height: 4,
              ),
              height: 24,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://miro.medium.com/fit/c/256/256/1*mZ3xXbns5BiBFxrdEwloKg.jpeg"),
              ),
              subtitle: Text(
                  "Cats are good pets, for they are clean and are not noisy."),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  StarRating(rating: 4, size: 15),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "12 Sep 2019",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Divider(
                color: Colors.black26,
                height: 4,
              ),
              height: 24,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://www.familiadejesusperu.org/images/avatar/john-doe-13.jpg"),
              ),
              subtitle: Text(
                  "There was no ice cream in the freezer, nor did they have money to go to the store."),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  StarRating(rating: 4, size: 15),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "15 Sep 2019",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
            SizedBox(
              child: Divider(
                color: Colors.black26,
                height: 4,
              ),
              height: 24,
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://pbs.twimg.com/profile_images/1020903668240052225/_6uVaH4c.jpg"),
              ),
              subtitle: Text(
                  "I think I will buy the red car, or I will lease the blue one."),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  StarRating(rating: 4, size: 15),
                  SizedBox(
                    width: 8,
                  ),
                  Text(
                    "25 Sep 2019",
                    style: TextStyle(fontSize: 12, color: Colors.black54),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  _buildProductImageData(BuildContext context) {
    return FutureBuilder(
      future: getProductDetailImage(),
      builder: (context, snapshot) {
        if (_listProductImageDetail.isEmpty) {
          return Text("");
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _listProductImageDetail.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                child: FadeInImage.assetNetwork(
                    placeholder: placeholder_path,
                    image: _listProductImageDetail[index]['ImageFile'],
                    fit: BoxFit.fill),
              );
            },
          );
        }
      },
    );
  }

  _buildProducts(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            children: <Widget>[
              Expanded(child: setRegularText("Similar Items", 16, Colors.black)
                  // Text(
                  //   "Similar Items",
                  //   style: TextStyle(
                  //       fontSize: 18.0,
                  //       fontWeight: FontWeight.w600,
                  //       color: Colors.black54),
                  //   textAlign: TextAlign.start,
                  // ),
                  ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    print("Clicked");
                  },
                  child: Text(
                    "",
                    style: TextStyle(fontSize: 18.0, color: Colors.blue),
                    textAlign: TextAlign.end,
                  ),
                ),
              ),
            ],
          ),
        ),
        buildTrending()
      ],
    );
  }

  Column buildTrending() {
    return Column(
      children: <Widget>[
        Container(
          height: 200,
          child: FutureBuilder(
            future: getNewLaunchedProduct(),
            builder: (context, snapshot) {
              if (_listNewLaunched.isEmpty) {
                return loadNewLaunchSkeleton();
              } else {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _listNewLaunched.length,
                  itemBuilder: (context, index) {
                    return TrendingItem(
                      product: Product(
                          id: _listNewLaunched[index].id,
                          productid: _listNewLaunched[index].productId,
                          catid: _listNewLaunched[index].categoryId,
                          company: _listNewLaunched[index].name.toString(),
                          name: _listNewLaunched[index]
                              .shortDescription
                              .toString(),
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
                      onBackPressClicked: () {},
                    );
                  },
                );
              }
            },
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

  getNewLaunchedProduct() async {
    Service()
        .getNewLaunched(widget.categoryid.toString(), "0", 1, 50)
        .then((value) => {
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

  getProductDetail(int productid, bool iscallBanner) {
    Service().getProductDetail(productid.toString(), "0").then((value) => {
          setState((() {
            if (value.statusCode == 1) {
              setProductData(value.data);
              if (iscallBanner) {
                hideProgressBar();
                widget.productid = value.data.productId;
                getProductBannerFromVariant(value.data.productId.toString());
                getCartItemList();
              }
            } else {
              if (iscallBanner) {
                hideProgressBar();
              }
              showSnakeBar(context, somethingWrong);
              print("Categorylist" + "Opps Something Wrong!");
            }
          }))
        });
  }

  setProductData(itemProdctDetailData data) async {
    str_Mrp = data.mrp.toString();
    str_saleprice = data.salePrice.toString();
    str_saleprice = removeDecimalAmount(str_saleprice);
    str_BV = data.bv.toString();
    str_PV = data.pv.toString();
    str_NV = data.nv.toString();
    str_SKU = data.sku.toString();
    str_ShortDescription = data.shortDescription.toString();
    str_Description = data.description.toString();
    str_highlightsIds = data.highlightsIds.toString();
    int_ProductQuantity = data.quantity;
    print("ProductData" + int_ProductQuantity.toString());
    if (int_ProductQuantity == 0) {
      print("ProductData" + "No Product");
      is_ShowCart = false;
      showNoProduct();
    }
    if (int_ProductQuantity! > 0) {
      is_ShowCart = true;
    }
    if (str_Description.isEmpty) {
      is_ShowDescription = false;
    } else {
      is_ShowDescription = true;
    }

    int_SelectedVariantId = data.highlightsIds;
    print("HightLightId" + " " + int_SelectedVariantId.toString());

    if (data.isMainProduct) {
      getProductVarinatData(
        widget.id.toString(),
      );
    } else {
      getProductVarinatData(data.masterProductId.toString());
    }

    getProductDetailImage();
    getCartItemList();

    await addItemInDatabase(data);

    print("Trith" +
        widget.id.toString() +
        " " +
        widget.productid.toString() +
        " " +
        widget.categoryid.toString());
  }

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        //...bottom card part,
        //...top circlular image part,
        Container(
          padding: EdgeInsets.only(
            top: 200,
            bottom: 16.0,
            left: 16.0,
            right: 16.0,
          ),
          margin: EdgeInsets.only(top: 66.0),
          decoration: new BoxDecoration(
            color: Colors.black, //Colors.black.withOpacity(0.3),
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, // To make the card compact
            children: <Widget>[
              Text(
                "title",
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                "description",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.white70,
                ),
              ),
              SizedBox(height: 24.0),
              Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                  color: Colors.amber,
                  onPressed: () {
                    Navigator.of(context).pop(); // To close the dialog
                  },
                  child: Text(
                    "Close",
                    style: TextStyle(
                      color: Colors.purple,
                    ),
                  ),
                ),
              ),
              // Implement Circular Image here
            ],
          ),
        ),
      ],
    );
  }

  getProductBanner(String productId) {
    Service().getProductBanner(productId).then((value) => {
          setState((() {
            print("Banner" + value.message.toString());
            if (value.statusCode == 1) {
              _listBannerImage = value.data;
              print("Banner" + _listBannerImage.toString());
              // showSnakeBar(context, value.statusCode.toString());
              getProductDetail(widget.id, false);
            } else {
              showSnakeBar(context, somethingWrong);
              print("Categorylist" + "Opps Something Wrong!");
              getProductDetail(widget.id, false);
            }
          }))
        });
  }

  getProductBannerFromVariant(String productId) {
    Service().getProductBanner(productId).then((value) => {
          setState((() {
            print("Banner" + value.message.toString());
            if (value.statusCode == 1) {
              _listBannerImage = [];
              _listBannerImage = value.data;
            } else {
              showSnakeBar(context, somethingWrong);
              print("Categorylist" + "Opps Something Wrong!");
            }
          }))
        });
  }

  getProductVarinatData(masterProductId) async {
    Service().getProductVarintData("0", masterProductId).then((value) => {
          setState((() {
            print("Banner" + value.message.toString());
            if (value.statusCode == 1) {
              _listProductVariant = value.data!;
              setAttribute();
              setState(() {
                is_ShowProductVariant = true;
              });

              print("ProductVarint" + _listProductVariant.length.toString());
            } else {
              setState(() {
                is_ShowProductVariant = false;
              });
              showSnakeBar(context, somethingWrong);
              print("Categorylist" + "Opps Something Wrong!");
            }
          }))
        });

    print("IsShowVariant" + is_ShowProductVariant.toString());
  }

  getProductDetailImage() async {
    final response = await http.get(Uri.parse(BASE_URL +
        WS_GET_PRODUCT_DETAILS_IMAGE +
        "?" +
        "EComProductDetailsId=" +
        widget.id.toString()));
    dynamic myjson = json.decode(response.body.toString());
    _listProductImageDetail = myjson["Data"];

    //sprint("ResponseCode" + _listProductImageDetail.toString());
  }

//   void getProductVarinatData() async {
//     Service().getProductListByCategory(productId).then((value) => {
//           setState((() {
//             print("Banner" + value.message.toString());
//             if (value.statusCode == 1) {
//               _listBannerImage = value.data;
//               print("Banner" + _listBannerImage.toString());
//               // showSnakeBar(context, value.statusCode.toString());
//               getProductDetail(widget.productid);
//             } else {
//               showSnakeBar(context, somethingWrong);
//               print("Categorylist" + "Opps Something Wrong!");
//               getProductDetail(widget.productid);
//             }
//           }))
//         });
//   }
// }

  Shimmer loadSkeletonLoader(Column skeletonbuildNewLaunch) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.white,
      period: Duration(milliseconds: 2000),
      child: skeletonbuildNewLaunch,
    );
  }

  showNoProductQuantity(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text(
        "Close",
        style: TextStyle(
            color: Colors.black, fontSize: 16, fontWeight: FontWeight.bold),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(""),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Center(
              child: Text(
                "Sold Out",
                style: TextStyle(
                    color: Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  'This product may not be available at the selected address.',
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
                padding: EdgeInsets.only(top: 10),
                child:
                    Text('Kindly change your address, to avail this product.')),
          ],
        ),
      ),
      actions: [
        okButton,
      ],
    );

    void showNoProduct() {
      showDialog(
        barrierColor: Colors.black26,
        context: context,
        builder: (context) {
          return SoldOutDialoug(
            title: "SoldOut",
            description:
                "This product may not be available at the selected address.",
          );
        },
      );
    }
  }

  void _settingModalBottomSheet(context, String str_description) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    "Description",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black45,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  SingleChildScrollView(
                    child: Html(data: str_description),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
          );
        });
  }

  void showNoProduct() {
    showDialog(
      barrierColor: Colors.black26,
      context: context,
      builder: (context) {
        return SoldOutDialoug(
          title: "Soldout",
          description:
              "This product may not be available at the selected address.",
        );
      },
    );
  }

  void addToCart(String deviceId, String str_userId, String productId,
      int quntity, String flag) {
    Future.delayed(Duration(seconds: 0), () {
      print("IsLogin" + is_Login.toString());
      if (!is_Login) {
        Service()
            .getAddToCartResponse(
                deviceId, str_userId, productId, quntity.toString(), flag)
            .then((value) => {
                  setState((() {
                    // if (_dialogKey.currentContext != null) {
                    //   Navigator.pop(_dialogKey.currentContext!);

                    // }
                    hideProgressBar();
                    if (value.statusCode == 1) {
                      if (flag == Flag_Plus) {
                        showSnakeBar(context, "Item Added to Cart!");
                        setState(() {
                          int_CartCounters = int_CartCounters + 1;
                          int_CartQuantity = int_CartQuantity! + 1;
                          int_CartCounter = int_CartCounter! + 1;
                          QTYCount = int_CartCounter.toString();
                          setState(() {});
                        });
                      } else {
                        setState(() {
                          if (int_CartQuantity! > 0) {
                            int_CartCounters = int_CartCounters - 1;
                            int_CartQuantity = int_CartQuantity! - 1;
                            int_CartCounter = int_CartCounter! - 1;
                            QTYCount = int_CartCounter.toString();
                            setState(() {});
                          }
                        });
                        showSnakeBar(context, "Item Removed from Cart!");
                      }
                    } else {
                      showSnakeBar(context, "Opps! Something Wrong");
                    }
                  }))
                });
      } else {
        getUserId();
        Future.delayed(Duration(seconds: 0), () {
          print("IsLogin" + str_UserId.toString());
          Service()
              .getAddToCartResponse(
                  deviceId, str_userId, productId, quntity.toString(), flag)
              .then((value) => {
                    setState((() {
                      hideProgressBar();
                      if (value.statusCode == 1) {
                        if (flag == Flag_Plus) {
                          //  cartCounter.addItemInCart();
                          showSnakeBar(context, "Item Added to Cart!");
                          setState(() {
                            int_CartCounters = int_CartCounters + 1;
                            int_CartQuantity = int_CartQuantity! + 1;
                            int_CartCounter = int_CartCounter! + 1;
                            QTYCount = int_CartCounter.toString();
                            setState(() {});
                          });
                        } else {
                          setState(() {
                            if (int_CartQuantity! > 0) {
                              int_CartCounters = int_CartCounters - 1;
                              int_CartQuantity = int_CartQuantity! - 1;
                              int_CartCounter = int_CartCounter! - 1;
                              QTYCount = int_CartCounter.toString();
                              setState(() {});
                            }
                          });
                          // cartCounter.removeItemFromCart();
                          showSnakeBar(context, "Item Removed from Cart!");
                        }
                      } else {
                        showSnakeBar(context, "Opps! Something Wrong");
                      }
                    }))
                  });
        });
      }
    });
  }

  void setDeviceId() async {
    setState(() {
      widget.device_Id = DeviceId.toString();
    });
  }

  void getCartItemList() {
    Future.delayed(Duration(seconds: 0), () {
      print("IsLogin" + is_Login.toString());
      if (!is_Login) {
        Service()
            .getCartItemWithoutLogin(widget.device_Id, "0")
            .then((value) => {
                  setState((() {
                    print("CartList" + value.statusCode.toString());
                    if (value.statusCode == 1) {
                      _listCartItem = value.data.cart;
                      compareproductquntity(_listCartItem);
                    } else {
                      showSnakeBar(context, somethingWrong);
                      print("Categorylist" + "Opps Something Wrong!");
                    }
                  }))
                });
      } else {
        getUserId();
        Future.delayed(Duration(seconds: 0), () {
          print("IsLogin" + str_UserId.toString());
          Service()
              .getCartItemWithLogin(widget.device_Id, "0", str_UserId)
              .then((value) => {
                    setState(() {
                      print("Cart" + value.data.cart.toString());
                      _listCartItem = value.data.cart;
                      compareproductquntity(_listCartItem);
                      // int_CartCounters = value.data!.sumOfQty;
                      // QTYCount = value.data!.sumOfQty.toString();
                    })
                  });
        });
      }
    });
  }

  void getCartCounter() {
    Service().getCartCount(DeviceId.toString(), "").then((value) => {
          setState(() {
            QTYCount = value.data!.sumOfQty.toString();
            setState(() {});
            print("TestCounter" + value.data!.sumOfQty.toString());
            int_CartCounter = value.data!.sumOfQty;
          })
        });
  }

  void compareproductquntity(List<ItemCart> listCartItem) {
    if (listCartItem.isNotEmpty) {
      for (int i = 0; i < listCartItem.length; i++) {
        print("CartItem" +
            listCartItem[i].productId.toString() +
            " " +
            widget.productid.toString());
        if (listCartItem[i].productId == widget.productid) {
          print("CartItemQuanity" + listCartItem[i].cartQuantity.toString());
          setState(() {
            int_CartQuantity = listCartItem[i].cartQuantity;
          });
          break;
        }
      }
    }
  }

  addItemInDatabase(itemProdctDetailData data) async {
    final dataitems = await SQLHelper.getItem(data.productId);
    if (dataitems.length > 0) {
    } else {
      await SQLHelper.createItem(
          data.name,
          data.salePrice.toString(),
          _listBannerImage[0].imageFile,
          data.productId.toString(),
          data.quantity.toString(),
          data.categoryId.toString(),
          data.id.toString(),
          data.mrp.toString(),
          data.shortDescription.toString());
      print("fdf" + "fdf");
    }
  }

  void setAttribute() {
    clearList();
    if (!_listProductVariant.isEmpty) {
      for (int i = 0; i < _listProductVariant.length; i++) {
        if (_listProductVariant[i].mainKey == "Color") {
          print("Color" +
              _listProductVariant[i].ecomAttributeValueList.toString());
          for (int j = 0;
              j < _listProductVariant[i].ecomAttributeValueList.length;
              j++) {
            String strColors = _listProductVariant[i]
                .ecomAttributeValueList[j]
                .attributeColor
                .toString();
            final splitted = strColors.split('#');
            _listProductVariantColor.add(ItemProductColorsVariant(
                AttributeName: _listProductVariant[i]
                    .ecomAttributeValueList[j]
                    .attributeName
                    .toString(),
                AttributeColor: "0xff" + splitted[1],
                EcomAttributeSKUList: _listProductVariant[i]
                    .ecomAttributeValueList[j]
                    .ecomAttributeSkuList));
            _listProductVariantColorSkuList.add(_listProductVariant[i]
                .ecomAttributeValueList[j]
                .ecomAttributeSkuList[0]);
          }
        }

        if (_listProductVariant[i].mainKey == "Weight") {
          for (int j = 0;
              j < _listProductVariant[i].ecomAttributeValueList.length;
              j++) {
            _listProductVariantWeight.add(ItemProductColorsVariant(
                AttributeName: _listProductVariant[i]
                    .ecomAttributeValueList[j]
                    .attributeName
                    .toString(),
                AttributeColor: "",
                EcomAttributeSKUList: _listProductVariant[i]
                    .ecomAttributeValueList[j]
                    .ecomAttributeSkuList));
            _listProductVariantWeightSkuList.add(_listProductVariant[i]
                .ecomAttributeValueList[j]
                .ecomAttributeSkuList[0]);
          }
        }

        if (_listProductVariant[i].mainKey == "Size") {
          for (int j = 0;
              j < _listProductVariant[i].ecomAttributeValueList.length;
              j++) {
            _listProductVariantSize.add(ItemProductColorsVariant(
                AttributeName: _listProductVariant[i]
                    .ecomAttributeValueList[j]
                    .attributeName
                    .toString(),
                AttributeColor: "",
                EcomAttributeSKUList: _listProductVariant[i]
                    .ecomAttributeValueList[j]
                    .ecomAttributeSkuList));
            _listProductVariantSizeSkuList.add(_listProductVariant[i]
                .ecomAttributeValueList[j]
                .ecomAttributeSkuList[0]);
          }
        }
      }
    }
  }

  setSelectedHeighlitId(
      List<ItemProductColorsVariant> listProductVariantColor) {
    if (_listProductVariantColorSkuList.indexOf(int_SelectedVariantId) != -1) {
      int_SelectedVariantId =
          _listProductVariantColorSkuList.indexOf(int_SelectedVariantId);
      str_SelectedColor = listProductVariantColor[int_SelectedVariantId]
          .AttributeName
          .toString();

      print("SelectedId" +
          _listProductVariantColorSkuList
              .indexOf(int_SelectedVariantId)
              .toString() +
          " " +
          _listProductVariantColorSkuList.toString());
    }
  }

  setSelectedHeighlitWeightId(
      List<ItemProductColorsVariant> listProductVariantColor) {
    if (_listProductVariantWeightSkuList.indexOf(int_SelectedVariantId) != -1) {
      int_SelectedVariantId =
          _listProductVariantWeightSkuList.indexOf(int_SelectedVariantId);
      print("SelectedId" +
          _listProductVariantWeightSkuList
              .indexOf(int_SelectedVariantId)
              .toString() +
          " " +
          _listProductVariantWeightSkuList.toString());
    }
  }

  setSelectedHeighlitSizetId(
      List<ItemProductColorsVariant> listProductVariantColor) {
    if (_listProductVariantSizeSkuList.indexOf(int_SelectedVariantId) != -1) {
      int_SelectedVariantId =
          _listProductVariantSizeSkuList.indexOf(int_SelectedVariantId);
      str_SelectedSize = listProductVariantColor[int_SelectedVariantId]
          .AttributeName
          .toString();
      print("SelectedSize" +
          _listProductVariantSizeSkuList
              .indexOf(int_SelectedVariantId)
              .toString() +
          " " +
          _listProductVariantSizeSkuList.toString());
    }
  }

  void clearList() {
    _listProductVariantColor = [];
    _listProductVariantColorSkuList = [];
    _listProductVariantWeight = [];
    _listProductVariantWeightSkuList = [];
    _listProductVariantSize = [];
    _listProductVariantSizeSkuList = [];
  }
}
