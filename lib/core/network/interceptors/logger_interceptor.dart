import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LoggerInterceptor extends Interceptor {
  @override
  void onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) {
    print('================ REQUEST ================');
    print('METHOD: ${options.method}');
    print('PATH: ${options.uri}');
    print('HEADERS: ${options.headers}');
    print('BODY: ${options.data}');
    print('=========================================');
    super.onRequest(options, handler);
  }

  @override
  void onResponse(
      Response response,
      ResponseInterceptorHandler handler,
      ) {
    print('================ RESPONSE ================');
    print('STATUS: ${response.statusCode}');
    print('BODY: ${response.data}');
    print('==========================================');
    super.onResponse(response, handler);
  }

  @override
  void onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) {
    print('================ ERROR ===================');
    print('STATUS: ${err.response?.statusCode}');
    print('BODY: ${err.response?.data}');
    print('==========================================');
    super.onError(err, handler);
  }
}
