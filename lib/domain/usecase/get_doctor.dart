import 'package:doctors_app/domain/entities/doctor.dart';
import 'package:doctors_app/domain/repositories/doctor_repo.dart';

class GetDoctor {
  final DoctorRepo repo;
  GetDoctor(this.repo);

  Future <Doctor?> excecute(){
    // print("im at getdoctor");
    return repo.fetchdata();
  }
}