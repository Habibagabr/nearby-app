import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/features/authenticationScreens/signupScreen/domain/repositories/auth_repo_interface.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/errors/error_mapper.dart';
import '../../../../../core/errors/failures.dart';
import '../dataSource/auth_remote_datasource_interface.dart';

@LazySingleton(as: AuthRepositoryInterface)
class AuthRepositoryImpl implements AuthRepositoryInterface {
  final AuthRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, void>> register({
    required String email,
    required String password,
    required String userName,
    required String role,
  }) async {
    try {
      await remote.register(
        email: email,
        password: password,
        userName: userName,
        role: role,
      );
      return const Right(null);
    } catch (e) {
      return Left(mapExceptionToFailure(e as Exception));
    }
  }
}
