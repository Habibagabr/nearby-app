abstract class SessionManager{
  Future<void>  saveSession({
    required String token,
    required String userId,
    required String role,
  });

  Future<String?> getToken();
  Future<String?> getUserId();
  Future<void> clearSession();
}