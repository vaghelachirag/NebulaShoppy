import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/services.dart';
import 'package:nebulashoppy/uttils/sharedpref.dart';
import 'package:nebulashoppy/widget/common_widget.dart';

import '../model/getcartCountResponse/getAddToCartResponse.dart';
import '../network/service.dart';
import '../screen/webview.dart';
import '../uttils/constant.dart';
import 'package:page_transition/page_transition.dart';
import '../uttils/constant.dart';

class forgotpasswordDialoug extends StatefulWidget {
  const forgotpasswordDialoug(
    BuildContext context, {
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title, description;
  @override
  _forgotpasswordDialougState createState() => _forgotpasswordDialougState();
}

class _forgotpasswordDialougState extends State<forgotpasswordDialoug> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  static final _formKey = GlobalKey<FormState>();

  bool _showNextStep = false;
  final GlobalKey<State> _dialogKey = GlobalKey<State>();
  String email = "";
  String password = "";
  String sendOption = "";



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

  void getLoginResponse() {
    setState(() {
      showProgressbar();
    });
    //  showLoadingDialog(context, _dialogKey, "Please Wait..");
    Service()
        .getSendPasswordOptionResponse(_usernameController.text)
        .then((value) => {
              if (value.toString() == str_ErrorMsg)
                {
                  showSnakeBar(
                      context, "The user name or password is incorrect")
                }
              else
                {
                  //Navigator.pop(_dialogKey.currentContext!),
                  print("Value" + value.data.email),
                  setState(() {
                    email = value.data.email;
                    password = value.data.mobile;
                    _showNextStep = true;
                    hideProgressBar();
                  })
                }
            });
  }

  setLoginData(value) {
    String token = value.tokenType + " " + value.accessToken;
    String refreshToken = value.tokenType + value.refreshToken;
    String role = value.tokenType + value.role;
    String displayName = value.displayName;
    String ibo_key_id = value.iboKeyId;
    String ibo_ref_id = value.encryptUserName;

    SharedPref.saveString(str_Token, token);
    SharedPref.saveString(str_RefreshToken, refreshToken);
    SharedPref.saveString(str_Role, role);
    SharedPref.saveString(str_DisplayName, displayName);
    SharedPref.saveString(str_IBO_Id, ibo_key_id);
    SharedPref.saveString(str_Refrence_Id, ibo_ref_id);
    SharedPref.saveBoolean(str_IsLogin, true);
  }

  void showForgotPasswordDialoug() {
    showDialog(
      barrierColor: Colors.black26,
      context: context,
      builder: (context) {
        return forgotpasswordDialoug(
          context,
          title: "SoldOut",
          description:
              "This product may not be available at the selected address.",
        );
      },
    );
  }

  Container sendPasswordOption(String email) {
    return Container(
        margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Radio(
              value: email,
              onChanged: (value) {
                setState(() {
                  sendOption = email;
                });
              },
              activeColor: THEME_COLOR,
              groupValue: '',
            ),
            Text(
              email,
              style: TextStyle(color: Colors.black, fontSize: 14),
            ),
          ],
        ));
  }

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
      child:  Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  child: showMaterialProgressbar(6)),
                Container(
           decoration: myProfileboxDecoration(), 
           child:  Stack(
                children: <Widget>[
                  Center(child: 
                  Padding(padding: EdgeInsets.all(10),child:  setBoldText("Forgot Password?", 16, Colors.white),)
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
              SizedBox(height: 30),
             Container(
                margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: SizedBox(
                width: 500,
                height: 45,
                child: getLoginText("Associate / IBO Login", _usernameController,
                    "Please enter Login Id", 100, TextInputType.name,context),
              ),
              ),
              ),
              Visibility(
                  visible: _showNextStep, child: sendPasswordOption(email)),
              Visibility(
                  visible: _showNextStep, child: sendPasswordOption(password)),
                    SizedBox(height: 10),
              SizedBox(
                 width: 200,
                child:  ElevatedButton(
                // style: elevatedButtonStyle(),
                style: buttonShapeLogin(),
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState!.validate()) {
                    print("Valid" + "Valid");
                    getLoginResponse();
                  }
                },
                child: const Text(
                  'Get Password',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                  ),
                ),
              ),
              )
             ,
              SizedBox(height: 20),
            ],
          )),
    );
  }
}
BoxDecoration myProfileboxDecoration(){
 return new BoxDecoration(
              color: myProfileBg,
             shape: BoxShape.rectangle,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0),topRight: Radius.circular(10.0)),
            );
}