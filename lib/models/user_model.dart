class UserDetails {
  final String token;
  final String name;
  final int coin;

  UserDetails({required this.token, required this.name, required this.coin});

  factory UserDetails.fromJson(Map<String, dynamic> json) {
    return UserDetails(
      token: json['token'],
      name: json['name'],
      coin: json['coin'],
    );
  }
}
