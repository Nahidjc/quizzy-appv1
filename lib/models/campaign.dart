class Campaign {
  final String id;
  final String campaignName;
  final DateTime startDate;
  final DateTime endDate;
  final String creator;

  Campaign({
    required this.id,
    required this.campaignName,
    required this.startDate,
    required this.endDate,
    required this.creator,
  });

  factory Campaign.fromJson(Map<String, dynamic> json) {
    return Campaign(
      id: json['id'],
      campaignName: json['campaignName'],
      startDate: DateTime.parse(json['startDate']).toLocal(),
      endDate: DateTime.parse(json['endDate']).toLocal(),
      creator: json['creator'],
    );
  }
}
