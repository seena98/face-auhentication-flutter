import 'package:face_detection/app/providers/login.provider.dart';
import 'package:face_detection/widgets/custom_button.dart';
import 'package:face_detection/widgets/custom_drawer_item.dart';
import 'package:face_detection/widgets/widget_blinker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:provider/provider.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    animation = Tween(
      begin: 0.0,
      end: ScreenUtil().setHeight(450),
    ).animate(_controller);
    _controller.forward();
    _controller.addListener(() {
      if (_controller.value == _controller.upperBound)
        _controller.reverse();
      else if (_controller.value == _controller.lowerBound)
        _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Welcome 2 FaceRecognition",
          style: TextStyle(
              fontSize: ScreenUtil().setSp(40),
              color: Theme.of(context).accentColor),
        ),
      ),
      body: ChangeNotifierProvider(
        create: (_) => LoginProvider(),
        child: Consumer<LoginProvider>(
          builder: (context, value, child) {
            return Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                WidgetBlinker(Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(20)),
                  child: Text(
                    value.data == null
                        ? "جهت اهراز هویت تصویر واضحی از خود انتخاب کنید"
                        : value.data.firstName + " " + value.data.lastName,
                    style: TextStyle(
                        fontSize: ScreenUtil().setSp(35),
                        fontWeight: FontWeight.bold),
                  ),
                )),
                Center(
                  child: Container(
                    height: ScreenUtil().setHeight(470),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Center(
                          child: GestureDetector(
                            onTap: () => value.isLoading
                                ? null
                                : value.getImage(), //TODO capture image
                            child: Container(
                              height: ScreenUtil().setHeight(450),
                              width: ScreenUtil().setHeight(450),
                              decoration: BoxDecoration(
                                  color: Theme.of(context).accentColor,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(
                                          ScreenUtil().setWidth(50)))),
                              child: value.image == null
                                  ? Center(
                                      child: Icon(
                                        Icons.photo_camera,
                                        color: Colors.white,
                                        size: ScreenUtil().setWidth(300),
                                      ),
                                    )
                                  : Image.file(
                                      value.image,
                                      fit: BoxFit.contain,
                                    ),
                            ),
                          ),
                        ),
                        !value.isLoading
                            ? Container()
                            : AnimatedBuilder(
                                animation: _controller,
                                builder: (context, child) {
                                  return Transform.translate(
                                    child: Container(
                                        width: double.maxFinite,
                                        height: 10,
                                        color: Colors.red),
                                    offset: Offset(0, animation.value),
                                  );
                                }),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: IgnorePointer(
                    ignoring: value.isLoading ?? false,
                    child: CustomButton(
                      text: value.isLoading ? "در حال پردازش" : "ورود",
                      onPressed: () => value.login(),
                      isPrimary: true,
                    ),
                  ),
                )
              ],
            );
          },
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
              () => Navigator.pushNamed(context, "register"),
            ),
            CustomDrawerItem(
              "Call-Me",
              () => Navigator.pushNamed(context, "register"),
            ),
            CustomDrawerItem(
              "Developers",
              () => Navigator.pushNamed(context, "Developers"),
            ),
            Spacer(),
            Text(
              "SRU UNIVERSITY",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(30),
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(.5)),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(50),
            )
          ],
        ),
      ),
    );
  }
}
