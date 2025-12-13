part of 'signup_screen_bloc.dart';

@immutable
sealed class SignupScreenState {}

final class SignupScreenInitial extends SignupScreenState {}

final class NavigateToLoginScreen extends SignupScreenState{}
