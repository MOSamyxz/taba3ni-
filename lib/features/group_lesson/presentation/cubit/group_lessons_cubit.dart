import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taba3ni/features/group_lesson/domain/usecase/get_group_lessons_usecase.dart';
import 'package:taba3ni/features/lesson_shared/domain/entity/lesson_entity.dart';

part 'group_lessons_state.dart';

class GroupLessonsCubit extends Cubit<GroupLessonsState> {
  final GetGroupLessonsUsecase groupLessonsUsecase;
  GroupLessonsCubit( {required this.groupLessonsUsecase}) : super(GroupLessonsInitial());

  Future<void> getGroupLessons(String groupId) async {
    emit(GroupLessonsLoading());
    try {
      final lessons = await groupLessonsUsecase.call(groupId);
      emit(GroupLessonsLoaded(lessons));
    } catch (e) {
      emit(GroupLessonsError(e.toString()));
    }
  }
}
