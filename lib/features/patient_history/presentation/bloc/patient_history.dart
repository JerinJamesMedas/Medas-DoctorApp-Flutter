abstract class PatientHistoryEvent {}

class FetchPatientHistory extends PatientHistoryEvent {}

class PatientHistoryState {}

class PatientHistoryInitial extends PatientHistoryState {}

class PatientHistoryLoading extends PatientHistoryState {}

class PatientHistoryLoaded extends PatientHistoryState {
  final List<dynamic> patientHistory;
  PatientHistoryLoaded({required this.patientHistory});
}

class PatientHistoryError extends PatientHistoryState {
  final String message;
  PatientHistoryError({required this.message});
}




