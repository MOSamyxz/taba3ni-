// lib/features/auth/data/datasources/auth_remote_data_source.dart

import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/user_model.dart';
import '../../domain/entities/user_entity.dart';
import 'package:taba3ni/core/errors/exceptions.dart';
abstract class AuthRemoteDataSource {
  Future<UserModel> loginTeacher(String email, String password);
  Future<UserModel> loginParent(String studentUsername, String phone);
  Future<void> logout();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final SupabaseClient client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<UserModel> loginTeacher(String email, String password) async {
    final response = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    final user = response.user;
    if (user == null) throw LoginException();

    return UserModel(
      id: user.id,
      name: user.userMetadata?['name'] ?? 'Teacher',
      role: UserRole.teacher,
    );
  }

  @override
  Future<UserModel> loginParent(String studentUsername, String phone) async {
    final response = await client
        .from('students')
        .select('id, name_ar')
        .eq('username_en', studentUsername)
        .eq('parent_phone', phone)
        .maybeSingle();

    if (response == null) throw LoginException();

    return UserModel(
      id: response['id'],
      name: response['name_ar'],
      role: UserRole.parent,
    );
  }

  @override
  Future<void> logout() async {
    await client.auth.signOut();
  }
}
