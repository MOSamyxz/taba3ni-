

import 'package:taba3ni/features/student_shared/domain/entity/student_entity.dart';

abstract class AddStudentRepository {
  Future<void> addStudent(StudentsEntity student);
}
