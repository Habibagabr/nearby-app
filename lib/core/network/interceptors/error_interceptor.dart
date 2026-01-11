import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../errors/exceptions.dart';

@lazySingleton
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final type = err.type;
    final status = err.response?.statusCode;

    if (type == DioExceptionType.connectionTimeout ||
        type == DioExceptionType.receiveTimeout ||
        type == DioExceptionType.unknown) {
      return handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: const NetworkException(),
        ),
      );
    }

    if (status == 401) {
      return handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: const UnauthorizedException(),
        ),
      );
    }

    if (status == 400) {
      return handler.reject(
        DioException(
          requestOptions: err.requestOptions,
          error: const ValidationException(),
        ),
      );
    }

    return handler.reject(
      DioException(
        requestOptions: err.requestOptions,
        error: ServerException(statusCode: status),
      ),
    );
  }
}
