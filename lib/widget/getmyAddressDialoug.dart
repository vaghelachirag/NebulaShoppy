import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:nebulashoppy/model/getMyAddressResponse/getAddressByCityResponse.dart';

import '../model/getMyAddressResponse/getMyAddressResponse.dart';
import '../network/service.dart';
import '../uttils/constant.dart';

class GETMYADDRESSDIALOUG extends StatefulWidget {

  
  final VoidCallback onAddressSelection;

  GETMYADDRESSDIALOUG(
  {required this.onAddressSelection});


  @override
  _GETMYADDRESSDIALOUGState createState() => _GETMYADDRESSDIALOUGState();
}
class _GETMYADDRESSDIALOUGState extends State<GETMYADDRESSDIALOUG> {
  
     bool bl_IsPickup = false;
     bool isSelectedPickup = false;
     bool isShowCity = false;
     bool isDoorStepDelivery = false;


    bool isAhmedabadClick = false;
    bool isHyderabadClick = false;
    bool isChennaiClick = false;

     bool isAhmedabadShow = true;
    bool isHyderabadShow = true;
    bool isChennaiShow = true;

   final colorBackground = const Color(0xF0F0F0);
   final GlobalKey<State> _dialogKey = GlobalKey<State>();

  List<GetAddressByCityData> _listAddressCityList = [];
  final List<GetMyAddressData> _listMyAddress = [];

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
                 isShowCity = false;
                 _listAddressCityList.clear();
                 setCityVisibity(3);
               });
              print("Tap"+ "Dorr Click");       
            },
            child:  Card(color: isDoorStepDelivery == true? colorBackground: Colors.white,elevation: 5,
              child: Row(
             children: [
            IconButton(onPressed: () { }, icon: Icon(CommunityMaterialIcons.dump_truck),  color: Colors.cyan),
              Text("Door step delivery (shipping charges applicable).",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w700),)],),))  ),
           Padding(padding: EdgeInsets.all(5),child:  Text("OR",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),),
           Padding(padding: EdgeInsets.fromLTRB(10, 2, 10, 0),child:
           GestureDetector(
             onTap: () {
                print("Tap"+ "Pickup");
                setState(() {
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
             child:  Card(
              color: isSelectedPickup == true
                          ? colorBackground
                          : Colors.white,
             elevation: 5,
             child: Row(
             children: [
             IconButton(onPressed: () { }, icon: Icon(CommunityMaterialIcons.map_marker_circle),  color: Colors.cyan),
            Text("Select a pickup point.",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w700),),],),
),)),
             Visibility(
              visible: bl_IsPickup && isShowCity,
              child:  Padding(padding: EdgeInsets.fromLTRB(10, 0, 10, 0),child: cityList(),))
            ,
        ],
    ),
    ),
    );
  }
  Column cityList(){
    return 
    Column(
      children: [
        Visibility(
          visible: isAhmedabadShow == true,
         child: 
        InkWell(
          onTap: () {
              print("City"+"Ahmedabad");
                setState(() {
                 isAhmedabadClick = true;
                 isHyderabadClick = false;
                 isChennaiClick = false;
                 isSelectedPickup = false;
                 getAddressbyCityId("783",0);
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
        )),
        Visibility(
           visible: isHyderabadShow == true,
          child: 
        InkWell(
          onTap: () {
              print("City"+"Hyderabad");
                setState(() {
                  isAhmedabadClick = false;
                 isHyderabadClick = true;
                 isChennaiClick = false;
                  isSelectedPickup = false;
                  getAddressbyCityId("4460",1);
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
        )),
        Visibility(
          visible: isChennaiShow == true,
          child: 
        InkWell(
          onTap: () {
              print("City"+"Chennai");
                setState(() {
                 isAhmedabadClick = false;
                 isHyderabadClick = false;
                 isChennaiClick = true;
                  isSelectedPickup = false;
                   getAddressbyCityId("3659",2);
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
        )),
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

  void getAddressbyCityId(String str_CityId, int int_Position) {
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
                    setCityVisibity(int_Position);
                    _listAddressCityList.clear();
                    _listAddressCityList = value.data;
                  })
                }
            });
  }
    GestureDetector getCityAddress(){
      return GestureDetector(
         onTap: () {
          setState(() {
              str_SelectedAddress =  _listAddressCityList[0].address.toString();
              widget.onAddressSelection();
                Navigator.pop(context);
          });
           print("SelectedAddresss"+"SelectedAddress");
         },
        child:  Container(
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
                                 style: TextStyle(
                                  fontFamily: EmberBold
                                 ),
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
    ),
    );
    }

  void setCityVisibity(int int_position) {
    if(int_position == 0){
                      isAhmedabadShow = true;
                      isHyderabadShow = false;
                      isChennaiShow = false;
    }
     if(int_position == 1){
                      isAhmedabadShow = false;
                      isHyderabadShow = true;
                      isChennaiShow = false;
    }
     if(int_position == 2){
                      isAhmedabadShow = false;
                      isHyderabadShow = false;
                      isChennaiShow = true;
    }
     if(int_position == 3){
                      isAhmedabadShow = true;
                      isHyderabadShow = true;
                      isChennaiShow = true;
    }
  }
   
}