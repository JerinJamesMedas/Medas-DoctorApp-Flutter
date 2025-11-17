import 'package:doctors_app/features/patient_history/presentation/model/allergy_list_model.dart';

abstract class AllergyRepo {
  Future<List<AllergyListModel>> getallAllergies(String id);
}