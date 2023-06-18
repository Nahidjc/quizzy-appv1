import 'package:flutter/material.dart';

class LeaderboardPage extends StatefulWidget {
  @override
  _LeaderboardPageState createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {
  List<LeaderboardEntry> todayLeaderboardData = [
    LeaderboardEntry(
      profilePic: 'assets/images/avatar.png',
      name: 'John Doe',
      points: 250,
    ),
    LeaderboardEntry(
      profilePic: 'assets/images/avatar.png',
      name: 'Jane Smith',
      points: 200,
    ),
    LeaderboardEntry(
      profilePic: 'assets/images/avatar.png',
      name: 'David Johnson',
      points: 180,
    ),
  ];

  List<LeaderboardEntry> weeklyLeaderboardData = [
    LeaderboardEntry(
      profilePic: 'assets/images/avatar.png',
      name: 'Emily Brown',
      points: 300,
    ),
    LeaderboardEntry(
      profilePic: 'assets/images/avatar.png',
      name: 'Michael Wilson',
      points: 280,
    ),
    LeaderboardEntry(
      profilePic: 'assets/images/avatar.png',
      name: 'Sarah Davis',
      points: 260,
    ),
    LeaderboardEntry(
      profilePic: 'assets/images/avatar.png',
      name: 'John Smith',
      points: 240,
    ),
    LeaderboardEntry(
      profilePic: 'assets/images/avatar.png',
      name: 'Jennifer Johnson',
      points: 220,
    ),
    LeaderboardEntry(
      profilePic: 'assets/images/avatar.png',
      name: 'David Brown',
      points: 200,
    ),
    LeaderboardEntry(
      profilePic: 'assets/images/avatar.png',
      name: 'Jessica Taylor',
      points: 180,
    ),
    LeaderboardEntry(
      profilePic: 'assets/images/avatar.png',
      name: 'Andrew Davis',
      points: 160,
    ),
    LeaderboardEntry(
      profilePic: 'assets/images/avatar.png',
      name: 'Sophia Wilson',
      points: 140,
    ),
    LeaderboardEntry(
      profilePic: 'assets/images/avatar.png',
      name: 'James Smith',
      points: 120,
    ),
  ];

  late List<LeaderboardEntry> currentLeaderboardData;

  bool showTodayLeaderboard = true;

  @override
  void initState() {
    super.initState();
    currentLeaderboardData = todayLeaderboardData;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Leaderboard'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLeaderboardOption('Today', showTodayLeaderboard),
                const SizedBox(width: 10),
                _buildLeaderboardOption('Weekly', !showTodayLeaderboard),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // SizedBox(
                //   height: 20,
                //   child: Text(
                //     'Top Performers',
                //     style: TextStyle(
                //       fontSize: 18,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                // ),
                _buildTopPerformers(),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildLeaderboardOption(String title, bool isSelected) {
    return GestureDetector(
      onTap: () {
        setState(() {
          showTodayLeaderboard = title == 'Today';
          currentLeaderboardData = showTodayLeaderboard
              ? todayLeaderboardData
              : weeklyLeaderboardData;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? Colors.blue : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTopPerformers() {
    return Container(
      child: Column(
        children: currentLeaderboardData
            .sublist(0, currentLeaderboardData.length)
            .asMap()
            .entries
            .map((entry) => _buildTopPerformerRow(
                  entry.key + 1,
                  entry.value.profilePic,
                  entry.value.name,
                  entry.value.points,
                ))
            .toList(),
      ),
    );
  }

  Widget _buildTopPerformerRow(
      int position, String profilePic, String name, int points) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.grey, width: 1.5),
            ),
            padding: const EdgeInsets.all(2),
            child: CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(profilePic),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  '$points Points',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
          Text(
            '$position' + _getOrdinalIndicator(position),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  String _getOrdinalIndicator(int number) {
    if (number % 10 == 1 && number % 100 != 11) {
      return 'st';
    } else if (number % 10 == 2 && number % 100 != 12) {
      return 'nd';
    } else if (number % 10 == 3 && number % 100 != 13) {
      return 'rd';
    } else {
      return 'th';
    }
  }
}

class LeaderboardEntry {
  final String profilePic;
  final String name;
  final int points;

  LeaderboardEntry({
    required this.profilePic,
    required this.name,
    required this.points,
  });
}
