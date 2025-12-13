part of 'signup_screen_bloc.dart';

@immutable
sealed class SignupScreenEvent {}

class SignupScreenStarted extends SignupScreenEvent{}

class SecondaryBtnClicked extends SignupScreenEvent{}
