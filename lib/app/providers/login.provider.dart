import 'package:face_detection/app/models/login.model.dart';
import 'package:face_detection/app/repository/api.dart';
import 'package:flutter/material.dart';

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
    var res = await ApiRequests().login(image);
    data = LoginModel.fromJson(res);
    changeLoadingState(false);
  }
}