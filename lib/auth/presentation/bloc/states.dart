import 'package:merostore/auth/data/models/change_password.dart';
import 'package:merostore/auth/data/models/login_model.dart';
import 'package:merostore/auth/data/models/register_model.dart';

abstract class AppAuthStates{}

class  AppAuthInitialStates extends AppAuthStates{}

class  ChangeEyePasswordStates extends AppAuthStates{}
class  GetUpDataProfileStates extends AppAuthStates{}

class  LoginSuccessStates extends AppAuthStates{
  final LoginModel loginModel;
  LoginSuccessStates(this.loginModel);
}
class  LoginLoadingStates extends AppAuthStates{}
class  LoginGetDataModelStates extends AppAuthStates{}
class  AppGetTokenStates extends AppAuthStates{}


class  LoginErrorStates extends AppAuthStates{
  final LoginModel loginModel;
  LoginErrorStates(this.loginModel);
}

//Register
class  RegisterWaitingStates extends AppAuthStates{}
class  RegisterSuccessStates extends AppAuthStates{
  final RegisterModel registerModel ;
  RegisterSuccessStates(this.registerModel);
}
class  RegisterErrorStates extends AppAuthStates{
  final RegisterModel registerModel ;
  RegisterErrorStates(this.registerModel);
}
//Update Profile
class  UpdateProfileWaitingStates extends AppAuthStates{}
class  UpdateProfileSuccessStates extends AppAuthStates{
  final RegisterModel updateProfile ;
  UpdateProfileSuccessStates(this.updateProfile);
}
class  UpdateProfileErrorStates extends AppAuthStates{
  final RegisterModel updateProfile ;
  UpdateProfileErrorStates(this.updateProfile);
}//ChangePassword
class  ChangePasswordWaitingStates extends AppAuthStates{}
class  ChangePasswordSuccessStates extends AppAuthStates{
  final ChangePasswordModel changePasswordModel ;
  ChangePasswordSuccessStates(this.changePasswordModel);
}
class  ChangePasswordErrorStates extends AppAuthStates{
  final ChangePasswordModel changePasswordModel ;
  ChangePasswordErrorStates(this.changePasswordModel);
}
