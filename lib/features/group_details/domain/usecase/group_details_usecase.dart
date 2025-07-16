import 'package:taba3ni/features/group_details/domain/entity/group_details_entity.dart';
import 'package:taba3ni/features/group_details/domain/repository/group_details_repository.dart';

class GetGroupDetailsUseCase {
  final GroupDetailsRepository repository;

  GetGroupDetailsUseCase(this.repository);

  Future<GroupDetailsEntity> call(String groupId) {
    return repository.getGroupDetails(groupId);
  }
}