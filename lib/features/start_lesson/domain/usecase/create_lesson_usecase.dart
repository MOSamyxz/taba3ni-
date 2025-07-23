import '../../../lesson_shared/domain/entity/lesson_entity.dart';
import '../repository/start_lesson_repository.dart';

class CreateLessonUseCase {
  final StartLessonRepository repo;

  CreateLessonUseCase(this.repo);

  Future<void> call(LessonEntity lesson) => repo.createLesson(lesson);
}
