import 'package:taba3ni/features/lesson_attendance/domain/entity/student_attendance_entity.dart';

class StudentAttendanceModel extends StudentAttendanceEntity {
 
  StudentAttendanceModel({
    required super.studentId,
    required super.studentName,
    required super.isPresent,
  });

  factory StudentAttendanceModel.fromMap(Map<String, dynamic> map) {
    return StudentAttendanceModel(
      studentId: map['student_id'],
      studentName: map['student_name'],
      isPresent: map['is_present'],
    );
  }
}
