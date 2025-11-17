import 'package:doctors_app/features/doctor_login/data/remote_datasource/user_data.dart';
import 'package:doctors_app/features/doctor_login/domain/repository/user_repo.dart';
import 'package:doctors_app/screens/user/user.dart';

class UserRepoImpl implements UserRepo {
  final UserRemoteDataSource remotedatasource;
  UserRepoImpl(this.remotedatasource);
  @override
  Future<User?> login(String email, String password) {
    return remotedatasource.login(email, password);
  }
}
