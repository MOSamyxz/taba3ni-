import 'dart:developer';

import 'package:taba3ni/features/add_group/data/datasource/add_group_remote_data_source.dart';
import 'package:taba3ni/features/add_group/domain/repository/add_group_repository.dart';
import 'package:taba3ni/features/group_shared/data/model/group_model.dart';
import 'package:taba3ni/features/group_shared/domain/entity/group_entity.dart';


class AddGroupRepositoryImpl implements AddGroupRepository {
  final AddGroupRemoteDataSource remoteDataSource;

  AddGroupRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addGroup(GroupEntity group) async {
    await remoteDataSource.addGroup(
      GroupModel(
        id: group.id,
        name: group.name,
        schedule: group.schedule,
        notes: group.notes,
        grade: group.grade,
      ),
    );
    log('✅ Supabase: group added successfully: ${group.name}');
  }
}
