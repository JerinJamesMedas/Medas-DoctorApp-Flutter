// data/datasources/doctor_remote_data_source.dart
import 'package:dio/dio.dart';
import 'package:doctors_app/domain/entities/doctor.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DoctorRemoteDataSource {
  final Dio dio;

  DoctorRemoteDataSource(this.dio);

  Future<DoctorModel?> fetchdata() async {
    try {
      final prefs = await SharedPreferences.getInstance();
       final uid = prefs.getString("uid");
      final response = await dio.post(
        // "http://192.168.1.146:8060/trial_1/doctor",
        "http://10.0.2.2:8060/trial_1/doctor",
        // "https://void-grace-relief-manufacturing.trycloudflare.com/trial_1/doctor",
        data: {"uid": uid},
        options: Options(
          contentType: Headers.formUrlEncodedContentType, // 👈 form data
        ),
      );

      if (response.data["status"] == "success") {
        // print("response was success");
        // print(response.data["status"]);
        return DoctorModel.fromJson(response.data["doctor"]);
      } else {
        // print(response.data["status"]);
        // print(response.data["message"]);
        return null;
      }
    } catch (e) {
      // print("there was error like this:");
      // print(e);
      rethrow;
    }
  }
}

class DoctorModel extends Doctor {
  DoctorModel({
    required super.docId,
    required super.name,
    required super.speciality,
    required super.bio,
    required super.phone,
    required super.email,
    required super.city,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      docId: json['docId'],
      name: json['name'],
      speciality: json['speciality'],
      bio: json['bio'],
      phone: json['phone'],
      email: json['email'],
      city: json['city'],
    );
  }
}
