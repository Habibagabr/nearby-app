import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:near_buy_gp/features/splashScreen/bloc/splash_screen_bloc.dart';

import '../../loginScreen/bloc/login_screen_bloc.dart';

part 'signup_screen_event.dart';
part 'signup_screen_state.dart';

class SignupScreenBloc extends Bloc<SignupScreenEvent, SignupScreenState> {
  SignupScreenBloc() : super(SignupScreenInitial()) {
    on<SecondaryBtnClicked>(_onSecondaryBtnClicked);
  }

  void _onSecondaryBtnClicked(
    SecondaryBtnClicked event,
    Emitter<SignupScreenState> emit,
  ) {
    emit(NavigateToLoginScreen());
  }
}
