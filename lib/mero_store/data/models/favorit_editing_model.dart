import 'package:merostore/mero_store/domain/entities/favorites_editing.dart';

class FavoritesEditingModel extends FavoritesEditing{
  FavoritesEditingModel({required super.status,required super.message});



  factory FavoritesEditingModel.fromJson(Map<String, dynamic> json) {
    return FavoritesEditingModel(
        status: json['status'],
        message: json['message']);
  }

}