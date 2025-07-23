import 'package:taba3ni/features/group_shared/domain/entity/group_entity.dart';

abstract class GroupDetailsRepository {
  Future<GroupEntity> getGroupDetails(String groupId);
}
