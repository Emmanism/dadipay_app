class UserModel {
  final String firstName;
  final String lastName;
  final String middleName;
  final String phoneNumber;
  final String bankingStatus;
  final String vendorCategory;
  final String businessAddress;
  final String homeAddress;
  final String nin;
  final String bvn;
  final String nok;
  final String role;
  final String nokAddress;
  final String nokNumber;
  final String password;
  final String email;
  final String passwordConfirmation;
  final String businessName;

  UserModel({
    required this.firstName,
    required this.lastName,
    required this.middleName,
    required this.phoneNumber,
    required this.bankingStatus,
    required this.vendorCategory,
    required this.businessAddress,
    required this.homeAddress,
    required this.nin,
    required this.bvn,
    required this.nok,
    required this.role,
    required this.nokAddress,
    required this.nokNumber,
    required this.password,
    required this.email,
    required this.passwordConfirmation,
    required this.businessName,
  });

  Map<String, String> toMap() {
    return {
      'firstname': firstName,
      'lastname': lastName,
      'middlename': middleName,
      'phone_number': phoneNumber,
      'banking_status': bankingStatus,
      'vendor_category': vendorCategory,
      'business_address': businessAddress,
      'home_address': homeAddress,
      'NIN': nin,
      'BVN': bvn,
      'NOK': nok,
      'NOK_address': nokAddress,
      'NOK_number': nokNumber,
      'password': password,
      'email': email,
      'password_confirmation': passwordConfirmation,
      'business_name': businessName,
    };
  }
}
