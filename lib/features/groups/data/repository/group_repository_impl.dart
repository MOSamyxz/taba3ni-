 

import 'package:taba3ni/features/group_shared/domain/entity/group_entity.dart';
import 'package:taba3ni/features/groups/data/datasource/group_remote_data_source.dart';

import 'package:taba3ni/features/groups/domain/repository/group_repository.dart';

class GroupRepositoryImpl implements GroupRepository {
  final GroupRemoteDataSource remoteDataSource;

  GroupRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<GroupEntity>> getGroups() async {
    return remoteDataSource.getGroups();
  }

  @override
  Future<void> deleteGroup(String id) {
    return remoteDataSource.deleteGroup(id);
  }
}
