import 'package:doctors_app/data/datasources/user_data.dart';
import 'package:doctors_app/domain/repositories/user_repo.dart';
import 'package:doctors_app/screens/user/user.dart';

class UserRepoImpl implements UserRepo {
  final UserRemoteDataSource remotedatasource;
  UserRepoImpl(this.remotedatasource);
  @override
  Future<User?> login(String email, String password) {
    return remotedatasource.login(email, password);
  }
}
