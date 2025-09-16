import 'package:doctors_app/domain/entities/doctor.dart';

abstract class DoctorRepo {
  Future<Doctor?>fetchdata();
}