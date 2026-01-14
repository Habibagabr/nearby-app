import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:near_buy_gp/core/errors/failures.dart';
import 'package:near_buy_gp/features/authenticationScreens/signupScreen/domain/entity/auth_entity.dart';

import '../../../../../core/network/sessionManager/session_manager_interface.dart';
import '../../../../../core/usecase/base_usecase.dart';
import '../repositories/auth_repo_interface.dart';

class RegisterParams {
  final String email;
  final String password;
  final String userName;
  final String role;

  const RegisterParams({
    required this.email,
    required this.password,
    required this.userName,
    required this.role,
  });
}

@lazySingleton
class RegisterUseCase extends UseCase<AuthEntity, RegisterParams> {
  final AuthRepositoryInterface authRepo;
  final SessionManager sessionManager;

  RegisterUseCase(this.authRepo , this.sessionManager);

  @override
  Future<Either<Failure, AuthEntity>> call(params) async {
    final result =  await authRepo.register(
        email: params.email,
        password: params.password,
        userName: params.userName,
        role: params.role
    );
    // map only calling in the term of success not in failure
    return result.map((authEntity) {
      sessionManager.saveSession(
        token: authEntity.accessToken,
        userId: authEntity.id,
        role: authEntity.role,
      );
      return authEntity;
    });

  }

}

