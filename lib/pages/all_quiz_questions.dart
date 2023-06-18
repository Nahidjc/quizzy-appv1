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
      "question": "What is the capital of Australia?",
      "options": ["Sydney", "Melbourne", "Canberra", "Perth"],
      "correctAnswer": 2
    },
    {
      "question": "Who painted the Mona Lisa?",
      "options": [
        "Leonardo da Vinci",
        "Vincent van Gogh",
        "Pablo Picasso",
        "Michelangelo"
      ],
      "correctAnswer": 0
    },
    {
      "question": "Which country won the FIFA World Cup in 2018?",
      "options": ["France", "Brazil", "Germany", "Spain"],
      "correctAnswer": 0
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
    {
      "question": "What is the tallest mountain in the world?",
      "options": ["Mount Everest", "K2", "Kangchenjunga", "Makalu"],
      "correctAnswer": 0
    },
    {
      "question":
          "Which programming language is known as the 'mother of all languages'?",
      "options": ["C", "Java", "Python", "Assembly"],
      "correctAnswer": 3
    },
    {
      "question": "Who is the author of the Harry Potter book series?",
      "options": [
        "J.K. Rowling",
        "Stephen King",
        "George R.R. Martin",
        "Dan Brown"
      ],
      "correctAnswer": 0
    },
    {
      "question": "What is the largest ocean on Earth?",
      "options": [
        "Pacific Ocean",
        "Atlantic Ocean",
        "Indian Ocean",
        "Arctic Ocean"
      ],
      "correctAnswer": 0
    },
    {
      "question": "Which of the following are programming paradigms?",
      "options": ["Imperative", "Declarative", "Functional", "Procedural"],
      "correctAnswers": [0, 1, 2],
    },
  ];

  Map<int, dynamic> selectedAnswers = {};
  int score = 0;
  int points = 0;
  bool isSubmitting = false;
  int timeRemaining = 100;
  Timer? timer;

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

      // _showResultModal();
    });
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
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
                  const SizedBox(height: 10),
                  Center(
                    child: CircleProgressBar(
                      timeRemaining: timeRemaining,
                      strokeWidth: 10.0,
                      radius: 50.0,
                    ),
                  ),
                  // const SizedBox(height: 20),
                  // Text(
                  //   'Time Remaining: ${timeRemaining ~/ 60}:${(timeRemaining % 60).toString().padLeft(2, '0')}',
                  //   style: const TextStyle(fontSize: 18),
                  // ),
                  const SizedBox(height: 16),
                  const Text(
                    'Quiz Questions',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: quizData.length,
                      itemBuilder: (BuildContext context, int index) {
                        final question = quizData[index];

                        if (question.containsKey('correctAnswers')) {
                          return MultipleCorrectAnswerQuestionWidget(
                            question: question,
                            selectedAnswers: selectedAnswers[index] ?? [],
                            index: index,
                            onChanged: (selectedOptions) {
                              setState(() {
                                selectedAnswers[index] = selectedOptions;
                              });
                            },
                          );
                        } else {
                          return SingleCorrectAnswerQuestionWidget(
                            question: question,
                            selectedAnswer: selectedAnswers[index],
                            index: index,
                            onChanged: (selectedOption) {
                              setState(() {
                                selectedAnswers[index] = selectedOption;
                              });
                            },
                          );
                        }
                      },
                    ),
                  ),
                  if (selectedAnswers.length == quizData.length)
                    ElevatedButton(
                      onPressed: submitQuiz,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                        backgroundColor: Colors.pink,
                        textStyle: const TextStyle(fontSize: 18),
                      ),
                      child: const Text(
                        'Submit Quiz',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}

class SingleCorrectAnswerQuestionWidget extends StatelessWidget {
  final Map<String, dynamic> question;
  final int? selectedAnswer;
  final int index;
  final ValueChanged<int?> onChanged;

  const SingleCorrectAnswerQuestionWidget({
    Key? key,
    required this.question,
    required this.selectedAnswer,
    required this.index,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Question ${index + 1}: ${question['question']}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        ...question['options'].asMap().entries.map<Widget>((optionEntry) {
          final optionIndex = optionEntry.key;
          final optionText = optionEntry.value;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            child: RadioListTile<int>(
              title: Text(optionText),
              value: optionIndex,
              groupValue: selectedAnswer,
              onChanged: onChanged,
            ),
          );
        }).toList(),
        const Divider(),
      ],
    );
  }
}

class MultipleCorrectAnswerQuestionWidget extends StatelessWidget {
  final Map<String, dynamic> question;
  final List<int>? selectedAnswers;
  final int index;
  final ValueChanged<List<int>?> onChanged;

  const MultipleCorrectAnswerQuestionWidget({
    Key? key,
    required this.question,
    required this.selectedAnswers,
    required this.index,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Question ${index + 1}: ${question['question']}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        ...question['options'].asMap().entries.map<Widget>((optionEntry) {
          final optionIndex = optionEntry.key;
          final optionText = optionEntry.value;

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 2),
            child: CheckboxListTile(
              title: Text(optionText),
              value: selectedAnswers?.contains(optionIndex) ?? false,
              onChanged: (value) {
                List<int>? updatedSelectedAnswers;
                if (value == true) {
                  updatedSelectedAnswers = [
                    ...(selectedAnswers ?? []),
                    optionIndex
                  ];
                } else {
                  updatedSelectedAnswers = [...(selectedAnswers ?? [])]
                    ..remove(optionIndex);
                }
                onChanged(updatedSelectedAnswers.isEmpty
                    ? null
                    : updatedSelectedAnswers);
              },
            ),
          );
        }).toList(),
        const Divider(),
      ],
    );
  }
}
