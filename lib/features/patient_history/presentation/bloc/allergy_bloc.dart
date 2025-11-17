import 'package:doctors_app/features/patient_history/domain/usecase/patient_history.dart';
import 'package:doctors_app/features/patient_history/presentation/model/allergy_list_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AllergyEvent{}

class GetAllergyEvent extends AllergyEvent{
  final String patientId;
  GetAllergyEvent(this.patientId);}

  abstract class AllergyState{}
  class AllergyInitial extends AllergyState{}

  class AllergyLoadingState extends AllergyState{}

  class AllergyLoadedState extends AllergyState{
    final List<AllergyListModel> allergyList;
    AllergyLoadedState(this.allergyList);}

  class AllergyErrorState extends AllergyState{
    final String message;
    AllergyErrorState(this.message);}

    class AllergyBloc extends Bloc<AllergyEvent, AllergyState> {
      final GetPatientAllerges allergy;
      AllergyBloc(this.allergy) : super(AllergyInitial()) {
        on<GetAllergyEvent>((event, emit) async {
          emit(AllergyLoadingState());
          try{
            final List<AllergyListModel> allergylist = await allergy.getAllergies(event.patientId);
            emit(AllergyLoadedState(allergylist));
          }catch(e){
            emit(AllergyErrorState(e.toString()));
          }
        });
      }
    }