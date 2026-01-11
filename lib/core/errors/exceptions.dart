import 'errors_key.dart';

sealed class AppException implements Exception {
  final String key;
  final int ? statusCode;

  const AppException(this.key, {this.statusCode});
}

class ServerException extends AppException {
  const ServerException({int? statusCode})
      : super(ErrorKeys.serverError, statusCode: statusCode);
}

class ValidationException extends AppException{
  const ValidationException(): super(ErrorKeys.validationError);
}

class NetworkException extends AppException {
  const NetworkException() : super(ErrorKeys.networkError);
}

class UnauthorizedException extends AppException {
  const UnauthorizedException()
      : super(ErrorKeys.unauthorized);
}


