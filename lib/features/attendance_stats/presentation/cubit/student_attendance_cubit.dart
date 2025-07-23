import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taba3ni/features/attendance_stats/domain/entity/student_attendance_stats_entity.dart';
import 'package:taba3ni/features/attendance_stats/domain/usecase/student_attendance_usecase.dart';

part 'student_attendance_state.dart';

class StudentAttendanceCubit extends Cubit<StudentAttendanceState> {
final   GetStudentAttendanceStatsUseCase getStudentAttendanceStatsUseCase;
  StudentAttendanceCubit({required this.getStudentAttendanceStatsUseCase}) : super(StudentAttendanceInitial());


 Future<void> loadStats(String groupId) async {
    emit(StudentAttendanceStatsLoading());
    try {
      final stats = await getStudentAttendanceStatsUseCase(groupId);
      emit(StudentAttendanceStatsLoaded(stats));
    } catch (e) {
      emit(StudentAttendanceStatsError(e.toString()));
    }
  }
}