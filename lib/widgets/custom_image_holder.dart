import 'package:face_detection/widgets/widget_blinker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class CustomImageHolder extends StatelessWidget{
  final text;
  final imageFilePath;
  bool isBlinking;
  CustomImageHolder(this.text,{this.imageFilePath,this.isBlinking = true});

  @override
  Widget build(BuildContext context) {
    return isBlinking ?
    Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        WidgetBlinker(Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
          child: Text(
            text,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(35),
              fontWeight: FontWeight.bold
            ),
          ),
        )),
        Center(
          child: GestureDetector(
            onTap: ()=>null,//TODO capture image
            child: Container(
              height: ScreenUtil().setHeight(450),
              width: ScreenUtil().setHeight(450),
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius:BorderRadius.all(Radius.circular(ScreenUtil().setWidth(50)))
              ),
              child: imageFilePath == null ?
              Center(
                child: Icon(
                  Icons.photo_camera,
                  color: Colors.white,
                  size: ScreenUtil().setWidth(300),
                ),
              ) :
              Image.file(imageFilePath,fit: BoxFit.contain,),
            ),
          ),
        ),
      ],
    ):
    Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(20)),
          child: Text(
            text,
            style: TextStyle(
                fontSize: ScreenUtil().setSp(35)
            ),
          ),
        ),
        Center(
          child: GestureDetector(
            onTap: ()=>null,//TODO capture image
            child: Container(
              height: ScreenUtil().setHeight(450),
              width: ScreenUtil().setHeight(450),
              decoration: BoxDecoration(
                  color: Theme.of(context).accentColor,
                  borderRadius:BorderRadius.all(Radius.circular(ScreenUtil().setWidth(50)))
              ),
              child: imageFilePath == null ?
              Center(
                child: Icon(
                  Icons.photo_camera,
                  color: Colors.white,
                  size: ScreenUtil().setWidth(300),
                ),
              ) :
              Image.file(imageFilePath,fit: BoxFit.contain,),
            ),
          ),
        ),
      ],
    );
  }

}