import 'package:flutter/material.dart';
import 'package:quizzy/components/data_list.dart';
import 'package:quizzy/pages/quiz_level.dart';

class ListTable {
  final String title;
  final void Function(BuildContext) onTap;

  const ListTable({
    required this.title,
    required this.onTap,
  });
}

class SubjectList extends StatelessWidget {
  final List<ListTable> dataList = [
    ListTable(
      title: 'Physics',
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizLevelList(),
          ),
        );
      },
    ),
    ListTable(
      title: 'Chemistry',
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizLevelList(),
          ),
        );
      },
    ),
    ListTable(
      title: 'Biology',
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizLevelList(),
          ),
        );
      },
    ),
    ListTable(
      title: 'Math',
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizLevelList(),
          ),
        );
      },
    ),
    ListTable(
      title: 'History',
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizLevelList(),
          ),
        );
      },
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return DataList(dataList: dataList);
  }
}
