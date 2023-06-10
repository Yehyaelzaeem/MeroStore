class GetProfile{
  final bool status;
  ProfileData profileData;
  GetProfile({required this.status,required this.profileData});
}
class ProfileData{
  final int id;
  final String name;
  final String email;
  final String phone;
  final String image;
  final String token;
  final dynamic points;
  final dynamic credit;

  ProfileData({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
    required this.token,
    required this.points,
    required this.credit
});

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      phone: json["phone"],
      image: json["image"],
      token: json["token"],
      points: json["points"],
      credit: json["credit"],
    );
  }
}