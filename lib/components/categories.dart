import 'package:flutter/material.dart';
import 'package:quizzy/pages/quiz_page.dart';

class Category {
  final String name;
  final Color color;
  final IconData icon;
  final void Function(BuildContext) onTap;

  const Category({
    required this.name,
    required this.color,
    required this.icon,
    required this.onTap,
  });
}

class Categories extends StatelessWidget {
  Categories({Key? key}) : super(key: key);

  final List<Category> categories = [
    Category(
      name: 'Technical',
      color: Colors.blue,
      icon: Icons.code,
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const QuizPage(),
          ),
        );
      },
    ),
    Category(
      name: 'Arts',
      color: Colors.green,
      icon: Icons.balance,
      onTap: (BuildContext context) {
        // Handle 'Arts' category tapped
      },
    ),
    Category(
      name: 'UI/UX',
      color: Colors.orange,
      icon: Icons.design_services,
      onTap: (BuildContext context) {
        // Handle 'UI/UX' category tapped
      },
    ),
    Category(
      name: 'Sports',
      color: Colors.teal,
      icon: Icons.sports_soccer,
      onTap: (BuildContext context) {
        // Handle 'Sports' category tapped
      },
    ),
    Category(
      name: 'GK',
      color: Colors.blue,
      icon: Icons.school,
      onTap: (BuildContext context) {
        // Handle 'GK' category tapped
      },
    ),
    Category(
      name: 'Science',
      color: Colors.green,
      icon: Icons.science,
      onTap: (BuildContext context) {
        // Handle 'Science' category tapped
      },
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          Category category = categories[index];
          return GestureDetector(
            onTap: () => category.onTap(context),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category.icon,
                    size: 48.0,
                    color: category.color,
                  ),
                  const SizedBox(height: 8.0),
                  Center(
                    child: Text(
                      category.name,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
