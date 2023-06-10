class LoginEntities{
  final bool status;
  final String message;
  final UserData?
  userData;

  LoginEntities({
    required this.status,
    required this.message,
    this.userData
});


}

class UserData {
       final int id;
       final String name;
       final String email;
       final String phone;
       final String image;
       final int points;
       final int credit;
       final String token;

       UserData({
         required  this.id,
         required  this.name,
         required this.email,
         required  this.phone,
         required  this.image,
         required  this.points,
         required  this.credit,
         required this.token
});
       factory UserData.fromJson(Map<String, dynamic> json) {
         return UserData(
           id: json["id"],
           name: json["name"],
           email: json["email"],
           phone: json["phone"],
           image: json["image"],
           points: json["points"],
           credit: json["credit"],
           token: json["token"],);
       }

}