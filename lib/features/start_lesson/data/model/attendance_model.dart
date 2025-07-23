import 'package:taba3ni/features/start_lesson/domain/entity/attendance_entity.dart';

class AttendanceModel extends AttendanceEntity{

  AttendanceModel({
    required super. id,
    required super. lessonId,
    required super. studentId,
    required super. present,
    super.reason,
  })  ;

  factory AttendanceModel.fromMap(Map<String, dynamic> json) {
    return AttendanceModel(
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
      'notes': reason,
    };
  }

}

 