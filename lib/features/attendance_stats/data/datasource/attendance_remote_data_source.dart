 
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taba3ni/features/attendance_stats/data/model/student_attendance_stats_model.dart';

abstract class AttendanceRemoteDataSource {
  Future<List<StudentAttendanceStatsModel>> getAttendanceStatsForGroup(String groupId);
}

class AttendanceRemoteDataSourceImpl implements AttendanceRemoteDataSource {
  final SupabaseClient client;

  AttendanceRemoteDataSourceImpl(this.client);

  @override
  Future<List<StudentAttendanceStatsModel>> getAttendanceStatsForGroup(String groupId) async {
  // Step 1: Get all lessons in this group
  final lessonsResponse = await client
      .from('lessons')
      .select('id')
      .eq('group_id', groupId);

  final lessonIds = (lessonsResponse as List).map((e) => e['id'] as String).toList();

  if (lessonIds.isEmpty) return [];
  // Step 2: Get all attendance records for these lessons
  final attendanceResponse = await client
      .from('attendance')
      .select('student_id, present')
      .inFilter('lesson_id', lessonIds);

  // Step 3: Get all students in this group
  final studentsResponse = await client
      .from('students')
      .select('id, name_ar')
      .eq('group_id', groupId);
  // Step 4: Prepare initial stats map
  final Map<String, StudentAttendanceStatsModel> stats = {};

  for (var student in studentsResponse) {
    stats[student['id']] = StudentAttendanceStatsModel(
      studentId: student['id'],
      studentName: student['name_ar'],
      presentCount: 0,
      absentCount: 0,
    );
 
  }
   // Step 5: Count present / absent per student
  for (var record in attendanceResponse) {
    final studentId = record['student_id'];
    final status = record['present'];

    if (stats.containsKey(studentId)) {
      if (status ) {
        stats[studentId] = stats[studentId]!.copyWith(
          presentCount: stats[studentId]!.presentCount + 1,
        );
      } else {
        stats[studentId] = stats[studentId]!.copyWith(
          absentCount: stats[studentId]!.absentCount + 1,
        );
      }
    }
  }
  return stats.values.toList();
}

}
