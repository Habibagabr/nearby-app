abstract class Failure {
  final String ? msg;
  const Failure(this.msg);
}
class ServerFailure extends Failure {
  const ServerFailure({required String ? msg}) : super(msg);
}

class ValidationFailure extends Failure {
  const ValidationFailure({required String ? msg}) : super(msg);
}

class NetworkFailure extends Failure{
  const NetworkFailure({required String ? msg}):super(msg);
}

class UnknownFailure extends Failure {
  const UnknownFailure({required String ? msg}) : super(msg);
}
