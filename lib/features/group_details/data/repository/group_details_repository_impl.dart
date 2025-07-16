
import 'package:taba3ni/features/group_details/data/datasource/group_details_remote_data_source.dart';
import 'package:taba3ni/features/group_details/domain/entity/group_details_entity.dart';
import 'package:taba3ni/features/group_details/domain/repository/group_details_repository.dart';

class GroupDetailsRepositoryImpl implements GroupDetailsRepository {
  final GroupDetailsRemoteDataSource remote;

  GroupDetailsRepositoryImpl(this.remote);

  @override
  Future<GroupDetailsEntity> getGroupDetails(String groupId) {
    return remote.getGroupDetails(groupId);
  }
}
