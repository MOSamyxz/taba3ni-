  // lib/core/errors/failure.dart

abstract class Failure {
  final String message;
  const Failure(this.message);
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

class LoginFailure extends Failure {
  const LoginFailure(super.message);
}
