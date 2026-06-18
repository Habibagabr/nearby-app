part of 'splash_screen_bloc.dart';

@immutable
abstract class SplashScreenState {}

class SplashScreenInitial extends SplashScreenState {}

class SplashScreenLoading extends SplashScreenState {}

class NavigateToOnBoarding extends SplashScreenState {}
class CheckLocationPermissionBeforeHome extends SplashScreenState {}
