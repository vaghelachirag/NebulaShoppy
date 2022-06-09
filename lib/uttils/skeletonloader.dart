
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
              width: 50,
              height: 50,
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
        child: 
        Column(
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
        child: Row(
          children: [
            Container(
              width: ScreenUtil().setSp(50),
              height: ScreenUtil().setSp(50),
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
            )         
          ],
        ));
  }