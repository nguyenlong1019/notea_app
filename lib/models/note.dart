class Note {
  String userId;
  String title;
  String description;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime? schedule;

  Note({
    required this.userId,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    this.schedule
  });

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'schedule': schedule?.toIso8601String(),
    };
  }

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      userId: json['userId'],
      title: json['title'],
      description: json['description'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      schedule: json['schedule'] != null ? DateTime.parse(json['schedule']) : null,
    );
  }
}