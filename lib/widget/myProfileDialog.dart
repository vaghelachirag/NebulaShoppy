import 'package:flutter/material.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:community_material_icon/community_material_icon.dart';

class MyProfileDialoug extends StatelessWidget {
   final String name, mobile,email,gender;

   const MyProfileDialoug(BuildContext context, {
    Key? key,
    required this.name,
    required this.mobile,
    required this.email,
    required this.gender,
  }) : super(key: key);


   dialogContent(BuildContext context) {
    double  padding = MediaQuery.of(context).size.width / 10 ;
    return Container(
      width: MediaQuery.of(context).size.width / 2,
      decoration: new BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 20.0,
            offset: const Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // To make the card compact
        children: <Widget>[
           Container(
           decoration: myProfileboxDecoration(), 
           child:  Stack(
                children: <Widget>[
                  Center(child: 
                  Padding(padding: EdgeInsets.all(10),child:  setBoldText("My Profile", 16, Colors.white),)
                 ,),
                 Padding(padding: EdgeInsets.all(10),child: Container(
                    alignment: Alignment.centerRight,
                    child:  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: () {
                          Navigator.pop(context);
                      },
                      child:  Icon(Icons.close, color: Colors.white,size: 20,),
                    )
                   ,)
                  ,
                 ),
                  )
                ],
              ), 
           ),
            SizedBox(height: 5),
              Container(
            margin: EdgeInsets.fromLTRB(2, 5, 10, 0),
            padding:  EdgeInsets.fromLTRB(2, 5, 10, 0),
            width: MediaQuery.of(context).size.width,
              child: Center(
                child: 
                setUserProfileName(context),
            ),
          ),
          SizedBox(height: 1),
         setUserProfileMobile(context),
           SizedBox(height: 1),
         setUserProfileEmail(context),
         setUserProfileGender(context),
         
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: dialogContent(context),
    );
  }
Container setUserProfileName(BuildContext context){
  return  
   Container(
    height: 35,
    child:   Row(children: [
                    SizedBox(
                      width: 77,
                      child: Row(
                        children: [
                       IconButton(onPressed: () {          
                    }, icon: Icon(CommunityMaterialIcons.account_circle_outline,size: 25)),
                    setRegularText("Name", 12, myProfileTitleBg)
                        ],
                      ),
                    )
                   ,
                    Padding(padding: EdgeInsets.only(left:  MediaQuery.of(context).size.width / 10),
                    child:   setRegularText(name, 12, myProfileDataBg),),
                  ],
                ));
}

  
Container  setUserProfileMobile(BuildContext context){
  return  Container(
    height: 35,
    child: Row(children: [
                      SizedBox(
                      width: 80,
                      child: Row(
                        children: [
                       IconButton(onPressed: () {          
                    }, icon: Icon(CommunityMaterialIcons.cellphone,size: 25)),
                     setRegularText("Mobile", 12, myProfileTitleBg)
                        ],
                      ),
                    ),
                   
                    Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 10),
                    child: setRegularText(mobile, 12, myProfileDataBg),),
                  ],
                ),
  );
  
}

Container setUserProfileEmail(BuildContext context){
  return   Container(
    height: 35,  child:
   Row(children: [
                SizedBox(
                      width: 80,
                      child: Row(
                        children: [
                         IconButton(onPressed: () {          
                    }, icon: Icon(CommunityMaterialIcons.email_outline,size: 25,)),
                    setRegularText("Email  ", 12, myProfileTitleBg)
                        ],
                      ),
                    )
                  ,
                    Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 10),
                    child: setRegularText(email, 12, myProfileDataBg),),
                  ],
                ));
}

Container setUserProfileGender(BuildContext context){
  return   Container(
    margin: EdgeInsets.only(bottom: 5),
    height: 35,  child: Row(children: [
                 SizedBox(
                      width: 80,
                      child: Row(
                        children: [
                       IconButton(onPressed: () {          
                    }, icon: Icon(CommunityMaterialIcons.gender_female,size: 25,)),
                   setRegularText("Gender", 12, myProfileTitleBg)
                        ],
                      ),
                    )
                   ,
                    Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width / 10),
                    child: setRegularText(gender, 12, myProfileDataBg),),
                  ],
                ));
}
BoxDecoration myProfileboxDecoration(){
 return new BoxDecoration(
              color: myProfileBg,
             shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
            );
}
}