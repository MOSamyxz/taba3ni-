
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<UserEntity> loginTeacher(String email, String password);
  Future<UserEntity> loginParent(String studentUsername, String parentPhone);
  Future<void> logout();
}
