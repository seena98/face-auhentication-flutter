import 'dart:async';

import 'package:flutter/material.dart';

class WidgetBlinker extends StatefulWidget{
  final child;
  WidgetBlinker(this.child);
  @override
  State<StatefulWidget> createState() {
    return WidgetBlinkerState();
  }

}

class WidgetBlinkerState extends  State<WidgetBlinker> with SingleTickerProviderStateMixin{
  AnimationController controller ;
  Timer timer;
  @override
  Widget build(BuildContext context) {
    return Opacity(
        opacity: controller.value,
        child: widget.child
    );
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
      reverseDuration: Duration(milliseconds: 1000),
      upperBound: 1.0,
      lowerBound: 0.0
    )
    ..forward()
    ..addListener(() async{
//      print("controller value is ${controller.value}");
      if(this.controller?.value == controller?.lowerBound)
        this?.controller?.forward();
      else if(this?.controller?.value == controller?.upperBound) {
        timer = Timer(
            Duration(milliseconds: 5000),
                (){

              this?.controller?.reverse();
            });
      }
      if(mounted)
        setState(() {});
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    timer?.cancel();
    super.dispose();


  }
}