import 'package:flutter/material.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:nebulashoppy/widget/common_widget.dart';

class PaymentCancelledWidget extends StatefulWidget {

   final VoidCallback onClickClicked;
   String title = "";
   String description = "";

    PaymentCancelledWidget({
    required this.title,
    required this.description,
    required this.onClickClicked,
  });



  @override
  _PaymentCancelledWidgetState createState() => _PaymentCancelledWidgetState();
}

class _PaymentCancelledWidgetState extends State<PaymentCancelledWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.black.withOpacity(0.5),
      child:  Dialog(
      elevation: 0,
      backgroundColor: Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 15),
          IconButton(
                icon: Icon(CommunityMaterialIcons.close_circle_outline),
                color: Colors.red,
                iconSize: 45,
                onPressed: () {
                },
              ),
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
            margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
            padding:  EdgeInsets.fromLTRB(10, 5, 10, 0),
            width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                   "${widget.description}",
                  style: TextStyle(
                    fontSize: 12.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
            ),
          ),
          SizedBox(height: 20),
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
