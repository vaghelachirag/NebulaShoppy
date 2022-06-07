import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_launcher_icons/android.dart';
import 'package:nebulashoppy/model/getmyorderresponse/setmyoderdetailitem.dart';
import 'package:nebulashoppy/model/getstateResponse.dart';
import 'package:nebulashoppy/screen/search.dart';
import 'package:nebulashoppy/uttils/CircularProgress.dart';
import 'package:nebulashoppy/widget/AppBarWidget.dart';
import 'package:nebulashoppy/widget/categoryproductWidget.dart';
import 'package:nebulashoppy/widget/common_widget.dart';
import 'package:page_transition/page_transition.dart';

import '../../model/getMyAddressResponse/getMyAddressResponse.dart';
import '../../model/getmyorderresponse/getmyorderresponse.dart';
import '../../model/homescreen/itemNewLaunched.dart';
import '../../model/homescreen/itemhomecategory.dart';
import '../../model/product.dart';
import '../../network/service.dart';
import '../../uttils/constant.dart';
import '../../widget/myOrderDetailWidget.dart';
import '../../widget/trending_item.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:community_material_icon/community_material_icon.dart';

class MyOrderDetail extends StatefulWidget {

   String ?ordernumber;
   String ?shippingAddress;
  final String? subTotal; 
  final String? shippingCharge;
  final String? grandTotal; 
  final String? shippingTransectionId; 
  final int? isPickupPoint; 
  List<OrderDetail> ?orderList = [];
  
  MyOrderDetail(
      {Key? key,
      required this.ordernumber,required this.shippingAddress,required this.subTotal,required this.shippingCharge,required this.grandTotal,required this.shippingTransectionId,required this.isPickupPoint,required this.orderList})
      : super(key: key);


  @override
  State<MyOrderDetail> createState() => _MyOrderDetailState();
}

class _MyOrderDetailState extends State<MyOrderDetail>
    with WidgetsBindingObserver {
 
  final GlobalKey<State> _dialogKey = GlobalKey<State>();
   
  @override
  void initState() {
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);
    var size = MediaQuery.of(context).size;
    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 3;
    final double itemWidth = size.width / 2;

    double unitHeightValue = MediaQuery.of(context).size.height * 0.01;
    double multiplier = 25;

    return Scaffold(
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: appBarWidget(context, 3, "Order Summary", false)),
      body:  SingleChildScrollView(child:   Column(
        children:  <Widget>[
           Container(
             width: MediaQuery.of(context).size.width,
             height: MediaQuery.of(context).size.height,
             color: Colors.white,
             padding:  EdgeInsets.all(10),
             child:  Column(
              children: [
                Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 0),child:   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                         alignment: Alignment.topLeft,
                         child:   setHeaderText('Order ID',14)                           
                    ),
                   Align(
                         alignment: Alignment.topRight,
                         child:    Text(widget.ordernumber.toString(),style: TextStyle(color: Colors.blue, fontWeight: FontWeight.normal,fontSize: 14))                     
    
                    )
                  ],
                ),)
              ,      
              dividerLine(),
              TotalText("Total","SubTotal",widget.subTotal.toString()),
              TotalText("","Shipping Charges",widget.shippingCharge.toString()),
              TotalText("","Grand Total",widget.grandTotal.toString()),
              dividerLine(),
              Padding(padding: EdgeInsets.all(10),child: Align(
                         alignment: Alignment.topLeft,
                         child:   setHeaderText('Payment',14)                           
                    ),),
                 Padding(padding: EdgeInsets.fromLTRB(10,0,10,0),child: Align(
                         alignment: Alignment.topLeft,
                         child:   Text("Transaction ID:" + " "+widget.ordernumber.toString(),style: TextStyle(color: Colors.grey,) )                        
                    ),),
                    dividerLine(),
                     Padding(padding: EdgeInsets.all(10),child: Align(
                         alignment: Alignment.topLeft,
                         child:   setHeaderText('Pickup Location',14)                           
                    ),),
                     getOderDetail()
              ],
            ),
           )
        ],
      ) ,)
        
      ,
    );
  }

  Visibility getOderDetail(){
    return Visibility(
      child:   Container(
          margin: EdgeInsets.all(5),
          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: widget.orderList?.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return GestureDetector(
                child: MyOrderDetailWidget(gradientColors: [Colors.white, Colors.white], 
                product: SetMyOrderDetailItem(id: 1, productimage: widget.orderList?[index].productName, productname: widget.orderList?[index].productName, price: "widget._orderList![index].price.toString()", qunatity: "widget._orderList![index].quantity.toString()")),
               
              );
              ;
            },
          ),
        ) );
  }
  
  Column setPickupLocation(){
    return Column(
      children: [
        Text(widget.shippingAddress.toString())
      ],
    );
  }

  Padding dividerLine(){
  return    Padding(padding: EdgeInsets.only(top: 10),child:    divider(context));
  }

  Padding TotalText(String title, String subheader, String str_data){
 return  Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 0),child:   Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                         alignment: Alignment.topLeft,
                         child:   setHeaderText(title,14)                           
                    ),
                   Align(
                         alignment: Alignment.topRight,
                         child:    Text(subheader,style: TextStyle(color: Colors.black38, fontWeight: FontWeight.bold,fontSize: 14))                     
    
                    ),
                       Align(
                         alignment: Alignment.topRight,
                         child:    Text(str_data,style: TextStyle(color: Colors.red, fontWeight: FontWeight.normal,fontSize: 14))                     
    
                    )
                  ],
                ),);
  }

  TextField getAddressText(String hint){
    return  TextField(
            
            decoration: addressText(hint),
            onChanged: (value) {
              // do something
            },
);
  }

  TextField getDropDownn(String hint){
    return  TextField(
             enabled: false, 
            decoration: inputwithdropdown(hint),
            onChanged: (value) {
              // do something
            },
);
  }

   
}
