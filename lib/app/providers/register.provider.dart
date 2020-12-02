import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:face_detection/app/repository/api.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class RegisterProvider extends ChangeNotifier {
  bool isLoading = false;
  var firstname, lastname, email;
  List<File> images = List();
  List<String> notAcceptedImages = List();

  changeLoadingState(bool isLoading) {
    if (this.isLoading == isLoading)
      return; //prevent from rebuilding widget tree
    this.isLoading = isLoading;
    notifyListeners();
  }

  Future register() async {
    changeLoadingState(true);
    if (images.length == 0) {
      BotToast.showSimpleNotification(title: "No image is selected");
      changeLoadingState(false);
      return;
    } else if (images.length == 1) {
      BotToast.showSimpleNotification(
          title: "Please choose at least 2 image to continue");
      changeLoadingState(false);
      return;
    } else if (images.length > 5) {
      BotToast.showSimpleNotification(
          title:
              "to much images has been selected, please choose max: 5-images");
      changeLoadingState(false);
      return;
    } else if (email == null) {
      BotToast.showSimpleNotification(title: "Email can not be empty");
      changeLoadingState(false);
      return;
    } else if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email)) {
      BotToast.showSimpleNotification(title: "email is not valid!");
      changeLoadingState(false);
      return;
    } else if (firstname == null) {
      BotToast.showSimpleNotification(title: "FirstName can not be empty");
      changeLoadingState(false);
      return;
    } else if (lastname == null) {
      BotToast.showSimpleNotification(title: "LastName can not be empty");
      changeLoadingState(false);
      return;
    }
    notAcceptedImages = List();
    var res = await ApiRequests().register(firstname, lastname, email, images);
    print(res);
    if ((res as Response).statusCode == 400) {
      BotToast.showSimpleNotification(
          title:
              "register failed! the uploaded images rejected because no single face was detected.");
      try {
        print("Status code is 400 , it's seems no faces were recognised ;");
        var response;
        response = res.data.toString().replaceFirst("[", "");
        response = response.toString().replaceFirst("]", "");
        response = response.toString().replaceAll(" ", "");
        notAcceptedImages = response.toString().split(",");
      } catch (e) {
        print("error in parsing error to get not Accepted images");
      }
    }
    if ((res as Response).statusCode == 201) {
      try {
        print("register was success, searching for not accepted images");
        var response;
        response = res.data.toString().replaceFirst("[", "");
        response = response.toString().replaceFirst("]", "");
        response = response.toString().replaceAll(" ", "");
        notAcceptedImages = response.toString().split(",");
        if (notAcceptedImages.isNotEmpty)
          BotToast.showSimpleNotification(
              title:
                  "Successful register! but some image was rejected because no single face was detected.");
      } catch (e) {
        BotToast.showSimpleNotification(title: "Successful register!");
        print(
            "error in parsing error to get not Accepted images, maybe all things are good!");
      }
    }
    //if res status code == 201 then success register occurred
    //else not success
    changeLoadingState(false);
  }

  Future getImage() async {
    final pickedFile = await ImagePicker().getImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
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
    images.add(File(croppedFile.path));
    notifyListeners();
  }

  bool isImageAccepted(String response) {
    bool res;
    var decodedResponse = jsonDecode(response);
    print("Decoded response : $decodedResponse");
    return res;
  }

  removeImageFromList(File e) {
    this.images.remove(e);
    notifyListeners();
  }
}
