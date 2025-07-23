import 'package:taba3ni/features/start_lesson/domain/entity/attendance_entity.dart';
import 'package:taba3ni/features/lesson_shared/domain/entity/lesson_entity.dart';

abstract class StartLessonRepository {
  Future<void> createLesson(LessonEntity lesson);
  Future<void> recordAttendance(List<AttendanceEntity> attendanceList);
}
