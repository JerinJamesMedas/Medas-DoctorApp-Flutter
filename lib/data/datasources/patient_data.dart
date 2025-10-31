import 'dart:convert';
import 'package:dio/dio.dart';
import '../../common_class/RefreshToken/refresh_token.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/patient.dart';

class PatientRemoteDataSource {
  final Dio dio;

  PatientRemoteDataSource(this.dio);

  Future<List<Patient>> fetchPatients() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final rToken = RToken(dio, prefs);
      final role = prefs.getString("role");
      final userId = prefs.getString("userId");
      final accessToken = prefs.getString("accessToken") ?? "";

      List<dynamic> jsonList;

      if (role == "admin" && userId == null) {
        final response = await rootBundle.loadString("assets/data/patient_details.json");
        jsonList = json.decode(response) as List<dynamic>;
      } else {
        final response = await dio.get(
          "http://192.168.29.142:5000/patients/$userId",
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Authorization": "Bearer $accessToken",
            },
          ),
        );

        var data = response.data as Map<String, dynamic>;
        if (data["error"] == "Invalid Token") {
          final newAccessToken = await rToken.reftoken();
          prefs.setString("accessToken", newAccessToken);
          final retryResponse = await dio.get(
            "http://192.168.29.142:5000/patients/$userId",
            options: Options(
              headers: {
                "Content-Type": "application/json",
                "Authorization": "Bearer $newAccessToken",
              },
            ),
          );
          data = retryResponse.data as Map<String, dynamic>;
        }

        jsonList = data["patient"];
      }

      return jsonList.map((json) {
        int parseInt(dynamic v) {
          if (v == null) return 0;
          if (v is int) return v;
          if (v is String) return int.tryParse(v) ?? 0;
          return 0;
        }

        return Patient(
          consultId: parseInt(json['consult_id']),
          appointType: (json['appoint_type'] ?? '').toString(),
          patientId: parseInt(json['patient_id']),
          appointHr: parseInt(json['appoint_hr']),
          appointMin: parseInt(json['appoint_min']),
          appointPurpose: (json['appoint_purpose'] ?? '').toString(),
          appointDate: (json['appoint_date'] ?? '').toString(),
          opNumber: (json['op_number'] ?? '').toString(),
          mobile: (json['mobile'] ?? '').toString(),
          appointStatus: (json['appoint_status'] ?? '').toString(),
          dateOfBirth: (json['date_of_birth'] ?? '').toString(),
          patientAge: parseInt(json['patient_age']),
          sex: (json['sex'] ?? '').toString(),
          patientName: (json['patient_name'] ?? '').toString(),
          visitType: (json['visit_type'] ?? '').toString(),
          doctorView: (json['doctor_view'] ?? '').toString(),
        );
      }).toList();
    } on DioException catch (e) {
      throw Exception("Failed to fetch patients: ${e.message}");
    }
  }
}
