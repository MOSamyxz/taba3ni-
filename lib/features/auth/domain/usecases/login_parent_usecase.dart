
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginParentUseCase {
  final AuthRepository repository;

  LoginParentUseCase(this.repository);

  Future<UserEntity> call(String studentUsername, String parentPhone) {
    return repository.loginParent(studentUsername, parentPhone);
  }
}
