import 'package:bot_toast/bot_toast.dart';
import 'package:face_detection/views/login.dart';
import 'package:face_detection/views/register.dart';
import 'package:face_detection/views/splash_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/providers/storage_service.dart';
import 'app/theme/theme.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.instance().registerService();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, value, child) {
          return MaterialApp(
            title: 'Face Recognition',
            builder: BotToastInit(), //1. call BotToastInit
            navigatorObservers: [
              BotToastNavigatorObserver()
            ], //2. registered route observer
            theme: value.currentTheme,
            home: SplashView(),
            initialRoute: "splash",
            routes: {
              "login": (context) => LoginView(),
              "register": (context) => RegisterView(),
              "splash": (context) => SplashView(),
            },
          );
        },
      ),
    );
  }


}
