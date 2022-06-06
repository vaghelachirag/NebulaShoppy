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
      body: Stack(
        children: <Widget>[
          Container(
              color: Colors.white,
              width: MediaQuery.of(context).size.height,
              padding: EdgeInsets.all(20.0),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [_createDataTable()],
              ))
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  DataTable _createDataTable() {
    return DataTable(columns: _createColumns(), rows: _createRows());
  }

  List<DataColumn> _createColumns() {
    return [
      DataColumn(label: Text('Amount')),
      DataColumn(label: Text('Transaction')),
      DataColumn(label: Text('Date')),
      DataColumn(label: Text('Remarks')),
    ];
  }

  List<DataRow> _createRows() {
    return [
      DataRow(cells: [
        DataCell(Text('Amount')),
        DataCell(Text('Transaction')),
        DataCell(Text('David John')),
        DataCell(Text('David John'))
      ]),
      DataRow(cells: [
        DataCell(Text('#101')),
        DataCell(Text('Dart Internals')),
        DataCell(Text('Alex Wick')),
        DataCell(Text('David John'))
      ])
    ];
  }

  void getMyEWalletHistory() {
    Service().getMyWalletHistoryResponse(str_IboKey).then((value) => {
          setState((() {
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

  List<DataRow> _createRows() {
    return _GetMyEWalletHistory.map((book) => DataRow(cells: [
          DataCell(Text('#' + book.balance.toString())),
          _createTitleCell(book.balance.toString()),
          DataCell(Text(book.createdOn.toString()))
        ])).toList();
  }

  DataCell _createTitleCell(bookTitle) {
    return DataCell(Text(bookTitle));
  }

  List<DataRow> _createRows() {
    return _GetMyEWalletHistory.map((book) => DataRow(cells: [
          DataCell(Text('#' + book.amount.toString()),
          _createTitleCell(book.createdOn.toString()),
          DataCell(Text(book.remark.toString()))
        ])).toList();
  }

  
}
