import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taba3ni/features/group_details/data/model/group_details_model.dart';

abstract class GroupDetailsRemoteDataSource {
  Future<GroupDetailsModel> getGroupDetails(String groupId);
}


class GroupDetailsRemoteDataSourceImpl implements GroupDetailsRemoteDataSource {
  final SupabaseClient client;
  GroupDetailsRemoteDataSourceImpl(this.client);

  @override
  Future<GroupDetailsModel> getGroupDetails(String groupId) async {
    final response = await client
        .from('groups')
        .select()
        .eq('id', groupId)
        .single();

    return GroupDetailsModel.fromMap(response);
  }
}
