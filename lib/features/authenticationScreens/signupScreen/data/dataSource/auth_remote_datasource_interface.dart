abstract class AuthRemoteDataSource {
  Future<void> register({
    required String email,
    required String password,
    required String userName,
    required String role,
  });
}
