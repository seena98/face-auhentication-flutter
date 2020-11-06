import 'package:face_detection/app/repository/api.dart';
import 'package:flutter/material.dart';

class RegisterProvider extends ChangeNotifier{
  bool isLoading;
  var firstname,lastname,email,images;
  changeLoadingState(bool isLoading){
    if(this.isLoading == isLoading)
      return; //prevent from rebuilding widget tree
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future register() async{
    changeLoadingState(true);
    var res = ApiRequests().register(firstname, lastname, email, images);
    //if res status code == 201 then success register occurred
    //else not success
    changeLoadingState(false);
  }
}