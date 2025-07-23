import 'package:taba3ni/features/lesson_attendance/domain/entity/student_attendance_entity.dart';
import 'package:taba3ni/features/lesson_attendance/domain/repository/lesson_attendance_repository.dart';

class GetLessonsAttendanceUseCase {
  final LessonAttendanceRepository repository;
  GetLessonsAttendanceUseCase(this.repository);

  Future<List<StudentAttendanceEntity>> call(String lessonId, String groupId) {
    return repository.getLessonsAttendance(lessonId,   groupId);
  }
}
