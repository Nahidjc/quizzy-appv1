import 'package:flutter/material.dart';
import 'package:quizzy/components/review/multple_answer_result.dart';
import 'package:quizzy/components/review/single_answer_result.dart';

class ResultReviewPage extends StatelessWidget {
  final List<Map<String, dynamic>> quizData;
  final List<dynamic> selectedAnswers;

  const ResultReviewPage({
    Key? key,
    required this.quizData,
    required this.selectedAnswers,
  }) : super(key: key);
  // List<Map<String, dynamic>> quizData = [
  //   {
  //     "question": "What is the capital of Australia?",
  //     "options": ["Sydney", "Melbourne", "Canberra", "Perth"],
  //     "correctAnswer": 2
  //   },
  //   {
  //     "question": "Who painted the Mona Lisa?",
  //     "options": [
  //       "Leonardo da Vinci",
  //       "Vincent van Gogh",
  //       "Pablo Picasso",
  //       "Michelangelo"
  //     ],
  //     "correctAnswer": 0
  //   },
  //   {
  //     "question": "Which of the following are programming paradigms?",
  //     "options": ["Imperative", "Declarative", "Functional", "Procedural"],
  //     "correctAnswers": [0, 1, 2],
  //   },
  //   {
  //     "question": "What is the tallest mountain in the world?",
  //     "options": ["Mount Everest", "K2", "Kangchenjunga", "Makalu"],
  //     "correctAnswer": 0
  //   },
  // ];

  // final List<dynamic> selectedAnswers = [
  //   2,
  //   2,
  //   [0, 1, 3],
  //   4
  // ];

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
            for (int i = 0; i < quizData.length; i++)
              Column(
                children: [
                  if (quizData[i].containsKey('correctAnswer'))
                    SingleCorrectAnswerWidget(
                      questionIndex: i + 1,
                      question: quizData[i]['question'] as String,
                      options: quizData[i]['options'] as List<String>,
                      correctAnswer: quizData[i]['correctAnswer'] as int,
                      selectedAnswer: selectedAnswers[i],
                    ),
                  if (quizData[i].containsKey('correctAnswers'))
                    MultipleCorrectAnswerWidget(
                      questionIndex: i + 1,
                      question: quizData[i]['question'] as String,
                      options: quizData[i]['options'] as List<String>,
                      correctAnswers:
                          quizData[i]['correctAnswers'] as List<int>,
                      selectedAnswers: selectedAnswers[i] as List<int>,
                    ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
