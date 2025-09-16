import 'package:doctors_app/data/datasources/user_data.dart';
import 'package:doctors_app/main.dart';
// import 'package:doctors_app/screens/auth/doctor/login.dart';
import 'package:doctors_app/screens/navigation/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCheck extends StatelessWidget {
  const LoginCheck({super.key});

  Future<Usermodel?> _getSavedUser() async {
    final prefs = await SharedPreferences.getInstance();

    final id = prefs.getInt("id");
    final username = prefs.getString("username");
    final email = prefs.getString("email");
    final role = prefs.getString("role");
    final uid = prefs.getString("uid");

    if (id != null && username != null && email != null && role != null && uid != null) {
      return Usermodel(
        id: id,
        username: username,
        email: email,
        role: role,
        uid: uid,
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Usermodel?>(
      future: _getSavedUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While checking → show loading screen
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData && snapshot.data != null) {
          // ✅ User found → go to Home
          print("app realized their is key");
          return BottomNavPage();
        } else {
          // ❌ No user found → go to Login
          return const LandingPage();
        }
      },
    );
  }
}
