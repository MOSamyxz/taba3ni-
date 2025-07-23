import 'package:taba3ni/features/group_lesson/data/datasource/group_lesson_remote_data_source.dart';
import 'package:taba3ni/features/group_lesson/domain/repository/group_lesson_repository.dart';
import 'package:taba3ni/features/lesson_shared/domain/entity/lesson_entity.dart';

class GroupLessonsRepositoryImpl extends GroupLessonsRepository{
final GroupLessonsRemoteDataSource remoteDataSource;
  GroupLessonsRepositoryImpl( this.remoteDataSource);


  @override
  Future<List<LessonEntity>> getGroupLessons(String groupId) {
    return remoteDataSource.getGroupLessons(groupId);
  }

}