part of 'group_lessons_cubit.dart';

sealed class GroupLessonsState extends Equatable {
  const GroupLessonsState();

  @override
  List<Object> get props => [];
}

final class GroupLessonsInitial extends GroupLessonsState {}

final class GroupLessonsLoading extends GroupLessonsState {}

final class GroupLessonsLoaded extends GroupLessonsState {
  final List<LessonEntity> lessons;
  const GroupLessonsLoaded(this.lessons);
}

final class GroupLessonsError extends GroupLessonsState {
  final String error;
  const GroupLessonsError(this.error);
}