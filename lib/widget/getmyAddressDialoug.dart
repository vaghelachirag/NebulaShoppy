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
                 _listAddressCityList.clear();
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
                  getAddressbyCityId("4460");
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
                   getAddressbyCityId("3659");
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
        ),
           FutureBuilder(
                builder: (context, snapshot) {
                  if (_listAddressCityList.isEmpty) {
                    return Text("");
                  } else {
                    return 
                    Align(
                      alignment: Alignment.topLeft,
                      child:getCityAddress(),
                    );
                  }
                },
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
                  setState(() {
                    _listAddressCityList.clear();
                    _listAddressCityList = value.data;
                  })
                }
            });
  }
    Container getCityAddress(){
      return  Container(
      width: 200,
      child: Padding(
          padding: EdgeInsets.fromLTRB(5, 0, 5, 5),
          child: Column(
            children: [
             Card(margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                                      child: Flexible(//newly added
                                  child: Container(
                                  padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 15.0),
                                  child: Text(
                                 _listAddressCityList[0].address.toString(),
                                 style: TextStyle(),
                                  softWrap: true
                                  ),
                                  )
                                   ),
                                    ),
                                  ),
                                ],
                              ),
                            ))
            ],
          )),
    );
    }
   
}