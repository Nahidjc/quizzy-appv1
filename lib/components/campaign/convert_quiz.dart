import 'package:quizzy/models/campaign_quiz.dart';

List<Map<String, dynamic>> convertToQuiz(List<QuestionModel> quizList) {
  List<Map<String, dynamic>> quizData = [];
  for (var quiz in quizList) {
    Map<String, dynamic> quizMap = {
      "question": quiz.question,
      "options": quiz.options,
        "correctAnswer": quiz.correctAnswer,
    };
    quizData.add(quizMap);
  }
  return quizData;
}