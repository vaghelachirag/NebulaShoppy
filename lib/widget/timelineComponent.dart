import 'dart:math';
import 'package:flutter/material.dart';

import '../model/Events.dart';
import '../uttils/constant.dart';

class TimelineComponet extends StatelessWidget {

  final int? ticks;

 const  TimelineComponet({@required this.ticks});


  @override
  Widget build(BuildContext context) {
    return
     Container(
       width: MediaQuery.of(context).size.width,
       alignment: Alignment.center,
       child: 
        Column(
          children: [
   Row(
       mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        tick1(),
        line(),
        tick2(),
        line(),
        tick3()
      ],
    ),
     Row(
       mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        orderProcessing(),
        lineprocessing(),
        orderDispatch(),
        lineprocessing(),
        orderDilivered(),
      ],
    )
          ],
        )
      ,
     );
    


  }

  Widget tick(bool isChecked){
    return isChecked?Icon(Icons.check_circle,color: Colors.amber.shade400,):Icon(Icons.radio_button_unchecked, color: Colors.amber.shade400,);
  }

  Widget tick1() {
    return this.ticks!>0?tick(true):tick(false);
  }
  Widget tick2() {
    return this.ticks!>1?tick(true):tick(false);
  }
  Widget tick3() {
    return this.ticks!>2?tick(true):tick(false);
  }
  Widget tick4() {
    return this.ticks!>3?tick(true):tick(false);
  }

  Widget spacer() {
    return Container(
      width: 5.0,
    );
  }

  Widget line() {
    return Container(
      color: Colors.amber.shade400,
      height: 1.0,
      width: 80.0,
    );
  }

  Widget lineprocessing() {
    return Container(
      color: Colors.white,
      height: 1.0,
      width: 60.0,
    );
  }

  
  Widget orderProcessing() {
    return Align(
      alignment: Alignment.center,
      child:   Text("Processing",style: TextStyle(fontSize: 12,color: Colors.black),) ,
    );
   
  }

    Widget orderDispatch() {
    return Text("Disptached",style: TextStyle(fontSize: 12,color: Colors.black),);
  }

   Widget orderDilivered() {
    return Text("Delivered",style: TextStyle(fontSize: 12,color: Colors.black),);
  }
}
