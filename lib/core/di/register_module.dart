import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/core/network/interceptors/error_interceptor.dart';
import '../network/interceptors/auth_interceptor.dart';
import '../network/interceptors/logger_interceptor.dart';
import '../constants/env.dart';

@module
abstract class RegisterModule {

  @lazySingleton
  FlutterSecureStorage get storage => const FlutterSecureStorage();


  @lazySingleton
  Dio dio(
      BaseOptions options,
      LoggerInterceptor logger ,
      AuthInterceptor auth,
      ErrorInterceptor error
      ) {
    final dio = Dio(options);
    dio.interceptors.addAll([logger, auth , error]);
    return dio;
  }

  @lazySingleton
  BaseOptions get options => BaseOptions(
    baseUrl: Env.baseUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  );
}
