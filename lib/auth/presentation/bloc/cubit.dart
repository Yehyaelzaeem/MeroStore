import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:merostore/auth/data/data_sources/remote_datasource.dart';
import 'package:merostore/auth/data/models/change_password.dart';
import 'package:merostore/auth/data/models/login_model.dart';
import 'package:merostore/auth/data/models/register_model.dart';
import 'package:merostore/auth/data/repositories/login_repo.dart';
import 'package:merostore/auth/domain/repositories/base_auth_repo.dart';
import 'package:merostore/auth/domain/use_cases/auth_usecase.dart';
import 'package:merostore/auth/presentation/bloc/states.dart';
import 'package:merostore/auth/presentation/widgets/widget.dart';
import 'package:merostore/core/shared_preference/shared_preference.dart';
import 'package:merostore/mero_store/presentation/bloc/cubit.dart';

class AuthCubit extends Cubit<AppAuthStates>{

  AuthCubit() : super(AppAuthInitialStates());

  static AuthCubit get(context)=>BlocProvider.of(context);
  var formKey =GlobalKey<FormState>();
  var registerFormKey =GlobalKey<FormState>();
  var updateFormKey =GlobalKey<FormState>();
  var changeFormKey =GlobalKey<FormState>();
  List<LoginModel> listLoginModel=[];
  TextEditingController emailLog =TextEditingController();
  TextEditingController passwordLog =TextEditingController();
  TextEditingController name =TextEditingController();
  TextEditingController phone =TextEditingController();
  TextEditingController email =TextEditingController();
  TextEditingController password =TextEditingController();
  TextEditingController confirmPassword =TextEditingController();
  bool isEye=false;
  bool isEyePassword=false;
  bool isEyeConPassword=false;
  bool isNotLoading=true;
  bool x=false;
  bool y=false;
  RegisterModel? registerModel;
  RegisterModel? updateProfileModel;
  ChangePasswordModel?changePasswordModel;


  void getProfileData(context){
    name.text=  AppCubit.get(context).profileModel!.profileData.name;
    phone.text=   AppCubit.get(context).profileModel!.profileData.phone;
    email.text=  AppCubit.get(context).profileModel!.profileData.email;
    emit(GetUpDataProfileStates());
  }

  void changeEyePassword(){
    isEye =!isEye;
    emit(ChangeEyePasswordStates());
  }
  void changeEyePasswordRegister(){
    isEyePassword =!isEyePassword;
    emit(ChangeEyePasswordStates());
  }
  void changeEyeConPasswordRegister(){
    isEyeConPassword =!isEyeConPassword;
    emit(ChangeEyePasswordStates());
  }

  Future login(String email,String password,context)async{
    listLoginModel.clear();
    BaseAuthDataSource baseAuthDataSource =AuthDataSource();
    BaseAuthRepo baseAuthRepo =AuthRepo(baseAuthDataSource);
    final res =await AuthUseCase(baseAuthRepo).login(email, password,context);
    listLoginModel.add(res);
    emit(LoginGetDataModelStates());
  }

  Future register(String name, String phone, String email, String password, String image,context)async
  {
    BaseAuthDataSource baseAuthDataSource =AuthDataSource();
    BaseAuthRepo baseAuthRepo =AuthRepo(baseAuthDataSource);
    await AuthUseCase(baseAuthRepo).register(name, phone, email, password, image).then((value) => {
      registerModel =value,
      if(registerModel!.status==true){
        emit(RegisterSuccessStates(registerModel!)),
    }else{
        showToast(registerModel!.message, ToastStates.error, context),
        emit(RegisterErrorStates(registerModel!)),
      }
    });
    emit(RegisterWaitingStates());
  }

  Future upDateProfile(String name, String phone, String email,context)async{
    x=true ;
    emit(UpdateProfileWaitingStates());

    BaseAuthDataSource baseAuthDataSource =AuthDataSource();
    BaseAuthRepo baseAuthRepo =AuthRepo(baseAuthDataSource);
    await AuthUseCase(baseAuthRepo).updateProfile(name, phone, email).then((value) => {
      updateProfileModel=value,
      if(updateProfileModel!.status==true){
        x=false ,
        AppCubit.get(context).getProfileData(context),
        emit(UpdateProfileSuccessStates(updateProfileModel!))
      }else{
        showToast(updateProfileModel!.message, ToastStates.error, context),
        x=false ,
        emit(UpdateProfileErrorStates(updateProfileModel!))
      }
    });
    emit(UpdateProfileWaitingStates());

  }
  Future changePassword(String password, String oldPassword,context)async{
    y=true;
    emit(ChangePasswordWaitingStates());
    BaseAuthDataSource baseAuthDataSource =AuthDataSource();
    BaseAuthRepo baseAuthRepo =AuthRepo(baseAuthDataSource);
    await AuthUseCase(baseAuthRepo).changePassword(password, oldPassword).then((value) => {
      changePasswordModel=value,
      if(changePasswordModel!.status==true){
        AppCubit.get(context).getProfileData(context),
        y=true,
    emit(ChangePasswordSuccessStates(changePasswordModel!))
      }else{
        y=true,
        showToast(changePasswordModel!.message, ToastStates.error, context),
        emit(ChangePasswordErrorStates(changePasswordModel!))
      }
    });
    emit(ChangePasswordWaitingStates());

  }




   Future loginLoadingStates()async{
     isNotLoading =false;
    emit(LoginLoadingStates());
  }
  Future loginSuccessStates(LoginModel loginModel)async{
    isNotLoading =true;
    emit(LoginSuccessStates(loginModel));
  }
  Future loginErrorStates(LoginModel loginModel,context)async{
    isNotLoading =true;
    showToast(loginModel.message, ToastStates.error, context);
    emit(LoginErrorStates(loginModel));
  }
  var token='';
  void getToken()async{
    token = await CacheHelper.getDate(key: 'token');
    emit(AppGetTokenStates());
  }

}