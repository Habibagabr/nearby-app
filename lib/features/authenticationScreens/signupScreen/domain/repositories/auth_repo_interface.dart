import 'package:near_buy_gp/features/authenticationScreens/signupScreen/domain/entity/auth_entity.dart';

import '../../../../../core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepositoryInterface {
  Future<Either<Failure, AuthEntity>> register({
    required String email,
    required String password,
    required String userName,
    required String role,
  });
}
