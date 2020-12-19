import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:face_detection/app/models/login.model.dart';
import 'package:face_detection/app/repository/api.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginProvider extends ChangeNotifier {
  bool isLoading = false;
  var image;
  LoginModel data;
  changeLoadingState(bool isLoading) {
    if (this.isLoading == isLoading)
      return; //prevent from rebuilding widget tree
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future login() async {
    data = null;
    changeLoadingState(true);
    var img = await image.readAsBytes();
    try {
      var res = await ApiRequests().login(img);
//      var res = await ApiRequests().register('mohammad','mahmooodi','${UniqueKey()}@qwe.rr',img);
      print(res);
      if (res.statusCode == 404)
        BotToast.showSimpleNotification(
            title: "USER NOT FOUND :)", backgroundColor: Colors.red);
      else if (res.statusCode == 400)
        BotToast.showSimpleNotification(
            title: res.data, backgroundColor: Colors.red);
      else if (res.statusCode == 200) {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        var userEmail = prefs.getString("email");
        if (LoginModel.fromJson(res.data).email == userEmail)
          data = LoginModel.fromJson(res.data);
        else
          BotToast.showSimpleNotification(title: "User not Authenticated...");
      }
    } catch (e) {
      print("error in login : $e");
      BotToast.showSimpleNotification(title: "Some error occurred ..");
    }
    changeLoadingState(false);
  }

  Future getImage() async {
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile == null) return;
    File croppedFile = await ImageCropper.cropImage(
        sourcePath: pickedFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.ratio4x3,
        ],
        maxWidth: 500,
        maxHeight: 500,
        compressFormat: ImageCompressFormat.jpg,
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Crop your face',
            toolbarColor: Color(0xff0F495C),
            cropFrameColor: Color(0xff0F495C),
            cropGridColor: Color(0xff0F495C),
            statusBarColor: Color(0xff0F495C),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
    image = File(croppedFile.path);
    notifyListeners();
  }

  logOut() {
    image = null;
    data = null;
    notifyListeners();
  }
}
