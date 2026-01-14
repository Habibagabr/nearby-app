import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../errors/exceptions.dart';

@lazySingleton
class ErrorInterceptor extends Interceptor {
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final statusCode = err.response?.statusCode;
    final data = err.response?.data;

    final backendMessage = data is Map<String, dynamic>
        ? data['message'] as String?
        : null;

    // Network errors
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.receiveTimeout ||
        err.type == DioExceptionType.connectionError) {
      handler.reject(
        err.copyWith(
          error: NetworkException(msg: "Network connection failed , please check your connection"),
        ),
      );
      return;
    }

    // Validation
    if (statusCode == 400 || statusCode == 402) {
      handler.reject(
        err.copyWith(
          error: ValidationException(msg: backendMessage),
        ),
      );
      return;
    }

    // Server
    handler.reject(
      err.copyWith(
        error: ServerException(msg: backendMessage),
      ),
    );
  }
}
