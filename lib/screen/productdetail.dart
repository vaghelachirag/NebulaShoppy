import 'dart:convert';
import 'dart:math';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nebulashoppy/model/getCartItemResponse/getCarItemResponse.dart';
import 'package:nebulashoppy/model/homescreen/itemNewLaunched.dart';
import 'package:nebulashoppy/model/homescreen/itemhomecategory.dart';
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
import 'package:nebulashoppy/widget/SearchWidget.dart';
import 'package:nebulashoppy/widget/dotted_slider.dart';
import '../model/homescreen/itembannerimage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../model/product.dart';
import '../widget/soldoutdialoug.dart';
import '../widget/star_rating.dart';
import '../widget/trending_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:http/http.dart' as http;

class ProductDetail extends StatefulWidget {
  int id;
  int productid;
  int categoryid;

  String device_Id = "";

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
  String str_UserId = "";
  bool isClicked = false;
  List<ProductBannerData> _listBannerImage = [];
  List<dynamic> _listProductImageDetail = [];
  List<itemNewLaunchedProduct> _listNewLaunched = [];
  List<ItemProductVariantData> _listProductVariant = [];
  List<ItemCart> _listCartItem = [];

  // Product Detail Data
  String str_Mrp = "";
  String str_saleprice = "";
  String str_PV = "";
  String str_BV = "";
  String str_NV = "";
  String str_SKU = "";
  String str_Description = "";
  String str_highlightsIds = "";

  int? int_ProductQuantity = 0;
  int? int_CartQuantity = 0;
  int? int_CartCounter = 0;
  bool is_ShowDescription = false;
  bool is_ShowCart = false;
  final controller = PageController(viewportFraction: 1, keepPage: true);

