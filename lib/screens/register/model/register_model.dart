class UserRegister {
  
  String name;
  String email;
  String password;
  String confirmPassword;
  String phoneNumber;

  UserRegister({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword,
    required this.phoneNumber,
  });

}

class UserLogin {
  
  String email;
  String password;

  UserLogin({
    required this.email,
    required this.password,
  });
}