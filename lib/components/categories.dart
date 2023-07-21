import 'package:flutter/material.dart';
import 'package:quizzy/components/data_list.dart';
import 'package:quizzy/pages/subject_list_page.dart';
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
      name: 'PSC',
      color: Colors.blue,
      icon: Icons.school,
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
      name: 'JSC',
      color: Colors.green,
      icon: Icons.school,
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubjectList(),
          ),
        );
      },
    ),
    Category(
      name: 'SSC',
      color: Colors.orange,
      icon: Icons.school,
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubjectList(),
          ),
        );
      },
    ),
    Category(
      name: 'HSC',
      color: Colors.teal,
      icon: Icons.school,
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubjectList(),
          ),
        );
      },
    ),
    Category(
      name: 'BCS',
      color: Colors.blue,
      icon: Icons.school,
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubjectList(),
          ),
        );
      },
    ),
    Category(
      name: 'Science',
      color: Colors.green,
      icon: Icons.science,
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SubjectList(),
          ),
        );
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
