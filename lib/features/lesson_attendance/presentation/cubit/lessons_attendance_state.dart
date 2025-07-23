part of 'lessons_attendance_cubit.dart';

sealed class LessonsAttendanceState extends Equatable {
  const LessonsAttendanceState();

  @override
  List<Object> get props => [];
}

final class LessonsAttendanceInitial extends LessonsAttendanceState {}

final class LessonsAttendanceLoading extends LessonsAttendanceState {}

final class LessonsAttendanceLoaded extends LessonsAttendanceState {
  final List<StudentAttendanceEntity> lessonAttendanceStudents ;
  const LessonsAttendanceLoaded(this.lessonAttendanceStudents);
}

final class LessonsAttendanceError extends LessonsAttendanceState {
  final String error;
  const LessonsAttendanceError(this.error);
}