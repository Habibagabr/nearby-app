part of 'splash_screen_bloc.dart';

@immutable
sealed class SplashScreenState {}

class SplashScreenLoading extends SplashScreenState {}

class NavigateToLogin extends SplashScreenState{}
