part of 'group_student_cubit.dart';

sealed class GroupStudentsState extends Equatable {
  const GroupStudentsState();

  @override
  List<Object> get props => [];
}

final class GroupStudentsInitial extends GroupStudentsState {}

final class GroupStudentsLoading extends GroupStudentsState {}

final class GroupStudentsLoaded extends GroupStudentsState {
  final List<StudentsEntity> students;

  const GroupStudentsLoaded(this.students);
}

final class GroupStudentsError extends GroupStudentsState {
  final String message;

  const GroupStudentsError(this.message);
}
