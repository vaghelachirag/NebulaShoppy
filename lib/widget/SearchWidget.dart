import 'package:flutter/material.dart';
import 'package:nebulashoppy/screen/test.dart';
import 'package:page_transition/page_transition.dart';
import 'package:nebulashoppy/screen/search.dart';

class SearchWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Theme(
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: Test(),
                ),
              );
            },
            child: Container(
                height: 40,
                child: TextField(
                  autofocus: false,
                  enabled: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(
                        width: 0,
                        style: BorderStyle.none,
                      ),
                    ),
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                    fillColor: Color(0xFFF2F4F5),
                    hintStyle: new TextStyle(color: Colors.grey[600]),
                    hintText: "Search",
                  ),
                )),
          ),
          data: Theme.of(context).copyWith(
            primaryColor: Colors.grey[600],
          )),
    );
  }
}
