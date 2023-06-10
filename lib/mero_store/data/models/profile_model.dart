import 'package:merostore/mero_store/domain/entities/get_profile.dart';

class ProfileModel extends GetProfile{
  ProfileModel({required super.status, required super.profileData});

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
        status: json['status'],
        profileData: ProfileData.fromJson(json['data']));
  }
  
}