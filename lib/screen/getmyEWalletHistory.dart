import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:nebulashoppy/model/getmyorderresponse/getmyorderresponse.dart';
import 'package:nebulashoppy/model/homescreen/itemNewLaunched.dart';
import 'package:nebulashoppy/model/homescreen/itemhomecategory.dart';
import 'package:nebulashoppy/model/setmyAccount/setmyAccount.dart';
import 'package:nebulashoppy/network/service.dart';
import 'package:nebulashoppy/screen/categorylist.dart';
import 'package:nebulashoppy/screen/productdetail.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/uttils/constant.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/SearchWidget.dart';
import '../model/getEwallethistory/GetMyEwalletHistoryResponse.dart';
import '../model/getmyorderresponse/setmyorder.dart';
import '../model/homescreen/itembannerimage.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

import '../model/product.dart';
import '../uttils/sharedpref.dart';
import '../widget/Accountwidget.dart';
import '../widget/LoginDialoug.dart';
import '../widget/myorderwidget.dart';
import '../widget/searchitem.dart';
import '../widget/star_rating.dart';
import '../widget/trending_item.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:intl/intl.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GetMyEWalletHistory extends StatefulWidget {
  String str_Url = "";
  String str_Title = "";

  GetMyEWalletHistory(
      {Key? key, required this.str_Url, required this.str_Title})
      : super(key: key);

  @override
  State<GetMyEWalletHistory> createState() => _GetMyEWalletHistoryState();
}

class _GetMyEWalletHistoryState extends State<GetMyEWalletHistory>
    with WidgetsBindingObserver {
  bool isLoading = true;
  final _key = UniqueKey();
  String str_IboKey = "";

  List<GetEWalletHistoryData> _GetMyEWalletHistory = [];

  final GlobalKey<State> _dialogKey = GlobalKey<State>();
  
  @override
  void initState() {
    super.initState();
    getIboKey();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    ScreenUtil.init(context);
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(60),
            child: appBarWidget(context, 3, widget.str_Title, false)),
        body: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(label:
               Text('Amount')),
              DataColumn(label: Text('Transaction')),
              DataColumn(label: Text('Date')),
              DataColumn(label: Text('Remarks'))
            ],
            rows:
                _GetMyEWalletHistory // Loops through dataColumnText, each iteration assigning the value to element
                    .map(
              ((element) => DataRow(
                    cells: <DataCell>[
                      DataCell( Text( rupees_Sybol+ " "+ element.amount
                          .toString(),style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.bold),)), //Extracting from Map element the value
                      DataCell(Text(element.transactiontype.toString(),style: TextStyle(  color: element.transactiontype.toString() == "CR"
                              ? Colors.green
                              : Colors.red),)),
                      DataCell(Text(element.createdOn.toString())),
                      DataCell(Text(element.remark.toString()))
                    ],
                  )),
            ).toList(),
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

  Container getTable() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(20.0),
      child: Table(
        border: TableBorder.all(width: 1.0, color: Colors.black),
        children: _GetMyEWalletHistory.map((video) {
          return TableRow(children: [
            TableCell(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  new Text('VideoId'),
                  new Text(video.amount.toString()),
                ],
              ),
            )
          ]);
        }).toList(),
      ),
    );
  }

  void getMyEWalletHistory() {
    showLoadingDialog(context, _dialogKey, "Please Wait..");
    Service().getMyWalletHistoryResponse(str_IboKey).then((value) => {
          setState((() {
             if (_dialogKey.currentContext != null) {
                      Navigator.pop(_dialogKey.currentContext!);
                }
            if (value.statusCode == 1) {
              _GetMyEWalletHistory = value.data;
            } else {
              showSnakeBar(context, "Opps! Something Wrong");
            }
          }))
        });
  }

  Container setTableTitle(String str_Title) {
    return Container(
      color: Colors.cyan[400],
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Text(str_Title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
        ),
      ),
    );
  }

  void getIboKey() async {
    str_IboKey = await SharedPref.readString(str_IBO_Id);
    print("IboKeyId" + str_IboKey.toString());
    getMyEWalletHistory();
  }
}
