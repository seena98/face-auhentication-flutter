import 'package:dio/dio.dart';
import 'package:face_detection/app/config/config.dart';

class ApiRequests {

  Future<dynamic> login(image) async {

    var request = await _getAuthRequester();
    Map data = Map();
    data['image'] = image;
    try {
      var res =
      await request.post(LOGIN,data: data);
      return res.data;
    } catch (e) {
      print("incoming argument as PATH is : $LOGIN");
      print((e as DioError).error);
      return (e as DioError).error;
    }
  }

  Future<dynamic> register(String firstname,lastname,email,image) async {

    var request = await _getAuthRequester();
    Map data = Map();
    data['image'] = image;
    data['email'] = email;
    data['first_name'] = firstname;
    data['last_name'] = lastname;
    try {
      var res =
      await request.post(REGISTER,data: data);
      return res.data;
    } catch (e) {
      print("incoming argument as PATH is : $REGISTER");
      print((e as DioError).error);
      return (e as DioError).error;
    }
  }

}


Future<Dio> _getAuthRequester() async {
  var dio = BaseOptions(
    baseUrl: BASE_URL,
    headers: {
      'Content-Type': 'application/json',
    },
  );
  return Dio(dio);
}

