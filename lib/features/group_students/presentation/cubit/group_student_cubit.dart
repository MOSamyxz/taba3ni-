import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taba3ni/features/group_students/domain/usecase/delete_student_usecase.dart';
import 'package:taba3ni/features/student_shared/domain/entity/student_entity.dart';
import 'package:taba3ni/features/group_students/domain/usecase/get_student_usecase.dart';

part 'group_student_state.dart';

class GroupStudentsCubit extends Cubit<GroupStudentsState> {
  final GetStudentsByGroupUseCase getStudentsByGroupUseCase;
final DeleteStudentUsecase deleteStudentUsecase;
  GroupStudentsCubit({required this.getStudentsByGroupUseCase,required this.deleteStudentUsecase}) : super(GroupStudentsInitial());

  Future<void> loadStudentsByGroupId(String groupId) async {
    try {
      emit(GroupStudentsLoading());
      final students = await getStudentsByGroupUseCase(groupId);
      emit(GroupStudentsLoaded(students));
    } catch (e) {
      emit(GroupStudentsError(e.toString()));
    }
  }

  Future<void > deleteStudent(String studentId, String groupId) async {
   try {
     await deleteStudentUsecase(studentId);
     await loadStudentsByGroupId(groupId);
   } catch (e) {
     emit(GroupStudentsError(e.toString()));
   }
  }
}
