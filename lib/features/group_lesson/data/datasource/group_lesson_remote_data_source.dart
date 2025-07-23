import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taba3ni/features/lesson_shared/data/model/lesson_model.dart';

abstract class GroupLessonsRemoteDataSource {
  Future<List<LessonModel>> getGroupLessons(String groupId);
}


class GroupLessonsRemoteDataSourceImpl implements GroupLessonsRemoteDataSource {
  final SupabaseClient client;
  GroupLessonsRemoteDataSourceImpl(this.client);

  @override


  Future<List<LessonModel>> getGroupLessons(String groupId) async {
    final response = await client
        .from('lessons')
        .select()
        .eq('group_id', groupId);

    return (response as List)
        .map((lesson) => LessonModel.fromMap(lesson))
        .toList();
  }
} 