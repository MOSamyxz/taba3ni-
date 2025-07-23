import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
 import 'package:taba3ni/features/lesson_attendance/domain/entity/student_attendance_entity.dart';
import 'package:taba3ni/features/lesson_attendance/domain/usecase/get_lesson_attendance_usecase.dart';

part 'lessons_attendance_state.dart';

class LessonsAttendanceCubit extends Cubit<LessonsAttendanceState> {
 final  GetLessonsAttendanceUseCase getLessonsAttendanceUseCase;
  LessonsAttendanceCubit({required this.getLessonsAttendanceUseCase}) : super(LessonsAttendanceInitial());

Future<void> getLessonsAttendance(String lessonId,String groupId) async {
  emit(LessonsAttendanceLoading());
  try {
    final lessonAttendanceStudents = await getLessonsAttendanceUseCase(lessonId,groupId);
    emit(LessonsAttendanceLoaded(lessonAttendanceStudents));
  } catch (e) {
    emit(LessonsAttendanceError(e.toString()));
  }

}
}