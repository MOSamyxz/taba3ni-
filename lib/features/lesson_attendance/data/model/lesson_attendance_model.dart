import 'package:taba3ni/features/lesson_attendance/domain/entity/lesson_attendance_entity.dart';

class LessonAttendanceModel extends LessonAttendanceEntity{
  LessonAttendanceModel({
    required super.id, 
    required super.lessonId, 
    required super.studentId, 
    required super.present,
    super.reason
    });

  factory LessonAttendanceModel.fromMap(Map<String, dynamic> json) {
    return LessonAttendanceModel(
      id: json['id'],
      lessonId: json['lesson_id'],
      studentId: json['student_id'],
      present: json['present'],
      reason: json['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'lesson_id': lessonId,
      'student_id': studentId,
      'present': present,
      'notes': reason
    };
  }

}