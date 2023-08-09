import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quizzy/api_caller/campaign.dart';
import 'package:quizzy/components/bottom-navigation.dart';
import 'package:quizzy/components/campaign/quiz_item.dart';
import 'package:quizzy/components/campaign/skeleton.dart';
import 'package:quizzy/components/custom_drawer.dart';
import 'package:quizzy/models/campaign_quiz.dart';
import 'package:quizzy/provider/login_provider.dart';

class CampaignQuizList extends StatefulWidget {
  final String campaignId;
  const CampaignQuizList({super.key, required this.campaignId});

  @override
  State<CampaignQuizList> createState() => _CampaignQuizListState();
}

class _CampaignQuizListState extends State<CampaignQuizList> {
  late List<CampaignModel> _campaignQuizList;
  final CampaignApi campaignApi = CampaignApi();
  bool isLoading = false;
  // final List<Map<String, dynamic>> quizData = [
  //   {
  //     'title': 'Quiz 1',
  //     'isAttempted': true,
  //     'isCorrect': true,
  //     'points': 10,
  //     'startTime': DateTime.now().subtract(const Duration(minutes: 30)),
  //     'endTime': DateTime.now().add(const Duration(minutes: 30)),
  //   },
  //   {
  //     'title': 'Quiz 2',
  //     'isAttempted': false,
  //     'isCorrect': false,
  //     'points': null,
  //     'startTime': DateTime.now().add(const Duration(minutes: 10)),
  //     'endTime': DateTime.now().add(const Duration(minutes: 40)),
  //   },
  //   {
  //     'title': 'Quiz 3',
  //     'isAttempted': false,
  //     'isCorrect': false,
  //     'points': null,
  //     'startTime': DateTime.now().add(const Duration(minutes: 1)),
  //     'endTime': DateTime.now().add(const Duration(minutes: 2)),
  //   },
  // ];

  @override
  void initState() {
    super.initState();
    _fetchCampaignQuiz();
  }

  Future<void> _fetchCampaignQuiz() async {
    setState(() {
      isLoading = true;
    });
    try {
      String userId = Provider.of<AuthProvider>(context, listen: false).userId;
      List<CampaignModel> campaignQuizList =
          await campaignApi.getCampaignQuiz(widget.campaignId, userId);
      setState(() {
        _campaignQuizList = campaignQuizList;
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
        title: const Text('Campaign Quiz'),
        actions: [Container()],
      ),
      body: isLoading
          ? const SkeletonBoxes()
          : ListView(
              children: _campaignQuizList.map((quiz) {
                return CampaignQuizItem(
                    title: quiz.title,
                    isAttempted: quiz.isAttempted,
                    points: quiz.point,
                    startTime: quiz.startTime,
                    endTime: quiz.endTime,
                    quiz: quiz);
              }).toList(),
            ),
             endDrawer: const CustomDrawer(),
        bottomNavigationBar: const BottomNav()
    );
  }
}
