import 'package:dio/dio.dart';
import 'package:doctors_app/features/patient_history/presentation/model/allergy_list_model.dart';

class AllergyRemoteDataSource {
  final Dio dio;

  AllergyRemoteDataSource(this.dio);
  Future<List<AllergyListModel>> getallergyList(String id) async {
    try {
      final response = await dio.get(
        'http://192.168.1.72:5000/history/allergytypes',
      );
      final List data = response.data["results"];

      return data.map((item) => AllergyListModel.fromJson(item)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
