import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../lesson_shared/data/model/lesson_model.dart';
import '../model/attendance_model.dart';

abstract class StartLessonRemoteDataSource {
  Future<void> createLesson(LessonModel lesson);
  Future<void> recordAttendance(List<AttendanceModel> records);
}

class StartLessonRemoteDataSourceImpl implements StartLessonRemoteDataSource {
  final SupabaseClient client;

  StartLessonRemoteDataSourceImpl(this.client);

  @override
  Future<void> createLesson(LessonModel lesson) async {
    await client.from('lessons').insert(lesson.toMap());
  }

  @override
  Future<void> recordAttendance(List<AttendanceModel> records) async {
    final data = records.map((e) => e.toMap()).toList();
    await client.from('attendance').insert(data);
  }
}
