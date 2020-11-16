import 'package:dio/dio.dart';
import 'package:face_detection/app/config/config.dart';
import 'package:http_parser/http_parser.dart';

class ApiRequests {
  Future<Response> login(image) async {
    var request = await _getAuthRequester();
    try {
      var res = await request.post(LOGIN,
          data: FormData.fromMap({
            'image': MultipartFile.fromBytes(image,
                contentType: MediaType('image', '*'),
                filename:
                    "login_image_at_${DateTime.now().toIso8601String()}.jpg"),
          }));
      return res;
    } catch (e) {
      print("incoming argument as PATH is : $LOGIN");
      for (var t in e.response.toString().split("\n")) print(t);
      print((e as DioError).error);
      return e.response;
    }
  }

  Future<dynamic> register(String firstname, lastname, email, image) async {
    var request = await _getAuthRequester();
    try {
      var res = await request.post(REGISTER,
          data: FormData.fromMap({
            'image': MultipartFile.fromBytes(image,
                contentType: MediaType('image', '*'),
                filename:
                    "login_image_at_${DateTime.now().toIso8601String()}.jpg"),
            'first_name': firstname,
            'last_name': lastname,
            'email': email
          }));
      return res.data;
    } catch (e) {
      print("incoming argument as PATH is : $REGISTER");
      for (var t in e.response.toString().split("\n")) print(t);
      print((e as DioError).error);
      return (e as DioError);
    }
  }
}

Future<Dio> _getAuthRequester() async {
  var dio = BaseOptions(
    baseUrl: BASE_URL,
    headers: {
      'Content-Type': 'multipart/form-data',
      'Accept-Encoding': "gzip, deflate, br"
    },
  );
  return Dio(dio);
}
