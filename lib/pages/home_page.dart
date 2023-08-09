import 'package:flutter/material.dart';
import 'package:quizzy/api_caller/categories.dart';
import 'package:quizzy/components/bottom-navigation.dart';
import 'package:quizzy/components/category/categories.dart';
import 'package:quizzy/components/category/category_skeleton.dart';
import 'package:quizzy/components/custom_drawer.dart';
import 'package:quizzy/components/header.dart';
import 'package:quizzy/components/slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            margin: const EdgeInsets.fromLTRB(15.0, 20.0, 15, 0.0),
            child: const Text(
              "Competitions Categories",
              textAlign: TextAlign.start,
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: isLoading
                ? const CategorySkeleton()
                : Categories(categoryList: categoryList),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.16,
            child: CarouselSliderCustom(),
          ),
        ],
      ),
      endDrawer: const CustomDrawer(),
      bottomNavigationBar: const BottomNav(
        currentIndex: 0,
      ),
    );
  }
}
