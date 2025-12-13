import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:near_buy_gp/features/splashScreen/splash_screen.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {
  SplashScreenBloc() : super(SplashScreenLoading()) {
    on<SplashScreenStarted>(_onStarted);
  }

  Future<void> _onStarted(
    SplashScreenStarted event,
    Emitter<SplashScreenState> emit,
  ) async {
    // simulation for the next logic "" the checking for if the user is pre-signed or not "
    await Future.delayed(const Duration(milliseconds: 2000));
    // change this later
    emit(NavigateToLogin());
  }


}
