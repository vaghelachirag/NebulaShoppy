import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:nebulashoppy/screen/address/addnewAddress.dart';
import 'package:nebulashoppy/screen/address/editmyAddress.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/uttils/CircularProgress.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/categoryproductWidget.dart';
import 'package:nebulashoppy/widget/common_widget.dart';
import 'package:page_transition/page_transition.dart';

import '../../model/getMyAddressResponse/getMyAddressResponse.dart';
import '../../model/homescreen/itemNewLaunched.dart';
import '../../model/homescreen/itemhomecategory.dart';
import '../../model/product.dart';
import '../../network/service.dart';
import '../../uttils/constant.dart';
import '../../widget/trending_item.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:community_material_icon/community_material_icon.dart';

class GetMyAddress extends StatefulWidget {
  GetMyAddress({Key? key}) : super(key: key);
  @override
  State<GetMyAddress> createState() => _GetMyAddressState();
}

class _GetMyAddressState extends State<GetMyAddress>
    with WidgetsBindingObserver {
  final GlobalKey<State> _dialogKey = GlobalKey<State>();
  List<GetMyAddressData> _listMyAddress = [];
  bool bl_ShowAddress = false;
  bool bl_ShowLoading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    showProgressbar();
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
          preferredSize: const Size.fromHeight(int_AppBarWidth),
          child: appBarWidget(context, 3, "Address", false)),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            showMaterialProgressbar(6),
            Padding(
              padding: EdgeInsets.all(0),
              child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: setBoldText("Your Addresses", 16, Colors.black))),
            ),
            addnewAddress(context),
            Visibility(
                visible: bl_ShowAddress,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(15, 10, 10, 0),
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: setBoldText(
                            "Personal Addresses", 16, Colors.black)))),
            Visibility(visible: bl_ShowAddress, child: myAdrresList())
          ],
        ),
      ),
    );
  }

  getMyAddress() {
    if (_listMyAddress.isEmpty) {
      setState(() {
         bl_ShowLoading = true;        
          showProgressbar();
      });
      
     // showLoadingDialog(context, _dialogKey, "Please Wait..");
      Service().getMyAddress().then((value) => {
             bl_ShowLoading = false,
             hideProgressBar(),
           // Navigator.pop(_dialogKey.currentContext!),
            if (value.toString() == str_ErrorMsg) {setState((() {}))},
            if (value.toString() != str_ErrorMsg)
              {
                if (value.statusCode == 1)
                  {
                    setState((() {
                      _listMyAddress = value.data;
                      bl_ShowAddress = true;
                    }))
                  }
              }
          });
    }
  }

  addnewAddress(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(10, 5, 20, 0),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              setRegularText("Add new Address", 12, Colors.black54),
              // Text(
              //  "Add new Address",
              //   maxLines: 1,
              //   style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal),
              // ),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          // openAccountData(product.postition,context);

                          navigateToAddNewScreen();
                        },
                        icon: Icon(CommunityMaterialIcons.arrow_right))
                  ],
                ),
              )
            ],
          )),
    );
    ;
  }

  myAdrresList() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 5, 10),
          child: Column(
            children: [
              FutureBuilder(
                future: getMyAddress(),
                builder: (context, snapshot) {
                  if (_listMyAddress.isEmpty) {
                    return Text("");
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _listMyAddress.length,
                      itemBuilder: (context, index) {
                        return Card(
                            margin: EdgeInsets.all(5),
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              width: MediaQuery.of(context).size.width,
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: setBoldText(
                                          _listMyAddress[index]
                                              .fullName
                                              .toString(),
                                          16,
                                          Colors.black),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 3, 10, 0),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: setRegularText(
                                            _listMyAddress[index]
                                                .addressLine1
                                                .toString(),
                                            14,
                                            Colors.black)
                                        //Text(_listMyAddress[index].addressLine1.toString(),style:  TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
                                    child: Align(
                                        alignment: Alignment.topLeft,
                                        child: setRegularText(
                                            _listMyAddress[index]
                                                .addressLine2
                                                .toString(),
                                            14,
                                            Colors.black)
                                        // Text(_listMyAddress[index].addressLine2.toString(),style:  TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                        ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: setRegularText(
                                          _listMyAddress[index].city.toString(),
                                          14,
                                          Colors.black),
                                      //  Text(_listMyAddress[index].city.toString(),style:  TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: setRegularText(
                                          _listMyAddress[index]
                                              .state
                                              .toString(),
                                          14,
                                          Colors.black),
                                      //  Text(_listMyAddress[index].state.toString() + " "+ _listMyAddress[index].pinCode.toString(),style:  TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 5, 5, 0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: setRegularText(
                                          "Mobile:" +
                                              " " +
                                              _listMyAddress[index]
                                                  .mobileNo
                                                  .toString(),
                                          14,
                                          Colors.black),
                                      //Text("Mobile:" + " "+ _listMyAddress[index].mobileNo.toString(),style:  TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: bottomButton(_listMyAddress[index]),
                                  )
                                ],
                              ),
                            ));
                      },
                    );
                    ;
                  }
                },
              )
            ],
          )),
    );
  }

  Row bottomButton(GetMyAddressData listMyAddres) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: OutlinedButton(
            child: Text('Edit'),
            style: OutlinedButton.styleFrom(
              primary: Colors.black,
              shadowColor: Colors.black,
              backgroundColor: Colors.grey[200],
              textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              editAddress(listMyAddres);

              // Navigator.push(
              //   context,
              //   PageTransition(
              //     type: PageTransitionType.fade,
              //     child: EditMyAddress(
              //         strFullName: listMyAddres.fullName.toString(),
              //         strAddressLine1: listMyAddres.addressLine1.toString(),
              //         strAddressLine2: listMyAddres.addressLine2.toString(),
              //         strCity: listMyAddres.city.toString(),
              //         strState: listMyAddres.state.toString(),
              //         strMobileNo: listMyAddres.mobileNo.toString(),
              //         strPinCode: listMyAddres.pinCode.toString(),
              //         strLandmark: listMyAddres.landmark.toString(),
              //         strId: listMyAddres.id.toString()),
              //   ),
              // );
            },
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: OutlinedButton(
            child: Text('Remove'),
            style: OutlinedButton.styleFrom(
              primary: Colors.black,
              shadowColor: Colors.black,
              backgroundColor: Colors.grey[200],
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              showAlertRemoveAddress(context, listMyAddres);
            },
          ),
        )
      ],
    );
  }

  showAlertRemoveAddress(BuildContext context, GetMyAddressData listMyAddres) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("No"),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = TextButton(
      child: Text("Yes"),
      onPressed: () {
        deleteMyAddress(listMyAddres);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Alert"),
      content: Text("Are you sure want to delete this address"),
      actions: [
        cancelButton,
        continueButton,
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

  void deleteMyAddress(GetMyAddressData listMyAddres) {
    Navigator.pop(context);
    setState(() {
      showProgressbar();
    });
   // showLoadingDialog(context, _dialogKey, "Please Wait..");
    Service()
        .getDeletMyAddressResponse(listMyAddres.id.toString())
        .then((value) => {
              hideProgressBar(),
              //Navigator.pop(_dialogKey.currentContext!),
              if (value.toString() == str_ErrorMsg) {setState((() {}))},
              if (value.toString() != str_ErrorMsg)
                {
                  if (value.statusCode == 1)
                    {
                      setState((() {
                        showSnakeBar(context, "Address Removed Successfully!");
                        _listMyAddress.remove(listMyAddres);
                      }))
                    }
                }
            });
  }

  navigateToAddNewScreen() async {
    var push_AddNewAddress = await Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => AddNewAddress()));

    if (push_AddNewAddress != null || push_AddNewAddress == true) {
      // perform your function
      print("Addnew" + "AddNews");
      _listMyAddress.clear();
      getMyAddress();
    }
  }

  void editAddress(GetMyAddressData listMyAddres) async {
    var push_EditAddress = await Navigator.of(context).push(MaterialPageRoute(
      builder: (context) => EditMyAddress(
          strFullName: listMyAddres.fullName.toString(),
          strAddressLine1: listMyAddres.addressLine1.toString(),
          strAddressLine2: listMyAddres.addressLine2.toString(),
          strCity: listMyAddres.city.toString(),
          strState: listMyAddres.state.toString(),
          strMobileNo: listMyAddres.mobileNo.toString(),
          strPinCode: listMyAddres.pinCode.toString(),
          strLandmark: listMyAddres.landmark.toString(),
          strId: listMyAddres.id.toString()),
    ));

    if (push_EditAddress != null || push_EditAddress == true) {
      // perform your function
      print("Addnew" + "AddNews");
      _listMyAddress.clear();
      getMyAddress();
    }
  }
}
