import 'package:doctors_app/features/patient_history/domain/entities/patient_history.dart';

class PatientHistorySectionModel extends PatientHistorySectionEntity {
  PatientHistorySectionModel({
    required super.name,
    required super.data,
  });

  factory PatientHistorySectionModel.fromJson(Map<String, dynamic> json) {
    return PatientHistorySectionModel(
      name: json["name"] ?? "",
      data: (json["data"] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "data": data,
    };
  }
}
