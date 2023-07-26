class QuizModel {
  List<QuizData> data;
  String message;

  QuizModel({required this.data, required this.message});

  factory QuizModel.fromJson(Map<String, dynamic> json) {
    return QuizModel(
      data: List<QuizData>.from(
          json['data'].map((data) => QuizData.fromJson(data))),
      message: json['message'],
    );
  }
}

class QuizData {
  String id;
  String mentor;
  String title;
  String subjectId;
  List<Question> questions;
  String difficultyLevel;

  QuizData({
    required this.id,
    required this.mentor,
    required this.title,
    required this.subjectId,
    required this.questions,
    required this.difficultyLevel,
  });

  factory QuizData.fromJson(Map<String, dynamic> json) {
    return QuizData(
      id: json['_id'],
      mentor: json['mentor'],
      title: json['title'],
      subjectId: json['subjectId'],
      questions: List<Question>.from(
          json['questions'].map((data) => Question.fromJson(data))),
      difficultyLevel: json['difficultyLevel'],
    );
  }
}

class Question {
  String question;
  List<String> options;
  dynamic correctAnswer;
  String id;

  Question({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.id,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      question: json['question'],
      options:
          List<String>.from(json['options'].map((option) => option.toString())),
      correctAnswer:
          json.containsKey('correctAnswer') ? json['correctAnswer'] : null,
      id: json['_id'],
    );
  }
}
