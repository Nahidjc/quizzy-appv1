import 'package:flutter/material.dart';
import 'package:quizzy/pages/quiz_page.dart';

class Category {
  final String name;
  final Color color;
  final IconData icon;

  const Category({
    required this.name,
    required this.color,
    required this.icon,
  });
}

class CategoryPage extends StatelessWidget {
  CategoryPage({Key? key}) : super(key: key);
  final List<Category> categories = [
    const Category(
      name: 'Technical',
      color: Colors.blue,
      icon: Icons.code,
    ),
    const Category(
      name: 'Digital Marketing',
      color: Colors.green,
      icon: Icons.balance,
    ),
    const Category(
      name: 'UI/UX',
      color: Colors.orange,
      icon: Icons.design_services,
    ),
    const Category(
      name: 'Sports',
      color: Colors.teal,
      icon: Icons.sports_soccer,
    ),
    const Category(
      name: 'GK',
      color: Colors.blue,
      icon: Icons.school,
    ),
    const Category(
      name: 'Science',
      color: Colors.green,
      icon: Icons.science,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz Categories',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.2,
            color: Colors.orange,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(color: Colors.black12),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: categories.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          Category category = categories[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizPage(category: category),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                color: category.color,
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
                    color: Colors.white,
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    category.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
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

class QuestionSetPage extends StatelessWidget {
  final Category category;

  const QuestionSetPage({
    Key? key,
    required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.name),
      ),
      body: Center(
        child: Text('Questions for ${category.name} category'),
      ),
    );
  }
}
