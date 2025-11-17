abstract class PatientHistoryEntity {
  final List<String>? medicalAlerts;
  final List<String>? allergies;
  final List<String>? pastHistory;
  final List<String>? nutritionalHistory;
  final List<String>? surgicalHistory;
  final List<String>? familyHistory;
  final List<String>? socialHistory;

  PatientHistoryEntity({
    this.medicalAlerts,
    this.allergies,
    this.pastHistory,
    this.nutritionalHistory,
    this.surgicalHistory,
    this.familyHistory,
    this.socialHistory,
  });
}

abstract class AllergiesEntity {
  final int id;
  final String allergy;
  final String allergyType;
  AllergiesEntity({required this.id, required this.allergy, required this.allergyType});
}


abstract class PatientHistorySectionEntity {
  final String name;
  final List<String> data;

  PatientHistorySectionEntity({
    required this.name,
    required this.data,
  });
}
