
import 'package:flutter/material.dart';

import '../uttils/constant.dart';


InputDecoration inputDecorationWithBorderAndIconEmail(getHint) {
  return InputDecoration(
    labelText: getHint,
    labelStyle: const TextStyle(color: BLACK),
    hintText: getHint,
    filled: true,
    alignLabelWithHint: true,
    prefixIcon: const Padding(
      padding: EdgeInsets.only(top: 0), // add padding to adjust icon
      child: Icon(
        Icons.person,
        color: BLACK,
      ),
    ),
    fillColor: white,
    focusedBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 0.5, color: Colors.grey),
    ),
    disabledBorder: const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      borderSide: BorderSide(width: 0.5, color: Colors.grey),
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
        borderRadius: BorderRadius.all(Radius.circular(10)),
        borderSide: BorderSide(width: 1, color: DARK_GRAY)),
    hintStyle: const TextStyle(fontSize: 16, color: BLACK),
  );
}

ButtonStyle buttonShapeStle() {
  return ButtonStyle(
    padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.fromLTRB(50, 10, 50, 10)),
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft:Radius.circular(10) ,
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10)
        ),
      ),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
  );
}

InputDecoration addressText(String hint){
  return InputDecoration(
                hintText: hint,
                 
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)));
}


InputDecoration inputwithdropdown(getHint) {
  return  InputDecoration(
                hintText: getHint,
                   prefixIcon: const Padding(
      padding: EdgeInsets.only(top: 0), // add padding to adjust icon
      child: Icon(
        Icons.arrow_drop_down,
        color: BLACK,
        
      ),
    ),
                contentPadding: const EdgeInsets.all(15),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10)));
}


Text setHeaderText(String title,double size){
  return Text(title,style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: size));
}
Text setPickupLocation(String title,double size){
  return Text(title,style: TextStyle(color: Colors.black45, fontWeight: FontWeight.bold,fontSize: 14));
}

 Container divider(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      height: 0.5,
    );
  }
  

ButtonStyle buttonShapeOrderDetail() {
  return ButtonStyle(
    shape: MaterialStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft:Radius.circular(10) ,
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
          topRight: Radius.circular(10)
        ),
      ),
    ),
    backgroundColor: MaterialStateProperty.all<Color>(Colors.cyan),
  );
}


