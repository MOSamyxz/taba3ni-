import 'package:taba3ni/features/add_group/domain/repository/add_group_repository.dart';
import 'package:taba3ni/features/groups/domain/entity/group_entity.dart';

class AddGroupUseCase {
  final AddGroupRepository repository;
  AddGroupUseCase(this.repository);

  Future<void> call(GroupEntity group) {
    return repository.addGroup(group);
  }
}
