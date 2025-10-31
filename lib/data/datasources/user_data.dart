import 'package:dio/dio.dart';
import 'package:doctors_app/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRemoteDataSource {
  final Dio dio;
  UserRemoteDataSource(this.dio);

  Future<Usermodel?> login(String email, String password) async {
    try {
      // Admin shortcut
      if (email == "admin@example.com" && password == "admin@123") {
        final user = Usermodel(
          userName: "jerry",
          doctorsName: "Dr. Jerry",
          doctorType: "General Practitioner",
          departmentName: "General Medicine",
          officeName: "Main Office",
        );

        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt("id", 12345);
        await prefs.setString("username", "jerry");
        await prefs.setString("email", email);
        await prefs.setString("role", "admin");
        await prefs.setString("uid", "jerry123");

        return user;
      }
        print("its in the login function");
      // Step 1: Login API
      final response = await dio.post(
        "http://192.168.29.142:5000/user/login",
        data: {"username": email, "password": password},
        options: Options(contentType: Headers.jsonContentType),
      );
      print("Login response: ${response.data}");

      if (response.data["Accesstoken"] == null ||
          response.data["refreshToken"] == null ||
          response.data["user_id"] == null) {
        return null;
      }

      // Step 2: Save tokens in SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("accessToken", response.data["Accesstoken"]);
      await prefs.setString("refreshToken", response.data["refreshToken"]);
      await prefs.setInt("user_id", response.data["user_id"]);

      final accessToken = response.data["Accesstoken"];
      final userId = response.data["user_id"];

      // Step 3: Call staff/userid API
      final userResponse = await dio.get(
        "http://192.168.29.142:5000/staff/$userId",
        options: Options(headers: {"Authorization": "Bearer $accessToken"}),
      );
      print("User details response: ${userResponse.data}");

      // Step 4: Map response to Usermodel and store info
      final userJson = userResponse.data; // JSON from staff/userid API
      final user = Usermodel(
        userName: userJson["user_name"] ?? "",
        doctorsName: userJson["doctors_name"] ?? "",
        doctorType: userJson["doctor_type"] ?? "",
        departmentName: userJson["department_name"] ?? "",
        officeName: userJson["office_Name"] ?? "",
      );

      return user;
    } catch (e) {
      print("Login error: $e");
      rethrow;
    }
  }
}
