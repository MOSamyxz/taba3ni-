import 'dart:developer';

import 'package:taba3ni/features/add_group/data/datasource/add_group_remote_data_source.dart';
import 'package:taba3ni/features/add_group/domain/repository/add_group_repository.dart';
import 'package:taba3ni/features/groups/data/model/group_model.dart';
import 'package:taba3ni/features/groups/domain/entity/group_entity.dart';

class AddGroupRepositoryImpl implements AddGroupRepository {
  final AddGroupRemoteDataSource remote;

  AddGroupRepositoryImpl(this.remote);

  @override
  Future<void> addGroup(GroupEntity group) async {
    await remote.addGroup(
      GroupModel(
        id: group.id,
        name: group.name,
        schedule: group.schedule,
        notes: group.notes,
      ),
    );
    log('✅ Supabase: group added successfully: ${group.name}');
  }
}
