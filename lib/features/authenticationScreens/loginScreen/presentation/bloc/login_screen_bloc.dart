import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:near_buy_gp/features/authenticationScreens/utils/input_field_error.dart';

import '../../../utils/common_validations.dart';


part 'login_screen_event.dart';
part 'login_screen_state.dart';

class LoginScreenBloc extends Bloc<LoginScreenEvent, LoginScreenState> {
  LoginScreenBloc() : super(LoginScreenInitial()) {
    on<SecondaryBtnClicked>(_navigateToSignupScreen);
    on<PrimaryBtnClicked>(_loginBtnPressed);
  }

  void _navigateToSignupScreen(
    SecondaryBtnClicked event,
    Emitter<LoginScreenState> emit,
  ) {
    emit(NavigateToSignupScreen());
  }

  void _loginBtnPressed(
    PrimaryBtnClicked event,
    Emitter<LoginScreenState> emit,
  ) {
    InputFieldError? emailError;
    InputFieldError? passwordError;

    // Email validation
    if (event.email.trim().isEmpty) {
      emailError = InputFieldError.required;
    } else if (!isValidEmailSyntax(event.email)) {
      emailError = InputFieldError.invalidEmail;
    }

    // Password validation
    if (event.password.trim().isEmpty) {
      passwordError = InputFieldError.required;
    } else if (!isStrongPassword(event.password)) {
      passwordError = InputFieldError.passwordsIsWeak;
    }

    // local Validation failed
    if (emailError != null || passwordError != null) {
      emit(
        LoginValidationError(
          emailError: emailError,
          passwordError: passwordError,
        ),
      );
      return;
    }

    // local Validation passed -> NOW loading
    emit(LoginLoading());
    // Call login API / use case
  }
}
