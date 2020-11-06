import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class CustomDrawerItem extends StatelessWidget{
  final title,onTap,isLastItem;
  CustomDrawerItem(this.title,this.onTap,{this.isLastItem = false});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          trailing: Icon(Icons.arrow_forward_ios,size: ScreenUtil().setHeight(40),),
          title: Text(
            title,
            style: TextStyle(
                color: Colors.black,
                fontSize: ScreenUtil().setSp(40)
            ),
          ),
        ),
        isLastItem ? Container():
        Divider(),
      ],
    );
  }

}