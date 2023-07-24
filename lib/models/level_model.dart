class Subject {
  final String id;
  final int subjectId;
  final String classId;
  final String subjectName;
  final String created;
  final String? modified;

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


class Level {
  final String id;
  final String levelName;
  final String displayName;
  final List<Subject> subjectList;

  Level({
    required this.id,
    required this.levelName,
    required this.displayName,
    required this.subjectList,
  });

  factory Level.fromJson(Map<String, dynamic> json) {
    var subjectListData = json['subjectList'] as List<dynamic>;
    List<Subject> subjectList =
        subjectListData.map((subjectData) => Subject.fromJson(subjectData)).toList();

    return Level(
      id: json['id'],
      levelName: json['levelName'],
      displayName: json['displayName'],
      subjectList: subjectList,
    );
  }
}
