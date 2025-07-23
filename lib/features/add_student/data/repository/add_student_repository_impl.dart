 
import 'package:taba3ni/features/add_student/data/datasource/add_student_remote_data_source.dart';
import 'package:taba3ni/features/add_student/domain/repository/add_student_repository.dart';
import 'package:taba3ni/features/student_shared/data/model/student_model.dart';
import 'package:taba3ni/features/student_shared/domain/entity/student_entity.dart';

class AddStudentRepositoryImpl implements AddStudentRepository {
  final AddStudentRemoteDataSource remoteDataSource;

  AddStudentRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addStudent(StudentsEntity student) async {
    final model = StudentsModel(
      id: student.id,
      name: student.name,
      username: student.username,
      groupId: student.groupId,
      parentPhone: student.parentPhone,
      phone: student.phone,
    );

    await remoteDataSource.addStudent(model);
  }
}
