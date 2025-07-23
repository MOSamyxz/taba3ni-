import '../../../lesson_shared/domain/entity/lesson_entity.dart';
import '../../domain/entity/attendance_entity.dart';
import '../../domain/repository/start_lesson_repository.dart';
import '../datasource/start_lesson_remote_data_source.dart';
import '../../../lesson_shared/data/model/lesson_model.dart';
import '../model/attendance_model.dart';

class StartLessonRepositoryImpl implements StartLessonRepository {
  final StartLessonRemoteDataSource remoteDataSource;

  StartLessonRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> createLesson(LessonEntity lesson) async {
    await remoteDataSource.createLesson(LessonModel(
      id: lesson.id,
      groupId: lesson.groupId,
      date: lesson.date,
      topic: lesson.topic,
      isExtre: lesson.isExtre,
    ));
  }

  @override
  Future<void> recordAttendance(List<AttendanceEntity> attendanceList) async {
    final models = attendanceList.map((e) => AttendanceModel(
      id: e.id,
      lessonId: e.lessonId,
      studentId: e.studentId,
      present: e.present,
      reason: e.reason,
    )).toList();

    await remoteDataSource.recordAttendance(models);
  }
}
