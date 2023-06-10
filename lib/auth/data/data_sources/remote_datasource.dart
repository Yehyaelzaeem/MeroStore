import 'package:merostore/auth/data/models/change_password.dart';
import 'package:merostore/auth/data/models/login_model.dart';
import 'package:merostore/auth/data/models/register_model.dart';
import 'package:merostore/auth/presentation/bloc/cubit.dart';
import 'package:merostore/core/network/apis.dart';
import 'package:merostore/core/network/dio.dart';

abstract class BaseAuthDataSource{
  Future login(String email,String password,context);
  Future register(String name,String phone,String email,String password,String image);
  Future updateProfile(String name,String phone,String email);
  Future changePassword(String password,String oldPassword);


}

class AuthDataSource implements BaseAuthDataSource{

  @override
  Future<LoginModel> login(String email, String password,context) async {
    AuthCubit.get(context).loginLoadingStates();
    var res = await DioHelper.postData(url: AppApis.login, data: {'email':email, 'password':password,},);
   if(res.statusCode==200){
     AuthCubit.get(context).loginSuccessStates(LoginModel.fromJson(res.data));
       return LoginModel.fromJson(res.data);
   }
   else{
    AuthCubit.get(context).loginErrorStates(LoginModel.fromJson(res.data),context);
     throw 'Error';
   }

    }

  @override
  Future<RegisterModel> register(String name, String phone, String email, String password, String image)async {
    var res = await DioHelper.postData(url: AppApis.register, data: {
      'name':name,
      'phone':phone,
      'email':email,
      'password':password,
      'image':image,
    },);
    if(res.statusCode==200){
      return RegisterModel.fromJson(res.data);
    }
    else{
      throw 'Error';
    }
  }
 @override
  Future<RegisterModel> updateProfile(String name, String phone, String email)async {
    var res = await DioHelper.putData(url: AppApis.updateProfile, data: {
      'name':name,
      'phone':phone,
      'email':email,
    },);
    if(res.statusCode==200){
      return RegisterModel.fromJson(res.data);
    }
    else{
      throw 'Error';
    }
  }

  @override
  Future<ChangePasswordModel> changePassword(String password, String oldPassword) async{
    var res = await DioHelper.postData(url: AppApis.changePassword, data: {
      "current_password": password,
      "new_password": oldPassword
    });
    if(res.statusCode==200){
      return ChangePasswordModel.fromJson(res.data);
    }
    else {
      throw 'Error';
    }

    }

}

