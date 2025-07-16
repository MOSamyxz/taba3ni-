import 'package:taba3ni/features/group_students/domain/entity/student_entity.dart';
import 'package:taba3ni/features/group_students/domain/repository/student_repository.dart';

class GetStudentsByGroupUseCase {
  final StudentsRepository repository;

  GetStudentsByGroupUseCase(this.repository);

  Future<List<StudentsEntity>> call(String groupId) {
    return repository.getStudentsByGroupId(groupId);
  }
}