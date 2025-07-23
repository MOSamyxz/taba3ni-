import 'package:taba3ni/features/lesson_shared/domain/entity/lesson_entity.dart';

abstract class GroupLessonsRepository {
 Future<List<LessonEntity>> getGroupLessons(String groupId);
}