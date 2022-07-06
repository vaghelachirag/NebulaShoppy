import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:nebulashoppy/model/getCityByStateResponse/getCityByStateResponse.dart';
import 'package:nebulashoppy/model/getstateResponse.dart';
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

class EditMyAddress extends StatefulWidget {
  EditMyAddress({Key? key}) : super(key: key);
  @override
  State<EditMyAddress> createState() => _EditMyAddressState();
}

class _EditMyAddressState extends State<EditMyAddress>
    with WidgetsBindingObserver {
  final GlobalKey<State> _dialogKey = GlobalKey<State>();
  List<GetMyAddressData> _listMyAddress = [];
  List<GetstateData> _listState = [];
   List<String> _listStatefilter = [];
  bool bl_ShowAddress = false;

  // For State Selection
  late GetstateData _getSelectedState;
  String str_SelectedState = "";
  int int_SelectedState = 0;
  String str_State = 'Select State';
  String str_City = 'City';

  List<getCityByStateData> _listCity = [];
  List<String> _listCityfilter = [];
  late getCityByStateData _getSelectedCity;
  String str_SelectedCity = "";
  int int_SelectedCity = 0;

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _mobileNumberController = TextEditingController();
  TextEditingController _pinCodeController = TextEditingController();
  TextEditingController _flatNumberController = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  TextEditingController _landmarkController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _cityController = TextEditingController();
  TextEditingController _addressTypeController = TextEditingController();

  static final _formKey = GlobalKey<FormState>();

  final dropdownState = GlobalKey<FormFieldState>();

  String str_AddressType = 'Select an Address Type*';
  var _listAddressType = [
    'Select an Address Type*',
    'Home (7 am - 9pm delivery)',
    'Office/Commercial (10am - 6am delivery)'
  ];

  @override
  void initState() {
    super.initState();
     _listStatefilter.add("Select State");
    _listCityfilter.add("City");
    getStateList();
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
          child: appBarWidget(context, 3, "Edit Address", false)),
      body: SingleChildScrollView(
          child: Form(
        key: _formKey,
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(0),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Personal Addresses",
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 8, 10, 0),
              child: getAddressText("Full Name", _fullNameController,
                  "Please Enter Full Name", 100, TextInputType.name),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 8, 10, 0),
              child: getAddressText("Mobile Number", _mobileNumberController,
                  "Please Enter Mobile Number", 11, TextInputType.number),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 8, 10, 0),
              child: getAddressText("Pincode", _pinCodeController,
                  "Please Enter PinCode", 5, TextInputType.number),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 8, 10, 0),
              child: getAddressText(
                  "Flat,House no.. Building, Company,Apartment",
                  _flatNumberController,
                  "Please Enter Flat,House",
                  100,
                  TextInputType.multiline),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 8, 10, 0),
              child: getAddressText(
                  "Area, Colony, Street,Sector,Village",
                  _areaController,
                  "Please Enter Area, Colony, Street,Sector,Village",
                  100,
                  TextInputType.multiline),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 8, 10, 0),
              child: getAddressText(
                  "Landmark e.g. near Apollo Hospital",
                  _landmarkController,
                  "Please Enter Landmark",
                  100,
                  TextInputType.multiline),
            ),
           // Padding(padding: EdgeInsets.fromLTRB(10, 8, 10, 0),child: stateListDropDown()),
              FutureBuilder(builder: (context, snapshot) {
              if (_listStatefilter.isEmpty) {
                return Text("");
              } else {
                return Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: addressStateDropDown());
              }
            }),
            FutureBuilder(builder: (context, snapshot) {
              if (_listCity.isEmpty) {
                return Text("");
              } else {
                return Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                    child: addressCityDropDown());
              }
            }),
           
            addDeliveryInstruction(),
            Padding(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                child: addressTypeDropDown()),
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(10),
              child: OutlinedButton(
                child: Text('Add Address'),
                style: OutlinedButton.styleFrom(
                  primary: Colors.white,
                  shadowColor: Colors.white,
                  backgroundColor: Colors.cyan[300],
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    print("Valid" + "Valid");
                    //getLoginResponse();
                  }
                },
              ),
            ),

            //  setAddressType()
          ],
        ),
      )),
    );
  }

  Column addDeliveryInstruction() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 8, 10, 0),
            child: Text("Add delivery instructions",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(10, 8, 10, 0),
          child: Text(
            "Preferences are used to plan your delivery. However, shipments can somtimes arrive early or later than planned.",
            style: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.w400),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 8, 10, 0),
            child: Text("Address Types",
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  TextFormField getAddressText( String hint,TextEditingController fullNameController, String str_Error,int i,TextInputType name) {
    return TextFormField(
        keyboardType: name,
        controller: fullNameController,
        decoration: addressText(hint),
        onChanged: (value) {
          // do something
        },
        maxLength: i,
        validator: (email) {
          if (email!.isEmpty) {
            return str_Error;
          } else {
            return null;
          }
        });
  }

  TextField getDropDownn(String hint) {
    return TextField(
      enabled: false,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: inputwithdropdown(hint),
      onChanged: (value) {
        // do something
      },
    );
  }

  getMyAddress() {
    if (_listMyAddress.isEmpty) {
      showLoadingDialog(context, _dialogKey, "Please Wait..");
      Service().getMyAddress().then((value) => {
            Navigator.pop(_dialogKey.currentContext!),
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
      margin: EdgeInsets.all(20),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 5, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Add new Address",
                maxLines: 1,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () {
                          // openAccountData(product.postition,context);
                        },
                        icon: Icon(CommunityMaterialIcons.arrow_right))
                  ],
                ),
              )
            ],
          )),
    );
  }

  myAdrresList() {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
          padding: EdgeInsets.fromLTRB(10, 5, 5, 10),
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
                                      child: Text(
                                        _listMyAddress[index]
                                            .fullName
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 3, 10, 0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        _listMyAddress[index]
                                            .addressLine1
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        _listMyAddress[index]
                                            .addressLine2
                                            .toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        _listMyAddress[index].city.toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        _listMyAddress[index].state.toString() +
                                            " " +
                                            _listMyAddress[index]
                                                .pinCode
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                    child: Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        "Mobile:" +
                                            " " +
                                            _listMyAddress[index]
                                                .mobileNo
                                                .toString(),
                                        style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal),
                                      ),
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
              primary: Colors.white,
              shadowColor: Colors.white,
              backgroundColor: Colors.cyan[300],
              textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold),
            ),
            onPressed: () {},
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: OutlinedButton(
            child: Text('Remove'),
            style: OutlinedButton.styleFrom(
              primary: Colors.white,
              shadowColor: Colors.white,
              backgroundColor: Colors.cyan[300],
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
    showLoadingDialog(context, _dialogKey, "Please Wait..");
    Service()
        .getDeletMyAddressResponse(listMyAddres.id.toString())
        .then((value) => {
              Navigator.pop(_dialogKey.currentContext!),
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

  getStateList() {
    Service().getStateList().then((value) => {
          if (this.mounted)
            {
              setState((() {
                if (value.statusCode == 1) {
                  //  print("Categorylist" + value.message);
                  _listState = value.data!;
                  _getSelectedState = _listState[0];
                  filterStateList();
                } else {
                  showSnakeBar(context, somethingWrong);
                  print("Categorylist" + "Opps Something Wrong!");
                }
              }))
            }
        });
  }

  InputDecorator stateListDropDown() {
    return InputDecorator(
      decoration: addressText("State"),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<GetstateData>(
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
            fontFamily: "verdana_regular",
          ),
          hint: Text(
            "Select Bank",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "verdana_regular",
            ),
          ),
          items: _listState
              .map<DropdownMenuItem<GetstateData>>((GetstateData value) {
            return DropdownMenuItem(
              value: value,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(value.stateName),
                ],
              ),
            );
          }).toList(),
          isExpanded: true,
          isDense: true,
          onChanged: (dynamic value) {
            print("Value" + value.stateName);
            setState(() {
              _getSelectedState = value;
              int_SelectedState = value.stateId;
              getCityByState(int_SelectedState);
            });
          },
          value: _getSelectedState,
        ),
      ),
    );
  }

  InputDecorator stateCityDropDown() {
    return InputDecorator(
      decoration: addressText("City"),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<getCityByStateData>(
          style: TextStyle(
            fontSize: 16,
            color: Color.fromARGB(255, 10, 8, 8),
            fontFamily: "verdana_regular",
          ),
          hint: Text(
            "Select Bank",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontFamily: "verdana_regular",
            ),
          ),
          items: _listCity.map<DropdownMenuItem<getCityByStateData>>(
              (getCityByStateData value) {
            return DropdownMenuItem(
              value: value,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(value.cityName),
                ],
              ),
            );
          }).toList(),
          isExpanded: true,
          isDense: true,
          onChanged: (dynamic value) {
            print("Value" + value.cityName);
            setState(() {
              _getSelectedCity = value;
              int_SelectedCity = value.stateId;
            });
          },
          value: _getSelectedCity,
        ),
      ),
    );
  }

