import 'package:flutter/material.dart';
import 'package:quizzy/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = ThemeData.light().textTheme.copyWith(
          bodyLarge: const TextStyle(
            fontFamily: 'Roboto',
          ),
          bodyMedium: const TextStyle(
            fontFamily: 'Roboto',
          ),
        );

    return MaterialApp(
      title: 'Demo Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        textTheme: textTheme,
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

