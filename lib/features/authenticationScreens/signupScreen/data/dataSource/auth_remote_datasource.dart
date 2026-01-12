import 'package:injectable/injectable.dart';

import 'auth_remote_datasource_interface.dart';
import 'package:dio/dio.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<void> register({
    required String email,
    required String password,
    required String userName,
    required String role,
  }) async {
    await dio.post(
      '/api/auth/register',
      data: {
        "email": email,
        "password": password,
        "userName": userName,
        "role": role,
      },
      options: Options(extra: {'requiresToken': false}),
    );
  }
}
