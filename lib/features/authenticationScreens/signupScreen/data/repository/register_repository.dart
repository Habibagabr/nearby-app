import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/features/authenticationScreens/signupScreen/domain/entity/auth_entity.dart';
import 'package:fpdart/fpdart.dart';

import '../../../../../core/errors/error_mapper.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../../../../core/errors/failures.dart';
import '../../domain/repositories/register_repo_interface.dart';
import '../dataSource/register_remote_datasource_interface.dart';

@LazySingleton(as: RegisterRepositoryInterface)
class AuthRepositoryImpl implements RegisterRepositoryInterface {
  final RegisterRemoteDataSource remote;

  AuthRepositoryImpl(this.remote);

  @override
  Future<Either<Failure, LoginEntity>> register({
    required String email,
    required String password,
    required String userName,
    required String role,
  }) async {
    try {
      final model = await remote.register(
        email: email,
        password: password,
        userName: userName,
        role: role,
      );
      return Right(model.toEntity());
    } catch (e) {
      if (e is DioException && e.error is AppException) {
        return Left(mapExceptionToFailure(e.error as AppException));
      }
      return const Left(
        UnknownFailure(msg: "Something went wrong , please try again later"),
      );
    }

  }
}
