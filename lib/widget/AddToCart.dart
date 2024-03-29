import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nebulashoppy/screen/home.dart';
import 'package:nebulashoppy/widget/star_rating.dart';
import '../model/product.dart';
import '../uttils/constant.dart';
import 'clip_shadow_path.dart';
import 'package:page_transition/page_transition.dart';
import 'package:nebulashoppy/screen/productdetail.dart';
import 'package:nebulashoppy/screen/categorylist.dart';

class AddToCart extends StatelessWidget {
  final int count;
  final VoidCallback onItemRemoved;
  final VoidCallback onItemAdd;
  final Function(int) onCountChanged;
  final bool is_Freee ;

  AddToCart({
    required this.count,
    required this.onItemRemoved,
    required this.onItemAdd,
    required this.onCountChanged,
    required this.is_Freee 
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              print("Cart" + "Removed");
             if(!is_Freee){
              onItemRemoved();
              }          
            },
            child: Container(
              child: Padding(
                padding: EdgeInsets.all(0),
                child: CircleAvatar(
                  backgroundColor: is_Freee == true
                                ? Colors.amber.shade100
                                : buttonColor,
                  maxRadius: 15,
                  child: Text(
                    "-",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 10,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Align(
              alignment: Alignment.center,
              child: Text(
                count.toString(),
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if(!is_Freee){
               onItemAdd();
              }          
            },
            child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  child: Padding(
                    padding: EdgeInsets.all(0),
                    child: CircleAvatar(
                      backgroundColor: is_Freee == true
                                ? Colors.amber.shade100
                                : buttonColor,
                      maxRadius: 15,
                      child: Text(
                        "+",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 10,
                            fontWeight: FontWeight.normal),
                      ),
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }
}
