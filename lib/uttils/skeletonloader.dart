import 'package:flutter/material.dart';

import '../uttils/constant.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

//  Search Skeleton
Widget boxseach() {
  return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.only(left: 10),
            width: ScreenUtil().setSp(80),
            height: ScreenUtil().setSp(80),
            decoration:
                BoxDecoration(shape: BoxShape.rectangle, color: Colors.grey),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 150,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ));
}

// Home Cateory
Widget boxHomeCatory() {
  return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
          )
        ],
      ));
}

// Home Cateory
Widget boxOrderList() {
  return Padding(
      padding: EdgeInsets.all(5),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration:
                BoxDecoration(shape: BoxShape.rectangle, color: Colors.grey),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 150,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 150,
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey),
                )
              ],
            ),
          )
        ],
      ));
}

// Home Cateory
Widget boxVerticalCategory() {
  return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Container(
            width: ScreenUtil().setSp(60),
            height: ScreenUtil().setSp(60),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
          ),
          SizedBox(height: 5),
          Container(
            width: 50,
            height: 0,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50), color: Colors.grey),
          ),
        ],
      ));
}

// My CartList
Widget boxMyCartList() {
  return Padding(
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration:
                BoxDecoration(shape: BoxShape.rectangle, color: Colors.grey),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ));
}

// Tranding Item
Widget boxTrandingItem() {
  return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration:
                BoxDecoration(shape: BoxShape.rectangle, color: Colors.grey),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: double.infinity,
                  height: 10,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.grey),
                ),
              ],
            ),
          )
        ],
      ));
}

Widget boxNewLaunch() {
  return Container(
    margin: EdgeInsets.only(bottom: 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
    child: Column(
      children: [
        Container(
          width: 100,
          height: 150,
          decoration:
              BoxDecoration(shape: BoxShape.rectangle, color: Colors.grey),
        ),
        Container(
          margin: EdgeInsets.all(5),
          width: 100,
          height: 0,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50), color: Colors.grey),
        ),
        // Container(
        //   margin: EdgeInsets.all(3),
        //   width: 80,
        //   height: 8,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(50), color: Colors.grey),
        // ),
        // Container(
        //   margin: EdgeInsets.all(3),
        //   width: 60,
        //   height: 5,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(50), color: Colors.grey),
        // )
      ],
    ),
  );
}

Widget boxProductCatWise(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(bottom: 0),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
    child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width ,
          height: MediaQuery.of(context).size.height,
          decoration:
              BoxDecoration(shape: BoxShape.rectangle, color: Colors.white),
        ),
      ],
    ),
  );
}
