import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/services.dart';
import 'package:nebulashoppy/uttils/sharedpref.dart';
import 'package:nebulashoppy/widget/common_widget.dart';

import '../model/getcartCountResponse/getAddToCartResponse.dart';
import '../network/service.dart';
import '../uttils/constant.dart';

class UserProfileWidget extends StatefulWidget {
  const UserProfileWidget(BuildContext context, {
    Key? key,
    required this.name,
    required this.mobile,
    required this.email,
    required this.gender,
  }) : super(key: key);



  final String name, mobile,email,gender;
  

  @override
  _UserProfileWidgetState createState() => _UserProfileWidgetState();
}

class _UserProfileWidgetState extends State<UserProfileWidget> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  static final _formKey = GlobalKey<FormState>();

  bool _passwordInVisible = true;
  final GlobalKey<State> _dialogKey = GlobalKey<State>();

  double padding = 0.0 ;

  @override
  Widget build(BuildContext context) {
    padding = MediaQuery.of(context).size.width / 10 ;
    return Dialog(
      elevation: 0,
      backgroundColor: Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Form(
        key: _formKey,
        child: 
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            Align(
              alignment: Alignment.topRight,
              child:  IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(CommunityMaterialIcons.close_box),  color: loginButtonColor),
            ),
           Text("My Profile",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
          SizedBox(height: 15),
          Container(
            margin: EdgeInsets.fromLTRB(2, 5, 10, 0),
            padding:  EdgeInsets.fromLTRB(2, 5, 10, 0),
            width: MediaQuery.of(context).size.width,
              child: Center(
                child: 
                setUserProfileName(),
            ),
          ),
          SizedBox(height: 1),
         setUserProfileMobile(),
           SizedBox(height: 1),
         setUserProfileEmail(),
         setUserProfileGender(),
        ],
      )
      ),
    );
  }
  
Row setUserProfileName(){
  return   Row(children: [
                    IconButton(onPressed: () {          
                    }, icon: Icon(CommunityMaterialIcons.account_circle_outline)),
                    Text("Name",style: TextStyle(color: Colors.black38,fontSize: 12),),
                    Padding(padding: EdgeInsets.only(left: padding),
                    child: Text(widget.name,style: TextStyle(color: Colors.black,fontSize: 14 ),),)
                  ],
                );
}

  
Row setUserProfileMobile(){
  return   Row(children: [
                    IconButton(onPressed: () {          
                    }, icon: Icon(CommunityMaterialIcons.cellphone)),
                    Text("Mobile",style: TextStyle(color: Colors.black38,fontSize: 12),),
                    Padding(padding: EdgeInsets.only(left: padding),
                    child: Text(widget.mobile,style: TextStyle(color: Colors.black,fontSize: 14 ),),)
                  ],
                );
}

Row setUserProfileEmail(){
  return   Row(children: [
                    IconButton(onPressed: () {          
                    }, icon: Icon(CommunityMaterialIcons.email)),
                    Text("Email",style: TextStyle(color: Color(0x60000000),fontSize: 12),),
                    Padding(padding: EdgeInsets.only(left: padding),
                    child: Text(widget.email,style: TextStyle(color: Colors.black,fontSize: 14 ),),)
                  ],
                );
}

Row setUserProfileGender(){
  return   Row(children: [
                    IconButton(onPressed: () {          
                    }, icon: Icon(CommunityMaterialIcons.gender_female)),
                    Text("Gender",style: TextStyle(color: Colors.black38,fontSize: 12),),
                    Padding(padding: EdgeInsets.only(left: padding),
                    child: Text(widget.gender,style: TextStyle(color: Colors.black,fontSize: 14 ),),)
                  ],
                );
}
}

