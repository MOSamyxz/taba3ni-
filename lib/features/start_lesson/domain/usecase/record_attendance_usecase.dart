import '../entity/attendance_entity.dart';
import '../repository/start_lesson_repository.dart';

class RecordAttendanceUseCase {
  final StartLessonRepository repo;

  RecordAttendanceUseCase(this.repo);

  Future<void> call(List<AttendanceEntity> records) =>
      repo.recordAttendance(records);
}
