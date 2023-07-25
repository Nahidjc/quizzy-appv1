import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quizzy/pages/quiz_list.dart';

class QuizLevelList extends StatefulWidget {
  @override
  _QuizLevelListState createState() => _QuizLevelListState();
}

class _QuizLevelListState extends State<QuizLevelList> {
  final List<Map<String, dynamic>> levelList = [
    {'level': 1, 'isUnlocked': true},
    {'level': 2, 'isUnlocked': false},
    {'level': 3, 'isUnlocked': false},
    {'level': 4, 'isUnlocked': false},
    {'level': 5, 'isUnlocked': false},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Levels'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: levelList.map((levelData) {
            int level = levelData['level'];
            bool isUnlocked = levelData['isUnlocked'];

            return buildLevelButton(context, level, isUnlocked);
          }).toList(),
        ),
      ),
    );
  }

  Widget buildLevelButton(BuildContext context, int level, bool isUnlocked) {
    final double buttonWidth = 180.0;
    final double buttonHeight = 60.0;
    final double borderRadius = 10.0;
    final EdgeInsetsGeometry buttonPadding =
        EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0);
    final Color unlockedColor = Colors.teal;
    final Color lockedColor = Colors.purple;
    final Color textColor = Colors.white;
    final Color boxShadowColor = Colors.black.withOpacity(0.3);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          if (isUnlocked) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizList(),
              ),
            );
          } else {
            QuickAlert.show(
              context: context,
              type: QuickAlertType.info,
              title: "Level is locked",
              text:
                  'This level is locked. Subscribe to unlock more levels and enhance your quiz experience!',
            );
          }
        },
        child: Container(
          width: buttonWidth,
          height: buttonHeight,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                color: boxShadowColor,
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 2),
              ),
            ],
            color: isUnlocked
                ? unlockedColor
                : lockedColor, // Use different colors for unlocked and locked levels
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Level $level',
                    style: TextStyle(
                      color: textColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!isUnlocked)
                    Icon(
                      Icons.lock,
                      color: textColor,
                      size: 24.0,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