DropdownButtonHideUnderline addressStateDropDown() {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
        decoration: addressText("City"),
        style: TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 10, 8, 8),
          fontFamily: "verdana_regular",
        ),
        hint: Text(
          "Select Bank",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: "verdana_regular",
          ),
        ),
        items: _listStatefilter.map((String items) {
          return DropdownMenuItem(value: items, child: Text(items));
        }).toList(),
        onChanged: (dynamic newValue) {
          setState(() {
            str_State = newValue.toString();
            for(int i=0; i<_listState.length; i++){
                if(_listState[i].stateName == str_State){
                     int_SelectedState = _listState[i].stateId;
                    getCityByState(int_SelectedState);
                    str_City = "City";
                    break;
                }
            }
          });
        },
        isExpanded: true,
        isDense: true,
        value: str_State,
      ),
    );
  }

   DropdownButtonHideUnderline addressCityDropDown() {
     return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
        decoration: addressText("City"),
        style: TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 10, 8, 8),
          fontFamily: "verdana_regular",
        ),
        hint: Text(
          "Select Bank",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: "verdana_regular",
          ),
        ),
        items: _listCityfilter.map((String items) {
          return DropdownMenuItem(value: items, child: Text(items));
        }).toList(),
        onChanged: (dynamic newValue) {
          setState(() {
            str_City = newValue.toString();
          });
        },
        isExpanded: true,
        isDense: true,
        value: str_City,
      ),
    );
   }

  DropdownButtonHideUnderline addressTypeDropDown() {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField(
        decoration: addressText("City"),
        style: TextStyle(
          fontSize: 16,
          color: Color.fromARGB(255, 10, 8, 8),
          fontFamily: "verdana_regular",
        ),
        hint: Text(
          "Select Bank",
          style: TextStyle(
            color: Colors.grey,
            fontSize: 16,
            fontFamily: "verdana_regular",
          ),
        ),
        items: _listAddressType.map((String items) {
          return DropdownMenuItem(value: items, child: Text(items));
        }).toList(),
        onChanged: (dynamic newValue) {
          setState(() {
            str_AddressType = newValue.toString();
          });
        },
        isExpanded: true,
        isDense: true,
        value: str_AddressType,
      ),
    );
  }

  getCityByState(int int_selectedState) {
    print("SelectedId" + int_selectedState.toString());
    Service().getCityByState(int_selectedState.toString()).then((value) => {
          if (this.mounted)
            {
              setState((() {
                if (value.statusCode == 1) {
                  print("Categorylist" + value.message);
                  _listCity = value.data;
                   filterCity();
                  _getSelectedCity = _listCity[0];
                } else {
                  showSnakeBar(context, somethingWrong);
                  print("Categorylist" + "Opps Something Wrong!");
                }
              }))
            }
        });
  }

  void filterStateList() {
    for(int i=0; i<_listState.length; i++){
      _listStatefilter.add(_listState[i].stateName);   
    }
     print("Filter"+_listStatefilter.toString());
  }

  void filterCity() {
    for(int i=0; i<_listCity.length; i++){
      _listCityfilter.add(_listCity[i].cityName);
    }
  }


}
