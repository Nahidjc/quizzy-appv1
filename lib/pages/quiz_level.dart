import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';
import 'package:quizzy/api_caller/stage.dart';
import 'package:quizzy/pages/login_page.dart';
import 'package:quizzy/pages/quiz_list.dart';
import 'package:breadcrumbs/breadcrumbs.dart';
import 'package:quizzy/provider/login_provider.dart';

import 'package:panara_dialogs/panara_dialogs.dart';

class QuizLevelList extends StatefulWidget {
  final String subjectName;
  final String displayName;
  final String subjectId;
  const QuizLevelList(
      {super.key,
      required this.subjectName,
      required this.displayName,
      required this.subjectId});
  @override
  State<QuizLevelList> createState() => _QuizLevelListState();
}

class _QuizLevelListState extends State<QuizLevelList> {
  final StageList _stageList = StageList();
  final AuthProvider authState = AuthProvider();
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

  Future<void> _stageSubscribe(String userId, String stageId) async {
    setState(() {
      isLoading = true;
    });
    try {
      await _stageList.subscribeStage(userId, stageId);
      await authState.userDetails(userId);
      _fetchStages();
      setState(() {
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
    final user = Provider.of<AuthProvider>(context);

    if (!user.isAuthenticated) {
      return const LoginPage();
    }
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: _stages.map((levelData) {
                  String levelName = levelData.levelName;
                  bool isUnlocked = levelData.isAccessible;
                  String stageId = levelData.id;
                  int cost = levelData.cost;
                  return buildLevelButton(
                      context, levelName, isUnlocked, stageId, cost);
                }).toList(),
              ),
      ),
    );
  }

  Widget buildLevelButton(BuildContext context, String levelName,
      bool isUnlocked, String stageId, int cost) {
    final user = Provider.of<AuthProvider>(context);
    const double buttonWidth = 180.0;
    const double buttonHeight = 60.0;
    const double borderRadius = 10.0;
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
                    levelName: levelName,
                    subjectId: widget.subjectId,
                    stageId: stageId),
              ),
            );
          } else {
            PanaraConfirmDialog.show(
              context,
              title: "Level is locked",
              message: "To unlock this level, you need to pay $cost coin.",
              confirmButtonText: "Unlock",
              cancelButtonText: "Cancel",
              onTapCancel: () {
                Navigator.pop(context);
              },
              onTapConfirm: () {
                Navigator.pop(context);
                if (user.coin < cost) {
                  QuickAlert.show(
                    context: context,
                    type: QuickAlertType.warning,
                    text: "You don't have enough coins to unlock this level",
                  );
                } else {
                  _stageSubscribe(user.userId, stageId);
                }
              },
              panaraDialogType: PanaraDialogType.normal,
              barrierDismissible: false,
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
            color: isUnlocked ? unlockedColor : lockedColor,
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
