import 'package:doctors_app/screens/user/user.dart';

abstract class UserRepo {
  Future<User?>login(String email, String password);
}
