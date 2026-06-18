part of 'onboarding_bloc.dart';

@immutable
sealed class OnboardingState {}

final class OnboardingInitial extends OnboardingState {}
final class OnboardingLoading extends OnboardingState {}

final class NavigateToHome extends OnboardingState{}
final class OnboardingErrorState extends OnboardingState{
  final String errorMessage;
  OnboardingErrorState({required this.errorMessage});
}