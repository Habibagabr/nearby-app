part of 'login_screen_bloc.dart';

@immutable
sealed class LoginScreenState {}

final class LoginScreenInitial extends LoginScreenState {}

final class NavigateToSignupScreen extends LoginScreenState{}

class LoginValidationError extends LoginScreenState {
  final InputFieldError? emailError;
  final InputFieldError? passwordError;

   LoginValidationError({
    this.emailError,
    this.passwordError,
  });
}

class LoginLoading extends LoginScreenState{}

class LoginSuccess extends LoginScreenState{}
