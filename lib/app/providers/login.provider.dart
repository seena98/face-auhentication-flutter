import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:face_detection/app/models/login.model.dart';
import 'package:face_detection/app/repository/api.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LoginProvider extends ChangeNotifier{
  bool isLoading = false;
  var image;
  LoginModel data;
  changeLoadingState(bool isLoading){
    if(this.isLoading == isLoading)
      return; //prevent from rebuilding widget tree
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future login() async{
    changeLoadingState(true);
    var img = await image.readAsBytes();
    try {
      var res = await ApiRequests().login(img);
//      var res = await ApiRequests().register('mohammad','mahmooodi','${UniqueKey()}@qwe.rr',img);
      print(res);
      if((res).response.statusCode == 404)
        BotToast.showSimpleNotification(title: "USER NOT FOUND :)",backgroundColor: Colors.red);
      else
        data = LoginModel.fromJson(res);
    }catch(e){
      print("error in login : $e");
      BotToast.showSimpleNotification(title: "Some error occurred ..");
    }
    changeLoadingState(false);
  }

  Future getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    image = File(pickedFile.path);
    notifyListeners();
  }
}