 
import 'package:taba3ni/features/add_student/domain/repository/add_student_repository.dart';
import 'package:taba3ni/features/student_shared/domain/entity/student_entity.dart';

class AddStudentUseCase {
  final AddStudentRepository repository;

  AddStudentUseCase(this.repository);

  Future<void> call(StudentsEntity student) {
    return repository.addStudent(student);
  }
}
