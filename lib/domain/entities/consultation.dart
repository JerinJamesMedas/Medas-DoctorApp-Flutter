class Consultation {
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
  final DateTime dateOfBirth;
  final int patientAge;
  final String sex;
  final String patientName;
  final String visitType;
  final String doctorView;
  final String visitTypeNew;
  final String visited;
  final String doctorVisitType;

  const Consultation({
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
    required this.dateOfBirth,
    required this.patientAge,
    required this.sex,
    required this.patientName,
    required this.visitType,
    required this.doctorView,
    required this.visitTypeNew,
    required this.visited,
    required this.doctorVisitType,
  });
}
