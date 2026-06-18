abstract class SessionManager{
  Future<void>  saveSession({
    required String token,
    required String userId,
    required String role,
    required String userName,
  });

  Future<String?> getToken();
  Future<String?> getUserId();
  Future<void> clearSession();
  Future<void> setFirstLaunchedStatus({required bool isFirstLaunch});
  Future<bool> checkFirstLaunchedStatus();
}