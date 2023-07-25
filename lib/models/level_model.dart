class QuizLevel {
  String id;
  String levelName;
  String displayName;
  List<Subject> subjectList;

  QuizLevel({
    required this.id,
    required this.levelName,
    required this.displayName,
    required this.subjectList,
  });

  factory QuizLevel.fromJson(Map<String, dynamic> json) {
    var subjectListData = json['subjectList'] as List<dynamic>;
    List<Subject> subjects =
        subjectListData.map((data) => Subject.fromJson(data)).toList();

    return QuizLevel(
      id: json['id'],
      levelName: json['levelName'],
      displayName: json['displayName'],
      subjectList: subjects,
    );
  }
}

class Subject {
  String id;
  int subjectId;
  String classId;
  String subjectName;
  String created;
  String? modified;

  Subject({
    required this.id,
    required this.subjectId,
    required this.classId,
    required this.subjectName,
    required this.created,
    this.modified,
  });

  factory Subject.fromJson(Map<String, dynamic> json) {
    return Subject(
      id: json['_id'],
      subjectId: json['id'],
      classId: json['class_id'],
      subjectName: json['subject_name'],
      created: json['created'],
      modified: json['modified'],
    );
  }
}

class QuizLevelResponse {
  List<QuizLevel> data;

  QuizLevelResponse({
    required this.data,
  });

  factory QuizLevelResponse.fromJson(Map<String, dynamic> json) {
    var levelListData = json['data'] as List<dynamic>;
    List<QuizLevel> levels =
        levelListData.map((data) => QuizLevel.fromJson(data)).toList();

    return QuizLevelResponse(
      data: levels,
    );
  }
}
