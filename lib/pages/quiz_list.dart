import 'package:flutter/material.dart';
import 'package:quizzy/components/data_list.dart';
import 'package:quizzy/pages/quiz_page.dart';
import 'package:quizzy/pages/subject_list_page.dart';

class QuizList extends StatelessWidget {
  final List<ListTable> dataList = [
    ListTable(
      title: 'Quiz-1',
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const QuizPage(),
          ),
        );
      },
    ),
    ListTable(
      title: 'Quiz-2',
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const QuizPage(),
          ),
        );
      },
    ),
    ListTable(
      title: 'Quiz-3',
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const QuizPage(),
          ),
        );
      },
    ),
    ListTable(
      title: 'Quiz-4',
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const QuizPage(),
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
