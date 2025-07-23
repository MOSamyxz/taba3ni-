import 'package:taba3ni/features/add_group/domain/repository/add_group_repository.dart';
import 'package:taba3ni/features/group_shared/domain/entity/group_entity.dart';

class UpdateGroupUseCase {
  final AddUpdateGroupRepository repository;
  UpdateGroupUseCase(this.repository);

  Future<void> call(GroupEntity group) {
    return repository.updateGroup(group);
  }
}
