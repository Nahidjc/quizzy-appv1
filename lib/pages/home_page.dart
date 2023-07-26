import 'package:flutter/material.dart';
import 'package:quizzy/components/categories.dart';
import 'package:quizzy/components/header.dart';
import 'package:quizzy/api_caller/categories.dart';
import 'package:quizzy/pages/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    fetchCategoryList();
  }

  List categoryList = [];
  Future<void> fetchCategoryList() async {
    setState(() {
      isLoading = true;
    });
    List<dynamic> levels = await CategoryList().fetchData();
    categoryList = levels;
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const MyAppBar(),
        body: Column(children: [
          Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.fromLTRB(15.0, 20.0, 15, 0.0),
              child: const Text("Competitions Categories",
                  textAlign: TextAlign.start,
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold))),
          Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Categories(categoryList: categoryList))
        ]),
        bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          currentIndex: _currentIndex,
          onTap: (int index) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              setState(() {
                _currentIndex = index;
                if (index == 1) {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => const ProfilePage(),
                  ));
                } else if (index == 2) {}
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
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        ));
  }
}
