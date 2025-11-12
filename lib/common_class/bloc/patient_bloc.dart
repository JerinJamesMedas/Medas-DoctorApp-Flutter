import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctors_app/domain/usecase/get_patient.dart';
import '../../../domain/entities/patient.dart';

// ----------------- Events -----------------
abstract class PatientEvent {}

class LoadPatients extends PatientEvent {}

// ----------------- States -----------------
abstract class PatientState {}

class InitPatientState extends PatientState {}

class PatientLoadingState extends PatientState {}

class PatientLoadedState extends PatientState {
  final List<Patient> patients;
  PatientLoadedState(this.patients);
}

class PatientLoadError extends PatientState {}

// ----------------- Bloc -----------------
class PatientBloc extends Bloc<PatientEvent, PatientState> {
  final GetPatients getPatients;

  PatientBloc(this.getPatients) : super(InitPatientState()) {
    on<LoadPatients>((event, emit) async {
      emit(PatientLoadingState());
      try {
        final patients = await getPatients();
        emit(PatientLoadedState(patients));
      } catch (e) {
        emit(PatientLoadError());
       // print("Error loading patients: $e");
      }
    });
  }
}
