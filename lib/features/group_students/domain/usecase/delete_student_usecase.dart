import 'package:taba3ni/features/group_students/domain/repository/student_repository.dart';

class DeleteStudentUsecase {
   
     final StudentsRepository repository;

  DeleteStudentUsecase(this.repository);

  Future<void> call(String studentId) {
    return repository.deleteStudent(studentId);
  }
}