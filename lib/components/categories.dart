import 'package:flutter/material.dart';
import 'package:quizzy/pages/subject_list_page.dart';
import 'package:quizzy/models/level_model.dart';

class Categories extends StatelessWidget {
  // Categories({Key? key}) : super(key: key);
  final List<dynamic> categoryList;

  Categories({super.key, required this.categoryList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: categoryList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          QuizLevel category = categoryList[index];
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SubjectList(subjectList: category.subjectList),
              ),
            ),
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
                  const Icon(
                    Icons.school,
                    size: 48.0,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 8.0),
                  Center(
                    child: Text(
                      category.displayName,
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
