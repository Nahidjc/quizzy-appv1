import 'dart:convert';
import 'package:quizzy/models/stage_model.dart';

import 'app_url.dart';
import 'package:http/http.dart' as http;

class StageList {
  Future<List<StageData>> fetchStage(String userid) async {
    final url = Uri.parse('${AppUrl.baseUrl}/stage/all');
    final headers = {'userid': userid};
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      var jsonData = json.decode(response.body);
      var stageDataResponse = StageDataResponse.fromJson(jsonData);
      List<StageData> stages = stageDataResponse.data;
      return stages;
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}
