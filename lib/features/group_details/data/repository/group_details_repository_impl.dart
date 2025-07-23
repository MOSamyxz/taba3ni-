
import 'package:taba3ni/features/group_details/data/datasource/group_details_remote_data_source.dart';
import 'package:taba3ni/features/group_shared/domain/entity/group_entity.dart';
import 'package:taba3ni/features/group_details/domain/repository/group_details_repository.dart';

class GroupDetailsRepositoryImpl implements GroupDetailsRepository {
  final GroupDetailsRemoteDataSource remoteDataSource;

  GroupDetailsRepositoryImpl(this.remoteDataSource);

  @override
  Future<GroupEntity> getGroupDetails(String groupId) {
    return remoteDataSource.getGroupDetails(groupId);
  }
}
