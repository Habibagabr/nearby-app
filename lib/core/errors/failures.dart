import 'errors_key.dart';

abstract class Failure {
  final String key;
  const Failure(this.key);
}
class ServerFailure extends Failure {
  const ServerFailure() : super(ErrorKeys.serverError);
}

class ValidationFailure extends Failure {
  const ValidationFailure() : super(ErrorKeys.validationError);
}

class NetworkFailure extends Failure{
  const NetworkFailure():super(ErrorKeys.networkError);
}

class UnauthorizedFailure extends Failure {
  const UnauthorizedFailure() : super(ErrorKeys.unauthorized);
}

class UnknownFailure extends Failure {
  const UnknownFailure() : super(ErrorKeys.unknownError);
}
