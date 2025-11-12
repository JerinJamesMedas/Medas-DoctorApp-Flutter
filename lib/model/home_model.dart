import 'package:doctors_app/domain/entities/consultation.dart';

class ConsultationModel extends Consultation {
  ConsultationModel({
    required super.consultId,
    required super.appointType,
    required super.patientId,
    required super.appointHr,
    required super.appointMin,
    required super.appointPurpose,
    required super.appointDate,
    required super.opNumber,
    required super.mobile,
    required super.appointStatus,
    required super.dateOfBirth,
    required super.patientAge,
    required super.sex,
    required super.patientName,
    required super.visitType,
    required super.doctorView,
    required super.visitTypeNew,
    required super.visited,
    required super.doctorVisitType,
  });

  factory ConsultationModel.fromJson(Map<String, dynamic> json) {
    return ConsultationModel(
      consultId: json['consult_id'] ?? 0,
      appointType: json['appoint_type'] ?? '',
      patientId: json['patient_id'] ?? 0,
      appointHr: json['appoint_hr'] ?? '',
      appointMin: json['appoint_min'] ?? '',
      appointPurpose: json['appoint_purpose'] ?? '',
      appointDate: DateTime.tryParse(json['appoint_date'] ?? '') ?? DateTime(1900),
      opNumber: json['op_number'] ?? '',
      mobile: json['mobile'] ?? '',
      appointStatus: json['appoint_status'] ?? '',
      dateOfBirth: DateTime.tryParse(json['date_of_birth'] ?? '') ?? DateTime(1900),
      patientAge: json['patient_age'] ?? 0,
      sex: json['sex'] ?? '',
      patientName: json['patient_name'] ?? '',
      visitType: json['visit_type'] ?? '',
      doctorView: json['doctor_view'] ?? '',
      visitTypeNew: json['visit_type_new'] ?? '',
      visited: json['visited'] ?? '',
      doctorVisitType: json['doctor_visit_type'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'consult_id': consultId,
      'appoint_type': appointType,
      'patient_id': patientId,
      'appoint_hr': appointHr,
      'appoint_min': appointMin,
      'appoint_purpose': appointPurpose,
      'appoint_date': appointDate.toIso8601String(),
      'op_number': opNumber,
      'mobile': mobile,
      'appoint_status': appointStatus,
      'date_of_birth': dateOfBirth.toIso8601String(),
      'patient_age': patientAge,
      'sex': sex,
      'patient_name': patientName,
      'visit_type': visitType,
      'doctor_view': doctorView,
      'visit_type_new': visitTypeNew,
      'visited': visited,
      'doctor_visit_type': doctorVisitType,
    };
  }
}
