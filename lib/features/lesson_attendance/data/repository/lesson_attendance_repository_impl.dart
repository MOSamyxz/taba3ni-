import 'package:taba3ni/features/lesson_attendance/data/datasource/lesson_attendance_remote_data_source.dart';
import 'package:taba3ni/features/lesson_attendance/data/model/student_attendance_model.dart';
 import 'package:taba3ni/features/lesson_attendance/domain/repository/lesson_attendance_repository.dart';

class LessonAttendanceRepositoryImpl extends LessonAttendanceRepository{
final LessonAttendanceRemoteDataSource lessonAttendanceRemoteDataSource;
  LessonAttendanceRepositoryImpl( this.lessonAttendanceRemoteDataSource);

  @override
  Future<List<StudentAttendanceModel>> getLessonsAttendance(String lessonId, String groupId) {
 return lessonAttendanceRemoteDataSource.getLessonsAttendance(lessonId, groupId);
   }
}