  final GlobalKey<State> _dialogKey = GlobalKey<State>();
  @override
  void initState() {
    super.initState();
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
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: appBarWidget(context, 3, "Product detail", true)),
      bottomNavigationBar: Visibility(
        visible: is_ShowCart,
        child: Container(
            color: Theme.of(context).backgroundColor,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 11,
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
                          child: Container(
                            child: Padding(
                              padding: EdgeInsets.all(0),
                              child: CircleAvatar(
                                  backgroundColor: Colors.cyan,
                                  maxRadius: 25,
                                  child: Icon(
                                    CommunityMaterialIcons.heart,
                                    color: Colors.white,
                                  )),
                            ),
                          ),
                        )),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        "Add To Cart",
                        style: TextStyle(fontSize: 20, color: Colors.black),
                      ),
                    ),
                    Container(
                      child: GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.device_Id = DeviceId.toString();
                            });
                            showLoadingDialog(
                                context, _dialogKey, "Please Wait..");
                            addToCart(widget.device_Id, str_UserId,
                                widget.productid.toString(), 1, Flag_Minus);
                          },
                          child: Padding(
                            padding: EdgeInsets.all(0),
                            child: CircleAvatar(
                              backgroundColor: Colors.cyan,
                              maxRadius: 25,
                              child: Text(
                                "-",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        int_CartQuantity.toString(),
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                        alignment: Alignment.topRight,
                        child: GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.device_Id = DeviceId.toString();
                              });
                              print("AddDeviceId" + widget.device_Id);
                              showLoadingDialog(
                                  context, _dialogKey, "Please Wait..");
                              addToCart(widget.device_Id, str_UserId,
                                  widget.productid.toString(), 1, Flag_Plus);
                              print("onCart" + "Add To Cart");
                            },
                            child: Container(
                              child: Padding(
                                padding: EdgeInsets.all(0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.cyan,
                                  maxRadius: 25,
                                  child: Text(
                                    "+",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.normal),
                                  ),
                                ),
                              ),
                            )))
                  ],
                ))),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _getTopImage(context),
            _buildInfo(context),
            // _getproductVariant(context),
            //Product Info
            // _buildExtra(context),
            _buildDescription(context),
            //  _buildComments(context),
            _buildProductImageData(context),
            _buildProducts(context),
          ],
        ),
      ),
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
      height: 200,
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
                  height: 150,
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
          style: TextStyle(fontSize: 16, color: Colors.red),
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
              child: 
              InkWell(
                onTap: (){
                   print("Test"+"Test");
                     Navigator.of(context).push(MaterialPageRoute(builder: (context) => SliderShowFullmages(listBannerImage: _listBannerImage,current: 0,)));
                },
                child:   Container(
                width: MediaQuery.of(context).size.width,
                height: 280,
                child: Center(
                  child: FadeInImage.assetNetwork(
                      placeholder: placeholder_path,
                      image: _listBannerImage[index].imageFile,
                      fit: BoxFit.fill),
                ),
              ),
              )
            ,
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
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _listBannerImage[0].name,
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.normal),
                              ),
                              Align(
                                alignment: Alignment.topRight,
                                child: StarRating(rating: 5, size: 16),
                              ),
                            ],
                          ),
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              _listBannerImage[0].description,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.normal),
                            ),
                          )
                        ],
                      )),
                  Column(
                    children: [
                      SizedBox(
                        height: 240,
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
                                dotHeight: 12,
                                dotWidth: 12,
                                activeDotColor: Colors.cyan)),
                      )
                    ],
                  )
                ],
              );
            }
          },
        ));
  }

  _getproductVariant(context) {
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
                    "White",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.all(0),
                child: CircleAvatar(
                  backgroundColor: Colors.green,
                  maxRadius: 15,
                  child: Text(
                    "-",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  _buildInfo(context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  '\u{20B9}${str_saleprice}',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                )
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Text(
                  "MRP:  " + rupees_Sybol,
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.normal),
                ),
                Padding(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      str_Mrp,
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
                    Text(
                      "PV:",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        str_PV,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "BV:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        str_BV,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "NV:",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        str_NV,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
                    )
                  ],
                )),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "SKU:",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.bold),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        str_SKU,
                        style: TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                            fontWeight: FontWeight.normal),
                      ),
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
                OutlineButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0)),
                  child: Text('64 GB'),
                  onPressed: () {}, //callback when button is clicked
                  borderSide: BorderSide(
                    color: Colors.grey, //Color of the border
                    style: BorderStyle.solid, //Style of the border
                    width: 0.8, //width of the border
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                OutlineButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0)),
                  child: Text('128 GB'),
                  onPressed: () {}, //callback when button is clicked
                  borderSide: BorderSide(
                    color: Colors.red, //Color of the border
                    style: BorderStyle.solid, //Style of the border
                    width: 1, //width of the border
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 8,
            ),
            Text("Color"),
            Row(
              children: <Widget>[
                OutlineButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0)),
                  child: Text('GOLD'),
                  onPressed: () {}, //callback when button is clicked
                  borderSide: BorderSide(
                    color: Colors.orangeAccent, //Color of the border
                    style: BorderStyle.solid, //Style of the border
                    width: 1.5, //width of the border
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                OutlineButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0)),
                  child: Text('SILVER'),
                  onPressed: () {}, //callback when button is clicked
                  borderSide: BorderSide(
                    color: Colors.grey, //Color of the border
                    style: BorderStyle.solid, //Style of the border
                    width: 0.8, //width of the border
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                OutlineButton(
                  shape: new RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(8.0)),
                  child: Text('PINK'),
                  onPressed: () {}, //callback when button is clicked
                  borderSide: BorderSide(
                    color: Colors.grey, //Color of the border
                    style: BorderStyle.solid, //Style of the border
                    width: 0.8, //width of the border
                  ),
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
          height: MediaQuery.of(context).size.height / 3.8,
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
                        fontWeight: FontWeight.bold,
                        color: Colors.black45,
                        fontSize: 18,
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Visibility(
                        visible: is_ShowDescription,
                        child: Expanded(child: Html(data: str_Description))),
                    SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          _settingModalBottomSheet(context, str_Description);
                        },
                        child: Text(
                          "View More",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.blueGrey,
                              fontSize: 16),
                        ),
                      ),
                    )
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
                Text(
                  "View All",
                  style: TextStyle(fontSize: 18.0, color: Colors.blue),
                  textAlign: TextAlign.end,
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
              Expanded(
                child: Text(
                  "Similar Items",
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.black54),
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    print("Clicked");
                  },
                  child: Text(
                    "View All",
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
          height: 180,
          child: FutureBuilder(
            future: getNewLaunchedProduct(),
            builder: (context, snapshot) {
              if (_listNewLaunched.isEmpty) {
                return loadSkeletonLoader(skeletonbuildNewLaunch());
              } else {
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _listNewLaunched.length,
                  itemBuilder: (context, index) {
                    return TrendingItem(
                      product: Product(
                          id: _listNewLaunched[index].productId,
                          productid: _listNewLaunched[index].id,
                          catid: _listNewLaunched[index].categoryId,
                          company: _listNewLaunched[index].name.toString(),
                          name: _listNewLaunched[index]
                              .shortDescription
                              .toString(),
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
                      mrp: '\$' + "Test"),
                  gradientColors: [Colors.white, Colors.white],
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

  getProductDetail(int productid) {
    Service().getProductDetail(productid.toString(), "0").then((value) => {
          setState((() {
            print("Banner" + value.message.toString());
            if (value.statusCode == 1) {
              setProductData(value.data);
            } else {
              showSnakeBar(context, somethingWrong);
              print("Categorylist" + "Opps Something Wrong!");
            }
          }))
        });
  }

  setProductData(itemProdctDetailData data) {
    str_Mrp = data.mrp.toString();
    str_saleprice = data.salePrice.toString();
    str_BV = data.bv.toString();
    str_PV = data.pv.toString();
    str_NV = data.nv.toString();
    str_SKU = data.sku.toString();
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
    getProductVarinatData();
    getProductDetailImage();
    getCartItemList();
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
              getProductDetail(widget.id);
            } else {
              showSnakeBar(context, somethingWrong);
              print("Categorylist" + "Opps Something Wrong!");
              getProductDetail(widget.id);
            }
          }))
        });
  }

  getProductVarinatData() async {
    Service().getProductVarintData("0", "65").then((value) => {
          setState((() {
            print("Banner" + value.message.toString());
            if (value.statusCode == 1) {
              _listProductVariant = value.data!;
              print("ProductVarint" + _listProductVariant.length.toString());
            } else {
              showSnakeBar(context, somethingWrong);
              print("Categorylist" + "Opps Something Wrong!");
            }
          }))
        });
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
    Service()
        .getAddToCartResponse(
            deviceId, str_userId, productId, quntity.toString(), flag)
        .then((value) => {
              setState((() {
                if (_dialogKey.currentContext != null) {
                  Navigator.pop(_dialogKey.currentContext!);
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
                }
              }))
            });
  }

  void setDeviceId() async {
    setState(() {
      widget.device_Id = DeviceId.toString();
    });
  }

  void getCartItemList() {
    Service().getCartItemWithoutLogin(widget.device_Id, "0").then((value) => {
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
}
