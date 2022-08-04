import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/widget/common_widget.dart';
import 'package:nebulashoppy/widget/mainButton.dart';
import '../screen/tabscreen.dart';

class UpdateAppVersion extends StatefulWidget {

  
  @override
  _UpdateAppVersionState createState() => _UpdateAppVersionState ();
}

class _UpdateAppVersionState  extends State<UpdateAppVersion> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.5),
      child:  Dialog(
      elevation: 0,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            child:   SizedBox(width: MediaQuery.of(context).size.width /6,
          height:  MediaQuery.of(context).size.height /10,
          child: Image.asset(assestPath+ 'nebula_logo.png', fit: BoxFit.fitWidth),),
          ),
         Container(
       width: MediaQuery.of(context).size.width,
        color: buttonColor,
      height: 1,
       ),
       Padding(padding: EdgeInsets.fromLTRB(20, 15, 20, 0),child: 
       Text("A new version of this app is now available. Would you like to download it?",style: TextStyle(color: Colors.black,fontSize: 14,fontFamily: Ember),)),
        Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 5),child: 
        Align(
            alignment: Alignment.center,
            child: MainButtonWidget(
                onPress: () {
                  print("Update"+ "Update Now");
                },
                buttonText: "Update Now"),
          ))
        ],
      ),
    ),
    );
   
  }

}
