import 'package:doctors_app/domain/repositories/user_repo.dart';
import 'package:doctors_app/screens/user/user.dart';

class GetUser {
  final UserRepo userRepo;
  GetUser(this.userRepo);
  Future<User?>execute(String email, String password){
    // print("its in get user");
    return userRepo.login(email, password);
  }
}