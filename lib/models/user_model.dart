class UserDetails {
  String? firstName;
  String? lastName;
  String? email;
  String? name;
  String? mobileNo;
  String? password;

  UserDetails({
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNo,
    this.password,
  });

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      mobileNo: json['mobileNo'],
      password: json['password'],
    );
  }
}
