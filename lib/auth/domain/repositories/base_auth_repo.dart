abstract class BaseAuthRepo{
  Future login(String email,String password,context);
  Future register(String name,String phone,String email,String password,String image);
  Future updateProfile(String name,String phone,String email);
  Future changePassword(String password,String oldPassword);


}