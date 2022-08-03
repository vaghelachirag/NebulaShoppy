import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/widget/common_widget.dart';

import '../screen/tabscreen.dart';

class PaymentSucessWidget extends StatefulWidget {

   final VoidCallback onClickClicked;
   String title = "";
   String description = "";
   String str_Amount;

    PaymentSucessWidget({
    required this.title,
    required this.description,
    required this.onClickClicked,
    required this.str_Amount
  });

  
  
  @override
  _PaymentSucessWidgetState createState() => _PaymentSucessWidgetState();
}

class _PaymentSucessWidgetState extends State<PaymentSucessWidget> {
  
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
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 8),
          Padding(padding: EdgeInsets.fromLTRB(0, 8, 0, 0),child:   SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            height:  MediaQuery.of(context).size.height / 10,
            child: AnimatedContainer(
          child: Image.asset(assestPath+ 'success.png',fit: BoxFit.contain,color:Colors.lightGreen,) ,
        duration: Duration(milliseconds: 5000),
       curve: Curves.bounceInOut,),
          ),)
        
          ,
           Container(
            margin: EdgeInsets.fromLTRB(0, 5, 0, 0),
            padding:  EdgeInsets.fromLTRB(0, 5, 0, 0),
            width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                 "Success",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontFamily: EmberBold
                  ),
                ),
            ),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
            padding:  EdgeInsets.fromLTRB(0, 10, 0, 0),
            width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                 "Paid  " + rupees_Sybol + "${widget.str_Amount}",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black38,
                    fontWeight: FontWeight.normal,
                  ),
                ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: InkWell(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15.0),
                bottomRight: Radius.circular(15.0),
              ),
              highlightColor: Colors.grey[200],
              onTap: () {
                Navigator.of(context).pop();
                
              },
              
              child: Center(
                child:   ElevatedButton(
                  style: buttonOK(),
                onPressed: () {
                Navigator.pop(context);
                 Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (dialogContex) => TabScreen(int_Selectedtab: 1,)),
              ModalRoute.withName("/tabscreen"));
                },
             child: Text('Ok'),
               ),
              ),
            ),
          ),
        ],
      ),
    ),
    );
   
  }
}
