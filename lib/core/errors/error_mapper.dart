import 'exceptions.dart';
import 'failures.dart';


//FIXME : this will be removed later
Failure mapExceptionToFailure(Exception exception) {

  if (exception is AppException) {
    return switch (exception) {
      ServerException() =>  ServerFailure(msg: exception.msg),
      NetworkException() => NetworkFailure(msg: exception.msg),
      ValidationException() => ValidationFailure(msg:exception.msg),
    };
  }
  return UnknownFailure(msg: "Something went wrong , please try again later");

}
