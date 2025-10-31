import 'package:doctors_app/screens/user/user.dart';


class Usermodel extends User {
  final String userName;
  final String doctorsName;
  final String doctorType;
  final String departmentName;
  final String officeName;

  const Usermodel({
    super.key,
    required this.userName,
    required this.doctorsName,
    required this.doctorType,
    required this.departmentName,
    required this.officeName,
  });

  factory Usermodel.fromJson(Map<String, dynamic> json) {
    return Usermodel(
      userName: json["user_name"] ?? "",
      doctorsName: json["doctors_name"] ?? "",
      doctorType: json["doctor_type"] ?? "",
      departmentName: json["department_name"] ?? "",
      officeName: json["office_Name"] ?? "",
    );
  }
}

