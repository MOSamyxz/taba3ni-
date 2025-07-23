import 'package:taba3ni/features/attendance_stats/domain/entity/student_attendance_stats_entity.dart';
import 'package:taba3ni/features/attendance_stats/domain/repository/attendance_repository.dart';

class GetStudentAttendanceStatsUseCase {
  final StudentAttendanceStatsRepository repository;

  GetStudentAttendanceStatsUseCase(this.repository);

  Future<List<StudentAttendanceStatsEntity>> call(String groupId) {
    return repository.getStatsForGroup(groupId);
  }
}
