


import 'package:doctors_app/data/datasources/home_data.dart';
import 'package:doctors_app/domain/repositories/homedata_repo.dart';
import 'package:doctors_app/model/home_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<ConsultationModel>> getHomeData() {
    return remoteDataSource.getHomeData();
  }
}