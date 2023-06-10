import 'package:merostore/mero_store/domain/entities/favorites_editing.dart';

class ChangePasswordModel extends FavoritesEditing{
  ChangePasswordModel({required super.status,required super.message});

  factory ChangePasswordModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordModel(
        status: json['status'],
        message: json['message']);
  }

}