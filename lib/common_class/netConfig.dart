import 'dart:io';
import 'package:flutter/foundation.dart';

class NetCon {
  static String get ip {
    if (kIsWeb) {
      return "192.168.1.146"; 
    } else if (Platform.isAndroid) {
      return "10.0.2.2"; 
    } else {
      return "localhost"; 
    }
  }

  static String get baseUrl => "192.168.29.143:5000"; 
}
