// data/repositories/doctor_repository_impl.dart
import 'package:doctors_app/data/datasources/doctor_data.dart';
import 'package:doctors_app/domain/repositories/doctor_repo.dart';

import '../../domain/entities/doctor.dart';
class DoctorRepositoryImpl implements DoctorRepo {
  final DoctorRemoteDataSource remoteDataSource;

  DoctorRepositoryImpl(this.remoteDataSource);

  @override
  Future<Doctor?> fetchdata() {
    // print("im at doc impl");
    return remoteDataSource.fetchdata();
  }
}
