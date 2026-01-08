import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('REQUEST[${options.method}] => PATH: ${options.path}');
    super.onRequest(options, handler);
  }
}
