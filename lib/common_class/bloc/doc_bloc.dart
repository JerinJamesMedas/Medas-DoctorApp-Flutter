import 'package:doctors_app/domain/usecase/get_doctor.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:doctors_app/domain/entities/doctor.dart';

/// -------- EVENTS --------
abstract class DoctorEvent {}

class LoginDoctorEvent extends DoctorEvent {
}

/// -------- STATES --------
abstract class DoctorState {}

class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

class DoctorLoaded extends DoctorState {
  final Doctor doctor;
  DoctorLoaded(this.doctor);
}

class DoctorError extends DoctorState {
  final String message;
  DoctorError(this.message);
}

/// -------- BLOC --------
class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  final GetDoctor getDoctor;

  DoctorBloc(this.getDoctor) : super(DoctorInitial()) {
    on<LoginDoctorEvent>((event, emit) async {
      emit(DoctorLoading());
      try {
        //print("im at bloc");
        final doctor = await getDoctor.excecute();
        if (doctor != null) {
          emit(DoctorLoaded(doctor));
        } else {
          emit(DoctorError("Invalid credentials"));
        }
      } catch (e) {
        emit(DoctorError("Something went wrong: $e"));
      }
    });
  }
}