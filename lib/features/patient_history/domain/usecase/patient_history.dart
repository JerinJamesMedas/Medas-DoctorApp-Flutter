import 'package:doctors_app/features/patient_history/domain/repository/allergy_repo.dart';
import 'package:doctors_app/features/patient_history/presentation/model/allergy_list_model.dart';

class GetPatientAllerges {
  final AllergyRepo phRepo;
  GetPatientAllerges(this.phRepo);
  Future<List<AllergyListModel>> getAllergies(String id){
    return phRepo.getallAllergies(id);
  }
}