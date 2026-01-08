part of 'login_screen_bloc.dart';

@immutable
sealed class LoginScreenEvent {}

class LoginScreenStarted extends LoginScreenEvent{}

class SecondaryBtnClicked extends LoginScreenEvent{}

class PrimaryBtnClicked extends LoginScreenEvent {
  final String email;
  final String password;
  PrimaryBtnClicked({
    required this.email,
    required this.password
  });
}
