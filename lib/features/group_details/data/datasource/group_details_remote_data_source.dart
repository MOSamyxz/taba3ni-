import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taba3ni/features/group_shared/data/model/group_model.dart';

abstract class GroupDetailsRemoteDataSource {
  Future<GroupModel> getGroupDetails(String groupId);
}


class GroupDetailsRemoteDataSourceImpl implements GroupDetailsRemoteDataSource {
  final SupabaseClient client;
  GroupDetailsRemoteDataSourceImpl(this.client);

  @override
  Future<GroupModel> getGroupDetails(String groupId) async {
    final response = await client
        .from('groups')
        .select()
        .eq('id', groupId)
        .single();

    return GroupModel.fromMap(response);
  }
}
