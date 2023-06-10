import 'package:merostore/auth/domain/entities/register.dart';

class RegisterModel extends RegisterEntities{
  RegisterModel({required super.status, required super.registerData,required super.message});

  factory RegisterModel.fromJson(Map<String, dynamic> json) {
    return RegisterModel(
        status: json['status'], 
        registerData: json['data'] != null ? RegisterData.fromJson(json['data']) : null,
        message: json['message']);
  }
  
}