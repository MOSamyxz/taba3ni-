import 'package:taba3ni/features/groups/domain/repository/group_repository.dart';

class DeleteGroupUseCase {
  final GroupRepository repository;
  DeleteGroupUseCase(this.repository);

  Future<void> call(String id) {
    return repository.deleteGroup(id);
  }
}
