// class Patient {
//   final String name;
//   final String mr;
//   final String dob;
//   final String type; 
//   final String nationality;
//   final String city;
//   final int visitcount;
//   final String appointmentDate; 
//   final String appointmentTime; 
//   final String op; 
//   final String mode;
//   final String title; 
//   final String revisit;
//   final bool visited;
//   final List<String> allergies;
//   final List<String> notes;

//   Patient({
//     required this.name,
//     required this.mr,
//     required this.dob,
//     required this.type,
//     required this.nationality,
//     required this.city,
//     required this.visitcount,
//     required this.appointmentDate,
//     required this.appointmentTime,
//     required this.op,
//     required this.mode,
//     required this.title,
//     required this.revisit,
//     required this.visited,
//     required this.allergies,
//     required this.notes
//   });
// }



class Patient {
  final int consultId;
  final String appointType;
  final int patientId;
  final int appointHr;
  final int appointMin;
  final String appointPurpose;
  final String appointDate;
  final String opNumber;
  final String mobile;
  final String appointStatus;
  final String dateOfBirth;
  final int patientAge;
  final String sex;
  final String patientName;
  final String visitType;
  final String doctorView;

  Patient({
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
  });
}