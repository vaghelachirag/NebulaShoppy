import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:nebulashoppy/model/getMyAddressResponse/getAddressByCityResponse.dart';

import '../network/service.dart';
import '../uttils/constant.dart';

class GETMYADDRESSDIALOUG extends StatefulWidget {
  @override
  _GETMYADDRESSDIALOUGState createState() => _GETMYADDRESSDIALOUGState();
}
class _GETMYADDRESSDIALOUGState extends State<GETMYADDRESSDIALOUG> {
    bool bl_IsPickup = false;
     bool isSelectedPickup = false;
     bool isDoorStepDelivery = false;


    bool isAhmedabadClick = false;
    bool isHyderabadClick = false;
    bool isChennaiClick = false;

   final colorBackground = const Color(0xF0F0F0);
   final GlobalKey<State> _dialogKey = GlobalKey<State>();

  List<GetAddressByCityData> _listAddressCityList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child:  Column(
        children: [
          Padding(padding: EdgeInsets.all(10), child:
          Text("Choose Your Location",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)),
           Padding(padding: EdgeInsets.all(10), child:
          Text("Select a delivery location to see product availability and delivery options",style: TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.normal),)),
          Padding(padding: EdgeInsets.fromLTRB(10, 2, 10, 0),child:
          GestureDetector(
            onTap: () {
               setState(() {
                 isDoorStepDelivery = true;
                 isSelectedPickup = false;
                 isAhmedabadClick = false;
                 isHyderabadClick = false;
                 isChennaiClick = false;
               });
              print("Tap"+ "Dorr Click");
            },
            child:  Card(
                color: isDoorStepDelivery == true
                          ? colorBackground
                          : Colors.white,
                       elevation: 5,
              child: Row(
             children: [
            IconButton(onPressed: () {
              }, icon: Icon(CommunityMaterialIcons.dump_truck),  color: Colors.cyan),
              Text("Door step delivery (shipping charges applicable).",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w700),)],),))
         
          ),
           Padding(padding: EdgeInsets.all(5),child:  Text("OR",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),),
           Padding(padding: EdgeInsets.fromLTRB(10, 2, 10, 0),child:
           GestureDetector(
             onTap: () {
                print("Tap"+ "Pickup");
                setState(() {
                  bl_IsPickup = true;
                  isDoorStepDelivery = false;
                  isSelectedPickup = true;
                });
             },
             child:  Card(
              color: isSelectedPickup == true
                          ? colorBackground
                          : Colors.white,
             elevation: 5,
             child: Row(
             children: [
             IconButton(onPressed: () {

             }, icon: Icon(CommunityMaterialIcons.map_marker_circle),  color: Colors.cyan),
            Text("Select a pickup point.",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w700),),         
    ],
  ),
),)),
             Visibility(
              visible: bl_IsPickup && isSelectedPickup,
              child:  Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),child: cityList(),))
            ,
        ],
    ),
      )
     ,
    );
  }
  Column cityList(){
    return 
    Column(
      children: [
        InkWell(
          onTap: () {
              print("City"+"Ahmedabad");
                setState(() {
                 isAhmedabadClick = true;
                 isHyderabadClick = false;
                 isChennaiClick = false;
                 getAddressbyCityId("783");
             });
          },
          child: Card(
             color: isAhmedabadClick == true
                          ? colorBackground
                          : Colors.white,
          elevation: 5,
          child: Row(
          children: [
            IconButton(onPressed: () {
              }, icon: Icon(CommunityMaterialIcons.city),  color: Colors.cyan),
              Text("Ahmedabad",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w700),)],),),
        ),
        InkWell(
          onTap: () {
              print("City"+"Hyderabad");
                setState(() {
                  isAhmedabadClick = false;
                 isHyderabadClick = true;
                 isChennaiClick = false;
             });
          },
          child: Card(
             color: isHyderabadClick == true
                          ? colorBackground
                          : Colors.white,
          elevation: 5,
          child: Row(
          children: [
            IconButton(onPressed: () {
              }, icon: Icon(CommunityMaterialIcons.city),  color: Colors.cyan),
              Text("Hyderabad",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w700),)],),),
        ),
        InkWell(
          onTap: () {
              print("City"+"Chennai");
                setState(() {
                 isAhmedabadClick = false;
                 isHyderabadClick = false;
                 isChennaiClick = true;
             });
          },
          child: Card(
             color: isChennaiClick == true
                          ? colorBackground
                          : Colors.white,
          elevation: 5,
          child: Row(
          children: [
            IconButton(onPressed: () {
              }, icon: Icon(CommunityMaterialIcons.city),  color: Colors.cyan),
              Text("Chennai",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w700),)],),),
        )
      ],
    );
  }

  void getAddressbyCityId(String str_CityId) {
      showLoadingDialog(context, _dialogKey, "Please Wait..");
      Service().getAddressByCitySelection(str_CityId).then((value) => {
                 Navigator.pop(_dialogKey.currentContext!),
                 if (value.toString() == str_ErrorMsg)
                {
                  showSnakeBar(context, str_ErrorMsg),
                }
              else
                {
                _listAddressCityList.clear(),
                _listAddressCityList = value.data,
                print("Add"+_listAddressCityList.length.toString())
                }
            });
  }
}