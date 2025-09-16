import 'package:dio/dio.dart';
import 'package:doctors_app/screens/user/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRemoteDataSource {
  final Dio dio;
  UserRemoteDataSource(this.dio);
  Future<Usermodel?> login(String email, String password) async {
    try {

      if(email == "admin@example.com" && password == "admin@123"){
        int userid = 12345;
        String usernames = "jerry";
        String userrole = "admin";
        String useruid = "jerry123";

                final user = Usermodel(
          email: email,
          id: userid,
          role: userrole,
          username: usernames,
          uid: useruid,
        );

        try {        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt("id", userid);
        await prefs.setString("username", usernames);
        await prefs.setString("email", email);
        await prefs.setString("role", userrole);
        await prefs.setString("uid",  useruid);}
        catch(e){
print(e);
        }

        return user;
      }

      else {
      final response = await dio.post(
        // "http://192.168.1.146:8060/trial_1/login",
        "http://10.0.2.2:8060/trial_1/login",
        // "https://void-grace-relief-manufacturing.trycloudflare.com/trial_1/login",
        data: {"email": email, "password": password},
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (response.data["status"] == "success") {
        final user = Usermodel.fromJson(response.data);
        print("hiii");
        print(user.uid);
try {        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt("id", user.id);
        await prefs.setString("username", user.username);
        await prefs.setString("email", user.email);
        await prefs.setString("role", user.role);
        await prefs.setString("uid", user.uid);}
        catch(e){
print(e);
        }

        return user;
      } else {
        return null;
      }
      }

    } catch (e) {
      rethrow;
    }
    
  }
}

class Usermodel extends User {
  final String username;
  final String role;
  final String email;
  final int id;
  final String uid;
  const Usermodel({
    super.key,
    required this.email,
    required this.id,
    required this.role,
    required this.username,
    required this.uid
  });

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    final user = json["user"];
    return Usermodel(
      email: user["email"],
      id: user["id"],
      role: user["role"],
      username: user["username"],
      uid: user["docid"],
    );
  }
}
