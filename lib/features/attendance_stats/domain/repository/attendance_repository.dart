import 'package:taba3ni/features/attendance_stats/domain/entity/student_attendance_stats_entity.dart';

abstract class StudentAttendanceStatsRepository {
  StudentAttendanceStatsRepository(Object object);

  Future<List<StudentAttendanceStatsEntity>> getStatsForGroup(String groupId);
}
