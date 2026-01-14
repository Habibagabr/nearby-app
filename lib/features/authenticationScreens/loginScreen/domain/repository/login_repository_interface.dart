import 'package:fpdart/fpdart.dart';
import 'package:near_buy_gp/core/errors/failures.dart';

import '../entity/login_entity.dart';

abstract class LoginRepository{
  Future<Either<Failure,LoginEntity>> login(String email , String password);
}