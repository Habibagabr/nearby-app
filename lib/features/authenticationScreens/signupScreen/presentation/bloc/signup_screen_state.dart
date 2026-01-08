part of 'signup_screen_bloc.dart';

sealed class SignupScreenState {}

final class SignupScreenInitial extends SignupScreenState {}

final class NavigateToLoginScreen extends SignupScreenState {}

final class SignupValidationError extends SignupScreenState {
  final InputFieldError? emailError;
  final InputFieldError? userNameError;
  final InputFieldError? passwordError;
  final InputFieldError? confirmPasswordError;

  SignupValidationError({
    required this.emailError,
    required this.userNameError,
    required this.passwordError,
    required this.confirmPasswordError,
  });
}
