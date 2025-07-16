import 'package:taba3ni/features/group_students/domain/entity/student_entity.dart';

abstract class StudentsRepository {
  Future<List<StudentsEntity>> getStudentsByGroupId(String groupId);
}
