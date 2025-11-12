import 'package:doctors_app/main.dart';
// import 'package:doctors_app/screens/auth/doctor/login.dart';
import 'package:doctors_app/screens/navigation/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginCheck extends StatelessWidget {
  const LoginCheck({super.key});

  Future<bool> _isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    final accessToken = prefs.getString("accessToken");
    final userId = prefs.getInt("user_id");
    print(userId);

    return accessToken != null && userId != null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While checking → show loading screen
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (snapshot.hasData && snapshot.data == true) {
          // User found → go to Home
          //  print("app realized their is key");
          print(snapshot.data);
          print("something is in user ");
          return BottomNavPage();
        } else {
          
          return const LandingPage();
        }
      },
    );
  }
}
