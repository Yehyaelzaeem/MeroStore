import 'package:merostore/mero_store/domain/entities/favorites.dart';

class FavoritesModel extends FavoritesEntities{
  FavoritesModel({required super.status, required super.getFavoritesBigData});

  factory FavoritesModel.fromJson(Map<String, dynamic> json) {
    return FavoritesModel(
        status: json['status'],
        getFavoritesBigData: GetFavoritesBigData.fromJson(json['data']) );
  }

}