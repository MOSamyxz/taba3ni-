import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taba3ni/features/lesson_attendance/data/model/student_attendance_model.dart';

abstract class LessonAttendanceRemoteDataSource {
  Future<List<StudentAttendanceModel>> getLessonsAttendance(String lessonId, String groupId);
}

class LessonAttendanceRemoteDataSourceImpl
    implements LessonAttendanceRemoteDataSource {
  final SupabaseClient client;

  LessonAttendanceRemoteDataSourceImpl(this.client);

 @override
Future<List<StudentAttendanceModel>> getLessonsAttendance(
    String lessonId, String groupId) async {
  final attendanceResponse = await client
      .from('attendance')
      .select()
      .eq('lesson_id', lessonId);

  final Map<String, bool> attendanceMap = {
    for (final record in attendanceResponse)
      record['student_id'] as String: record['present'] as bool
  };

  final studentsResponse = await client
      .from('students')
      .select()
      .eq('group_id', groupId);

  final students = (studentsResponse as List).map((e) {
    final studentId = e['id'] as String;
    final studentName = e['name_ar'] as String;
    final isPresent = attendanceMap[studentId] ?? false; 

    return StudentAttendanceModel(
      studentId: studentId,
      studentName: studentName,
      isPresent: isPresent,
    );
  }).toList();

  return students;
}


    }