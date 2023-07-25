class StageData {
  String id;
  String levelName;
  bool isAccessible;

  StageData({
    required this.id,
    required this.levelName,
    required this.isAccessible,
  });

  factory StageData.fromJson(Map<String, dynamic> json) {
    return StageData(
      id: json['_id'],
      levelName: json['levelName'],
      isAccessible: json['isAccessible'],
    );
  }
}

class StageDataResponse {
  List<StageData> data;

  StageDataResponse({
    required this.data,
  });

  factory StageDataResponse.fromJson(Map<String, dynamic> json) {
    var dataList = json['data'] as List<dynamic>;
    List<StageData> stages =
        dataList.map((data) => StageData.fromJson(data)).toList();
    return StageDataResponse(
      data: stages,
    );
  }
}
