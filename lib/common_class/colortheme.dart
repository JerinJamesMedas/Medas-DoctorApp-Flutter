import 'package:flutter/material.dart';

class Apptheme{

    // Colors
  static const Color primaryColor = Color.fromRGBO(23, 54, 87,1);
  static const Color secondaryColor = Color.fromRGBO(15, 35, 69,1);
  static const Color backgroundColor = Colors.white;
  static const Color textColorblack = Colors.black;
   static const Color textColorwhite = Colors.white;
  static const Color cardColor = Colors.white;

  // Gradient
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color.fromRGBO(23, 54, 87,1), Color.fromRGBO(26, 58, 90,1), Color.fromRGBO(34, 75, 112,1)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Colors.orangeAccent, Colors.redAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}