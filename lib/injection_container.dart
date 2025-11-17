import 'package:dio/dio.dart';
import 'package:doctors_app/features/patient_history/data/remote_datasource/allergy_remote_data_source.dart';
import 'package:doctors_app/features/patient_history/data/repo_impl/allergy_repo_impl.dart';
import 'package:doctors_app/features/patient_history/domain/repository/allergy_repo.dart';
import 'package:doctors_app/features/patient_history/domain/usecase/patient_history.dart';
import 'package:doctors_app/features/patient_history/presentation/bloc/allergy_bloc.dart';
import 'package:get_it/get_it.dart';

// Data Sources
import 'package:doctors_app/features/doctor_login/data/remote_datasource/user_data.dart';
import 'package:doctors_app/data/datasources/doctor_data.dart';
import 'package:doctors_app/data/datasources/patient_data.dart';
import 'package:doctors_app/features/home/data/remotedataSource/home_data.dart';

// Repositories
import 'package:doctors_app/features/doctor_login/data/repo_impl/user_impl.dart';
import 'package:doctors_app/data/repository/doctor_impl.dart';
import 'package:doctors_app/data/repository/patient_impl.dart';
import 'package:doctors_app/features/home/data/repoimpl/home_impl.dart';

// Domain Interfaces
import 'package:doctors_app/features/doctor_login/domain/repository/user_repo.dart';
import 'package:doctors_app/domain/repositories/doctor_repo.dart';
import 'package:doctors_app/domain/repositories/patient_repo.dart';
import 'package:doctors_app/features/home/domain/repository/homedata_repo.dart';

// Use Cases
import 'package:doctors_app/features/doctor_login/domain/usecase/get_user.dart';
import 'package:doctors_app/domain/usecase/get_doctor.dart';
import 'package:doctors_app/domain/usecase/get_patient.dart';
import 'package:doctors_app/features/home/domain/usecase/get_homedata.dart';

// Blocs
import 'package:doctors_app/features/doctor_login/presentation/bloc/user_bloc.dart';
import 'package:doctors_app/common_class/bloc/doc_bloc.dart';
import 'package:doctors_app/common_class/bloc/patient_bloc.dart';
import 'package:doctors_app/features/home/presentation/bloc/homeBlock.dart';

final gi = GetIt.instance;

Future<void> initDependencies() async {
  // Core
  gi.registerLazySingleton<Dio>(() => Dio());

  // ------------------ USER ------------------
  gi.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSource(gi<Dio>()),
  );
  gi.registerLazySingleton<UserRepo>(
    () => UserRepoImpl(gi<UserRemoteDataSource>()),
  );
  gi.registerLazySingleton<GetUser>(
    () => GetUser(gi<UserRepo>()),
  );
  gi.registerFactory<UserBloc>(
    () => UserBloc(gi<GetUser>()),
  );

  // ------------------ DOCTOR ------------------
  gi.registerLazySingleton<DoctorRemoteDataSource>(
    () => DoctorRemoteDataSource(gi<Dio>()),
  );
  gi.registerLazySingleton<DoctorRepo>(
    () => DoctorRepositoryImpl(gi<DoctorRemoteDataSource>()),
  );
  gi.registerLazySingleton<GetDoctor>(
    () => GetDoctor(gi<DoctorRepo>()),
  );
  gi.registerFactory<DoctorBloc>(
    () => DoctorBloc(gi<GetDoctor>()),
  );

  // ------------------ PATIENT ------------------
  gi.registerLazySingleton<PatientRemoteDataSource>(
    () => PatientRemoteDataSource(gi<Dio>()),
  );
  gi.registerLazySingleton<PatientRepository>(
    () => PatientRepositoryImpl(gi<PatientRemoteDataSource>()),
  );
  gi.registerLazySingleton<GetPatients>(
    () => GetPatients(gi<PatientRepository>()),
  );
  gi.registerFactory<PatientBloc>(
    () => PatientBloc(gi<GetPatients>()),
  );

  // ------------------ HOME ------------------
  gi.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSource(gi<Dio>()),
  );
  gi.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(gi<HomeRemoteDataSource>()),
  );
  gi.registerLazySingleton<GetHomeData>(
    () => GetHomeData(gi<HomeRepository>()),
  );
  gi.registerFactory<HomeBloc>(
    () => HomeBloc(gi<GetHomeData>()),
  );



//-------------------- Patient History ------------------

     // -------------- patient Allergies ------------------

     gi.registerLazySingleton<AllergyRemoteDataSource>(()=> AllergyRemoteDataSource(gi<Dio>()));
     gi.registerLazySingleton<AllergyRepo>(() => AllergyRepoImpl(gi<AllergyRemoteDataSource>()));
     gi.registerLazySingleton<GetPatientAllerges>(()=> GetPatientAllerges(gi<AllergyRepo>()));
     gi.registerFactory<AllergyBloc>(()=> AllergyBloc(gi<GetPatientAllerges>()));


}
