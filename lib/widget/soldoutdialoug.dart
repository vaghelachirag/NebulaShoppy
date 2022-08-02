import 'package:flutter/material.dart';

import 'common_widget.dart';

class SoldOutDialoug extends StatefulWidget {
  const SoldOutDialoug({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  final String title, description;

  @override
  _SoldOutDialougState createState() => _SoldOutDialougState();
}

class _SoldOutDialougState extends State<SoldOutDialoug> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 0,
      backgroundColor: Color(0xffffffff),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 15),
          // Text(
          //   "${widget.title}",
          //   style: TextStyle(
          //     fontSize: 20.0,
          //     fontWeight: FontWeight.bold,
          //     color: Colors.red
          //   ),
          // ),
           SizedBox(height: 5),
           SizedBox(
            width: MediaQuery.of(context).size.width / 5,
            height:  MediaQuery.of(context).size.width / 5,
            child:  Image.asset('assets/images/soldout.png',fit: BoxFit.contain,),
           )
          ,
          SizedBox(height: 5),
          Container(
            margin: EdgeInsets.fromLTRB(20, 5, 20, 0),
            padding:  EdgeInsets.fromLTRB(20, 5, 20, 0),
            width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "${widget.description}",
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.black,
                    fontWeight: FontWeight.normal,
                  ),
                ),
            ),
          ),
           Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
            padding:  EdgeInsets.fromLTRB(20, 5, 20, 0),
            width: MediaQuery.of(context).size.width,
              child: Center(
                child: Text(
                  "Kindly change your address, to avail this product.",
                  style: TextStyle(
                    fontSize: 14.0,
                    fontWeight: FontWeight.normal,
                  ),
                ),
            ),
          ),
          SizedBox(height: 20),
          Padding(padding: EdgeInsets.fromLTRB(0, 0, 0, 10),child:
          Container(
            width: MediaQuery.of(context).size.width,
            height: 50,
            child: InkWell(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
              ),
              highlightColor: Colors.grey[200],
              onTap: () {
                Navigator.of(context).pop();
              },
              
              child: 
              Center(
                child:  ElevatedButton(
                  style: buttonOK(),
                onPressed: () {
                Navigator.of(context).pop();
                },
             child: Text('OK'),
               ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
