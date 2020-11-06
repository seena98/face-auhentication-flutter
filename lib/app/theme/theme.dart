import 'package:flutter/material.dart';

import '../providers/storage_service.dart';

enum ThemeStateMode { DarkMode, LightMode }
const Color GreenCardColor = Color(0xff40FF3C);
const Color SearchBarLightColor = Color(0xffAAAAAA);
const Color SearchBarDarkColor = Color(0xff909698);
const Color SearchBarBackgroundColor = Color(0xfff1f1f1);
const Color blackColorForText = Color(0xff1F1F1F);
const Color whiteColorForText = Color(0xffD2D2D2);
const Color grayBlueForProgress = Color(0xff0F495C);
const Color goldenColorLightMode = Color(0xffFFC736);
const Color silverColorLightMode = Color(0xff474747);
const Color bronzeColorLightMode = Color(0xff8B4403);
class ThemeProvider extends ChangeNotifier {
  ThemeProvider() {
    var mode = StorageService.instance().getStorage.getString('THEME_MODE');
    if (mode != null && mode == 'DARK') {
      currentTheme = _getDarkTheme();
      this.mode = ThemeStateMode.DarkMode;
    } else {
      currentTheme = _getLightMode();
      this.mode = ThemeStateMode.LightMode;
    }
  }

  ThemeData currentTheme;
  ThemeStateMode mode;
  void changeThemeMode(ThemeStateMode mode) {
    switch (mode) {
      case ThemeStateMode.DarkMode:
        StorageService.instance().getStorage.setString('THEME_MODE', 'DARK');
        currentTheme = _getDarkTheme();
        this.mode = ThemeStateMode.DarkMode;
        break;
      case ThemeStateMode.LightMode:
        StorageService.instance().getStorage.setString('THEME_MODE', 'LIGHT');
        currentTheme = _getLightMode();
        this.mode = ThemeStateMode.LightMode;
        break;
    }
    notifyListeners();
  }

  ThemeData _getDarkTheme() {
    return ThemeData.dark().copyWith(
      accentColor: Color(0xffffffff),
      primaryColor: Color(0xff3C3C3C),
      errorColor: Color(0xffFF3B3B),
      backgroundColor: Color(0xff272727),
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(fontFamily: 'Shabnam'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(.4),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(.4),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Colors.white.withOpacity(.6),
            ),
          ),
          fillColor: Color(0xff0F495C),
          hintStyle: TextStyle(
            color: Color(0xff0F495C).withOpacity(.5),
          )),
      textTheme: TextTheme(
        subhead: TextStyle(
          fontFamily: 'Shabnam',
          color: Colors.white
        ),
        body1: TextStyle(
          fontFamily: 'Shabnam',
          color: Colors.white,
        ),
        body2: TextStyle(
          fontFamily: 'Shabnam',
          color: Colors.black,
        ),
        button: TextStyle(
          fontFamily: 'Shabnam',
        )
      ),
    );
  }

  ThemeData _getLightMode() {
    return ThemeData.light().copyWith(
      accentColor: Color(0xff0F495C),

      primaryColor: Color(0xffF4F4F4),
      errorColor: Color(0xffFF3B3B),
      backgroundColor: Color(0xffFFFFFF),
      accentIconTheme: IconThemeData(
          color: Color(0xff0F495C)
      ),
      primaryIconTheme: IconThemeData(
          color: Color(0xff0F495C)
      ),
      iconTheme: IconThemeData(
        color: Color(0xff0F495C)
      ),
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyle(fontFamily: 'Shabnam'),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xff0F495C).withOpacity(.4),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xff0F495C).withOpacity(.4),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: Color(0xff0F495C).withOpacity(.6),
            ),
          ),
          fillColor: Color(0xff0F495C),
          hintStyle: TextStyle(
            color: Color(0xff0F495C).withOpacity(.5),
          )),
      textTheme: TextTheme(
        subhead: TextStyle(fontFamily: 'Shabnam', color: Colors.black),
        body1: TextStyle(fontFamily: 'Shabnam', color: Colors.black),
        body2: TextStyle(fontFamily: 'Shabnam', color: Colors.white),
        button: TextStyle(
          fontFamily: 'Shabnam',
        )
      ),
    );
  }
}
