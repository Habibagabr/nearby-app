import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:near_buy_gp/core/network/sessionManager/session_manager_interface.dart';

import '../../../core/di/injection.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

@injectable
class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  final SessionManager sessionManager;

  SplashScreenBloc(this.sessionManager) : super(SplashScreenInitial()) {
    on<SplashScreenStarted>(_onStarted);
  }

  Future<void> _onStarted(
      SplashScreenStarted event,
      Emitter<SplashScreenState> emit,
      ) async {
    emit(SplashScreenLoading());

    // Start the Job of the stopwatch
    final minimumSplashDelay = Future.delayed(const Duration(seconds: 2));

    // 1. Ensures all asynchronous dependencies (like SharedPreferences) are registered and ready
    await getIt.allReady();

    // 2. Check onboarding status
    final isFirstTimeLaunch = await sessionManager.checkFirstLaunchedStatus();

    await minimumSplashDelay;

    if (isFirstTimeLaunch) {
      // Go straight to Onboarding
      emit(NavigateToOnBoarding());
    } else {
      // Not first time: Tell UI to prompt location validation during the splash sequence
      emit(CheckLocationPermissionBeforeHome());
    }
  }
}
