import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taba3ni/features/group_details/domain/entity/group_details_entity.dart';
import 'package:taba3ni/features/group_details/domain/usecase/group_details_usecase.dart';

part 'group_details_state.dart';

class GroupDetailsCubit extends Cubit<GroupDetailsState> {
  final GetGroupDetailsUseCase getGroupDetails;

  GroupDetailsCubit({required this.getGroupDetails,})
      : super(GroupDetailsInitial());

  Future<void> loadGroup(String groupId) async {
    emit(GroupDetailsLoading());
    try {
      final group = await getGroupDetails(groupId);
      emit(GroupDetailsLoaded(group));
    } catch (e) {
      emit(GroupDetailsError("فشل في تحميل بيانات المجموعة"));
    }
  }
}
