import 'package:doctors_app/features/home/domain/repository/homedata_repo.dart';
import 'package:doctors_app/features/home/presentation/model/home_model.dart';

class GetHomeData {
  final HomeRepository repository;

  GetHomeData(this.repository);

  Future<List<ConsultationModel>> call() async {
    return await repository.getHomeData();
  }
}
