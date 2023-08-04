import 'package:flutter/material.dart';
import 'package:quizzy/pages/home_page.dart';
import 'package:quizzy/pages/profile_page.dart';

class BottomNav extends StatefulWidget {
  final int currentIndex;
  const BottomNav({Key? key, this.currentIndex = 0}) : super(key: key);

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
      onTap: (int index) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            // _currentIndex = index;
            if (index == 0 && index != _currentIndex) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const HomePage(),
              ));
            }
            if (index == 1 && index != _currentIndex) {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ));
            } else if (index == 2) {
              Scaffold.of(context).openEndDrawer();
            }
          });
        });
      },
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.menu_rounded),
          label: 'Settings',
        ),
      ],
    );
  }
}
