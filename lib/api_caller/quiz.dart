import 'dart:convert';
import 'package:quizzy/models/quiz_model.dart';

import 'app_url.dart';
import 'package:http/http.dart' as http;

class QuizApi {
  Future<List<QuizData>> fetchQuiz(String stageId, String subjectId) async {
    final url = Uri.parse('${AppUrl.baseUrl}/quiz/subject/stage');
    final headers = {'stageid': stageId, 'subjectid': subjectId};
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var quizModelData = QuizModel.fromJson(jsonData);
      List<QuizData> quizzes = quizModelData.data;
      return quizzes;
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}
