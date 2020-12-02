import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:face_detection/views/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(800, 1280), allowFontScaling: false);
//    return LoginView();
    return AnimatedSplashScreen(
        duration: 3000, //sec
        splash: Icons.tag_faces_sharp,
        nextScreen: LoginView(),
        splashTransition: SplashTransition.fadeTransition,
        backgroundColor: Theme.of(context).primaryColor);
  }
}
