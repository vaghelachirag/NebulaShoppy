import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:flutter/services.dart';
import 'package:nebulashoppy/widget/common_widget.dart';

import '../uttils/constant.dart';

class LoginDialoug extends StatefulWidget {
  const LoginDialoug(BuildContext context, {
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
        child: 
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
            Align(
              alignment: Alignment.topRight,
              child:  IconButton(onPressed: () {
                Navigator.pop(context);
              }, icon: Icon(CommunityMaterialIcons.close_box),  color: Colors.cyan),
            ),
           Text("Associate / IBO Login",style: TextStyle(color: Colors.black,fontSize: 16,fontWeight: FontWeight.w500),),
          SizedBox(height: 15),
          Container(
            margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
            padding:  EdgeInsets.fromLTRB(10, 5, 10, 0),
            width: MediaQuery.of(context).size.width,
              child: Center(
                child:  TextFormField(
                                  controller: _usernameController,
                                  obscureText: false,
                                  enabled: true,
                                  textInputAction: TextInputAction.next,
                                  keyboardType: TextInputType.number,
                                  // inputFormatters: [
                                  //   LengthLimitingTextInputFormatter(10),
                                  // ],
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(
                                        RegExp('[0-9]')),
                                    LengthLimitingTextInputFormatter(10),
                                  ],
                                  decoration:
                                      inputDecorationWithBorderAndIconEmail(
                                          'Associate / IBO Login'),
                                  validator: (email) {
                                    if (email!.isEmpty) {
                                      return 'Please enter Login Id';
                                    }  else {
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
            padding:  EdgeInsets.fromLTRB(10, 5, 10, 0),
            width: MediaQuery.of(context).size.width,
              child: Center(
                child:    Container(
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
                           print("Valid"+ "Valid");
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
                       Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                       child: Text("Forgot Password",style: TextStyle(color: Colors.red[300],fontSize: 14,fontWeight: FontWeight.bold),),),
                         Padding(padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
                       child: Text("Register Here",style: TextStyle(color: Colors.black54,fontSize: 14,fontWeight: FontWeight.bold),),)
                       
                     ],
                   )
          
        ],
      )
      ),
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
}

