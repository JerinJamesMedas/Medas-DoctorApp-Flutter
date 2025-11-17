import 'package:dio/dio.dart';
import 'package:doctors_app/common_class/netConfig.dart';
import 'package:doctors_app/features/home/presentation/model/home_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeRemoteDataSource {
  final Dio dio;
  HomeRemoteDataSource(this.dio);
  Future<List<ConsultationModel>> getHomeData() async {
    final ip = NetCon.baseUrl;
    final pref = await SharedPreferences.getInstance();
    // final uid = pref.getString("uid");
    final uid = 76;
    final accessToken = pref.getString("accessToken");
    print("inside home data source");
    try {
      final response = await dio.post(
        "http://$ip/patients/home/$uid",
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $accessToken",
          },
        ),
      );
      if (response.statusCode == 200) {
        final data = response.data;
        print("data is $data");

        final List<dynamic> appointmentsJson = data['appoinment'] ?? [];

        final List<ConsultationModel> appoinments = appointmentsJson
            .map((json) => ConsultationModel.fromJson(json))
            .toList();
        return appoinments;
      } else {
        throw Exception("Failed to load home data");
      }
    } catch (e) {
      throw Exception("Error fetching home data: $e");
    }
  }
}
