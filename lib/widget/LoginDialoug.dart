import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/services.dart';
import 'package:nebulashoppy/uttils/sharedpref.dart';
import 'package:nebulashoppy/widget/common_widget.dart';
import 'package:nebulashoppy/widget/forgotpasswordDialoug.dart';

import '../model/getcartCountResponse/getAddToCartResponse.dart';
import '../network/service.dart';
import '../screen/webview.dart';
import '../uttils/constant.dart';
import 'package:page_transition/page_transition.dart';
import '../uttils/constant.dart';

class LoginDialoug extends StatefulWidget {
  const LoginDialoug(
    BuildContext context, {
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title, description;

  @override
  _LoginDialougState createState() => _LoginDialougState();
}

class _LoginDialougState extends State<LoginDialoug> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  static final _formKey = GlobalKey<FormState>();

  bool _passwordInVisible = true;
  final GlobalKey<State> _dialogKey = GlobalKey<State>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Visibility(
                    visible: false,
                    child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(CommunityMaterialIcons.close_box),
                        color: Colors.cyan)),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: 
                setBoldText("Associate / IBO Login", 16, Colors.black)
                // Text(
                //   "Associate / IBO Login",
                //   style: TextStyle(
                //       color: Colors.black,
                //       fontSize: 16,
                //       fontWeight: FontWeight.w500),
                // ),
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: TextFormField(
                    
                    controller: _usernameController,
                    obscureText: false,
                    enabled: true,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    // inputFormatters: [
                    //   LengthLimitingTextInputFormatter(10),
                    // ],
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      LengthLimitingTextInputFormatter(10),
                    ],
                    decoration: inputDecorationWithBorderAndIconEmail(
                        'Associate / IBO Login'),
                    validator: (email) {
                      if (email!.isEmpty) {
                        return 'Please enter Login Id';
                      } else {
                        return null;
                      }
                    },
                    onChanged: (text) {
                      setState(() {});
                    },
                  ),
                ),
              ),
              SizedBox(height: 5),
              Container(
                margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
                padding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    child: buildPasswordFormField('Password'),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                // style: elevatedButtonStyle(),
                style: buttonShapeStle(),
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  if (_formKey.currentState!.validate()) {
                    print("Valid" + "Valid");
                    getLoginResponse();
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                      padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                      child: GestureDetector(
                        child: 
                        setRegularText("Forgot Password", 14, Colors.red),
                        onTap: () {
                          print("Forgot" + "ForgotPassword");
                          Navigator.pop(context);
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
                        },
                      )),
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                    child: GestureDetector(
                      child: 
                      setRegularText("Register Here", 14, Colors.black)
                     ,
                      onTap: () {
                        print("Register" + "Register");
                        Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: Webview(
                                str_Title: "Register",
                                str_Url: register,
                              ),
                            ));
                      },
                    ),
                  )
                ],
              )
            ],
          )),
    );
  }

  TextFormField buildPasswordFormField(getHint) {
    return TextFormField(
      enabled: true,
      controller: _passwordController,
      validator: (username) {
        if (username!.isEmpty) {
          return 'Please enter Password';
        } else {
          return null;
        }
      },
      obscureText: _passwordInVisible,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: getHint,
        labelStyle: const TextStyle(color: BLACK),
        hintText: getHint,
        prefixIcon: const Padding(
          padding: EdgeInsets.only(top: 0), // add padding to adjust icon
          child: Icon(
            Icons.lock,
            color: BLACK,
          ),
        ),
        filled: true,
        fillColor: white,
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        disabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(width: 1, color: Colors.grey),
        ),
        border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(
              width: 1,
            )),
        errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: DARK_GRAY)),
        focusedErrorBorder: const OutlineInputBorder(
            borderRadius: const BorderRadius.all(const Radius.circular(10)),
            borderSide: BorderSide(width: 1, color: DARK_GRAY)),
        hintStyle: const TextStyle(fontSize: 16, color: BLACK),
        // suffix: GestureDetector(
        //     onTap: () {
        //       setState(() {
        //         _passwordInVisible = !_passwordInVisible;
        //       });
        //     },
        //     child: Text(
        //       _passwordInVisible == true ? 'Show' : 'Hide',
        //       style: TextStyle(
        //           color: Colors.black.withOpacity(0.5), fontSize: 14.0),
        //     )),
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _passwordInVisible = !_passwordInVisible;
            });
          },
          child: Icon(
            _passwordInVisible ? Icons.visibility : Icons.visibility_off,
            color: BLACK,
          ),
        ),
      ),
    );
  }

  void getLoginResponse() {
    showLoadingDialog(context, _dialogKey, "Please Wait..");
    Service().getGenerateTokenResponse(_usernameController.text, _passwordController.text, 'password').then((value) => {
              if (value.toString() == str_ErrorMsg)
                {
                  Navigator.pop(_dialogKey.currentContext!),
                  showSnakeBar(
                      context, "The user name or password is incorrect")
                }
              else
                {
                  Navigator.pop(_dialogKey.currentContext!),
                  getValidLoginResponse(value)
                }
            });
  }

  getValidLoginResponse(value) {
    Service().getLoginResponse(value.iboKeyId).then((loginresponse) => {
          if (loginresponse.statusCode == 1)
            {
              Navigator.pop(context),
              showSnakeBar(context, "Login Successfully!"),
              setLoginData(value),
              refreshApp(context)
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
}
