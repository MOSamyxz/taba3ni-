import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taba3ni/features/group_students/domain/entity/student_entity.dart';
import 'package:taba3ni/features/group_students/domain/usecase/get_student_usecase.dart';

part 'group_student_state.dart';

class GroupStudentsCubit extends Cubit<GroupStudentsState> {
  final GetStudentsByGroupUseCase getStudentsByGroupUseCase;

  GroupStudentsCubit({required this.getStudentsByGroupUseCase}) : super(GroupStudentsInitial());

  Future<void> loadStudentsByGroupId(String groupId) async {
    try {
      emit(GroupStudentsLoading());
      final students = await getStudentsByGroupUseCase(groupId);
      emit(GroupStudentsLoaded(students));
    } catch (e) {
      emit(GroupStudentsError(e.toString()));
    }
  }
}
