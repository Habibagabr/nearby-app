import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:near_buy_gp/features/authenticationScreens/loginScreen/domain/usecases/login_usecase.dart';
import 'package:near_buy_gp/features/authenticationScreens/utils/input_field_error.dart';

import '../../../utils/common_validations.dart';

part 'login_screen_event.dart';
part 'login_screen_state.dart';

@Injectable()
class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  final LoginUseCase loginUseCase;

  LoginScreenBloc(this.loginUseCase) : super(LoginScreenInitial()) {
    on<SecondaryBtnClicked>(_navigateToSignupScreen);
    on<PrimaryBtnClicked>(_loginBtnPressed);
  }

  void _navigateToSignupScreen(
    SecondaryBtnClicked event,
    Emitter<LoginScreenState> emit,
  ) {
    emit(NavigateToSignupScreen());
  }

  Future<void> _loginBtnPressed(
    PrimaryBtnClicked event,
    Emitter<LoginScreenState> emit,
  ) async {
    InputFieldError? emailError;
    InputFieldError? passwordError;

    // -------- Email validation --------
    if (event.email.trim().isEmpty) {
      emailError = InputFieldError.required;
    } else if (!isValidEmailSyntax(event.email)) {
      emailError = InputFieldError.invalidEmail;
    }

    // -------- Password validation --------
    if (event.password.trim().isEmpty) {
      passwordError = InputFieldError.required;
    } else if (!isStrongPassword(event.password)) {
      passwordError = InputFieldError.passwordsIsWeak;
    }

    // -------- Local validation failed --------
    if (emailError != null || passwordError != null) {
      emit(
        LoginValidationError(
          emailError: emailError,
          passwordError: passwordError,
        ),
      );
      return;
    }

    // -------- Local validation passed --------
    emit(LoginLoading());

    final result = await loginUseCase(
      LoginParam(email: event.email, password: event.password),
    );

    result.fold(
      (failure) {
        emit(LoginFailure(failure.msg));
      },
      (_) {
        emit(LoginSuccess());
      },
    );
  }
}
