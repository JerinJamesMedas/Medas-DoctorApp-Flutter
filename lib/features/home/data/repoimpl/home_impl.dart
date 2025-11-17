


import 'package:doctors_app/features/home/data/remotedataSource/home_data.dart';
import 'package:doctors_app/features/home/domain/repository/homedata_repo.dart';
import 'package:doctors_app/features/home/presentation/model/home_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ConsultationModel>> getHomeData() {
    return remoteDataSource.getHomeData();
  }
}