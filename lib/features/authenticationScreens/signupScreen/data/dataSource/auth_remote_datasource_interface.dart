import 'package:near_buy_gp/features/authenticationScreens/signupScreen/data/models/auth_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthModel> register({
    required String email,
    required String password,
    required String userName,
    required String role,
  });
}
