import 'package:dio/dio.dart';
import 'package:doctors_app/common_class/bloc/doc_bloc.dart';
import 'package:doctors_app/common_class/bloc/user_bloc.dart';
import 'package:doctors_app/data/datasources/doctor_data.dart';
import 'package:doctors_app/data/datasources/user_data.dart';
import 'package:doctors_app/data/repository/doctor_impl.dart';
import 'package:doctors_app/data/repository/user_impl.dart';
import 'package:doctors_app/domain/repositories/doctor_repo.dart';
import 'package:doctors_app/domain/repositories/patient_repo.dart';
import 'package:doctors_app/domain/repositories/user_repo.dart';
import 'package:doctors_app/domain/use%20case/get_doctor.dart';
import 'package:doctors_app/domain/use%20case/get_user.dart';
import 'package:get_it/get_it.dart';
import 'package:doctors_app/data/datasources/patient_data.dart';
import 'package:doctors_app/data/repository/patient_impl.dart';
import 'package:doctors_app/domain/use%20case/get_patient.dart';
import 'package:doctors_app/common_class/bloc/patient_bloc.dart';

final gi = GetIt.instance;

Future<void> initUser() async{
  
  gi.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSource(gi<Dio>()));
  
  gi.registerLazySingleton<UserRepo>(
    () => UserRepoImpl(gi<UserRemoteDataSource>())
  );

  gi.registerLazySingleton<GetUser>(
    () => GetUser(gi<UserRepo>()),
  );

  gi.registerFactory<UserBloc>(
    () => UserBloc(gi<GetUser>()),
  );
}

Future<void> initDoctor() async{

// Doctor Data source
  gi.registerLazySingleton<DoctorRemoteDataSource>(
    () => DoctorRemoteDataSource(gi<Dio>()),
  );

  // Doctor Repository
  gi.registerLazySingleton<DoctorRepo>(
    () => DoctorRepositoryImpl(gi<DoctorRemoteDataSource>()),
  );

  // Doctor Use case
  gi.registerLazySingleton<GetDoctor>(
    () => GetDoctor(gi<DoctorRepo>()),
  );

  // Doctor Bloc
  gi.registerFactory<DoctorBloc>(
    () => DoctorBloc(gi<GetDoctor>()),
  );


}

Future<void> initPatient() async {
  // External
  gi.registerLazySingleton<Dio>(() => Dio());

  // Data sources
  gi.registerLazySingleton<PatientRemoteDataSource>(
    () => PatientRemoteDataSource(gi<Dio>()),
  );

  // Repository
  gi.registerLazySingleton<PatientRepository>(
    () => PatientRepositoryImpl(gi<PatientRemoteDataSource>()),
  );

  // Use cases
  gi.registerLazySingleton<GetPatients>(
    () => GetPatients(gi<PatientRepository>()),
  );

  // Bloc
  gi.registerFactory<PatientBloc>(
    () => PatientBloc(gi<GetPatients>()),
  );
}
