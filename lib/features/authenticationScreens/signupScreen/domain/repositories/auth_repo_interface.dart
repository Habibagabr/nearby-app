import '../../../../../core/errors/failures.dart';
import 'package:fpdart/fpdart.dart';

abstract class AuthRepositoryInterface {
  Future<Either<Failure, void>> register({
    required String email,
    required String password,
    required String userName,
    required String role,
  });
}
