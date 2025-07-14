
import '../entities/user_entity.dart';
import '../repositories/auth_repository.dart';

class LoginTeacherUseCase {
  final AuthRepository repository;

  LoginTeacherUseCase(this.repository);

  Future<UserEntity> call(String email, String password) {
    return repository.loginTeacher(email, password);
  }
}
