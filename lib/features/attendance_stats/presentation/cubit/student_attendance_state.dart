part of 'student_attendance_cubit.dart';

sealed class StudentAttendanceState extends Equatable {
  const StudentAttendanceState();

  @override
  List<Object> get props => [];
}

final class StudentAttendanceInitial extends StudentAttendanceState {}

final class StudentAttendanceStatsLoading extends StudentAttendanceState {}

final class StudentAttendanceStatsLoaded extends StudentAttendanceState {
  final List<StudentAttendanceStatsEntity> stats;
  const StudentAttendanceStatsLoaded(this.stats);
}

final class StudentAttendanceStatsError extends StudentAttendanceState {
  final String error;
  const StudentAttendanceStatsError(this.error);
}
