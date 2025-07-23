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
  // 1. هات كل سجلات الحضور للحصة دي
  final attendanceResponse = await client
      .from('attendance')
      .select()
      .eq('lesson_id', lessonId);

  // 2. حول البيانات إلى خريطة فيها student_id كـ key و is_present كـ value
  final Map<String, bool> attendanceMap = {
    for (final record in attendanceResponse)
      record['student_id'] as String: record['present'] as bool
  };

  // 3. هات كل الطلبة في الجروب دا
  final studentsResponse = await client
      .from('students')
      .select()
      .eq('group_id', groupId);

  // 4. كون الليست النهائية من StudentAttendanceModel
  final students = (studentsResponse as List).map((e) {
    final studentId = e['id'] as String;
    final studentName = e['name_ar'] as String;
    final isPresent = attendanceMap[studentId] ?? false; // لو مفيش سجل اعتبره غايب

    return StudentAttendanceModel(
      studentId: studentId,
      studentName: studentName,
      isPresent: isPresent,
    );
  }).toList();

  return students;
}


    }