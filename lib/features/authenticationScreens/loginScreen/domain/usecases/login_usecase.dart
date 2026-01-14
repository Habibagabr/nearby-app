import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/core/errors/failures.dart';
import 'package:near_buy_gp/core/network/sessionManager/session_manager_interface.dart';
import 'package:near_buy_gp/core/usecase/base_usecase.dart';
import 'package:near_buy_gp/features/authenticationScreens/loginScreen/domain/entity/login_entity.dart';
import 'package:near_buy_gp/features/authenticationScreens/loginScreen/domain/repository/login_repository_interface.dart';

class LoginParam {
  final String email;
  final String password;

  const LoginParam({required this.email, required this.password});
}

@LazySingleton()
class LoginUseCase extends UseCase<LoginEntity, LoginParam> {
  final LoginRepository repository;
  final SessionManager sessionManager;
  LoginUseCase(this.repository, this.sessionManager);

  @override
  Future<Either<Failure, LoginEntity>> call(LoginParam params) async {
    final result = await repository.login(params.email, params.password);

    // just happened in case of success
    return result.map((loginEntity) {
      sessionManager.saveSession(
        token: loginEntity.accessToken,
        userId: loginEntity.id,
        role: loginEntity.role,
        userName: loginEntity.userName,
      );
      return loginEntity;
    });
  }
}

