import 'package:doctors_app/domain/repositories/homedata_repo.dart';
import 'package:doctors_app/model/home_model.dart';

class GetHomeData {
  final HomeRepository repository;

  GetHomeData(this.repository);

  Future<List<ConsultationModel>> call() async {
    return await repository.getHomeData();
  }
}
