import 'package:flutter/material.dart';
import 'package:quizzy/pages/subject_list_page.dart';

class DataList extends StatelessWidget {
  final List<ListTable> dataList;

  const DataList({super.key, required this.dataList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: null,
        toolbarHeight: 80.0,
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: const Text('SSC',
            style: TextStyle(
                color: Colors.white,
                fontSize: 22.0,
                fontWeight: FontWeight.bold)),
      ),
      body: ListView.builder(
        itemCount: dataList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(3),
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
