import 'package:taba3ni/features/groups/domain/entity/group_entity.dart';


abstract class GroupRepository {
  Future<List<GroupEntity>> getGroups();  
  Future<void> deleteGroup(String id);
}
