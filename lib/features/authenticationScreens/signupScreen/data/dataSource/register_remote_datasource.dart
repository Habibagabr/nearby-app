import 'package:injectable/injectable.dart';

import 'package:dio/dio.dart';
import 'package:near_buy_gp/features/authenticationScreens/signupScreen/data/dataSource/register_remote_datasource_interface.dart';

import '../models/register_model.dart';

@LazySingleton(as: RegisterRemoteDataSource)
class RegisterRemoteDataSourceImpl implements RegisterRemoteDataSource {
  final Dio dio;

  RegisterRemoteDataSourceImpl(this.dio);

  @override
  Future<RegisterModel> register({
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
   return RegisterModel.fromJson(response.data);
  }
}
