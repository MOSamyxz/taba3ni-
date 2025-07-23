import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taba3ni/features/group_shared/data/model/group_model.dart';


abstract class GroupRemoteDataSource {
  Future<List<GroupModel>> getGroups();
  Future<void> deleteGroup(String id);
}



class GroupRemoteDataSourceImpl implements GroupRemoteDataSource {
  final SupabaseClient client;

  GroupRemoteDataSourceImpl(this.client);

  @override
  Future<List<GroupModel>> getGroups() async {
    final response = await client
        .from('groups')
        .select();

    return (response as List)
        .map((item) => GroupModel.fromMap(item))
        .toList();
  }

  @override
  Future<void> deleteGroup(String id) async {
    await client.from('groups').delete().eq('id', id);
  }
}
