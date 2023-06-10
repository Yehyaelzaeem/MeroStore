class RegisterEntities{
  final bool status;
  final String message;
  final RegisterData? registerData ;

  RegisterEntities({required this.status, this.registerData,required this.message});
}

class RegisterData{
   final int id;
   final String name;
   final String phone;
   final String email;
   final String image;
   final String token;

   RegisterData(
   {
     required this.id,required this.name,required this.phone,
     required this.email,required this.image,required this.token
});

   factory RegisterData.fromJson(Map<String, dynamic> json) {
    return RegisterData(
      id: json["id"],
      name: json["name"],
      phone: json["phone"],
      email: json["email"],
      image: json["image"],
      token: json["token"],
    );
  }

}