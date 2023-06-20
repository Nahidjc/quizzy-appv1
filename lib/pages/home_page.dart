import 'package:flutter/material.dart';
import 'package:quizzy/components/bottom-navigation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(),
      bottomNavigationBar: BottomNav(),
    );
  }
}