import 'package:merostore/mero_store/domain/entities/get_categories.dart';

class CategoriesModel extends GetCategoriesEntities{
  CategoriesModel({required super.status, required super.getCategoriesData});

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
        status: json['status'],
        getCategoriesData:GetCategoriesData.fromJson(json['data']) ,
    );
  }

}