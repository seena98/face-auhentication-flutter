import 'package:face_detection/app/providers/login.provider.dart';
import 'package:face_detection/widgets/custom_drawer_item.dart';
import 'package:face_detection/widgets/custom_image_holder.dart';
import 'package:face_detection/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Welcome 2 FaceRecognition",style: TextStyle(fontSize: ScreenUtil().setSp(40),color: Theme.of(context).accentColor),),
      ),
      body: ChangeNotifierProvider(
          create: (_)=>LoginProvider(),
        child: Consumer<LoginProvider>(
          builder: (context,value,child){
            if(value.data == null)
              return child;
            return Center(
              child: ListView(
                shrinkWrap: true,

                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  CustomImageHolder(value.data.firstName+" "+value.data.lastName,)
                ],
              ),
            );
          },
          child: CustomImageHolder("جهت اهراز هویت تصویر واضحی از خود بگیرید"),
        ),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: double.maxFinite,
              height: 300,
              color: Theme.of(context).accentColor,
              child: DrawerHeader(
                  child: Column(
                    children: [
                      Expanded(
                        child: CircleAvatar(
                          child: Text("MC"),
                          radius: 80,
                        ),
                      ),
                      Text("New login method..")
                    ],
                  ),
                duration: Duration(seconds: 2),
                padding: EdgeInsets.all(ScreenUtil().setHeight(20)),
              ),
            ),
            CustomDrawerItem(
              "Sign-Up",
              ()=>Navigator.pushNamed(context, "register"),
            ),
            CustomDrawerItem(
              "Call-Me",
              ()=>Navigator.pushNamed(context, "register"),
            ),
            CustomDrawerItem(
              "Developers",
              ()=>Navigator.pushNamed(context, "Developers"),
            ),
            Spacer(),
            Text("SRU UNIVERSITY",style: TextStyle(fontSize: ScreenUtil().setSp(30),fontWeight: FontWeight.bold,color: Colors.black.withOpacity(.5)),),
            SizedBox(height: ScreenUtil().setHeight(50),)
          ],
        ),
      ),
    );
  }

}