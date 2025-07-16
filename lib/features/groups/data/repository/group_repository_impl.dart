 
import 'dart:developer';

import 'package:taba3ni/features/groups/data/datasource/group_remote_data_source.dart';
import 'package:taba3ni/features/groups/data/model/group_model.dart';
import 'package:taba3ni/features/groups/domain/entity/group_entity.dart';
import 'package:taba3ni/features/groups/domain/repository/group_repository.dart';

class GroupRepositoryImpl implements GroupRepository {
  final GroupRemoteDataSource remote;

  GroupRepositoryImpl(this.remote);

  @override
  Future<List<GroupEntity>> getGroups() async {
    return remote.getGroups();
  }

  @override
  Future<void> deleteGroup(String id) {
    return remote.deleteGroup(id);
  }
}
