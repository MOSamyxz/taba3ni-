import 'package:taba3ni/features/group_lesson/domain/repository/group_lesson_repository.dart';
import 'package:taba3ni/features/lesson_shared/domain/entity/lesson_entity.dart';

class GetGroupLessonsUsecase {
final GroupLessonsRepository groupLessonsRepository;
const GetGroupLessonsUsecase(this.groupLessonsRepository);

Future<List<LessonEntity>> call(groupId) => groupLessonsRepository.getGroupLessons(groupId);

}