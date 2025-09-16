import 'package:doctors_app/data/datasources/patient_data.dart';
import 'package:doctors_app/domain/repositories/patient_repo.dart';

import '../../domain/entities/patient.dart';

class PatientRepositoryImpl implements PatientRepository {
  final PatientRemoteDataSource localDataSource;

  PatientRepositoryImpl(this.localDataSource);

  @override
  Future<List<Patient>> getPatients() {
    return localDataSource.fetchPatients();
  }
}
