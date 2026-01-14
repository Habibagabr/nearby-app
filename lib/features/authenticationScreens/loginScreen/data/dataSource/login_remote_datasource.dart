import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

import 'package:near_buy_gp/features/authenticationScreens/loginScreen/data/model/login_model.dart';

import 'login_remote_datasource_interface.dart';

@LazySingleton(as : LoginRemoteDataSource)
class LoginRemoteDataSourceImpl implements LoginRemoteDataSource{
  final Dio dio ;
  LoginRemoteDataSourceImpl(this.dio);

  @override
  Future<LoginModel> login(String email, String password) async {
    final result = await dio.post(
      "/api/auth/signin",
      data:{
        "email":email,
        "password":password
      },
      options: Options(extra: {'requiresToken': false}),
    );
    return LoginModel.fromJson(result.data);
  }

}