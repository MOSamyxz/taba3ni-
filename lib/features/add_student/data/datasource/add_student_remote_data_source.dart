
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taba3ni/features/student_shared/data/model/student_model.dart';

abstract class AddStudentRemoteDataSource {
  Future<void> addStudent(StudentsModel student);
}

class AddStudentRemoteDataSourceImpl implements AddStudentRemoteDataSource {
  final SupabaseClient client;

  AddStudentRemoteDataSourceImpl(this.client);

  @override
  Future<void> addStudent(StudentsModel student) async {
     await client.from('students').insert(student.toMap());
   }
}
