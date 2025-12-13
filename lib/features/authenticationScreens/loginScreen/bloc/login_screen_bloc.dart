import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc() : super(LoginScreenInitial()) {
    on<SecondaryBtnClicked>(_navigateToSignupScreen);
  }

  void _navigateToSignupScreen(
    SecondaryBtnClicked event,
    Emitter<LoginScreenState> emit,
  ) {
    emit(NavigateToSignupScreen());
  }
}
