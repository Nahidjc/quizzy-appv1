import 'package:flutter/material.dart';
import 'package:quizzy/pages/home_page.dart';
import 'package:quizzy/pages/leaderboard.dart';
import 'package:quizzy/pages/profile_page.dart';

class BottomNav extends StatefulWidget {
  final int currentIndex;
  const BottomNav({Key? key, this.currentIndex = 3}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      currentIndex: _currentIndex,
      selectedItemColor: Colors.purple,
      unselectedItemColor: Colors.amber,
      onTap: (int index) {
          setState(() {
            if (index == 0 && index != _currentIndex) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
            } else if (index == 1 && index != _currentIndex) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ));
            } else if (index == 2) {
               Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const LeaderboardPage(),
              ));
            } else if (index == 3 && index != _currentIndex) {
              Scaffold.of(context).openEndDrawer();
            }
          });
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.group),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.bar_chart),
          label: 'Leaderboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_rounded),
          label: 'Settings',
        ),
      ],
    );
  }
}
