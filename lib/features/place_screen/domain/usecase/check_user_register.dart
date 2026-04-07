import 'dart:ffi';

import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/core/network/sessionManager/session_manager_interface.dart';

@LazySingleton()
class CheckUserRegister {
  final SessionManager sessionManager;

  CheckUserRegister({required this.sessionManager});

  Future<bool> call() async {
    String? userId = await sessionManager.getUserId();

    if (userId == null) {
      return false;
    } else {
      return true;
    }
  }
}
