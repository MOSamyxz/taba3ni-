import 'package:taba3ni/features/lesson_shared/domain/entity/lesson_entity.dart';

class LessonModel extends LessonEntity {
  LessonModel({
  required super.id, 
  required super.groupId, 
  required super.date,
  super.topic, 
  super.isExtre
  });


  factory LessonModel.fromMap(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      groupId: json['group_id'],
      date: DateTime.parse(json['date']),
      topic: json['topic'],
      isExtre: json['is_extra'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'group_id': groupId,
      'date': date.toIso8601String(),
      'topic': topic,
      'is_extra': isExtre,
    };
  }
}



