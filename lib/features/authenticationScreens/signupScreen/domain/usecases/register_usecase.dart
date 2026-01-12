import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';

import 'package:near_buy_gp/core/errors/failures.dart';

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
class RegisterUseCase extends UseCase<void, RegisterParams> {
  final AuthRepositoryInterface authRepo;
   RegisterUseCase(this.authRepo);

  @override
  Future<Either<Failure, void>> call(params) {
    return authRepo.register(
        email: params.email,
        password: params.password,
        userName: params.userName,
        role: params.role
    );
  }

}

