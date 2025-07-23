import 'package:taba3ni/features/group_students/data/datasource/student_remote_data_source.dart';
import 'package:taba3ni/features/student_shared/domain/entity/student_entity.dart';
import 'package:taba3ni/features/group_students/domain/repository/student_repository.dart';

class StudentsRepositoryImpl implements StudentsRepository {
  final StudentsRemoteDataSource remoteDataSource;

  StudentsRepositoryImpl(this.remoteDataSource);

  @override
  Future<List<StudentsEntity>> getStudentsByGroupId(String groupId) {
    return remoteDataSource.getStudentsByGroupId(groupId);
  }

  @override
  Future<void> deleteStudent(String studentId) {
    return remoteDataSource.deleteStudent(studentId);
  }
}
