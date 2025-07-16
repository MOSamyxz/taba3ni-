import 'package:taba3ni/features/groups/domain/entity/group_entity.dart';


abstract class AddGroupRepository {
  Future<void> addGroup(GroupEntity group);
}
