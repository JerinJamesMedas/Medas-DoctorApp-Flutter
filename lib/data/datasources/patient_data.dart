import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/patient.dart';

class PatientRemoteDataSource {
  final Dio dio;

  PatientRemoteDataSource(this.dio);

  Future<List<Patient>> fetchPatients() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final uid = prefs.getString("uid");
      final role = prefs.getString("role"); // ✅ check role
      print("in data fetching");
      print("UID: $uid, Role: $role");

      // 🔹 If admin, load from assets instead of API
      if (role == "admin") {
        final String response = await rootBundle.loadString(
          "assets/data/patient_details.json",
        );
        final data = json.decode(response) as List<dynamic>;
   

        return data
            .map(
              (json) => Patient(
                name: json['patient'],
                mr: json['mr'],
                dob: json['dob'],
                type: json['type'],
                nationality: json['nationality'],
                city: json['city'],
                visitcount: json['visitCount'],
                appointmentDate: json['appointmentDate'],
                appointmentTime: json['appointmentTime'],
                op: json['op'] ?? 'No',
                mode: json['mode'] ?? '',
                title: json['title'] ?? '',
                revisit: json['revisit'],
                visited: json['visited'],
                allergies: json["allergies"] != null
                    ? List<String>.from(json["allergies"])
                    : [],
                notes: json["notes"] != null
                    ? List<String>.from(json["notes"])
                    : [],
              ),
              
            )
            .toList();
      }

      // 🔹 Otherwise, fetch from API
      final response = await dio.post(
        "http://10.0.2.2:8060/trial_1/doctor/patient",
        queryParameters: {"docid": uid},
        options: Options(headers: {"Content-Type": "application/json"}),
      );

      final data = response.data as Map<String, dynamic>;
      final List<dynamic> jsonList = data["patient"];

      return jsonList
          .map(
            (json) => Patient(
              name: json['patient'],
              mr: json['mr'],
              dob: json['dob'],
              type: json['type'],
              nationality: json['nationality'],
              city: json['city'],
              visitcount: json['visitCount'],
              appointmentDate: json['appointmentDate'],
              appointmentTime: json['appointmentTime'],
              op: json['op'] ?? 'No',
              mode: json['mode'] ?? '',
              title: json['title'] ?? '',
              revisit: json['revisit'],
              visited: json['visited'],
              allergies: json["allergies"],
              notes: json["notes"],
            ),
          )
          .toList();
    } on DioException catch (e) {
      throw Exception("Failed to fetch patients: ${e.message}");
    }
  }
}
