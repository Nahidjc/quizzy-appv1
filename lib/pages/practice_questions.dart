import 'package:flutter/material.dart';
import 'package:quizzy/components/practice/practice_multple_answer_result.dart';
import 'package:quizzy/components/review/single_answer_result.dart';
import 'package:quizzy/models/quiz_model.dart';

class PracticeQuestionPage extends StatefulWidget {
  final QuizData quiz;
  const PracticeQuestionPage({Key? key, required this.quiz}) : super(key: key);

  @override
  State<PracticeQuestionPage> createState() => _PracticeQuestionPageState();
}

class _PracticeQuestionPageState extends State<PracticeQuestionPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Result Review'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            for (int i = 0; i < widget.quiz.length; i++)
              Column(
                children: [
                  if (widget.quiz[i].containsKey('correctAnswer'))
                    SingleCorrectAnswerWidget(
                      questionIndex: i + 1,
                      question: widget.quiz[i]['question'] as String,
                      options: widget.quiz[i]['options'] as List<String>,
                      correctAnswer: widget.quiz[i]['correctAnswer'] as int,
                    ),
                  if (widget.quizData[i].containsKey('correctAnswers'))
                    PracticeMultipleCorrectAnswerWidget(
                      questionIndex: i + 1,
                      question: widget.quizData[i]['question'] as String,
                      options: widget.quizData[i]['options'] as List<String>,
                      correctAnswers:
                          widget.quizData[i]['correctAnswers'] as List<int>,
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
