import 'package:merostore/auth/data/data_sources/remote_datasource.dart';
import 'package:merostore/auth/domain/repositories/base_auth_repo.dart';

class AuthRepo extends BaseAuthRepo{
  final BaseAuthDataSource baseAuthDataSource;

  AuthRepo(this.baseAuthDataSource);

  @override
  Future login(String email, String password,context) async{
   return await baseAuthDataSource.login(email, password,context);
  }

  @override
  Future register(String name, String phone, String email, String password, String image)async {
   return await baseAuthDataSource.register(name, phone, email, password, image);
  }
  @override
  Future updateProfile(String name, String phone, String email,)async {
   return await baseAuthDataSource.updateProfile(name, phone, email);
  }
  @override
  Future changePassword(String password, String oldPassword,)async {
   return await baseAuthDataSource.changePassword(password, oldPassword);
  }
}