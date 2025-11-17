import 'package:flutter_bloc/flutter_bloc.dart';
import '../model/home_model.dart';
import '../../domain/usecase/get_homedata.dart';

// ----------------- Events -----------------
abstract class HomeEvent {}

class LoadHomeData extends HomeEvent {
  LoadHomeData();
}

// ----------------- States -----------------
abstract class HomeState {}

class InitHomeState extends HomeState {}

class HomeLoadingState extends HomeState {}

class HomeLoadedState extends HomeState {
  final List<ConsultationModel> homeData;
  HomeLoadedState(this.homeData);
}

class HomeLoadError extends HomeState {
  final String message;
  HomeLoadError(this.message);
}

// ----------------- Bloc -----------------
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetHomeData getHomeData;

  HomeBloc(this.getHomeData) : super(InitHomeState()) {
    on<LoadHomeData>((event, emit) async {
      emit(HomeLoadingState());
      try {
        final homeData = await getHomeData();
        emit(HomeLoadedState(homeData));
      } catch (e) {
        emit(HomeLoadError(e.toString()));
      }
    });
  }
}
