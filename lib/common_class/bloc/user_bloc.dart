import 'package:doctors_app/domain/use%20case/get_user.dart';
import 'package:doctors_app/screens/user/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class Userevent{}

class LoginUserEvent extends Userevent{
final  String email;
final  String password;
  LoginUserEvent(this.email, this.password);
}

abstract class Userstate{}

class Userinitial extends Userstate{}

class UserLoading extends Userstate{}

class UserLoaded extends Userstate{
  final User user;
  UserLoaded(this.user);
}

class UserError extends Userstate{
  final String msg;
  UserError(this.msg);
}

class UserBloc extends Bloc<Userevent,Userstate>{
  final GetUser loginUser;
  UserBloc(this.loginUser) :super(Userinitial()){
    on<LoginUserEvent>((event, emit) async{
      emit(UserLoading());
      try{
        final user = await loginUser.execute(event.email, event.password);
        if(user != null){
          emit(UserLoaded(user));
        
        }else{
          emit(UserError("invalid credentials"));
        }
      }catch(e){
        emit(UserError("Something went wrong: $e"));
      }
    });
  }
}