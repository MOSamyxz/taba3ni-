import 'package:taba3ni/features/attendance_stats/data/datasource/attendance_remote_data_source.dart';
import 'package:taba3ni/features/attendance_stats/data/model/student_attendance_stats_model.dart';
import 'package:taba3ni/features/attendance_stats/domain/repository/attendance_repository.dart';

class StudentAttendanceStatsRepositoryImpl implements StudentAttendanceStatsRepository {
  final AttendanceRemoteDataSource remoteDataSource;

  StudentAttendanceStatsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<StudentAttendanceStatsModel>> getStatsForGroup(String groupId) {
    return remoteDataSource.getAttendanceStatsForGroup(groupId);
  }
}
