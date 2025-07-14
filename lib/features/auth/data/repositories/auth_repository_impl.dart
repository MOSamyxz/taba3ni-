// lib/features/auth/data/repositories/auth_repository_impl.dart

import 'package:taba3ni/features/auth/data/datasource/auth_remote_data_source.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<UserEntity> loginTeacher(String email, String password) {
    return remoteDataSource.loginTeacher(email, password);
  }

  @override
  Future<UserEntity> loginParent(String studentUsername, String phone) {
    return remoteDataSource.loginParent(studentUsername, phone);
  }

  @override
  Future<void> logout() {
    return remoteDataSource.logout();
  }
}
