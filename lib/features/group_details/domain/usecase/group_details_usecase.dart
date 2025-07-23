import 'package:taba3ni/features/group_shared/domain/entity/group_entity.dart';
import 'package:taba3ni/features/group_details/domain/repository/group_details_repository.dart';

class GetGroupDetailsUseCase {
  final GroupDetailsRepository repository;

  GetGroupDetailsUseCase(this.repository);

  Future<GroupEntity> call(String groupId) {
    return repository.getGroupDetails(groupId);
  }
}