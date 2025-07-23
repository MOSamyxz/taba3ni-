import 'package:taba3ni/features/lesson_attendance/domain/entity/student_attendance_entity.dart';

abstract class LessonAttendanceRepository {
 
  Future<List<StudentAttendanceEntity>> getLessonsAttendance(String lessonId, String groupId);
}