class LessonEntity {
  final String id;
  final String groupId;
  final DateTime date;
  final String? topic;
  final bool isExtre;

  LessonEntity({
    required this.id,
    required this.groupId,
    required this.date,
    this.topic,
    this.isExtre = false,
  });
}
