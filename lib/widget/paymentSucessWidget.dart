import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:nebulashoppy/widget/common_widget.dart';

class PaymentSucessWidget extends StatefulWidget {

   final VoidCallback onClickClicked;
   String title = "";
   String description = "";

    PaymentSucessWidget({
    required this.title,
    required this.description,
    required this.onClickClicked,
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
      backgroundColor: Colors.grey[100],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 15),
           Image.asset('assets/images/payment_successful.gif',fit: BoxFit.contain,),
          Container(
            margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
            padding:  EdgeInsets.fromLTRB(10, 0, 0, 0),
            width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "${widget.title}",
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
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
                   widget.onClickClicked();
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
