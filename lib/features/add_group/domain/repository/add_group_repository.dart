import 'package:taba3ni/features/group_shared/domain/entity/group_entity.dart';


abstract class AddUpdateGroupRepository {
  Future<void> addGroup(GroupEntity group);
  Future<void> updateGroup(GroupEntity group);
   
}
