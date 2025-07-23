  // lib/core/errors/failure.dart

abstract class Failure {
  final String error;
  const Failure(this.error);
}

class ServerFailure extends Failure {
  const ServerFailure(super.error);
}

class CacheFailure extends Failure {
  const CacheFailure(super.error);
}

class LoginFailure extends Failure {
  const LoginFailure(super.error);
}
