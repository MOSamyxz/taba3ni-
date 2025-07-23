import 'package:taba3ni/features/student_shared/domain/entity/student_entity.dart';

abstract class StudentsRepository {
  Future<List<StudentsEntity>> getStudentsByGroupId(String groupId);

  Future<void> deleteStudent(String studentId);
}
