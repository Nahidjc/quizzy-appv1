class CampaignModel {
  final String id;
  final String campaign;
  final String title;
  final List<QuestionModel> questions;
  final DateTime startTime;
  final DateTime endTime;
  final bool isAttempted;
  final bool isAvailable;
  final bool isClosed;
  final bool isUpcoming;
  final int currentTime;

  CampaignModel({
    required this.id,
    required this.campaign,
    required this.title,
    required this.questions,
    required this.startTime,
    required this.endTime,
    required this.isAttempted,
    required this.isAvailable,
    required this.isClosed,
    required this.isUpcoming,
    required this.currentTime,
  });

  factory CampaignModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> questionList = json['questions'];

    return CampaignModel(
      id: json['_id'],
      campaign: json['campaign'],
      title: json['title'],
      questions: questionList.map((q) => QuestionModel.fromJson(q)).toList(),
      startTime: DateTime.fromMillisecondsSinceEpoch(json['startTime']),
      endTime: DateTime.fromMillisecondsSinceEpoch(json['endTime']),
      isAttempted: json['isAttempted'],
      isAvailable: json['isAvailable'],
      isClosed: json['isClosed'],
      isUpcoming: json['isUpcoming'],
      currentTime: json['currentTime'],
    );
  }
}

class QuestionModel {
  final String question;
  final List<String> options;
  final int correctAnswer;
  final String id;

  QuestionModel({
    required this.question,
    required this.options,
    required this.correctAnswer,
    required this.id,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    final List<dynamic> optionsList = json['options'];

    return QuestionModel(
      question: json['question'],
      options: List<String>.from(optionsList),
      correctAnswer: json['correctAnswer'],
      id: json['_id'],
    );
  }
}
