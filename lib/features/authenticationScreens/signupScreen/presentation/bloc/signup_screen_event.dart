part of 'signup_screen_bloc.dart';

sealed class SignupScreenEvent {}

class SignupScreenStarted extends SignupScreenEvent{}

class SecondaryBtnClicked extends SignupScreenEvent{}

class PrimaryBtnClicked extends SignupScreenEvent{
  String  email;
  String  userName;
  String  password;
  String  confirmPassword;

  PrimaryBtnClicked({
   required this.email,
    required this.userName,
    required this.password,
    required this.confirmPassword

});
}
