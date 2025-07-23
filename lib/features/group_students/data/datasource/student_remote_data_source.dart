
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taba3ni/features/student_shared/data/model/student_model.dart';

abstract class StudentsRemoteDataSource {
  Future<List<StudentsModel>> getStudentsByGroupId(String groupId);
  Future<void> deleteStudent( String studentId);
}

class StudentsRemoteDataSourceImpl implements StudentsRemoteDataSource {
  final SupabaseClient client;

  StudentsRemoteDataSourceImpl(this.client);

  @override
  Future<List<StudentsModel>> getStudentsByGroupId(String groupId) async {
    final response = await client
        .from('students')
        .select()
        .eq('group_id', groupId);

    return (response as List)
        .map((student) => StudentsModel.fromMap(student))
        .toList();
  }
  
  @override
  Future<void> deleteStudent(studentId) async{
     await client.from('students') .delete().eq('id', studentId);

   }
}
