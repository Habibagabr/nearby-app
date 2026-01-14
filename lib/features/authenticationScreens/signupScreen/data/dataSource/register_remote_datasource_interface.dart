import '../models/register_model.dart';

abstract class RegisterRemoteDataSource {
  Future<RegisterModel> register({
    required String email,
    required String password,
    required String userName,
    required String role,
  });
}
