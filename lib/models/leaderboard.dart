class Leaderboard {
  final int totalPoints;
  final String userId;
  final String firstName;

  Leaderboard({
    required this.totalPoints,
    required this.userId,
    required this.firstName,
  });

  factory Leaderboard.fromJson(Map<String, dynamic> json) {
    return Leaderboard(
      totalPoints: json['totalPoints'] as int,
      userId: json['userId'] as String,
      firstName: json['firstName'] as String,
    );
  }
}
