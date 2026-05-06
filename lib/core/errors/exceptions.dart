//FIXME : this will be removed later

sealed class AppException implements Exception {
  final String ? msg;
  final int ? statusCode;

  const AppException({this.msg, this.statusCode});
}

class ServerException extends AppException {
  const ServerException({super.msg,super.statusCode});
}

class ValidationException extends AppException{
  const ValidationException({super.msg,super.statusCode});
}

class NetworkException extends AppException {
  const NetworkException({super.msg,super.statusCode});
}


