import 'package:flutter/material.dart';
import 'package:quizzy/pages/quiz_result.dart';
import 'dart:async';
import 'package:quizzy/utils/quiz_points.dart';
import 'package:quizzy/pages/quiz_category.dart';
import 'package:quizzy/widget/circular_progress.dart';

class QuizPage extends StatefulWidget {
  final Category category;
  const QuizPage({Key? key, required this.category}) : super(key: key);

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Map<String, dynamic>> quizData = [
    {
      "question": "Which of the following are programming paradigms?",
      "options": ["Imperative", "Declarative", "Functional", "Procedural"],
      "correctAnswers": [0, 1, 2],
    },
    {
      "question": "What is the capital of Australia?",
      "options": ["Sydney", "Melbourne", "Canberra", "Perth"],
      "correctAnswer": 2
    },
    {
      "question": "What is the chemical symbol for gold?",
      "options": ["Au", "Ag", "Fe", "Cu"],
      "correctAnswer": 0
    },
    {
      "question": "Which planet is known as the Red Planet?",
      "options": ["Mars", "Venus", "Jupiter", "Mercury"],
      "correctAnswer": 0
    },
    {
      "question": "Who wrote the novel 'To Kill a Mockingbird'?",
      "options": [
        "Harper Lee",
        "Jane Austen",
        "F. Scott Fitzgerald",
        "George Orwell"
      ],
      "correctAnswer": 0
    },
  ];

  Map<int, dynamic> selectedAnswers = {};
  int score = 0;
  int points = 0;
  bool isSubmitting = false;
  int timeRemaining = 100;
  Timer? timer;
  int currentQuestionIndex = 0;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (timeRemaining > 0) {
          timeRemaining--;
        } else {
          timer.cancel();
          submitQuiz();
        }
      });
    });
  }

  void submitQuiz() {
    timer?.cancel();
    setState(() {
      isSubmitting = true;
    });

    Future.delayed(const Duration(seconds: 3), () {
      int correctAnswers = 0;
      for (int i = 0; i < quizData.length; i++) {
        final question = quizData[i];
        final selectedAnswer = selectedAnswers[i];

        if (question.containsKey('correctAnswer')) {
          final correctAnswer = question['correctAnswer'];
          if (selectedAnswer == correctAnswer) {
            correctAnswers++;
          }
        } else if (question.containsKey('correctAnswers')) {
          final correctAnswersList = question['correctAnswers'];
          if (selectedAnswer != null &&
              selectedAnswer.length == correctAnswersList.length &&
              selectedAnswer.toSet().containsAll(correctAnswersList)) {
            correctAnswers++;
          }
        }
      }
      selectedAnswers = {};

      final quizPoint = QuizPoints();
      int quizpoint = quizPoint.calculatePoints(
          correctAnswers, timeRemaining, quizData.length);
      setState(() {
        score = correctAnswers;
        points = quizpoint;
        isSubmitting = false;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QuizResultPage(
              quizLength: quizData.length,
              correctAnswers: correctAnswers,
              percentage: (correctAnswers / quizData.length) * 100),
        ),
      );
    });
  }

  void nextQuestion() {
    if (currentQuestionIndex < quizData.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    }
  }

  void previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
      });
    }
  }

  bool allQuestionsAnswered = false;
  bool checkAllQuestionsAnswered() {
    for (var i = 0; i < quizData.length; i++) {
      if (selectedAnswers[i] == null) {
        return false;
      }
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = quizData[currentQuestionIndex];
    final dynamic options = currentQuestion['options'];

    List<dynamic> getOptions() {
      if (options is List<dynamic>) {
        return options;
      } else if (options is int) {
        return List.generate(options, (index) => index.toString());
      } else {
        return [];
      }
    }

    final List<dynamic> questionOptions = getOptions();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Page'),
      ),
      body: isSubmitting
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleProgressBar(
                      timeRemaining: timeRemaining,
                      strokeWidth: 10.0,
                      radius: 50.0,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Question ${currentQuestionIndex + 1}: ${currentQuestion['question']}',
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  // Text('Question ${currentQuestionIndex + 1}'),
                  // Text(
                  //   currentQuestion['question'],
                  //   style: const TextStyle(fontSize: 20),
                  //   textAlign: TextAlign.center,
                  // ),
                  const SizedBox(height: 20),
                  if (currentQuestion.containsKey('correctAnswers'))
                    MultipleCorrectAnswerQuestionWidget(
                      options: questionOptions,
                      selectedAnswers:
                          selectedAnswers[currentQuestionIndex] ?? [],
                      onAnswerSelected: (selectedOptions) {
                        setState(() {
                          selectedAnswers[currentQuestionIndex] =
                              selectedOptions;
                          allQuestionsAnswered = checkAllQuestionsAnswered();
                        });
                      },
                    )
                  else
                    SingleCorrectAnswerQuestionWidget(
                      options: questionOptions,
                      selectedAnswer: selectedAnswers[currentQuestionIndex],
                      onAnswerSelected: (selectedOption) {
                        setState(() {
                          selectedAnswers[currentQuestionIndex] =
                              selectedOption;
                          allQuestionsAnswered = checkAllQuestionsAnswered();
                        });
                      },
                    ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (currentQuestionIndex > 0)
                        ElevatedButton(
                          onPressed: previousQuestion,
                          child: const Text('Previous'),
                        ),
                      const SizedBox(width: 20),
                      if (currentQuestionIndex < quizData.length - 1)
                        ElevatedButton(
                          onPressed: nextQuestion,
                          child: const Text('Next'),
                        ),
                      const SizedBox(width: 20),
                      if (allQuestionsAnswered)
                        ElevatedButton(
                          onPressed: submitQuiz,
                          child: const Text('Submit Quiz'),
                        ),
                    ],
                  )
                ],
              ),
            ),
    );
  }
}

class SingleCorrectAnswerQuestionWidget extends StatelessWidget {
  final List<dynamic> options;
  final dynamic selectedAnswer;
  final ValueChanged<dynamic> onAnswerSelected;

  const SingleCorrectAnswerQuestionWidget({
    Key? key,
    required this.options,
    required this.selectedAnswer,
    required this.onAnswerSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(options.length, (index) {
        return ListTile(
          title: Text(options[index]),
          leading: Radio(
            value: index,
            groupValue: selectedAnswer,
            onChanged: (value) {
              onAnswerSelected(value);
            },
          ),
        );
      }),
    );
  }
}

class MultipleCorrectAnswerQuestionWidget extends StatelessWidget {
  final List<dynamic> options;
  final List<dynamic> selectedAnswers;
  final ValueChanged<List<dynamic>> onAnswerSelected;

  const MultipleCorrectAnswerQuestionWidget({
    required this.options,
    required this.selectedAnswers,
    required this.onAnswerSelected,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(options.length, (index) {
        return ListTile(
          title: Text(options[index]),
          leading: Checkbox(
            value: selectedAnswers.contains(index),
            onChanged: (value) {
              List<dynamic> updatedAnswers = List.from(selectedAnswers);
              if (value == true) {
                updatedAnswers.add(index);
              } else {
                updatedAnswers.remove(index);
              }
              onAnswerSelected(updatedAnswers);
            },
          ),
        );
      }),
    );
  }
}
