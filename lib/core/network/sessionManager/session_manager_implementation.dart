import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/core/network/sessionManager/session_manager_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

@LazySingleton(as: SessionManager)
class SessionManagerImpl extends SessionManager {
  final FlutterSecureStorage storage;
  final SharedPreferences sharedPreferences;

  SessionManagerImpl(this.storage , this.sharedPreferences);

  @override
  Future<void> clearSession() async {
    await FlutterSecureStorage().deleteAll();
  }

  @override
  Future<String?> getToken() {
    return storage.read(key: 'auth_token');
  }

  @override
  Future<String?> getUserId() {
    return storage.read(key: "user_id");
  }

  @override
  Future<void> saveSession({
    required String token,
    required String userId,
    required String role,
    required String userName,
  }) async {
    await storage.write(key: 'auth_token', value: token);
    await storage.write(key: 'user_id', value: userId);
    await storage.write(key: 'user_role', value: role);
    await storage.write(key: 'user_name', value: userName);
  }


  @override
  Future<void> setFirstLaunchedStatus({required bool isFirstLaunch}) async {
    await sharedPreferences.setBool("is_first_launched", isFirstLaunch);

  }

  @override
  Future<bool> checkFirstLaunchedStatus() async{
    return sharedPreferences.getBool("is_first_launched") ?? true;
  }

}
