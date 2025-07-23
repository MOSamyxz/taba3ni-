
part of 'start_lesson_cubit.dart';

abstract class StartLessonState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartLessonInitial extends StartLessonState {}

class StartLessonLoading extends StartLessonState {}

class StartLessonSuccess extends StartLessonState {}

class StartLessonError extends StartLessonState {
  final String error;
  StartLessonError(this.error);

  @override
  List<Object?> get props => [error];
}

final class SetAttenddance extends StartLessonState {
  final String studentId;
  final String status;

   SetAttenddance({required this.studentId, required this.status});

  @override
  List<Object> get props => [studentId, status];
}