import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quizzy/api_caller/stage.dart';
import 'package:quizzy/pages/quiz_list.dart';
import 'package:breadcrumbs/breadcrumbs.dart';
import 'package:quizzy/provider/login_provider.dart';

class QuizLevelList extends StatefulWidget {
  final String subjectName;
  final String displayName;
  QuizLevelList(
      {super.key, required this.subjectName, required this.displayName});
  @override
  State<QuizLevelList> createState() => _QuizLevelListState();
}

class _QuizLevelListState extends State<QuizLevelList> {
  final StageList _stageList = StageList();
  List<dynamic> _stages = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _fetchStages();
  }

  Future<void> _fetchStages() async {
    setState(() {
      isLoading = true;
    });
    try {
      String userId = Provider.of<AuthProvider>(context, listen: false).userId;
      List<dynamic> stageData = await _stageList.fetchStage(userId);
      setState(() {
        _stages = stageData;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80.0,
        centerTitle: true,
        backgroundColor: Colors.purple,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Breadcrumbs(
          crumbs: [
            TextSpan(text: widget.displayName),
            TextSpan(text: widget.subjectName),
          ],
          separator: ' > ',
          style: const TextStyle(color: Colors.white, fontSize: 18.0),
        ),
      ),
      body: Center(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
                children: _stages.map((levelData) {
                  String levelName = levelData.levelName;
                  bool isUnlocked = levelData.isAccessible;
                  return buildLevelButton(context, levelName, isUnlocked);
          }).toList(),
        ),
      ),
    );
  }

  Widget buildLevelButton(
      BuildContext context, String levelName, bool isUnlocked) {
    const double buttonWidth = 180.0;
    const double buttonHeight = 60.0;
    const double borderRadius = 10.0;
    const EdgeInsetsGeometry buttonPadding =
        EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0);
    const Color unlockedColor = Colors.teal;
    const Color lockedColor = Colors.purple;
    const Color textColor = Colors.white;
    Color boxShadowColor = Colors.black.withOpacity(0.3);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: InkWell(
        onTap: () {
          if (isUnlocked) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizList(
                    displayName: widget.displayName,
                    subjectName: widget.subjectName,
                    levelName: levelName),
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
                offset: const Offset(0, 2),
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
                    levelName,
                    style: const TextStyle(
                      color: textColor,
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (!isUnlocked)
                    const Icon(
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
