import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/di/injection.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc
    extends Bloc<SplashScreenEvent, SplashScreenState> {

  SplashScreenBloc() : super(SplashScreenInitial()) {
    on<SplashScreenStarted>(_onStarted);
  }

  Future<void> _onStarted(
      SplashScreenStarted event,
      Emitter<SplashScreenState> emit,
      ) async {
    emit(SplashScreenLoading());

    await getIt.allReady();

    emit(SplashScreenReady());
  }
}
