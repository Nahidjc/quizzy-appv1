import 'package:quizzy/models/quiz_model.dart';

List<Map<String, dynamic>> convertToQuizData(List<Question> quizList) {
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
