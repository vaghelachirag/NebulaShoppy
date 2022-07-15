import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:nebulashoppy/model/getMyAddressResponse/getAddressByCityResponse.dart';
import 'package:nebulashoppy/widget/common_widget.dart';

import '../model/getMyAddressResponse/getMyAddressResponse.dart';
import '../network/service.dart';
import '../uttils/constant.dart';

class GETMYADDRESSDIALOUG extends StatefulWidget {
  final VoidCallback onAddressSelection;

  GETMYADDRESSDIALOUG({required this.onAddressSelection});

  @override
  _GETMYADDRESSDIALOUGState createState() => _GETMYADDRESSDIALOUGState();
}

class _GETMYADDRESSDIALOUGState extends State<GETMYADDRESSDIALOUG> {
  bool bl_IsPickup = false;
  bool bl_IsDrop = false;
  bool isSelectedPickup = false;
  bool isShowCity = false;
  bool isDoorStepDelivery = false;

  bool isAhmedabadClick = false;
  bool isHyderabadClick = false;
  bool isChennaiClick = false;

  bool isAhmedabadShow = true;
  bool isHyderabadShow = true;
  bool isChennaiShow = true;

  final GlobalKey<State> _dialogKey = GlobalKey<State>();

  List<GetAddressByCityData> _listAddressCityList = [];
  final List<GetMyAddressData> _listMyAddress = [];
  List<GetMyAddressData> _listMyAddressList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Visibility(
                visible: showProgress, child: showMaterialProgressbar(5)),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Choose Your Location",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Select a delivery location to see product availability and delivery options",
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                      fontWeight: FontWeight.normal),
                )),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 0),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        bl_IsDrop = true;
                        isDoorStepDelivery = true;
                        isSelectedPickup = false;
                        isAhmedabadClick = false;
                        isHyderabadClick = false;
                        isChennaiClick = false;
                        isShowCity = false;
                        _listAddressCityList.clear();
                        setCityVisibity(3);
                        getMyAddress();
                      });
                      print("Tap" + "Dorr Click");
                    },
                    child: Card(
                      color: isDoorStepDelivery == true
                          ? buttonColor
                          : Colors.white,
                      elevation: 5,
                      child: Row(
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: Icon(CommunityMaterialIcons.dump_truck),
                              color: Colors.cyan),
                          Text(
                            "Door step delivery (shipping charges applicable).",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                fontWeight: FontWeight.w700),
                          )
                        ],
                      ),
                    ))),
            Padding(
              padding: EdgeInsets.all(5),
              child: Text(
                "OR",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 2, 10, 0),
                child: GestureDetector(
                  onTap: () {
                    print("Tap" + "Pickup");
                    setState(() {
                      bl_IsDrop = false;
                      bl_IsPickup = true;
                      isDoorStepDelivery = false;
                      isSelectedPickup = true;
                      isShowCity = true;
                      isAhmedabadClick = false;
                      isHyderabadClick = false;
                      isChennaiClick = false;
                      isShowCity = true;
                      _listAddressCityList.clear();
                      setCityVisibity(3);
                    });
                  },
                  child: Card(
                    color:
                        isSelectedPickup == true ? buttonColor : Colors.white,
                    elevation: 5,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon:
                                Icon(CommunityMaterialIcons.map_marker_circle),
                            color: Colors.cyan),
                        Text(
                          "Select a pickup point.",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                  ),
                )),
            Visibility(
                visible: bl_IsPickup && isShowCity,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: cityList(),
                )),
            Visibility(
                visible: bl_IsDrop,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: getMyDeliveryAddress()))
          ],
        ),
      ),
    );
  }

  Column cityList() {
    return Column(
      children: [
        Visibility(
            visible: isAhmedabadShow == true,
            child: InkWell(
              onTap: () {
                print("City" + "Ahmedabad");
                setState(() {
                  isAhmedabadClick = true;
                  isHyderabadClick = false;
                  isChennaiClick = false;
                  isSelectedPickup = false;
                  getAddressbyCityId("783", 0);
                });
              },
              child: Card(
                color: isAhmedabadClick == true ? buttonColor : Colors.white,
                elevation: 5,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
                      child: SizedBox(
                          width: 25,
                          height: 25,
                          child:
                              Image.asset(assestPath + 'ahmedabad_icon.png')),
                    ),
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(CommunityMaterialIcons.city),
                    //     color: Colors.cyan),
                    Text(
                      "Ahmedabad",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            )),
        Visibility(
            visible: isHyderabadShow == true,
            child: InkWell(
              onTap: () {
                print("City" + "Hyderabad");
                setState(() {
                  isAhmedabadClick = false;
                  isHyderabadClick = true;
                  isChennaiClick = false;
                  isSelectedPickup = false;
                  getAddressbyCityId("4460", 1);
                });
              },
              child: Card(
                color: isHyderabadClick == true ? buttonColor : Colors.white,
                elevation: 5,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
                      child: SizedBox(
                          width: 25,
                          height: 25,
                          child:
                              Image.asset(assestPath + 'hydrabad_icon.png')),
                    ),
                    Text(
                      "Hyderabad",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            )),
        Visibility(
            visible: isChennaiShow == true,
            child: InkWell(
              onTap: () {
                print("City" + "Chennai");
                setState(() {
                  isAhmedabadClick = false;
                  isHyderabadClick = false;
                  isChennaiClick = true;
                  isSelectedPickup = false;
                  getAddressbyCityId("3659", 2);
                });
              },
              child: Card(
                color: isChennaiClick == true ? buttonColor : Colors.white,
                elevation: 5,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
                      child: SizedBox(
                          width: 25,
                          height: 25,
                          child: Image.asset(assestPath + 'chennai_icon.png')),
                    ),
                    // IconButton(
                    //     onPressed: () {},
                    //     icon: Icon(CommunityMaterialIcons.city),
                    //     color: Colors.cyan),
                    Text(
                      "Chennai",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w700),
                    )
                  ],
                ),
              ),
            )),
        FutureBuilder(
          builder: (context, snapshot) {
            if (_listAddressCityList.isEmpty) {
              return Text("");
            } else {
              return Align(
                alignment: Alignment.topLeft,
                child: getCityAddress(),
              );
            }
          },
        )
      ],
    );
  }

  void getAddressbyCityId(String str_CityId, int int_Position) {
    //  showLoadingDialog(context, _dialogKey, "Please Wait..");
    showProgressbar();
    Service().getAddressByCitySelection(str_CityId).then((value) => {
          //    Navigator.pop(_dialogKey.currentContext!),
          hideProgressBar(),
          if (value.toString() == str_ErrorMsg)
            {
              showSnakeBar(context, str_ErrorMsg),
            }
          else
            {
              setState(() {
                setCityVisibity(int_Position);
                _listAddressCityList.clear();
                _listAddressCityList = value.data;
              })
            }
        });
  }

  getMyAddress() {
    if (_listMyAddress.isEmpty) {
      // showLoadingDialog(context, _dialogKey, "Please Wait..");
      showProgressbar();
      Service().getMyAddress().then((value) => {
            hideProgressBar(),
            //Navigator.pop(_dialogKey.currentContext!),
            if (value.toString() == str_ErrorMsg) {setState((() {}))},
            if (value.toString() != str_ErrorMsg)
              {
                if (value.statusCode == 1)
                  {
                    setState((() {
                      _listMyAddressList = value.data;
                      // bl_ShowAddress = true;
                    }))
                  }
              }
          });
    }
  }

  GestureDetector getCityAddress() {
    return GestureDetector(
      onTap: () {
        setState(() {
          str_SelectedAddress = _listAddressCityList[0].address.toString();
          widget.onAddressSelection();
          Navigator.pop(context);
        });
        print("SelectedAddresss" + "SelectedAddress");
      },
      child: Container(
        width: 200,
        child: Padding(
            padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
            child: Column(
              children: [
                Card(
                    margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      margin: EdgeInsets.all(0),
                      padding: EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                  padding:
                                      EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                                  child: Text(
                                      _listAddressCityList[0]
                                          .address
                                          .toString(),
                                      style: TextStyle(fontFamily: EmberBold),
                                      softWrap: true),
                                )),
                          ),
                        ],
                      ),
                    ))
              ],
            )),
      ),
    );
  }

  void setCityVisibity(int int_position) {
    if (int_position == 0) {
      isAhmedabadShow = true;
      isHyderabadShow = false;
      isChennaiShow = false;
    }
    if (int_position == 1) {
      isAhmedabadShow = false;
      isHyderabadShow = true;
      isChennaiShow = false;
    }
    if (int_position == 2) {
      isAhmedabadShow = false;
      isHyderabadShow = false;
      isChennaiShow = true;
    }
    if (int_position == 3) {
      isAhmedabadShow = true;
      isHyderabadShow = true;
      isChennaiShow = true;
    }
  }

  FutureBuilder getMyDeliveryAddress() {
    return FutureBuilder(
      builder: (context, snapshot) {
        if (_listMyAddressList.isEmpty) {
          return Text("");
        } else {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _listMyAddressList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.pop(context);
                      str_SelectedAddress =
                          getPickupAddress(_listMyAddressList[index]);
                      widget.onAddressSelection();
                    });
                  },
                  child: Container(
                    child: Padding(
                        padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
                        child: Column(
                          children: [
                            Card(
                                margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                elevation: 5,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(0),
                                  padding: EdgeInsets.all(0),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(10),
                                        child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0.0, 0.0, 0.0, 15.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Text(getPickupAddress(
                                                      _listMyAddressList[
                                                          index])),
                                                ],
                                              ),
                                            )),
                                      ),
                                    ],
                                  ),
                                ))
                          ],
                        )),
                  ));
            },
          );
        }
      },
    );
  }

  String getPickupAddress(GetMyAddressData getMyAddressData) {
    String str_Address = getMyAddressData.fullName.toString() +
        "\n" +
        getMyAddressData.addressLine1.toString() +
        " , " +
        getMyAddressData.addressLine2.toString() +
        " , " +
        getMyAddressData.city.toString() +
        " , " +
        getMyAddressData.state.toString() +
        "," +
        "(" +
        getMyAddressData.mobileNo.toString() +
        ")";
    print("Address" + str_Address);
    return str_Address;
  }
}
