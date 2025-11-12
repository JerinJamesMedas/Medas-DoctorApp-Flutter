class Appointment {
  final int consultId;
  final String appointType;
  final int patientId;
  final String appointHr;
  final String appointMin;
  final String appointPurpose;
  final DateTime appointDate;
  final String opNumber;
  final String mobile;
  final String appointStatus;
  final String? dateOfBirth;
  final int patientAge;
  final String sex;
  final String patientName;
  final String visitType;
  final String doctorView;

  Appointment({
    required this.consultId,
    required this.appointType,
    required this.patientId,
    required this.appointHr,
    required this.appointMin,
    required this.appointPurpose,
    required this.appointDate,
    required this.opNumber,
    required this.mobile,
    required this.appointStatus,
    this.dateOfBirth,
    required this.patientAge,
    required this.sex,
    required this.patientName,
    required this.visitType,
    required this.doctorView,
  });

    factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      consultId: json['consult_id'],
      appointType: json['appoint_type'],
      patientId: json['patient_id'],
      appointHr: json['appoint_hr'] ?? '',
      appointMin: json['appoint_min'] ?? '',
      appointPurpose: json['appoint_purpose'] ?? '',
      appointDate: DateTime.parse(json['appoint_date']),
      opNumber: json['op_number'],
      mobile: json['mobile'] ?? '',
      appointStatus: json['appoint_status'] ?? '',
      dateOfBirth: json['date_of_birth'],
      patientAge: json['patient_age'] ?? 0,
      sex: json['sex'] ?? '',
      patientName: json['patient_name'] ?? '',
      visitType: json['visit_type'] ?? '',
      doctorView: json['doctor_view'] ?? '',
    );
  }
}


