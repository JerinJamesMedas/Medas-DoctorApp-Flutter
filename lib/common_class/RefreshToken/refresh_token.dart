import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RToken  {
  SharedPreferences pref;
  final Dio dio;
  String token = "";
  RToken(this.dio, this.pref);
  Future<String> reftoken() async {
    String refreshtoken = pref.getString("refreshToken") ?? "";
    final response = await dio.post(
      "http://localhost:5000/api//refresh",
      data: {"token" : refreshtoken},
      options: Options(contentType: Headers.jsonContentType),
      );
    token = response.data["accessToken"];
    return token;
  }
}