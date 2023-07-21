import 'package:flutter/material.dart';
import 'package:breadcrumbs/breadcrumbs.dart';
import 'package:quizzy/pages/subject_list_page.dart';

class DataList extends StatelessWidget {
  final List<ListTable> dataList;

  const DataList({super.key, required this.dataList});

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
