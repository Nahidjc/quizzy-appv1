import 'package:flutter/material.dart';
import 'package:quizzy/pages/subject_list_page.dart';
import 'package:quizzy/models/level_model.dart';

class Categories extends StatelessWidget {
  final List<dynamic> categoryList;

  const Categories({super.key, required this.categoryList});

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
                builder: (context) => SubjectList(
                    subjectList: category.subjectList,
                    displayName: category.displayName),
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
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        double fontSize = constraints.maxWidth *
                            0.12; // Adjust this factor to control the font size
                        return Text(
                          category.displayName,
                          style: TextStyle(
                            color: const Color.fromARGB(255, 204, 109,
                                251), 
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            fontStyle:
                                FontStyle.italic,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(
                                    0.5), 
                                offset: const Offset(1,
                                    1), 
                                blurRadius:
                                    2.0, 
                              ),
                            ],
                          ),
                        );
                      },
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
