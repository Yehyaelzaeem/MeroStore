import 'package:merostore/mero_store/domain/entities/home.dart';
import 'package:merostore/mero_store/presentation/screens/home.dart';

class HomeDataModel extends HomeEntities{
  HomeDataModel({required super.status, required super.homeData});

  factory HomeDataModel.fromJson(Map<String, dynamic> json) {
    return HomeDataModel(
      status: json["status"],
      homeData: HomeData.fromJson(json["data"]),
    );
  }
}