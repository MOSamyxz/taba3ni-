import 'package:taba3ni/features/groups/domain/entity/group_entity.dart';
import 'package:taba3ni/features/groups/domain/repository/group_repository.dart';


class GetGroupsUseCase {
  final GroupRepository repository;
  GetGroupsUseCase(this.repository);

  Future<List<GroupEntity>> call() {
    return repository.getGroups();
  }
}
