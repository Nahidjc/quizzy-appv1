import 'package:flutter/material.dart';
import 'package:quizzy/models/level_model.dart';
import 'package:quizzy/pages/quiz_level.dart';
import 'package:breadcrumbs/breadcrumbs.dart';

class ListTable {
  final String title;
  final void Function(BuildContext) onTap;

  const ListTable({
    required this.title,
    required this.onTap,
  });
}

class SubjectList extends StatelessWidget {
  final List<dynamic> subjectList;
  const SubjectList({super.key, required this.subjectList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        centerTitle: true,
        backgroundColor: Colors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Breadcrumbs(
          crumbs: const [
            TextSpan(text: 'SSC'),
            TextSpan(text: 'Chemistry'),
          ],
          separator: ' > ',
          style: const TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
      body: ListView.builder(
        itemCount: subjectList.length,
        itemBuilder: (context, index) {
          Subject subjects = subjectList[index];
          return Card(
            margin: const EdgeInsets.all(5.0),
            color: Colors.white,
            child: ListTile(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => QuizLevelList(),
                ),
              ),
              title: Text(
                subjects.subjectName,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Colors.black),
              ),
            ),
          );
        },
      ),
    );
  }
}
