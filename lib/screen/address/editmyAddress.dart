import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/android.dart';
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

  EditMyAddress({Key? key})
      : super(key: key);
  @override
  State<EditMyAddress> createState() => _EditMyAddressState();
}

class _EditMyAddressState extends State<EditMyAddress>
    with WidgetsBindingObserver {
 
  final GlobalKey<State> _dialogKey = GlobalKey<State>();
    List<GetMyAddressData> _listMyAddress = [];
      List<GetstateData> _listState = [];
    bool bl_ShowAddress = false;
  int _value = 1;
  
  @override
  void initState() {
    super.initState();
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
          child: appBarWidget(context, 3, "EditAddress", false)),
      body:  SingleChildScrollView(child:   Column(
        children:  <Widget>[
  Padding(padding: EdgeInsets.all(0),
      child: 
      Padding(padding: EdgeInsets.all(10),child:   Align(
        alignment:  Alignment.topLeft,
        child: Text("Personal Addresses",style: TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),),),
      ) ,),
      Padding(padding: EdgeInsets.all(10)
      ,child:getAddressText("Full Name"),),
        Padding(padding: EdgeInsets.all(10)
      ,child:getAddressText("Mobile Number"),),
      Padding(padding: EdgeInsets.all(10)
      ,child:getAddressText("Pincode"),),
       Padding(padding: EdgeInsets.all(10)
      ,child:getAddressText("Flat,House no.. Building, Company,Apartment"),),
         Padding(padding: EdgeInsets.all(10)
      ,child:getAddressText("Area, Colony, Street,Sector,Village"),),
          Padding(padding: EdgeInsets.all(10)
      ,child:getAddressText("Landmark e.g. near Apollo Hospital"),),

      FutureBuilder(
        future: getStateList(),
        builder: (context, snapshot) {
           if(_listState.isEmpty){
             return Text("");
           }
           else{
              return Text("");
        //      return    Container(
        //   padding: EdgeInsets.all(20),
        //   child :DropdownButton(
        //     value: _value,   
        //     items: list_items.map((int item) {
        //       return DropdownMenuItem<int>(
        //         child: Text('Log $item'),
        //         value: item,
        //       );
        //     }).toList(),
            
        //     onChanged:(value) {
        //       setState(() {
        //         _value = value as int;
        //       });
        //     },
        //     hint:Text("Select item"),
        //     disabledHint:Text("Disabled"),
        //     elevation: 8,
        //     style:TextStyle(color:Colors.black, fontSize: 16),
        //     icon: Icon(Icons.arrow_drop_down_circle),
        //     iconDisabledColor: Colors.white,
        //     iconEnabledColor: Colors.grey,
        //     isExpanded: true,
        //     dropdownColor: Colors.white,
        //     )
        // );
           }
      },)
          
        ],
      ) ,)
   
      ,
    );
  }

  TextField getAddressText(String hint){
    return  TextField(
            
            decoration: addressText(hint),
            onChanged: (value) {
              // do something
            },
);
  }

  TextField getDropDownn(String hint){
    return  TextField(
             enabled: false, 
            decoration: inputwithdropdown(hint),
            onChanged: (value) {
              // do something
            },
);
  }

   getMyAddress() {
     if(_listMyAddress.isEmpty){
 showLoadingDialog(context, _dialogKey, "Please Wait..");
       Service().getMyAddress().then((value) => {
          Navigator.pop(_dialogKey.currentContext!),
          if (value.toString() == str_ErrorMsg)
            {
              setState((() {
               
              }))
            },
          if (value.toString() != str_ErrorMsg)
            {
            
               if(value.statusCode == 1){
                 setState((() {
                 _listMyAddress = value.data;
                 bl_ShowAddress  = true;
              }))
               
               }
            }
        });
     }
  
  }


 addnewAddress(BuildContext context) {
    return  Card(
      margin: EdgeInsets.all(20),
  elevation: 5,
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10),
  ),
  child:  Padding(
        padding: EdgeInsets.fromLTRB(10,5,5,10),
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
    ;
  }

  myAdrresList(){
   return Container(
     width: MediaQuery.of(context).size.width,
  child:  Padding(
        padding: EdgeInsets.fromLTRB(10,5,5,10),
        child: Column(
          children: [
             FutureBuilder(
               future:  getMyAddress(),
               builder: (context, snapshot) {
                 if(_listMyAddress.isEmpty){
                   return Text("");
                 }
                 else{
                   return ListView.builder(
             shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _listMyAddress.length,
            itemBuilder: (context, index) {
              return   Card(
      margin: EdgeInsets.all(5),
  elevation: 5,
  shape: RoundedRectangleBorder(
  borderRadius: BorderRadius.circular(10),
  ),
  child: 
              Container(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(5),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Padding(padding: EdgeInsets.all(10),
                    child:     Align(
                      alignment: Alignment.topLeft,
                      child:  Text(_listMyAddress[index].fullName.toString(),style:  TextStyle(fontSize: 16,fontWeight: FontWeight.bold),),
                    ),),
                    Padding(padding: EdgeInsets.fromLTRB(10, 3, 10, 0),
                    child:  Align(
                      alignment: Alignment.topLeft,
                      child:  Text(_listMyAddress[index].addressLine1.toString(),style:  TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                    ) ,),
                     Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child:  Align(
                      alignment: Alignment.topLeft,
                      child:  Text(_listMyAddress[index].addressLine2.toString(),style:  TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                    ) ,),
                     Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child:  Align(
                      alignment: Alignment.topLeft,
                      child:  Text(_listMyAddress[index].city.toString(),style:  TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                    ) ,),
                     Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child:  Align(
                      alignment: Alignment.topLeft,
                      child:  Text(_listMyAddress[index].state.toString() + " "+ _listMyAddress[index].pinCode.toString(),style:  TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                    ) ,),
                      Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                    child:  Align(
                      alignment: Alignment.topLeft,
                      child:  Text("Mobile:" + " "+ _listMyAddress[index].mobileNo.toString(),style:  TextStyle(fontSize: 14,fontWeight: FontWeight.normal),),
                    ) ,),
                    Padding(padding: EdgeInsets.all(5),
                    child: bottomButton(_listMyAddress[index]) ,)
                  ],
                ),
              ));
            },
          );;
                 }
             },)
          ],
        )
        ),
);
}

  Row bottomButton(GetMyAddressData listMyAddres){
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              onPressed: () {
               
              },
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
               showAlertRemoveAddress(context,listMyAddres);
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
    onPressed:  () {
       Navigator.pop(context);
    },
  );
  Widget continueButton = TextButton(
    child: Text("Yes"),
    onPressed:  () {
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
       Service().getDeletMyAddressResponse(listMyAddres.id.toString()).then((value) => {
          Navigator.pop(_dialogKey.currentContext!),
          if (value.toString() == str_ErrorMsg)
            {
              setState((() {
               
              }))
            },
          if (value.toString() != str_ErrorMsg)
            {
            
               if(value.statusCode == 1){
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
                } else {
                  showSnakeBar(context, somethingWrong);
                  print("Categorylist" + "Opps Something Wrong!");
                }
              }))
            }
        });
  }
}
