import 'exceptions.dart';
import 'failures.dart';


Failure mapExceptionToFailure(Exception exception) {
  if (exception is AppException) {
    return switch (exception) {
      ServerException() => const ServerFailure(),
      NetworkException() => const NetworkFailure(),
      UnauthorizedException() => const UnauthorizedFailure(),
      ValidationException() => throw UnimplementedError(),
    };
  }

  return const UnknownFailure();
}
