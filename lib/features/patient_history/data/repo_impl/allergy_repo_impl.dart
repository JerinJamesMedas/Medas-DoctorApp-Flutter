import 'package:doctors_app/features/patient_history/data/remote_datasource/allergy_remote_data_source.dart';
import 'package:doctors_app/features/patient_history/domain/repository/allergy_repo.dart';
import 'package:doctors_app/features/patient_history/presentation/model/allergy_list_model.dart';

class AllergyRepoImpl extends AllergyRepo {
  final AllergyRemoteDataSource rds;
  AllergyRepoImpl(this.rds);
  @override
  Future<List<AllergyListModel>> getallAllergies(String id) {
    return rds.getallergyList(id);
  }
  }
