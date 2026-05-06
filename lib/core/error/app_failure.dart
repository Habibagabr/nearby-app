sealed class AppFailure {
  final String failureMessage;

  AppFailure({required this.failureMessage});
}

class NetworkFailure extends AppFailure {
  final String networkFailureMessage;

  NetworkFailure({required this.networkFailureMessage})
    : super(failureMessage: networkFailureMessage);
}

class ServerFailure extends AppFailure {
  final String serverFailureMessage;

  ServerFailure({required this.serverFailureMessage})
    : super(failureMessage: serverFailureMessage);
}

// when the user cancel the request : e.g : when it navigate from the screen so we don't have to complete the request to save user data
class CancelFailure extends AppFailure {
  final String cancelFailureMessage;

  CancelFailure({required this.cancelFailureMessage})
    : super(failureMessage: cancelFailureMessage);
}

// any failure rather than being network one
class GeneralFailure extends AppFailure {
  final String generalFailureMessage;

  GeneralFailure({required this.generalFailureMessage})
    : super(failureMessage: generalFailureMessage);
}
