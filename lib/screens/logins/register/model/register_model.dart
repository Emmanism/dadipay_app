class RegisterModel {
  String firstName;
  String lastName;
  String email;
  String phoneNumber;
  String userName;
  String password;
  String passwordConfirmation;

  RegisterModel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.userName,
      required this.password,
      required this.passwordConfirmation});

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'user_name': userName,
      'phone_number': phoneNumber,
      'password': password,
      'password_confirmation': passwordConfirmation,
    };
  }
}
