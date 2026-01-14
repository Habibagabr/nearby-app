import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/features/authenticationScreens/signupScreen/data/models/auth_model.dart';

import 'auth_remote_datasource_interface.dart';
import 'package:dio/dio.dart';

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<AuthModel> register({
    required String email,
    required String password,
    required String userName,
    required String role,
  }) async {
   Response response = await dio.post(
      '/api/auth/register',
      data: {
        "email": email,
        "password": password,
        "userName": userName,
        "role": role,
      },
      options: Options(extra: {'requiresToken': false}),
    );
   return AuthModel.fromJson(response.data);
  }
}
