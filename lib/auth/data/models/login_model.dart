import 'package:merostore/auth/domain/entities/login.dart';

class LoginModel extends LoginEntities{
  LoginModel({required super.status, required super.message, required super.userData});

  factory LoginModel.fromJson(Map<String, dynamic> json) {
    return LoginModel(
        status: json['status'],
        message: json['message'],
        userData: json['data'] != null ? UserData.fromJson(json['data']) : null,
    );
  }
  
}

