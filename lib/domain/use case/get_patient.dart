import 'package:doctors_app/domain/repositories/patient_repo.dart';

import '../entities/patient.dart';

class GetPatients {
  final PatientRepository repository;

  GetPatients(this.repository);

  Future<List<Patient>> call() {
    return repository.getPatients();
  }
}
