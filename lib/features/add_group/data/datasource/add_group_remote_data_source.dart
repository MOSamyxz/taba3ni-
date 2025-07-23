import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taba3ni/features/group_shared/data/model/group_model.dart';


abstract class AddGroupRemoteDataSource {
  Future<void> addGroup(GroupModel group);
  Future<void> updateGroup(GroupModel group);

}



class AddGroupRemoteDataSourceImpl implements AddGroupRemoteDataSource {
  final SupabaseClient client;
  AddGroupRemoteDataSourceImpl(this.client);

  @override
  Future<void> addGroup(GroupModel group) async {
    await client.from('groups').insert(group.toMap());
  }

  @override
  Future<void> updateGroup(GroupModel group) async {
    await client.from('groups').update(group.toMap()).eq('id', group.id);
  }
}
