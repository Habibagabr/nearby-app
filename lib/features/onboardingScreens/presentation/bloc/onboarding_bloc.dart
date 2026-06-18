import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:near_buy_gp/core/network/sessionManager/session_manager_interface.dart';

part 'onboarding_event.dart';

part 'onboarding_state.dart';

@injectable
class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final SessionManager sessionManager;

  OnboardingBloc(this.sessionManager) : super(OnboardingInitial()) {
    on<SkipPressed>(onSkipPressed);
  }

  Future<void> onSkipPressed(
    SkipPressed event,
    Emitter<OnboardingState> emit,
  ) async {
    emit(OnboardingLoading());
    try {
      await sessionManager.setFirstLaunchedStatus(isFirstLaunch: false);
      emit(NavigateToHome());
    } catch (e) {
      emit(OnboardingErrorState(errorMessage: e.toString()));
    }
  }
}
