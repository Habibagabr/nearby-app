import 'package:fpdart/src/either.dart';
import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:near_buy_gp/core/errors/failures.dart';

import 'package:near_buy_gp/features/authenticationScreens/loginScreen/domain/entity/login_entity.dart';

import '../../../../../core/errors/error_mapper.dart';
import '../../../../../core/errors/exceptions.dart';
import '../../domain/repository/login_repository_interface.dart';
import '../dataSource/login_remote_datasource_interface.dart';

@Injectable(as: LoginRepository)
class LoginRepositoryImp implements LoginRepository {
  final LoginRemoteDataSource dataSource;
  LoginRepositoryImp(this.dataSource);

  @override
  Future<Either<Failure, LoginEntity>> login(
    String email,
    String password,
  ) async {
    try {
      final result = await dataSource.login(email, password);
      return Right(result.toEntity());
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
