import 'package:doctors_app/features/patient_history/domain/entities/patient_history.dart';

class AllergyListModel extends AllergiesEntity {
  AllergyListModel({
    required super.id,
    required super.allergy,
    required super.allergyType,
  });

  factory AllergyListModel.fromJson(Map<String, dynamic> json) {
    return AllergyListModel(
      id: json['id'] ?? 0,
      allergy: json['allergy'] ?? '',
      allergyType: json['allergy_type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "allergy": allergy,
      "allergy_type": allergyType,
    };
  }
}
