import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';

class GETMYADDRESSDIALOUG extends StatefulWidget {
  @override
  _GETMYADDRESSDIALOUGState createState() => _GETMYADDRESSDIALOUGState();
}
class _GETMYADDRESSDIALOUGState extends State<GETMYADDRESSDIALOUG> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Column(
        children: [
          Padding(padding: EdgeInsets.all(10), child:
          Text("Choose Your Location",style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold),)),
           Padding(padding: EdgeInsets.all(10), child:
          Text("Select a delivery location to see product availability and delivery options",style: TextStyle(fontSize: 14,color: Colors.grey,fontWeight: FontWeight.normal),)),
          Padding(padding: EdgeInsets.fromLTRB(10, 2, 10, 0),child:
          GestureDetector(
            onTap: () {
              print("Tap"+ "Dorr Click");
            },
            child:  Card(
  elevation: 5,
  child: Row(
    children: [
        IconButton(onPressed: () {
              }, icon: Icon(CommunityMaterialIcons.dump_truck),  color: Colors.cyan),
              Text("Door step delivery (shipping charges applicable).",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w700),)
    ],
  ),
) ,
          )
         
          ),
           Padding(padding: EdgeInsets.all(5),child:  Text("OR",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14),),),
           Padding(padding: EdgeInsets.fromLTRB(10, 2, 10, 0),child:
           GestureDetector(
             onTap: () {
               
             },
             child:  Card(
  elevation: 5,
  child: Row(
    children: [
        IconButton(onPressed: () {
              }, icon: Icon(CommunityMaterialIcons.map_marker_circle),  color: Colors.cyan),
              Text("Select a pickup point.",style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w700),)
    ],
  ),
),
           )
         
          )
        ],
    ),
    );
  }
}