
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:taba3ni/features/group_shared/domain/entity/group_entity.dart';
import 'package:taba3ni/features/groups/domain/usecase/delete_group_usecase.dart';
import 'package:taba3ni/features/groups/domain/usecase/get_groups_usecase.dart';

part 'group_state.dart';


class GroupCubit extends Cubit<GroupState> {
  final GetGroupsUseCase getGroupsUseCase;
  final DeleteGroupUseCase deleteGroupUseCase;

  GroupCubit({
    required this.getGroupsUseCase,
    required this.deleteGroupUseCase,
  }) : super(GroupInitial());

  Future<void> loadGroups() async {
    emit(GroupLoading());
    try {
      final groups = await getGroupsUseCase();
      emit(GroupLoaded(groups));
    } catch (e) {
      emit(GroupError('فشل تحميل المجموعات'));
    }
  }


  Future<void> deleteGroup(String id) async {
    try {
      await deleteGroupUseCase(id);
      await loadGroups();
    } catch (e) {
      emit(GroupError('فشل في حذف المجموعة'));
    }
  }
}