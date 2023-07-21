import 'package:flutter/material.dart';
import 'package:quizzy/components/data_list.dart';
import 'package:quizzy/pages/quiz_list.dart';
import 'package:quizzy/pages/subject_list_page.dart';

class QuizLevelList extends StatelessWidget {
  final List<ListTable> dataList = [
    ListTable(
      title: 'Level-1',
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizList(),
          ),
        );
      },
    ),
    ListTable(
      title: 'Level-2',
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizList(),
          ),
        );
      },
    ),
    ListTable(
      title: 'Level-3',
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizList(),
          ),
        );
      },
    ),
    ListTable(
      title: 'Level-4',
      onTap: (BuildContext context) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QuizList(),
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
