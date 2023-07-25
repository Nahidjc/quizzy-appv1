import 'package:flutter/material.dart';
import 'package:quizzy/pages/quiz_page.dart';
import 'package:breadcrumbs/breadcrumbs.dart';

class ListTable {
  final String title;
  final void Function(BuildContext) onTap;

  const ListTable({
    required this.title,
    required this.onTap,
  });
}

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
            TextSpan(text: 'Level-1'),
          ],
          separator: ' > ',
          style: const TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(5.0),
            color: Colors.white,
            child: ListTile(
              onTap: () => dataList[index].onTap(context),
              title: Text(
                dataList[index].title,
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
