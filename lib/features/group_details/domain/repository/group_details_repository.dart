import 'package:taba3ni/features/group_details/domain/entity/group_details_entity.dart';

abstract class GroupDetailsRepository {
  Future<GroupDetailsEntity> getGroupDetails(String groupId);
}
