import 'package:merostore/auth/domain/repositories/base_auth_repo.dart';

class AuthUseCase {
  final BaseAuthRepo baseAuthRepo;
  AuthUseCase(this.baseAuthRepo);

  Future login(String email,String password,context)async{
    return await baseAuthRepo.login(email, password,context);
  }

  Future register(String name,String phone,String email,String password,String image)async{
    return await baseAuthRepo.register(name, phone, email, password, image);
  }
  Future updateProfile(String name,String phone,String email)async{
    return await baseAuthRepo.updateProfile(name, phone, email);
  }
  Future changePassword(String password,String oldPassword)async{
    return await baseAuthRepo.changePassword(password, oldPassword);
  }
}